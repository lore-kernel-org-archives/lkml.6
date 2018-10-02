Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777EFC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DDF20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DDF20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbeJBVol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:44:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35760 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbeJBVok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:44:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so2628259wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lwbd+UcWSdJD5I10DIEnUzZN/CNn2JSB+Sr2UG85mb8=;
        b=gSY4TDNUYU69+mAptAZmgwiou3yIQXb9ry8a5mGS/fnKH211z4JypTiEB+O0A65AZ3
         H4hRFjyvM9fYf0otBTz6+zFwY6FUzpH+8AaM4Kob2yCW5poa5/Jc8UB0OJJ2xzJ0oRGA
         YpLwOvgF0FMWm045Lq3ouuV1WVgUvLsObdyKohoclilEGNVSu2Tzmqwrxb3jdVCpWlSR
         tOhCE/ZLj953KM9QOiotO5Lm8mD+P6LPmoIi6YO8jg5Nu7G+JKZwtG71dmZVRmTwsByL
         sxEoKBFlLPorffWtqhMiPQQEfAScPSJ90g2eUpXMydrWX6OCi57ehYVzWZ43eneK/cAI
         HBBQ==
X-Gm-Message-State: ABuFfoilCmDLth35o8+Q5DRJHvm+tHfFzEwCkQpMKamQe7Xqp8JzIOIt
        FYe6symbNySYcl1yRjTmuIs=
X-Google-Smtp-Source: ACcGV612eFxvdBhOaQBF5tFOJo32uiL1RlMkLE+CfelcEbtS8cxLLU0cgvxMMiBOfvjwD0RCQXjugg==
X-Received: by 2002:adf:eec4:: with SMTP id a4-v6mr11645875wrp.242.1538492449727;
        Tue, 02 Oct 2018 08:00:49 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id z89-v6sm37733989wrb.3.2018.10.02.08.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 08:00:48 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id A677612572A;
        Tue,  2 Oct 2018 17:00:47 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     linux-mm@kvack.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        david@redhat.com, dave.jiang@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v3 3/5] mm/memory_hotplug: Check for IORESOURCE_SYSRAM in release_mem_region_adjustable
Date:   Tue,  2 Oct 2018 17:00:27 +0200
Message-Id: <20181002150029.23461-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181002150029.23461-1-osalvador@techadventures.net>
References: <20181002150029.23461-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This is a preparation for the next patch.

Currently, we only call release_mem_region_adjustable() in __remove_pages
if the zone is not ZONE_DEVICE, because resources that belong to
HMM/devm are being released by themselves with devm_release_mem_region.

Since we do not want to touch any zone/page stuff during the removing
of the memory (but during the offlining), we do not want to check for
the zone here.
So we need another way to tell release_mem_region_adjustable() to not realease
the resource in case it belongs to HMM/devm.

HMM/devm acquires/releases a resource through
devm_request_mem_region/devm_release_mem_region.

These resources have the flag IORESOURCE_MEM, while resources acquired by
hot-add memory path (register_memory_resource()) contain
IORESOURCE_SYSTEM_RAM.

So, we can check for this flag in release_mem_region_adjustable, and if the
resource does not contain such flag, we know that we are dealing with a HMM/devm
resource, so we can back off.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 kernel/resource.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/resource.c b/kernel/resource.c
index 81937830a42f..6956ce3a4730 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1272,6 +1272,21 @@ int release_mem_region_adjustable(struct resource *parent,
 			continue;
 		}
 
+		/*
+		 * All memory regions added from memory-hotplug path
+		 * have the flag IORESOURCE_SYSTEM_RAM.
+		 * If the resource does not have this flag, we know that
+		 * we are dealing with a resource coming from HMM/devm.
+		 * HMM/devm use another mechanism to add/release a resource.
+		 * This goes via devm_request_mem_region/devm_release_mem_region.
+		 * HMM/devm take care to release their resources when they want, so
+		 * if we are dealing with them, let us just back off here.
+		 */
+		if (!(res->flags & IORESOURCE_SYSRAM)) {
+			ret = 0;
+			break;
+		}
+
 		if (!(res->flags & IORESOURCE_MEM))
 			break;
 
-- 
2.13.6

