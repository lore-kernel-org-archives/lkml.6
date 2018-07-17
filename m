Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E633FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E8E2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E8E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeGQO0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:26:44 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731615AbeGQO0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:26:43 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lsf1t-1g37JF2Aif-012DLU; Tue, 17 Jul 2018 15:53:08 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jann Horn <jannh@google.com>, "Tobin C. Harding" <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] random: fix rdrand mix-in
Date:   Tue, 17 Jul 2018 15:53:00 +0200
Message-Id: <20180717135307.3713325-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:WZgbE637AAgQW4ChcH5dH8Sl4SIv1Fo5xxxZYegee96rlF0ZFCk
 Eu9pBEswRiWNfVXXKjvg07PBhpJZKn31b95OfwFwmvZDQ1cDz4g1ktbtYjSDsRnUkt9LSUo
 wYX8X07xqMJ5agcRoFLqzXPcieJXkjZvUyAa1MylVmtDxqvw6+6C64T8vtE5F8Ijk0yOYQb
 RTmJBBZzL7IweNUfaClEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VD8pRcCibbQ=:vLDYu1to3c6uBFHQ7a2Vry
 V5u2lhjT3ZXNj/Xt9KLCCL3gFjbjHlQbpnhNZA86yl1QW/V2GtG6YLOU0nJLLAlpuINFsJVfh
 jC71TPXLfs6d7TLdPInY/gNAfgVNyRMyqPdstF8lDGi2uf0rImdkjlS+X3Axf4dIe5FCocSa2
 OQTCXuQh2871uS6f5Q7A7PvViPHx1onXFVQ+7WDao2FDGbMxicB60uMOs7lRzRGMtQViX8DMl
 cVMaA+xl9opQ66x/W56YaBzFbLzvF98JKidE5/esPzCJIRJBke65CCdf+XvJNV/Ump/dVLezv
 CZwIeO7PARx73U2xkEgM3JxEnWD6bHa15oGJ9s5yexGoQhlrJ/0ou/vk6plQtpqCnNRGx1sUl
 o8tUUckC5Sn6JQSvRo07d6qT2+bG2LMt+JR77Sfaubi+s5DiangXY9RdIw8hypxjs6gKr2xy/
 ZSaFeiUUvoxRGtPBo1+jm88nTOqEsXxBe9IUbcYrm7bjPdrFcpLnNlDYGfBfu6gdjwf1cFBmF
 RBpnV4g0hbDbJ6sWF7qdsCwL3qTd+zpgP0/XYLnc04XE8auRdwo6GsswTPWFkm2cxLXvbDpdN
 aAkm4iwyPE7dnJC8i+gNtZfEybFDxxNV6qpw6BVCas0Ht9WGtdD7Ax8ipHNFc4u8CrRBgNQ2i
 5AqOD4ZPpmPR4Yno9QRjA8ijRUcakmg7cyJPs3CRixBypZR/jBxWrlKpZYphFi3VQI3Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added arch_get_random_int() call was done incorrectly,
using the output only if rdrand hardware was /not/ available. The
compiler points out that the data is uninitialized in this case:

drivers/char/random.c: In function 'write_pool.constprop':
drivers/char/random.c:1912:11: error: 't' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This fixes the condition so we only use that data when it was
valid.

Fixes: 349ddb707fb7 ("random: mix rdrand with entropy sent in from userspace")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 283fe390e878..71660aef8c8c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1907,7 +1907,7 @@ write_pool(struct entropy_store *r, const char __user *buffer, size_t count)
 			return -EFAULT;
 
 		for (b = bytes ; b > 0 ; b -= sizeof(__u32), i++) {
-			if (arch_get_random_int(&t))
+			if (!arch_get_random_int(&t))
 				continue;
 			buf[i] ^= t;
 		}
-- 
2.9.0

