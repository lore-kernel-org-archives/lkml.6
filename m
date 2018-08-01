Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D2CC46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03383208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03383208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389205AbeHAOJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:09:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53436 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387673AbeHAOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:09:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id s9-v6so6755595wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 05:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mAoLSSretO233e7nE9tPJv3281GRJk2A72FvTsbUgPA=;
        b=XlUXKCchtTLqjRkXrsgHRKXDOhw+7C6ccxlobLLiWlGkREzHXk9mwCXTLpDf/qLGQT
         s7vXl1JAv2D3JV54mVw6grZDPFYhMJo5nqLPqMGqu9PXZ1lTCezCXc5UTaL0jLBP1aEI
         HOAWqsidz5FXxK6b08iLRJLKNmLm+t1fgexvJ3AfU5WkV2MXyiIyx++EDTKt/eJLuGs9
         fezTtcX/ZLFfXgMuOiXH83P6beeIg+9spOmgLgTirf3LbQ35TWhWUo8kdkDQsvEZooS7
         n6AidGkjDXLmQ2d5Gv6El8w3eVcdBtQpSiaHCyoRLnXR7b9urSFJVzxi1e9SEYW5WUyW
         U9MQ==
X-Gm-Message-State: AOUpUlHp4za7/uoHivYI9KtxEKFaGKH/NZRy8rXL+mPcPme0lnDTDD3z
        PgYTD+3g4E40OkBggpvjlyE=
X-Google-Smtp-Source: AAOMgpc5EIihffVMmLtQ0cpbYmVKzqIlB0E0kMDNHRYgkTczQh1kkc0Odd+/iOEbx7A/v5myFe6GHg==
X-Received: by 2002:a1c:168a:: with SMTP id 132-v6mr2854484wmw.13.1533126235999;
        Wed, 01 Aug 2018 05:23:55 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id l5-v6sm3375320wmh.0.2018.08.01.05.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 05:23:55 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 462F312453D;
        Wed,  1 Aug 2018 14:23:54 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        david@redhat.com, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v6 0/5] Refactor free_area_init_core and add free_area_init_core_hotplug
Date:   Wed,  1 Aug 2018 14:23:43 +0200
Message-Id: <20180801122348.21588-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Changes:

v5 -> v6:
        - Added patch from Pavel that removes __paginginit
        - Convert all __meminit(old __paginginit) to __init
          for functions we do not need after initialization.
        - Move definition of free_area_init_core_hotplug
          to include/linux/memory_hotplug.h
        - Add Acked-by from Michal Hocko

v4 -> v5:
        - Remove __ref from hotadd_new_pgdat and placed it to
          free_area_init_core_hotplug. (Suggested by Pavel)
        - Since free_area_init_core_hotplug is now allowed to be in a different
          section (__ref), remove the __paginginit.)
        - Stylecode in free_area_init_core_hotplug (Suggested by Pavel)
        - Replace s/@__paginginit/@__init for free_area_init_node/free_area_init_core
          as these functions are now only called during early init.
        - Add Reviewd-by from Pavel

v3 -> v4:
        - Unify patch-5 and patch-4.
        - Make free_area_init_core __init (Suggested by Michal).
        - Make zone_init_internals __paginginit (Suggested by Pavel).
        - Add Reviewed-by/Acked-by:

v2 -> v3:
        - Think better about split free_area_init_core for
          memhotplug/early init context (Suggested by Michal).

This patchset does the following things:

 1) Clean up/refactor free_area_init_core/free_area_init_node
    by moving the ifdefery out of the functions.
 2) Move the pgdat/zone initialization in free_area_init_core to its
    own function.
 3) Introduce free_area_init_core_hotplug, a small subset of free_area_init_core,
    which is only called from memhotlug code path.
    In this way, we have:
 4) Remove __paginginit and convert it to __meminit
 5) Reconvert all __meminit to __init for functions we do not need after
    initialization.

After this, we have:

    free_area_init_core: called during early initialization
    free_area_init_core_hotplug: called whenever a new node is allocated/re-used (memhotplug path)

Oscar Salvador (3):
  mm/page_alloc: Move ifdefery out of free_area_init_core
  mm/page_alloc: Inline function to handle
    CONFIG_DEFERRED_STRUCT_PAGE_INIT
  mm/page_alloc: Introduce free_area_init_core_hotplug

Pavel Tatashin (2):
  mm: access zone->node via zone_to_nid() and zone_set_nid()
  mm: remove __paginginit

 include/linux/memory_hotplug.h |   1 +
 include/linux/mm.h             |  11 +--
 include/linux/mmzone.h         |  26 +++++--
 mm/internal.h                  |  12 ----
 mm/memory_hotplug.c            |  16 ++---
 mm/mempolicy.c                 |   4 +-
 mm/mm_init.c                   |   9 +--
 mm/page_alloc.c                | 151 +++++++++++++++++++++++++++++------------
 8 files changed, 137 insertions(+), 93 deletions(-)

-- 
2.13.6

