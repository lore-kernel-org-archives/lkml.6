Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AE2C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DA02080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpZoYzLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DA02080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeLNEHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:07:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37190 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNEHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 23:07:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so2169101pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 20:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=706ugoSFA3ymuQUNBKujB1WwD4e1IjlNm1YwTPv7M+M=;
        b=IpZoYzLklxBXfrJU2i26x/Up3fdEdRBeHckTBsTwEmj0ASs4if17wvS9yQykFSLJne
         23QSHTlBsVA7Rx0AbI+fDrT1gDtQpaQq4NiR7tJkXauhn6Rl2hH+NjAGv2vT3lt6argH
         fN8M2Sz1luM4yJX6VwIX6bBmKX5Voxxid5nzTwao61/lO+RiZmTWz57ERT3yfDkAOGId
         ON+mt4qffLvIS2HQ6cXvohsm0SnIbD9mfqBWLBnB1FkXrPkDQEePBx5P1f1tV+yq5Adp
         39edmuWZUgnUKgZNZ7FrHRayWp6gNyKHluEEVhKcCc69eJW7THwn5q2lW9SQZIJXiKoW
         5Ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=706ugoSFA3ymuQUNBKujB1WwD4e1IjlNm1YwTPv7M+M=;
        b=S0Mj0oVdli45PsKVvZfqv7sdjFBA/yEqECCsm1OwIKT6tjdiIY4Jys/rUURFb9o3zP
         g8i8XLnqJBRMOLwqtBGsx3FHHddYlYI3ZlgDz3s9RsfB8b4K65DknE2AEomCHufVPR46
         WJ4BZn/TPx3wqK1QtFE0Kbi3IYsxanAybPAfN6GkPo54WHXAWgG4ol3PERfFutPcWC+1
         Ul73COSN7ZX1ngNXBQ6AT7o0LpRrzkgV3Sd+OF5PxR+0Vf1GfViwX2e02UnC76J3Bw7l
         8NDLWzXl2N34isHnXbK4huylvU7U/Ijfce+nn9YjTXcg8YMtGmJ78VhVc0tTESHllHVa
         q7lw==
X-Gm-Message-State: AA+aEWYwhD40Rn5YrAVbNNzejORqjYrsTDNrea8FVOrv4eBAXrmvsosO
        pvBbNKs3KjlfAIJ96T0GQ90yfezbug==
X-Google-Smtp-Source: AFSGD/XYoek3+hXpkI12rFuxYgdXh4eEeLByOOBViIf+PVj+WT3uBRWv+vhEx2I8Q1ZUT8y0dZQCdw==
X-Received: by 2002:a63:5f88:: with SMTP id t130mr1362254pgb.395.1544760463739;
        Thu, 13 Dec 2018 20:07:43 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r66sm4609160pfk.157.2018.12.13.20.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 20:07:42 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, yinghai@kernel.org,
        vgoyal@redhat.com, kexec@lists.infradead.org
Subject: [PATCHv2] x86/kdump: bugfix, make the behavior of crashkernel=X consistent with kaslr
Date:   Fri, 14 Dec 2018 12:07:26 +0800
Message-Id: <1544760446-506-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Customer reported a bug on a high end server with many pcie devices, where
kernel bootup with crashkernel=384M, and kaslr is enabled. Even
though we still see much memory under 896 MB, the finding still failed
intermittently. Because currently we can only find region under 896 MB,
if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
randomly, and crashkernel reservation need be aligned to 128 MB, that's
why failure is found. It raises confusion to the end user that sometimes
crashkernel=X works while sometimes fails.
If want to make it succeed, customer can change kernel option to
"crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
limited space to behave even though its grammer looks more generic.
And we can't answer questions raised from customer that confidently:
1) why it doesn't succeed to reserve 896 MB;
2) what's wrong with memory region under 4G;
3) why I have to add ',high', I only require 384 MB, not 3840 MB.

This patch simplifies the method suggested in the mail [1]. It just goes
bottom-up to find a candidate region for crashkernel. The bottom-up may be
better compatible with the old reservation style, i.e. still want to get
memory region from 896 MB firstly, then [896 MB, 4G], finally above 4G.

There is one trivial thing about the compatibility with old kexec-tools:
if the reserved region is above 896M, then old tool will fail to load
bzImage. But without this patch, the old tool also fail since there is no
memory below 896M can be reserved for crashkernel.

[1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: yinghai@kernel.org,
Cc: vgoyal@redhat.com
Cc: kexec@lists.infradead.org

---
v1->v2:
  improve commit log
 arch/x86/kernel/setup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d494b9b..60f12c4 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -541,15 +541,18 @@ static void __init reserve_crashkernel(void)
 
 	/* 0 means: find the address automatically */
 	if (crash_base <= 0) {
+		if (!memblock_bottom_up())
+			memblock_set_bottom_up(true);
 		/*
 		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
 		 * as old kexec-tools loads bzImage below that, unless
 		 * "crashkernel=size[KMG],high" is specified.
 		 */
 		crash_base = memblock_find_in_range(CRASH_ALIGN,
-						    high ? CRASH_ADDR_HIGH_MAX
-							 : CRASH_ADDR_LOW_MAX,
-						    crash_size, CRASH_ALIGN);
+			(max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN);
+		if (!memblock_bottom_up())
+			memblock_set_bottom_up(false);
+
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
-- 
2.7.4

