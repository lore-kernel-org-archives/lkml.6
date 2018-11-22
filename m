Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7A7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A3D2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="D4zqYW3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A3D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403813AbeKVKtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:49:12 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36649 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390789AbeKVKsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:48:50 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5199889155;
        Thu, 22 Nov 2018 13:12:06 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1542845526;
        bh=PMQhtDSc3oJyhBzmJkl78Lhqhbao3oLy+FftS3ZfJuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=D4zqYW3jsbarrVDy4CgM1k7OM1OKkdbfXWu4NHPJsT6c6t9pWMwmBxYByeVtxPIvB
         Sd+cm42FP+zpg+a1imrT5S7B91goEFJgsEe3ym4Ao+YSkuwvLXNSrDKxlc+TC7+uyp
         O/ZMeKJFyyAoy6JlOrjDrsFAU5jhFMd0lOlKeIZScmm0m+a7GP0H7yJogimQpII6b6
         71FKhy8BiAyaHZTvU8MMGuU59Cl6R2CjY6tHYhehMwjPHku4QE0IDJzuMORo58SibT
         ta/3w/wb+qiIm/ID88d5PcSHYlWo0OG60xHwJAhq+/CcAHnzxcEharNvE6PDD2WSW6
         SHYIjBkbTnVvA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bf5f4550005>; Thu, 22 Nov 2018 13:12:05 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 4E1A413EF06;
        Thu, 22 Nov 2018 13:12:08 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id DA8C01E08D9; Thu, 22 Nov 2018 13:12:02 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v7 7/9] EDAC: Add missing debugfs_create_x32 wrapper
Date:   Thu, 22 Nov 2018 13:11:40 +1300
Message-Id: <20181122001142.19187-8-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
References: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
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
