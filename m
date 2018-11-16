Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3F8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3662086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3662086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389437AbeKPSl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:41:58 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39272 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389359AbeKPSl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:41:57 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so16406864edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 00:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4D3ilvRNbEdywbamB4FAtEIm3b4AWw0D1l/xvNW28A=;
        b=lIw1KkeP1x61MMwqiPlDfE4rARdgELiaK1l+ZMMSUWYHjj+UdYFFcIWoT6aQIxwVtH
         1vs9HG+kEogpTMSfWAUO1Rwk0CbHCFHpnWsFlQbqUW1zPGgg9zneIOP3dPNE2BV6ww0G
         RgT/AmjefKXhnmwTIiGCc6i0yWnFzDy7rAgG6zm+ljXcxTuMulJaF02b2UWhDxTNNxbW
         XxUXRQrXee1JLviqnSYQ+Yu2Am93FtXAZ774mM8WMfz9rlgiGB/nBJocx24a1VuS/sfx
         5Mo93ZOeUOPWrZWnw1NwoYJ8nLsjCOgtUqPz2L6OSn87AGV8tpRfU+jctNaQ2dQBdWHy
         6sMw==
X-Gm-Message-State: AGRZ1gIGcd/WxU4HzLxaYbuG5eY9DXaaR6JdNyxmBK8BOcp/+UOda7N3
        O2GaAs0iGgU6aUOzne0pJ64=
X-Google-Smtp-Source: AJdET5ce8thTuMJ1q0vegNyv6CKr019FdypPkBANPR2wA8fynBbK/HMeJFfdMuj/HhmEqB5Y+sYBvg==
X-Received: by 2002:a17:906:f6cb:: with SMTP id jo11-v6mr1444856ejb.80.1542357036521;
        Fri, 16 Nov 2018 00:30:36 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m13sm5305393edd.2.2018.11.16.00.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 00:30:35 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <OSalvador@suse.com>, Baoquan He <bhe@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 3/5] mm, memory_hotplug: drop pointless block alignment checks from __offline_pages
Date:   Fri, 16 Nov 2018 09:30:18 +0100
Message-Id: <20181116083020.20260-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116083020.20260-1-mhocko@kernel.org>
References: <20181116083020.20260-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

This function is never called from a context which would provide
misaligned pfn range so drop the pointless check.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2b2b3ccbbfb5..a92b1b8f6218 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1554,12 +1554,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	struct zone *zone;
 	struct memory_notify arg;
 
-	/* at least, alignment against pageblock is necessary */
-	if (!IS_ALIGNED(start_pfn, pageblock_nr_pages))
-		return -EINVAL;
-	if (!IS_ALIGNED(end_pfn, pageblock_nr_pages))
-		return -EINVAL;
-
 	mem_hotplug_begin();
 
 	/* This makes hotplug much easier...and readable.
-- 
2.19.1

