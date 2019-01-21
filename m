Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A2CC282E6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65CC2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUifWiu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfAUHvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:51:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34404 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfAUHvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:51:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so9758315pfg.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VwtpKFkarJQTrnp91bAROukJhzGrFDojqjTq9xzyvLM=;
        b=QUifWiu/dxnIP6lpjGUy3QpJG0R+7KqDRevW7A9+I0xyIC0m0J5rhjA2YDs+iy3nHz
         TsfjOzNxqmnMXrWyakTOqaMRetpwYFlfV1EUBhQRN4ErmLGwjlW5xQU0guk7Z7ml+ErP
         ntvRjMF+eC/DuPjBygVuLGCATuTSZcAL7tFNBhIdzyE6CuF6EbkskaHEaGuFRKtXUelh
         ujGOYF9mcfJDyIEK0nKVqNv+DNz3ErJzdTbhMfn7j2E4Ner4ygiSzw8TpxjsLsO6Ur9+
         jb+keQXX+gQurfaA7WcPgwlluG3CxDNywcDuZoYyjEnSvVjRm877C9h1X8cQsisTBKSq
         HzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VwtpKFkarJQTrnp91bAROukJhzGrFDojqjTq9xzyvLM=;
        b=NiRHw9S6PMSG8cGBVy6mm+2KmOMzHV9anCySANb0e6pucBTPT66lG1STx8pkT3c2t0
         Z1nupasrADg1C6mWtxMohhTbUhiCSPd+jbS8K1gANhQT9nlne4Ixq2pLDsZXvFz7r1Tw
         +6lqYu40RfBAgifxwFnyyShjtwW0FFA8z5EQydPLmKp9Lu5MGmSqfRSH0JfoI2jH9fVI
         eQxBDf504TvrU8ktEpUry7FnMEobiAIXv0vGtBOPTWNv4SHdwjc4bs/gCo/XglmBjX1h
         R53qyMZ8AZ9cQkTTbDkJiRkHcw2QuWDHA671An7htY94w5blDJsTt2dd8VqzpASuwPgc
         D6AA==
X-Gm-Message-State: AJcUukdL41EffZHDxNcYecukoKFWsk+Dr0JHigGMgZRIo1J5IJnP3qDD
        rG1mks3NWgSlAOZzYiHtztI8DtECcw==
X-Google-Smtp-Source: ALg8bN6yx1jcaJKdqldfgFOXsjSWmgnYMe4fc14wSsbAQhH4w86lYENcV7kXUKPCAAqrQ+8hSY9j7Q==
X-Received: by 2002:a62:11c7:: with SMTP id 68mr28350595pfr.21.1548047790887;
        Sun, 20 Jan 2019 21:16:30 -0800 (PST)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k24sm16755208pfj.13.2019.01.20.21.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 21:16:30 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     kexec@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X consistent with kaslr
Date:   Mon, 21 Jan 2019 13:16:08 +0800
Message-Id: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

People reported crashkernel=384M reservation failed on a high end server
with KASLR enabled.  In that case there is enough free memory under 896M
but crashkernel reservation still fails intermittently.

The situation is crashkernel reservation code only finds free region under
896 MB with 128M aligned in case no ',high' being used.  And KASLR could
break the first 896M into several parts randomly thus the failure happens.
User has no way to predict and make sure crashkernel=xM working unless
he/she use 'crashkernel=xM,high'.  Since 'crashkernel=xM' is the most
common use case this issue is a serious bug.

And we can't answer questions raised from customer:
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
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
v6 -> v7: commit log improvement
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

