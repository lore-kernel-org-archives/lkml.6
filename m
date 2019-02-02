Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D975C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD9D20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="uwCBX5Kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfBBGYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:24:08 -0500
Received: from tomli.me ([153.92.126.73]:45102 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfBBGYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:24:08 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Feb 2019 01:23:43 EST
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id a5ba1c07;
        Sat, 2 Feb 2019 06:17:24 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:7b76:77ab)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Feb 2019 06:17:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=zS+qFKJ+ykWCn9siHyUTZoQDoSRi7BGV5qc6gtTuzXs=; b=uwCBX5KdK+IRmlyKmE31z9zkOMxjEhsXTQVnvdQZHrcAJecq3SJHKt5D3Hl/dS8liAFp/QoZNgkqWLDrjnCwf8Tnxl40EObpObjGw0tz9Xk5p5a+1s/rUtoN1+IGNt+8syY6i+FiHzwvaHnPPb7nQAl3zEEnqSy6tcgMNrSvfY85408EjbYtSTby5L/lv+6JveZPaemaGMBHvU7KNqTJRsL11Ac8gsUo4utiBDexZ8dmW/lhXvgdB7JgPZSkyKQfyPTXGgHtXzOR0I7+OtbAs0mRcbdDY6/Hri33WIzqJYgI4qY93fxPj8M0JIT6UVRwK4TiCZ4FFmRL7sFcp2oMCg==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3/8] fbdev: sm712fb: add 2D-related I/O headers and functions.
Date:   Sat,  2 Feb 2019 14:16:43 +0800
Message-Id: <20190202061648.30374-4-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
References: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds I/O macros and functions related to 2D opeartions.
A hunk of hardware register definitions are taken verbatim from
OpenBSD.

In addition, a utility function pad_to_dword() is added to help
padding data for the 2D engine. It  accepts 3, 2, or 1 byte(s) of
data, and pads it to a 32-bit word suitable for 2D Drawing Engine.

Yes, we can set info->pixmap.scan_align/buf_align = 4 and forget
about padding, but it's incompatible with cfb_imageblit() w/
depth == 1. In case we need to fallback (e.g. debugging), it would
be inconvenient, so we pad it manually.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/video/fbdev/sm712.h | 96 +++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/video/fbdev/sm712.h b/drivers/video/fbdev/sm712.h
index 942019dc816a..6d096c1b254c 100644
--- a/drivers/video/fbdev/sm712.h
+++ b/drivers/video/fbdev/sm712.h
@@ -95,6 +95,102 @@ static inline u8 smtc_seqr(u8 reg)
 	return smtc_mmiorb(0x3c5);
 }
 
+/*
+ * DPR (2D drawing engine)
+ */
+#define DPR_COORDS(x, y)		(((x) << 16) | (y))
+
+#define SCR_DE_STATUS			0x16
+#define SCR_DE_STATUS_MASK		0x18
+#define SCR_DE_ENGINE_IDLE		0x10
+
+#define DPR_BASE			0x00408000
+#define DPR_SRC_COORDS			0x00
+#define DPR_DST_COORDS			0x04
+#define DPR_SPAN_COORDS			0x08
+#define DPR_DE_CTRL			0x0c
+#define DPR_PITCH			0x10
+#define DPR_FG_COLOR			0x14
+#define DPR_BG_COLOR			0x18
+#define DPR_STRETCH			0x1c
+#define DPR_DE_FORMAT_SELECT		0x1e
+#define DPR_COLOR_COMPARE		0x20
+#define DPR_COLOR_COMPARE_MASK		0x24
+#define DPR_BYTE_BIT_MASK		0x28
+#define DPR_CROP_TOPLEFT_COORDS		0x2c
+#define DPR_CROP_BOTRIGHT_COORDS	0x30
+#define DPR_MONO_PATTERN_LO32		0x34
+#define DPR_MONO_PATTERN_HI32		0x38
+#define DPR_SRC_WINDOW			0x3c
+#define DPR_SRC_BASE			0x40
+#define DPR_DST_BASE			0x44
+
+#define DE_CTRL_START			0x80000000
+#define DE_CTRL_RTOL			0x08000000
+#define DE_CTRL_COMMAND_MASK		0x001f0000
+#define DE_CTRL_COMMAND_SHIFT			16
+#define DE_CTRL_COMMAND_BITBLT			0x00
+#define DE_CTRL_COMMAND_SOLIDFILL		0x01
+#define DE_CTRL_COMMAND_HOSTWRITE		0x08
+#define DE_CTRL_ROP2_SELECT		0x00008000
+#define DE_CTRL_ROP2_SRC_IS_PATTERN	0x00004000
+#define DE_CTRL_ROP2_SHIFT			0
+#define DE_CTRL_ROP2_COPY			0x0c
+#define DE_CTRL_HOST_SHIFT			22
+#define DE_CTRL_HOST_SRC_IS_MONO		0x01
+#define DE_CTRL_FORMAT_XY			0x00
+#define DE_CTRL_FORMAT_24BIT			0x30
+
+/*
+ * 32-bit I/O for 2D opeartions.
+ */
+extern void __iomem *smtc_dprbaseaddress;   /* DPR, 2D control registers */
+
+static inline u8 smtc_dprr(u8 reg)
+{
+	return readl(smtc_dprbaseaddress + reg);
+}
+
+static inline void smtc_dprw(u8 reg, u32 val)
+{
+	writel(val, smtc_dprbaseaddress + reg);
+}
+
+static inline void smtc_dprw_16(u8 reg, u16 val)
+{
+	writew(val, smtc_dprbaseaddress + reg);
+}
+
+static inline u32 pad_to_dword(const u8 *bytes, int length)
+{
+	u32 dword = 0;
+
+	switch (length) {
+#ifdef __BIG_ENDIAN
+	case 3:
+		dword |= bytes[2] << 8;
+	/* fallthrough */
+	case 2:
+		dword |= bytes[1] << 16;
+	/* fallthrough */
+	case 1:
+		dword |= bytes[0] << 24;
+		break;
+#else
+	case 3:
+		dword |= bytes[2] << 16;
+	/* fallthrough */
+	case 2:
+		dword |= bytes[1] << 8;
+	/* fallthrough */
+	case 1:
+		dword |= bytes[0];
+		break;
+#endif
+	}
+	return dword;
+}
+
 /* The next structure holds all information relevant for a specific video mode.
  */
 
-- 
2.20.1

