Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C43C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C577A20898
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C577A20898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeH2Azg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:55:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33953 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeH2Azg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:55:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id m199-v6so2834558wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 14:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SeY6d0/ITeqoecKbPWVqyAHHkb7nxCmq1kmKXUf6pfc=;
        b=ZBlpJTAJcXGMkOPFmJPJmuT2m3WvJn/xKWUtxrVlPV0NKquKsaLCnNotpe2aKgr1sO
         KWptuVhXq8fuEaa2qs30t17TnEjaRqbVj6LrO2WejgmJfmLhyf5vfPMGDQY0x500ofb2
         CrkYePSbIHSKr/z0399eQmxPIXvwFwLpXaG6lZ7vBi7k1fSluw20wWY2voU8TOBDe0kp
         yBKr1FhD/fFLPKF5XXKYHad48OvcBKJdrnPHiImNfp+zT+g33hIhMkhm6YUXD9H3n4ur
         ONYcBRdBFcwinorYew7b5qHzLkRqVjJwtMSTM9G3YE9khKQzw62g4BDpawBkNIJBKIQH
         76Vg==
X-Gm-Message-State: APzg51DTlYtcUB+u+EOmg1YYb26qLPwGcwb22662UlGa5G6t17jjvm+k
        lQ9k8h2QkKxmppy4KCSCChE=
X-Google-Smtp-Source: ANB0VdaRSACAJUpy11fVV90YRu9xjoE8gaNbdvJ4n0Zm+XH6Abl+083EHXn14mHkiuCv2TQm8hTtvw==
X-Received: by 2002:a1c:a8d0:: with SMTP id r199-v6mr2261406wme.97.1535490129272;
        Tue, 28 Aug 2018 14:02:09 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id f13-v6sm2148183wrt.9.2018.08.28.14.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 14:02:08 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id A6C33124BC2;
        Tue, 28 Aug 2018 23:02:07 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, Pavel.Tatashin@microsoft.com,
        sfr@canb.auug.org.au, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm/page_alloc: Clean up check_for_memory
Date:   Tue, 28 Aug 2018 23:01:58 +0200
Message-Id: <20180828210158.4617-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

check_for_memory looks a bit confusing.
First of all, we have this:

if (N_MEMORY == N_NORMAL_MEMORY)
	return;

Checking the ENUM declaration, looks like N_MEMORY canot be equal to
N_NORMAL_MEMORY.
I could not find where N_MEMORY is set to N_NORMAL_MEMORY, or the other
way around either, so unless I am missing something, this condition 
will never evaluate to true.
It makes sense to get rid of it.

Moving forward, the operations whithin the loop look a bit confusing
as well.

We set N_HIGH_MEMORY unconditionally, and then we set N_NORMAL_MEMORY
in case we have CONFIG_HIGHMEM (N_NORMAL_MEMORY != N_HIGH_MEMORY)
and zone <= ZONE_NORMAL.
(N_HIGH_MEMORY falls back to N_NORMAL_MEMORY on !CONFIG_HIGHMEM systems,
and that is why we can just go ahead and set N_HIGH_MEMORY unconditionally)

Although this works, it is a bit subtle.

I think that this could be easier to follow:

First, we should only set N_HIGH_MEMORY in case we have
CONFIG_HIGHMEM.
And then we should set N_NORMAL_MEMORY in case zone <= ZONE_NORMAL,
without further checking whether we have CONFIG_HIGHMEM or not.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 839e0cc17f2c..6aa947f9e614 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6819,15 +6819,12 @@ static void check_for_memory(pg_data_t *pgdat, int nid)
 {
 	enum zone_type zone_type;
 
-	if (N_MEMORY == N_NORMAL_MEMORY)
-		return;
-
 	for (zone_type = 0; zone_type <= ZONE_MOVABLE - 1; zone_type++) {
 		struct zone *zone = &pgdat->node_zones[zone_type];
 		if (populated_zone(zone)) {
-			node_set_state(nid, N_HIGH_MEMORY);
-			if (N_NORMAL_MEMORY != N_HIGH_MEMORY &&
-			    zone_type <= ZONE_NORMAL)
+			if (IS_ENABLED(CONFIG_HIGHMEM))
+				node_set_state(nid, N_HIGH_MEMORY);
+			if (zone_type <= ZONE_NORMAL)
 				node_set_state(nid, N_NORMAL_MEMORY);
 			break;
 		}
-- 
2.13.6

