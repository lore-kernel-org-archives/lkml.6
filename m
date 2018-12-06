Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11502C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D845D214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D845D214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLFT20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:28:26 -0500
Received: from hall.aurel32.net ([163.172.24.10]:35656 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLFT20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:28:26 -0500
X-Greylist: delayed 1364 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2018 14:28:25 EST
Received: from [2001:bc8:30d7:120:9bb5:8936:7e6a:9e36] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <aurelien@aurel32.net>)
        id 1gUyxv-0007BB-FS; Thu, 06 Dec 2018 20:05:39 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.91)
        (envelope-from <aurelien@aurel32.net>)
        id 1gUyxu-0004Eq-LJ; Thu, 06 Dec 2018 20:05:38 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, x86@kernel.org,
        Aurelien Jarno <aurelien@aurel32.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "H . J . Lu" <hjl.tools@gmail.com>
Subject: [PATCH] vfs: fix preadv64v2 and pwritev64v2 compat syscalls with offset == -1
Date:   Thu,  6 Dec 2018 20:05:34 +0100
Message-Id: <20181206190534.16246-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preadv2 and pwritev2 syscalls are supposed to emulate the readv and
writev syscalls when offset == -1. Therefore the compat code should
check for offset before calling do_compat_preadv64 and
do_compat_pwritev64. This is the case for the preadv2 and pwritev2
syscalls, but handling of offset == -1 is missing in their 64-bit
equivalent.

This patch fixes that, calling do_compat_readv and do_compat_writev when
offset == -1. This fixes the following glibc tests on x32:
 - misc/tst-preadvwritev2
 - misc/tst-preadvwritev64v2

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 fs/read_write.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 4dae0399c75a..c2dd3737fea2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1241,6 +1241,9 @@ COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
 		const struct compat_iovec __user *,vec,
 		unsigned long, vlen, loff_t, pos, rwf_t, flags)
 {
+	if (pos == -1)
+		return do_compat_readv(fd, vec, vlen, flags);
+
 	return do_compat_preadv64(fd, vec, vlen, pos, flags);
 }
 #endif
@@ -1347,6 +1350,9 @@ COMPAT_SYSCALL_DEFINE5(pwritev64v2, unsigned long, fd,
 		const struct compat_iovec __user *,vec,
 		unsigned long, vlen, loff_t, pos, rwf_t, flags)
 {
+	if (pos == -1)
+		return do_compat_writev(fd, vec, vlen, flags);
+
 	return do_compat_pwritev64(fd, vec, vlen, pos, flags);
 }
 #endif
-- 
2.19.1

