Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C755C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE60720851
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="RZmkYOGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE60720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbeJ2QOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:14:17 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51816 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbeJ2QNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:13:25 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A0E0A8365E;
        Mon, 29 Oct 2018 20:25:53 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1540797953;
        bh=PMQhtDSc3oJyhBzmJkl78Lhqhbao3oLy+FftS3ZfJuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RZmkYOGOwJlIvt+KcWt9WGCqi8u+RltaYe5Ys3EZ14cs2ZWG2US3vgi2TGAz9bv2Q
         u79Ds5rxSdB1DaHIvg/su6b5V5BqZ6Lx2aX8ax6PnF/Xpz+vSwXhC6vVyDnMuwSo7d
         jeWXnfYF7xJdhqxI4Wy/VX+ApuFdQEKWTAg6WraGbfNaxEGAV7/r7K1JbSJM9sB9At
         VsL/Lm2dyNFjY50XAdATSLZENAonKw1oPn6OiToRclksiJOlL80Edu9LmT0tw0v2S7
         gOf48YUVB6EFKs6wCR9iDZO51ux69Ywn9iR8biYjhfjw7Gq9wDwvx1+4XCVmo7fRv1
         stBiPrzdp1MIQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bd6b6010001>; Mon, 29 Oct 2018 20:25:53 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id DD1AE13EFE2;
        Mon, 29 Oct 2018 20:25:53 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 0FA821E21FF; Mon, 29 Oct 2018 20:25:49 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk
Cc:     u.kleine-koenig@pengutronix.de, jlu@pengutronix.de, bp@alien8.de,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v5 6/8] EDAC: Add missing debugfs_create_x32 wrapper
Date:   Mon, 29 Oct 2018 20:25:33 +1300
Message-Id: <20181029072535.31667-7-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181029072535.31667-1-chris.packham@alliedtelesis.co.nz>
References: <20181029072535.31667-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Luebbe <jlu@pengutronix.de>

We already have wrappers for x8 and x16, so add the missing x32 one.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
=20drivers/edac/debugfs.c     | 11 +++++++++++
=20drivers/edac/edac_module.h |  5 +++++
=202 files changed, 16 insertions(+)

diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
index 92dbb7e2320c..268ede7a60b2 100644
--- a/drivers/edac/debugfs.c
+++ b/drivers/edac/debugfs.c
@@ -161,3 +161,14 @@ struct dentry *edac_debugfs_create_x16(const char *n=
ame, umode_t mode,
=20	return debugfs_create_x16(name, mode, parent, value);
=20}
=20EXPORT_SYMBOL_GPL(edac_debugfs_create_x16);
+
+/* Wrapper for debugfs_create_x32() */
+struct dentry *edac_debugfs_create_x32(const char *name, umode_t mode,
+				       struct dentry *parent, u32 *value)
+{
+	if (!parent)
+		parent =3D edac_debugfs;
+
+	return debugfs_create_x32(name, mode, parent, value);
+}
+EXPORT_SYMBOL_GPL(edac_debugfs_create_x32);
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index dec88dcea036..546b16e29221 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -82,6 +82,8 @@ struct dentry *
=20edac_debugfs_create_x8(const char *name, umode_t mode, struct dentry *=
parent, u8 *value);
=20struct dentry *
=20edac_debugfs_create_x16(const char *name, umode_t mode, struct dentry =
*parent, u16 *value);
+struct dentry *
+edac_debugfs_create_x32(const char *name, umode_t mode, struct dentry *p=
arent, u32 *value);
=20#else
=20static inline int edac_debugfs_init(void)					{ return -ENODEV; }
=20static inline void edac_debugfs_exit(void)					{ }
@@ -98,6 +100,9 @@ edac_debugfs_create_x8(const char *name, umode_t mode,=

=20static inline struct dentry *
=20edac_debugfs_create_x16(const char *name, umode_t mode,
=20		       struct dentry *parent, u16 *value)			{ return NULL; }
+static inline struct dentry *
+edac_debugfs_create_x32(const char *name, umode_t mode,
+		       struct dentry *parent, u32 *value)			{ return NULL; }
=20#endif
=20
=20/*
--=20
2.19.1
