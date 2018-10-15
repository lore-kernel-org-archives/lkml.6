Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EC8C71134
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D555E208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D555E208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeJOXQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:16:39 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:36752 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJOXQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:16:38 -0400
Received: by mail-wm1-f50.google.com with SMTP id a8-v6so20036350wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 08:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LU4r8F9ALUwSKM0hFeYt7FRRV25cfLCEn+tw+FqJXU0=;
        b=YW2691xyD+C0apzg5mHXs1nsEyGTOybImAxcPYQXeYH8eBw2lpnXHwCCu0ijmFW2Vy
         PHKveswKi8m1LGOJHDXLJXEz/rXJrREV0VFychP6hIYpphZ++rnW4nEASmL8RiYCNGge
         0aYYMfcSONTAEIa8cPPYet7YsDCOZiDllXGf5N48/OUUI4CYDXdZT7te2oEab9jR0QJo
         O/q5wcQWGnPO5JADY0FGkUEVWnm1/CPRG0rPV8c1c9xOGg+zWxq4ab8V06iSHPLP5yyE
         4/vO4ovsslWv1nCk3fDPQbCciKf5yqRkBzzwaCMZR1ldQg3qOuTL/VwA50i8O8YclSX4
         AE7Q==
X-Gm-Message-State: ABuFfogOYERkI5E+m1a2hLqWepQa+Hd4fwVdCKLQ+AbqfMoZnyGaSmN4
        VtVCdyjO7oE2xwLpLOWHOlc=
X-Google-Smtp-Source: ACcGV60ElEusojk80rAhPz/fnJhPg3FeIAW4+zGJf9j3lTeckJXR8OKcY7YK8QbGrLRmF29+k/5DLg==
X-Received: by 2002:a7b:c00a:: with SMTP id c10-v6mr13207541wmb.73.1539617452849;
        Mon, 15 Oct 2018 08:30:52 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id k7-v6sm10931764wmf.22.2018.10.15.08.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 08:30:52 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 398DF1251F0;
        Mon, 15 Oct 2018 17:30:51 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        david@redhat.com, dave.jiang@intel.com, linux-mm@kvack.org,
        alexander.h.duyck@linux.intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/5] Do not touch pages/zones during hot-remove path
Date:   Mon, 15 Oct 2018 17:30:29 +0200
Message-Id: <20181015153034.32203-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patchset aims to solve [1] and [2] issues.
Due to the lack of feedback of previous versions, I decided to go safe,
so I reverted some of the changes I did in RFCv3:

 1) It is no longer based on [3], although the code would be easier and
    the changes less.

 2) hotplug lock stays in HMM/devm, mainly because I am not sure whether
    it is ok to leave the kasan calls out of lock or not.
    If we think that this can be done, the hotplug lock can be moved
    within add/del_device_memory, which would be nicer IMHO.

 3) Although I think that init_currently_empty_zone should be protected
    by the spanlock since it touches zone_start_pfn, I decided to leave
    it as it is right now.
    The main point of moving it within the lock was to be able to move
    move_pfn_range_to_zone out of the hotplug lock for HMM/devm code.
    
The main point of this patchset is to move all the page/zone handling
from the hot-remove path, back to the offlining stage.
In this way, we can better split up what each part does:

  * hot-add path:
    - Create a new resource for the hot-added memory
    - Create memory sections for the hot-added memory
    - Create the memblocks representing the hot-added memory

  * online path:
    - Re-adjust zone/pgdat nr of pages (managed, spanned, present)
    - Initialize the pages from the new memory-range
    - Online memory sections

  * offline path:
    - Offline memory sections
    - Re-adjust zone/pgdat nr of pages (managed, spanned, present)

  * hot-remove path:
    - Remove memory sections
    - Remove memblocks
    - Remove resources

So, hot-add/remove stages should only care about sections and memblocks.
While all the zone/page handling should belong to the online/offline stage.

Another thing is that for the sake of reviewability, I split the patchset
in 5 parts, but pathc3 could be combined into patch4.
 
This patchset is based on top of mmotm.

[1] https://patchwork.kernel.org/patch/10547445/
[2] https://www.spinics.net/lists/linux-mm/msg161316.html
[3] https://patchwork.kernel.org/cover/10613425/

Oscar Salvador (5):
  mm/memory_hotplug: Add nid parameter to arch_remove_memory
  mm/memory_hotplug: Create add/del_device_memory functions
  mm/memory_hotplug: Check for IORESOURCE_SYSRAM in
    release_mem_region_adjustable
  mm/memory_hotplug: Move zone/pages handling to offline stage
  mm/memory-hotplug: Rework unregister_mem_sect_under_nodes

 arch/ia64/mm/init.c            |   6 +-
 arch/powerpc/mm/mem.c          |  14 +---
 arch/s390/mm/init.c            |   2 +-
 arch/sh/mm/init.c              |   6 +-
 arch/x86/mm/init_32.c          |   6 +-
 arch/x86/mm/init_64.c          |  11 +---
 drivers/base/memory.c          |   9 ++-
 drivers/base/node.c            |  38 ++---------
 include/linux/memory.h         |   2 +-
 include/linux/memory_hotplug.h |  21 ++++--
 include/linux/node.h           |   9 ++-
 kernel/memremap.c              |  13 ++--
 kernel/resource.c              |  16 +++++
 mm/hmm.c                       |  35 +++++-----
 mm/memory_hotplug.c            | 142 +++++++++++++++++++++++++----------------
 mm/sparse.c                    |   6 +-
 16 files changed, 177 insertions(+), 159 deletions(-)

-- 
2.13.6

