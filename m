Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CC7C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2930B2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2930B2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeJBVoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:44:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39465 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeJBVoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:44:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so1875870wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vV57za+RZegx5K6hatPcdBK9pa1kxQE7f2kJZHzy1nw=;
        b=kT9Mrxn7QxVDz4WBTmPw4qXGQIgcd1W16fHBbifPmAYiOL+egSKeTu9arBkcY0SjFu
         0PeKiCeJfR1qBozHRUrxBUfRMwezaeL+g0SoU69oL/52OUEo7skUeVCshjvDz5zyrn/K
         mnHVIW2KWY/7FRDY1RvVf9WoH0DpeXwaTLrzcVWM7V/PlPqnwvQGdPCNzKuhCXnoT1yM
         G0vChaRA41aIjYSYBrEapYcorCEWgeXzgQwXhKX6K7dE6el/YIGwo8WitiF66Ucye+zD
         YsK6nopKF9nWnJc6to51epsE8b51VJZKB1gfu70dkT2TDQ2TdBQ99h4hR9e3LZpaV80q
         X3Iw==
X-Gm-Message-State: ABuFfohVNQvHMOeeP7yioiAQjcQGeJ2AYGudR7EcHM2MnUxj7yIpqGuj
        Qx1texsPZhjV7LcA+7/AQqY=
X-Google-Smtp-Source: ACcGV630pDGe5A/pWCB2EVlv2BB5XBijO9pWEn6fBbPzAQbRro5vCpgSrLZoJvlsdk1fPYHop6KN0A==
X-Received: by 2002:adf:b188:: with SMTP id q8-v6mr11070301wra.95.1538492447320;
        Tue, 02 Oct 2018 08:00:47 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id p9-v6sm11325085wmc.37.2018.10.02.08.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 08:00:46 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id A2D8F12561E;
        Tue,  2 Oct 2018 17:00:45 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     linux-mm@kvack.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        david@redhat.com, dave.jiang@intel.com,
        Oscar Salvador <osalvador@techadventures.net>
Subject: [RFC PATCH v3 0/5] Do not touch pages/zones during hot-remove path
Date:   Tue,  2 Oct 2018 17:00:24 +0200
Message-Id: <20181002150029.23461-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was about to send the patchset without RFC as suggested, but I wanted
to give it one more spin before sending it officially.

I rebased this patchset on top of [1] and [2].

I chose to rebase this on top of [1] because after that, HMM/devm got some
of their code unified, and the changes to be done were less.

Currently, the operations layout performed by the hot-add/remove and
offline/online stages looks like the following:

- hot-add memory:
  a) Allocate a new resouce based on the hot-added memory
  b) Add memory sections for the hot-added memory

- online memory:
  c) Re-adjust zone/pgdat nr of pages (managed, spanned, present)
  d) Initialize the pages from the new memory-range
  e) Online memory sections

- offline memory:
  f) Offline memory sections
  g) Re-adjust zone/pgdat nr of managed/present pages

- hot-remove memory:
  i) Re-adjust zone/pgdat nr of spanned pages
  j) Remove memory sections
  k) Release resource


This is not right for two reasons:

 1) If we do not get to online memory added by a hot-add operation,
    and we offline it right away, we can access steal pages as these
    are only initialized during the onlining stage.
    Two problems have been reported for this [3] and [4]
 2) hot-add/remove memory operations should only care about
    sections and memblock, nothing else.

This patchset moves the handling of the zones/pages
from the hot-remove path to the offline stage.

One of the things that made me scratch my head is the handling of the
memory-hotplug in regard of HMM/devm.
I really scratched my head to find out a way to handle it properly
and nicely, but let me be honest about this, my knowledge of that
part of the code tends to 0.

Jerome reviewed that part of the changes and it looked ok for him,
and Pavel did not see anything wrong in v2 either.

But I would like to get more feedback before sending it without RFC.

The picture we have after this is:

- hot-add memory:
  a) Allocate a new resouce based on the hot-added memory
  b) Add memory sections for the hot-added memory

- online memory:
  c) Re-adjust zone/pgdat nr of pages (managed, spanned, present)
  d) Initialize the pages from the new memory-range
  e) Online memory sections

- offline memory:
  f) Offline memory sections
  g) Re-adjust zone/pgdat nr of managed/present/spanned pages

- hot-remove memory:
  i) Remove memory sections
  j) Release resource


[1] https://patchwork.kernel.org/cover/10613425/
[2] https://patchwork.kernel.org/cover/10617699/
[3] https://patchwork.kernel.org/patch/10547445/
[4] https://www.spinics.net/lists/linux-mm/msg161316.html

Oscar Salvador (5):
  mm/memory_hotplug: Add nid parameter to arch_remove_memory
  mm/memory_hotplug: Create add/del_device_memory functions
  mm/memory_hotplug: Check for IORESOURCE_SYSRAM in
    release_mem_region_adjustable
  mm/memory_hotplug: Move zone/pages handling to offline stage
  mm/memory-hotplug: Rework unregister_mem_sect_under_nodes

 arch/ia64/mm/init.c            |   6 +-
 arch/powerpc/mm/mem.c          |  13 +---
 arch/s390/mm/init.c            |   2 +-
 arch/sh/mm/init.c              |   6 +-
 arch/x86/mm/init_32.c          |   6 +-
 arch/x86/mm/init_64.c          |  10 +--
 drivers/base/memory.c          |   9 ++-
 drivers/base/node.c            |  38 ++--------
 include/linux/memory.h         |   2 +-
 include/linux/memory_hotplug.h |  17 +++--
 include/linux/node.h           |   7 +-
 kernel/memremap.c              |  50 +++++---------
 kernel/resource.c              |  15 ++++
 mm/memory_hotplug.c            | 153 ++++++++++++++++++++++++++---------------
 mm/sparse.c                    |   4 +-
 15 files changed, 169 insertions(+), 169 deletions(-)

-- 
2.13.6

