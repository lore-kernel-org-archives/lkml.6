Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B34C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406E120840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="tX9ObQSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406E120840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeKIQoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:44:17 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45836 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbeKIQnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:43:32 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1E650886D4;
        Fri,  9 Nov 2018 20:04:16 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1541747056;
        bh=PMQhtDSc3oJyhBzmJkl78Lhqhbao3oLy+FftS3ZfJuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tX9ObQSo0ioBaTl2hn6Mt2wyQWHYBzlwCBQ/foWQPR2hhXqoRo/L1I5ivHW9IAB8W
         QktDVglIwH7qaVT5n/jbq7JlQPICh1lN7SkB06frFcOSCMGCebXKIoKjLFRnxY3cCi
         Mw6SkPC8FL8kC+PKhcxwugAb7juuKD9ZfZUWa6IXksS7rt7ZGJd+/4VAmPX6UL5GUZ
         8Ir+fMyrms6yMWTqlO2LMI0qyWwG8zjAv041QtHCAR4UkJvXXO3S5LhYDWKfqdpfSS
         H0cJIGXRPmfBOVjn9nF9sh7FMm6nfN+NwX/2YgP/K4ZQYS+FQ5BSOLKsPhR8Nswmof
         qPeOTf7LqRUJA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5be531600001>; Fri, 09 Nov 2018 20:04:00 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id E4AC613EEA1;
        Fri,  9 Nov 2018 20:04:04 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C16CC1E0BC9; Fri,  9 Nov 2018 20:03:59 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v6 7/9] EDAC: Add missing debugfs_create_x32 wrapper
Date:   Fri,  9 Nov 2018 20:03:47 +1300
Message-Id: <20181109070349.20464-8-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
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
