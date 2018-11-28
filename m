Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92930C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A6E206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A6E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mok.nu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeK2Dd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:33:56 -0500
Received: from proxy06.fsdata.se ([89.221.252.251]:7332 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727979AbeK2Dd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:33:56 -0500
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2018 22:33:55 EST
Received: from localhost (94.234.45.192) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 28 Nov 2018 17:16:29
 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>, <2pi@mok.nu>
Subject: [PATCH] x86: boot: add missing va_end to die
Date:   Wed, 28 Nov 2018 17:16:07 +0100
Message-ID: <20181128161607.10973-1-2pi@mok.nu>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [94.234.45.192]
X-ClientProxiedBy: PROXY01.HMC.local (192.168.46.51) To DAG01.HMC.local
 (192.168.46.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each call to va_start must have a corresponding call to va_end before
the end of the function. Add the missing va_end.

Found with Coccinelle.

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
---
 arch/x86/boot/tools/build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index d4e6cd4577e5..07223fd42d01 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -132,6 +132,7 @@ static void die(const char * str, ...)
 	va_list args;
 	va_start(args, str);
 	vfprintf(stderr, str, args);
+	va_end(args);
 	fputc('\n', stderr);
 	exit(1);
 }
-- 
2.19.2

