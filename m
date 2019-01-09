Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223D8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DBC206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfAIOsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:48:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56626 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbfAIOsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:48:10 -0500
Received: from [5.158.153.52] (helo=slartibartfast.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <manut@linutronix.de>)
        id 1ghF9M-0002e8-AY; Wed, 09 Jan 2019 15:48:08 +0100
From:   Manuel Traut <manut@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     sasha.levin@oracle.com, Manuel Traut <manut@linutronix.de>
Subject: [PATCH] scripts/decode_stacktrace.sh: prefix addr2line with $CROSS_COMPILE
Date:   Wed,  9 Jan 2019 15:47:56 +0100
Message-Id: <20190109144756.24202-1-manut@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least for ARM64 kernels compiled with the crosstoolchain from
Debian/stretch or with the toolchain from kernel.org the line number is not
decoded correctly by 'decode_stacktrace.sh':

$ echo "[  136.513051]  f1+0x0/0xc [kcrash]" | \
  CROSS_COMPILE=/opt/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux- \
 ./scripts/decode_stacktrace.sh /scratch/linux-arm64/vmlinux \
                                /scratch/linux-arm64 \
                                /nfs/debian/lib/modules/4.20.0-devel
[  136.513051] f1 (/linux/drivers/staging/kcrash/kcrash.c:68) kcrash

If addr2line from the toolchain is used the decoded line number is correct:

[  136.513051] f1 (/linux/drivers/staging/kcrash/kcrash.c:57) kcrash

Signed-off-by: Manuel Traut <manut@linutronix.de>
---
 scripts/decode_stacktrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 64220e36ce3b..2f8c30b5c85b 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -66,7 +66,7 @@ parse_symbol() {
 	if [[ "${cache[$module,$address]+isset}" == "isset" ]]; then
 		local code=${cache[$module,$address]}
 	else
-		local code=$(addr2line -i -e "$objfile" "$address")
+		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address")
 		cache[$module,$address]=$code
 	fi
 
-- 
2.20.1

