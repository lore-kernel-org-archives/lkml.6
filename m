Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED0BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F97320843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F97320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbeGYXPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:15:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39827 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730370AbeGYXPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:15:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so8766847wre.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bl/81BSqMfqMAozlJA/17n7uO5ZVtEHZYbOG3yyuBlo=;
        b=s0C+/ipp53lTkBSPIQZYRu7RKXaE5gqtWMUy1PA5FEZaFz/FBT4DVrMgk6CbGm3ca4
         /d8jMUmItaoejwcshYNXUCsfdIXzgBAlpyb/4XEr2/0NXpZ0zmOvr6Af83G45Vw2fIvX
         hHqO6RUYoFMpODOZjto/sNILAe9lsKWuxqzSlDp8WrFZub/a97CqRXOEDZfM1262Bk5J
         JfiatLHwj7bNp1JEMBEDYq6OG15/BgF4nBR+0hi44V6Fw5aX8kLmWf63ZEvnBjLkM6lX
         HtOtsF0dHWsPR5mhp3Aab0mi3AjMfy8DOGrXc4qjFfDrQJh+kJU/S7MyPGv2PPKpP637
         ksfg==
X-Gm-Message-State: AOUpUlH73jpPjiWNWoqXxLPMGh8CZx0SRnBFhVBAfSvK7VrjrD3YXXSb
        GPeqaESMYD+0k8pIelKnGPM=
X-Google-Smtp-Source: AAOMgpdcdIQQgUdhYdbA5YN732by20J2ilmf3XGw0ODQiEl34sJDPZyd9pt+9KP6fUy+ziKUINpjxQ==
X-Received: by 2002:adf:eb87:: with SMTP id t7-v6mr6045327wrn.123.1532556111483;
        Wed, 25 Jul 2018 15:01:51 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id t69-v6sm82367wmt.40.2018.07.25.15.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:01:50 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 07FF11241AD;
        Thu, 26 Jul 2018 00:01:50 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 0/5] Refactor free_area_init_core and add free_area_init_core_hotplug
Date:   Thu, 26 Jul 2018 00:01:39 +0200
Message-Id: <20180725220144.11531-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patchset does three things:

 1) Clean ups/refactor free_area_init_core/free_area_init_node
    by moving the ifdefery out of the functions.
 2) Move the pgdat/zone initialization in free_area_init_core to its
    own function.
 3) Introduce free_area_init_core_hotplug, a small subset of free_area_init_core,
    which is only called from memhotlug code path.
    In this way, we have:

    free_area_init_core: called during early initialization
    free_area_init_core_hotplug: called whenever a new node was allocated (memhotplug path)

Oscar Salvador (4):
  mm/page_alloc: Move ifdefery out of free_area_init_core
  mm/page_alloc: Inline function to handle
    CONFIG_DEFERRED_STRUCT_PAGE_INIT
  mm/page_alloc: Move initialization of node and zones to an own
    function
  mm/page_alloc: Introduce memhotplug version of free_area_init_core

Pavel Tatashin (1):
  mm: access zone->node via zone_to_nid() and zone_set_nid()

 include/linux/mm.h     |  10 +---
 include/linux/mmzone.h |  26 +++++++---
 mm/memory_hotplug.c    |  23 ++++-----
 mm/mempolicy.c         |   4 +-
 mm/mm_init.c           |   9 +---
 mm/page_alloc.c        | 132 +++++++++++++++++++++++++++++++++++--------------
 6 files changed, 129 insertions(+), 75 deletions(-)

-- 
2.13.6

