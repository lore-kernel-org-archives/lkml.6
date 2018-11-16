Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D546CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20672086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20672086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mess.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390016AbeKQCWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:22:39 -0500
Received: from gofer.mess.org ([88.97.38.141]:49467 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbeKQCWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:22:39 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id D48B6605DA; Fri, 16 Nov 2018 16:09:39 +0000 (GMT)
From:   Sean Young <sean@mess.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Remove superfluous check for __linux__
Date:   Fri, 16 Nov 2018 16:09:39 +0000
Message-Id: <20181116160939.22085-1-sean@mess.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building BPF code using "clang -target bpf -c", clang does not
define __linux__.

To build BPF IR decoders the include linux/lirc.h is needed which
includes linux/types.h. Currently this workaround is needed:

https://git.linuxtv.org/v4l-utils.git/commit/?id=dd3ff81f58c4e1e6f33765dc61ad33c48ae6bb07

This check might otherwise be useful to stop users from using a non-linux
compiler, but if you're doing that you are going to have a lot more
trouble anyway.

Signed-off-by: Sean Young <sean@mess.org>
---
 arch/mips/include/uapi/asm/sgidefs.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/mips/include/uapi/asm/sgidefs.h b/arch/mips/include/uapi/asm/sgidefs.h
index 26143e3b7c26..69c3de90c536 100644
--- a/arch/mips/include/uapi/asm/sgidefs.h
+++ b/arch/mips/include/uapi/asm/sgidefs.h
@@ -11,14 +11,6 @@
 #ifndef __ASM_SGIDEFS_H
 #define __ASM_SGIDEFS_H
 
-/*
- * Using a Linux compiler for building Linux seems logic but not to
- * everybody.
- */
-#ifndef __linux__
-#error Use a Linux compiler or give up.
-#endif
-
 /*
  * Definitions for the ISA levels
  *
-- 
2.19.1

