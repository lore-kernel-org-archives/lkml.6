Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEEBC71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A09E2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A09E2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeJOXQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:16:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33031 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJOXQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:16:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id e4-v6so21873431wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 08:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JKE318wIKCFxCuunfg2WJB1Hno/yv4pQr9QRB3MB9UE=;
        b=B3ebfcTER+wrpidmSmsgn2t9Q3G0Sct1Q21/NIxho7LKn5Y9dtVIvtZa3Tt18lAuCK
         ayCOyFa2Dir5c4Adl7cDYMjTzEt66869H+hxLl1EFqNNO8bNrotvN6YeKmQ2J4emggp5
         8dC3grUApVy2BxK7ynpt6NGvuTQn2epJ8VE1NH4Jh+FUw0mVxjzrRMvh8VOfl4agNs9k
         VTzo/8sAPbSffBJbX6nDdCHZ1YKmxBTCBjqg5/X6tegPY7FFc6euyvMpbP3qjHO2Lw4S
         0EfxKOY3ULxbRjwO0l5pLTgJLpltyhpQgLt5ABqwsFQFZKg9fDa/trUZuZZebHb08aZ9
         opBA==
X-Gm-Message-State: ABuFfoiPPr9hjZgS/gKp/vWATcEWbUuzSo/JctIPnJ3DteV2oFXAut0K
        IKQDQTiHxiqzHYlnNd91+Po=
X-Google-Smtp-Source: ACcGV60wvEZ8JvfJapnVl+qBRKKwzhci+rtNmrhU40OZeeKHlRQJvUMi6foPtmo15PHXMVJtGnwGVw==
X-Received: by 2002:adf:a352:: with SMTP id d18-v6mr14941988wrb.31.1539617455156;
        Mon, 15 Oct 2018 08:30:55 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id a1-v6sm8859580wrt.79.2018.10.15.08.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 08:30:54 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 4B1191259A8;
        Mon, 15 Oct 2018 17:30:52 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        david@redhat.com, dave.jiang@intel.com, linux-mm@kvack.org,
        alexander.h.duyck@linux.intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 3/5] mm/memory_hotplug: Check for IORESOURCE_SYSRAM in release_mem_region_adjustable
Date:   Mon, 15 Oct 2018 17:30:32 +0200
Message-Id: <20181015153034.32203-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181015153034.32203-1-osalvador@techadventures.net>
References: <20181015153034.32203-1-osalvador@techadventures.net>
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
So we need another way to tell release_mem_region_adjustable() to not
realease the resource in case it belongs to HMM/devm.

HMM/devm acquires/releases a resource through
devm_request_mem_region/devm_release_mem_region.

These resources have the flag IORESOURCE_MEM, while resources acquired by
hot-add memory path (register_memory_resource()) contain
IORESOURCE_SYSTEM_RAM.

So, we can check for this flag in release_mem_region_adjustable, and if
the resource does not contain such flag, we know that we are dealing with
a HMM/devm resource, so we can back off.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 kernel/resource.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/resource.c b/kernel/resource.c
index 81937830a42f..c45decd7d6af 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1272,6 +1272,22 @@ int release_mem_region_adjustable(struct resource *parent,
 			continue;
 		}
 
+		/*
+		 * All memory regions added from memory-hotplug path
+		 * have the flag IORESOURCE_SYSTEM_RAM.
+		 * If the resource does not have this flag, we know that
+		 * we are dealing with a resource coming from HMM/devm.
+		 * HMM/devm use another mechanism to add/release a resource.
+		 * This goes via devm_request_mem_region and
+		 * devm_release_mem_region.
+		 * HMM/devm take care to release their resources when they want,
+		 * so if we are dealing with them, let us just back off here.
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

