Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0877EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F4320883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQCid65T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F4320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeKIQ0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:26:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32996 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbeKIQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:26:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id w22-v6so509653plk.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9DJFcKlJJiJ+Adjp9pPwaHOqo/nJGemRGYZuMELBj8A=;
        b=uQCid65TF8sng2YSSfz4J4DdW5Or8lUZ8VX5K8FXmbK6ie7EpUB9Rg3E81Z+ZKzh75
         x6JxMb8pw79ckVogFV5IJd81nJcjoRBj8XA1tHzURc5tneRQ+HUDfOmAGmw55jjyUvEs
         YreOhgU4/Z5Ik2lxFQtHDiZDyge5PiquAMF1aEh+rk9diamSA/koWheiesZ0itasdbaU
         97yU45tEDNUYzpEYS6YNVdzPIMJuED/OZiuXFD02YW1fHBAJhy7TbDse9LQpH0lpv3k8
         udtveFHnbfRa2hyqcL747oEIj/OEb0NvKWCyy+5Yl1DLCTDWp8WKBQC8O2W6Cw4YxCdz
         sy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=9DJFcKlJJiJ+Adjp9pPwaHOqo/nJGemRGYZuMELBj8A=;
        b=nki17w8rzjwdXajAgOUs05QAfaB+QHKKWjomNUkkNFvKrNgVSHYID0xwIcGfJ7pl1+
         No2h6Hvi1O8XMcJxf85t/lO8qE0aMaABEcedoBV1el3A5CPaEdOQcdtkuqwmULlf7LG5
         gs/kkB5IlWt4FAMD7u1ILjKSq5QxBjMbcnWesKeDRjzgTBgu+BGX1kSjWW+Sw3IX60Mz
         zVSy+aEAltYVOHi4gMsSDXmip7krL+gC3dMBWrs60LaCuM63p5fqFSsCWwg327AbJ6w3
         QGnYe3oe8+lAmR9Eb02XJILn1WT8bB7sN/H0FApFRujrXNa4UooGnqlzm2eVvokA8DWc
         zmnw==
X-Gm-Message-State: AGRZ1gIOkRlfTg/NYu3tbnPo4ApviDxXJAWMWCPAeB1cv8xi5GShZjFb
        SOrY58DgmqqqtUymr8TE8Q==
X-Google-Smtp-Source: AJdET5c18VaLRA2NAXOA8WsQgpjRuBVfBbcG23XHcUbq5h80KjAALEeN9ruRMTSSaEPaypfq9ccq3g==
X-Received: by 2002:a17:902:8486:: with SMTP id c6-v6mr7466272plo.119.1541746060224;
        Thu, 08 Nov 2018 22:47:40 -0800 (PST)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6808355pfg.97.2018.11.08.22.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 22:47:39 -0800 (PST)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [RFC][PATCH v1 05/11] mm: hwpoison-inject: don't pin for hwpoison_filter()
Date:   Fri,  9 Nov 2018 15:47:09 +0900
Message-Id: <1541746035-13408-6-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another memory error injection interface debugfs:hwpoison/corrupt-pfn
also takes bogus refcount for hwpoison_filter(). It's justified
because this does a coarse filter, expecting that memory_failure()
redoes the check for sure.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/hwpoison-inject.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git v4.19-mmotm-2018-10-30-16-08/mm/hwpoison-inject.c v4.19-mmotm-2018-10-30-16-08_patched/mm/hwpoison-inject.c
index b6ac706..766062c 100644
--- v4.19-mmotm-2018-10-30-16-08/mm/hwpoison-inject.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/mm/hwpoison-inject.c
@@ -25,11 +25,6 @@ static int hwpoison_inject(void *data, u64 val)
 
 	p = pfn_to_page(pfn);
 	hpage = compound_head(p);
-	/*
-	 * This implies unable to support free buddy pages.
-	 */
-	if (!get_hwpoison_page(p))
-		return 0;
 
 	if (!hwpoison_filter_enable)
 		goto inject;
@@ -39,23 +34,20 @@ static int hwpoison_inject(void *data, u64 val)
 	 * This implies unable to support non-LRU pages.
 	 */
 	if (!PageLRU(hpage) && !PageHuge(p))
-		goto put_out;
+		return 0;
 
 	/*
-	 * do a racy check with elevated page count, to make sure PG_hwpoison
-	 * will only be set for the targeted owner (or on a free page).
+	 * do a racy check to make sure PG_hwpoison will only be set for
+	 * the targeted owner (or on a free page).
 	 * memory_failure() will redo the check reliably inside page lock.
 	 */
 	err = hwpoison_filter(hpage);
 	if (err)
-		goto put_out;
+		return 0;
 
 inject:
 	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
-	return memory_failure(pfn, MF_COUNT_INCREASED);
-put_out:
-	put_hwpoison_page(p);
-	return 0;
+	return memory_failure(pfn, 0);
 }
 
 static int hwpoison_unpoison(void *data, u64 val)
-- 
2.7.0

