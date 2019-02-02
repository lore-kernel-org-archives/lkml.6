Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98663C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FA720870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="jyFdyIc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfBBGYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:24:01 -0500
Received: from tomli.me ([153.92.126.73]:45102 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfBBGYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:24:00 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Feb 2019 01:23:43 EST
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 60300660;
        Sat, 2 Feb 2019 06:17:18 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:7b76:77ab)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Feb 2019 06:17:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=sEFDZFlfDqKnYMQYk7vg5Y9I18fK+Xt8XdV3FTX5+0M=; b=jyFdyIc7VKf6ekP38FjjcyNFO7ZNH0+csscqp/3jG+SBtjegsYccFgnZH5S3WEevLZJO5XajWkAoi7eyBS+8ulq+MtSEyG+BIilpkThywIHMHqyXzGtd85/lTEDP+3/J6vZK8tHS8exdNdbj15ZCgPZ3xyHhIg8Zhurcafi4RClOfSo8EPjlwovcLaYL6L0ckyAf3yzlc2E3l4U5aNpsHvLeh0IRFNlySpgmDSFQB4JgBkBWJe34ssg9NqWBPLVnhksYj+Jj/rs79KknEEu5f235FxzPCNcHmbuSHmKq1JCad3pyK7IPB70tOSmNs0rDnrCA+useqMKnYQ6Rp2wt0A==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/8] fbdev: sm712fb: use type "u8" for 8-bit I/O.
Date:   Sat,  2 Feb 2019 14:16:42 +0800
Message-Id: <20190202061648.30374-3-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
References: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit converts "unsigned int" and "int" in I/O wrappers
to "u8". It improves readability since it's consistent with
the prototypes of readb() and writeb(). More importantly, it
reduces readers' confusion, since the upcoming 2D acceleration
code will use a different wordsize.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/video/fbdev/sm712.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/sm712.h b/drivers/video/fbdev/sm712.h
index 99077e91ae10..942019dc816a 100644
--- a/drivers/video/fbdev/sm712.h
+++ b/drivers/video/fbdev/sm712.h
@@ -63,19 +63,19 @@ extern void __iomem *smtc_regbaseaddress;
 #define SIZE_CR30_CR4D      (0x4D - 0x30 + 1)
 #define SIZE_CR90_CRA7      (0xA7 - 0x90 + 1)
 
-static inline void smtc_crtcw(int reg, int val)
+static inline void smtc_crtcw(u8 reg, u8 val)
 {
 	smtc_mmiowb(reg, 0x3d4);
 	smtc_mmiowb(val, 0x3d5);
 }
 
-static inline void smtc_grphw(int reg, int val)
+static inline void smtc_grphw(u8 reg, u8 val)
 {
 	smtc_mmiowb(reg, 0x3ce);
 	smtc_mmiowb(val, 0x3cf);
 }
 
-static inline void smtc_attrw(int reg, int val)
+static inline void smtc_attrw(u8 reg, u8 val)
 {
 	smtc_mmiorb(0x3da);
 	smtc_mmiowb(reg, 0x3c0);
@@ -83,13 +83,13 @@ static inline void smtc_attrw(int reg, int val)
 	smtc_mmiowb(val, 0x3c0);
 }
 
-static inline void smtc_seqw(int reg, int val)
+static inline void smtc_seqw(u8 reg, u8 val)
 {
 	smtc_mmiowb(reg, 0x3c4);
 	smtc_mmiowb(val, 0x3c5);
 }
 
-static inline unsigned int smtc_seqr(int reg)
+static inline u8 smtc_seqr(u8 reg)
 {
 	smtc_mmiowb(reg, 0x3c4);
 	return smtc_mmiorb(0x3c5);
-- 
2.20.1

