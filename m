Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BCAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A4F2089A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A4F2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbeG0PZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:25:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39475 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730561AbeG0PZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:25:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so5562350wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 07:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eoqKW9JEVbdCFtIa9sGseW16utw62J/r/d1lFZgZBFU=;
        b=HGx5jLsglT8wfq6wbprb3c4PNCqTg260MTzzjUIor7SIMJIganU++kXYEJAO8lLfXM
         epWdoCHAfIbyKf89dbBzeL/8V1poigOzfKcQnFOSvfjHYaebotVjHrcc+37WpRGbDpP6
         S3inUbEk1+EDV05NXYn84ykUmw+dcMnrh27s93aTffHZoVmG/Vj2EiAmJShpslEBQABZ
         apqyuBlRgdbN2z/BrPxE5JYIIfnxVldzxH87+7O0nQ1WqgU4Hq0LtY7JsW2SykI2xNLT
         zCu1MGLcLfG9KvgUJIJHDcEPZZkf3Vy8horjcjo7ZoqZxPamnG7z5/B0riqKPPs6epZi
         hpnA==
X-Gm-Message-State: AOUpUlGcxgMiIEF0i/5RR2VeWrt0ALyPmtB7eKCKRtIjNfPfqC4TTyTr
        M3/74LgwxByG8ezk/NU+nEA=
X-Google-Smtp-Source: AAOMgpc33Pu4wqmPSBCAm7wgM2gHvY6Kc6QeBqVg7uMzQT82YbwCnvhHMKVnZg/FPDy25L0baW4Wiw==
X-Received: by 2002:a1c:7c13:: with SMTP id x19-v6mr4647728wmc.27.1532700212869;
        Fri, 27 Jul 2018 07:03:32 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id i23-v6sm1756400wmf.24.2018.07.27.07.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:03:32 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 35FD21243FF;
        Fri, 27 Jul 2018 16:03:31 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 0/4] Refactor free_area_init_core and add free_area_init_core_hotplug
Date:   Fri, 27 Jul 2018 16:03:21 +0200
Message-Id: <20180727140325.11881-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Changes:

v3 -> v4:
        - Unify patch-5 and patch-4
        - Make free_area_init_core __init (Suggested by Michal)
        - Make zone_init_internals __paginginit (Suggested by Pavel)
        - Add Reviewed-by/Acked-by:

v2 -> v3:
        - Think better about split free_area_init_core for
          memhotplug/early init context (Suggested by Michal)

This patchset does three things:

 1) Clean up/refactor free_area_init_core/free_area_init_node
    by moving the ifdefery out of the functions.
 2) Move the pgdat/zone initialization in free_area_init_core to its
    own function.
 3) Introduce free_area_init_core_hotplug, a small subset of free_area_init_core,
    which is only called from memhotlug code path.
    In this way, we have:

    free_area_init_core: called during early initialization
    free_area_init_core_hotplug: called whenever a new node is allocated/re-used (memhotplug path)

Oscar Salvador (3):
  mm/page_alloc: Move ifdefery out of free_area_init_core
  mm/page_alloc: Inline function to handle
    CONFIG_DEFERRED_STRUCT_PAGE_INIT
  mm/page_alloc: Introduce free_area_init_core_hotplug

Pavel Tatashin (1):
  mm: access zone->node via zone_to_nid() and zone_set_nid()

 include/linux/mm.h     |  13 ++---
 include/linux/mmzone.h |  26 +++++++---
 mm/memory_hotplug.c    |  16 ++----
 mm/mempolicy.c         |   4 +-
 mm/mm_init.c           |   9 +---
 mm/page_alloc.c        | 134 +++++++++++++++++++++++++++++++++++--------------
 6 files changed, 130 insertions(+), 72 deletions(-)

-- 
2.13.6

