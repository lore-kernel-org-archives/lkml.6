Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8888C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C82C20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsIgvhIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfAOIH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:07:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34293 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfAOIH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:07:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so915390pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 00:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KORwXFzpEltZpxmTPyMtmgz43m066XMlEdPBJpiM3/0=;
        b=FsIgvhIMImg15PtrbP8s4JebSMkj9LPglBtaib1EdTcWEvzL8cnD40evdiIiFUe2kM
         q2pQf4YH0sUKXWGHGpQQ9IsqAxfApzKQlMn4PRssXlnmz8Y/7YdkB1O9sa7ytRb1Kw9J
         n1HTfZre3NC8mU9eQkVQlbedyR1rVTS8SxQIGHUvIqUwE60BP+LWrp3DJ2weVpUfBYtF
         3sLvh8LGeChn9NSKwiRJi7ayLP652ZDuyf+r7JCGWaSbk3xOGEu3i519blZyYRb28Ic+
         WawfxPOM0eWHSc52OOpGczoZxPMbvGLgr+shyx/LrdiAc4pVHJVbSxqEch/ZjhyYAZsC
         j4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KORwXFzpEltZpxmTPyMtmgz43m066XMlEdPBJpiM3/0=;
        b=WFLpG+C4tCKMjwOqRvVVlEl88a5HBhZPjycIHLJIZK86jaTZ2nRpkUZBQhYjXZ8hVS
         HaH/MXRRJ6JIzVXrU4eZFbL+eu3xy9yZP8KbSkdE6xP57re7TEodvgN2y7BYlSAnnIr6
         YpY2S9EYoAkw200JcnZawvnjmSfJKRDy+maiUF+LnFxZMvarIcuTiN8buSeVlLozOq9c
         aJi5RMe5Dipm79TWIQp6S6oFKGcc1HcdfAQxd8U0hX/gygMBGePGeg01XOvXaLrFJAmu
         UntCyxU37SBsIDMITa6sCsCr1G3dkMxtDXot7Lsq37+jzTC9PwGtRU3Hi0Y5Jtwd7Rqd
         9o2g==
X-Gm-Message-State: AJcUukdyqUTYs/MECnjbUn7D94gOD0Uk2cJM/x5ycUXK0BX0EbEFr2Xq
        2T4Xjw2z2FzRtZ7A1+b4Jw==
X-Google-Smtp-Source: ALg8bN4LXZ3ndA2nTrxdjC7RVe4kHmgk/REXCtD+obhggQ891/R9TdOmT1H3vbh1DLUD3tt1ipntiw==
X-Received: by 2002:a62:5dd1:: with SMTP id n78mr2707653pfj.58.1547539645593;
        Tue, 15 Jan 2019 00:07:25 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n186sm2971538pfn.137.2019.01.15.00.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 00:07:24 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X consistent with kaslr
Date:   Tue, 15 Jan 2019 16:07:03 +0800
Message-Id: <1547539623-18201-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

People reported a bug on a high end server with many pcie devices, where
kernel bootup with crashkernel=384M, and kaslr is enabled. Even
though we still see much memory under 896 MB, the finding still failed
intermittently. Because currently we can only find region under 896 MB,
if without ',high' specified. Then KASLR breaks 896 MB into several parts
randomly, and crashkernel reservation need be aligned to 128 MB, that's
why failure is found. It raises confusion to the end user that sometimes
crashkernel=X works while sometimes fails.
If want to make it succeed, customer can change kernel option to
"crashkernel=384M,high". Just this give "crashkernel=xx@yy" a very
limited space to behave even though its grammar looks more generic.
And we can't answer questions raised from customer that confidently:
1) why it doesn't succeed to reserve 896 MB;
2) what's wrong with memory region under 4G;
3) why I have to add ',high', I only require 384 MB, not 3840 MB.
This patch tries to get memory region from 896 MB firstly, then [896MB,4G],
finally above 4G.
Dave Young sent the original post, and I just re-post it with commit log
improvement as his requirement.
http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
There was an old discussion below (previously posted by Chao Wang):
https://lkml.org/lkml/2013/10/15/601

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: yinghai@kernel.org,
Cc: vgoyal@redhat.com
Cc: Randy Dunlap <rdunlap@infradead.org>
---
v6 -> v7: fix spelling mistake pointed out by Randy
 arch/x86/kernel/setup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d872a5..fa62c81 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -551,6 +551,22 @@ static void __init reserve_crashkernel(void)
 						    high ? CRASH_ADDR_HIGH_MAX
 							 : CRASH_ADDR_LOW_MAX,
 						    crash_size, CRASH_ALIGN);
+#ifdef CONFIG_X86_64
+		/*
+		 * crashkernel=X reserve below 896M fails? Try below 4G
+		 */
+		if (!high && !crash_base)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						(1ULL << 32),
+						crash_size, CRASH_ALIGN);
+		/*
+		 * crashkernel=X reserve below 4G fails? Try MAXMEM
+		 */
+		if (!high && !crash_base)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						CRASH_ADDR_HIGH_MAX,
+						crash_size, CRASH_ALIGN);
+#endif
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
-- 
2.7.4

