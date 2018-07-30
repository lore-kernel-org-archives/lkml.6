Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D8FFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC81220881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC81220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeG3LwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:52:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33717 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbeG3LwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:52:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so12260135wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 03:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9Wb89sZl48ZLEl0m2kvUGWLXvaF95IbPdf1nJbbYfMA=;
        b=pZYXAiuODzGyp8hrHfCrbWzh1q1bEwHYVtLUHGWiCx3rfQEruCynjo+0y5pTn853Vr
         bwotrl5TTpgtA7NSnhfQ6WzkiZKHeT+qsVOWMdfT44gzreqNkAfaGYRUhYAsYKaemoJR
         xsPEtu8AIT+z+iXzeWJ/qhuShFk33XL05xPsQIwRF/eSlIUC6NiESf+CZl47epC1Uwqp
         +flycWeZcDJGS5ztFhE4WOMn7NHRSeIqQSZbxQiP9D7s9eJK9PvbSMIJH4VzEPQod5K3
         K053C36cuGIomSP69/ZkegwlrzL8RwxhvuTlfa9Pzi0O7myqAc6HqOnAVT+91lNDc0ub
         2J9g==
X-Gm-Message-State: AOUpUlFpa86ebbLdvsCcj/oZv31NXXYAe01IxnXeMo6vRe6rWYWtF4LB
        O2rnVnIbfVCkaw3RgRdcZNc=
X-Google-Smtp-Source: AAOMgpeIhKmqBFzKh/FNLtFB+Rq+To311NPRK+Bjjog7TBTrEMAC0nIKfbFpZ+Dl2Cq2xf85aqt3iw==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr7228909wre.29.1532945883847;
        Mon, 30 Jul 2018 03:18:03 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id n7-v6sm7298445wmc.2.2018.07.30.03.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 03:18:03 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 7716512440E;
        Mon, 30 Jul 2018 12:18:02 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        david@redhat.com, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v5 0/4] Refactor free_area_init_core and add free_area_init_core_hotplug
Date:   Mon, 30 Jul 2018 12:17:53 +0200
Message-Id: <20180730101757.28058-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Changes:

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

 include/linux/mm.h     |  15 ++----
 include/linux/mmzone.h |  26 +++++++---
 mm/memory_hotplug.c    |  16 ++----
 mm/mempolicy.c         |   4 +-
 mm/mm_init.c           |   9 +---
 mm/page_alloc.c        | 134 +++++++++++++++++++++++++++++++++++--------------
 6 files changed, 130 insertions(+), 74 deletions(-)

-- 
2.13.6

