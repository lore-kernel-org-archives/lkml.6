Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/k8WFLj8oZw1tht26EQAzC+7k4kq2JKbAlz9PQSOfidjnnIriZZc/wmAi250gQZUV8HdTe
ARC-Seal: i=1; a=rsa-sha256; t=1522168379; cv=none;
        d=google.com; s=arc-20160816;
        b=Ub2KE3KJHQQpxJ75ZJaGcOQ9GcDKBAqk+I4Oh7jP+ZNygyRR5AXqEUfgGaWgU3w/g9
         Mf3eaHaLrbuCoXmmY4hect2u7hNFK+9X0Xoiprf0oXq2C1E8Kx3YmeUTbIbWfLLjbTGu
         vkp5k7ULRHfNr4FkYcA2c/9VUxgsN5RMdYcrBKaD1ZTD1ktbKkpJ4k/eZKrMRaofzi7c
         ejxO1r5aiG5Acb8gASE3rmG1aVlD8XTj4JWGBwrA9jQYQsyWXbW0ZLBxODi1UW16OotO
         RDFMeRHunbuk8YN5k/DDr2/pgzdJ6DdXq4kdXWUw+tmejl0ryXzyjbb/GqXcOKwdLQwq
         3+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2V7QZ5XPKvRbwo4Eko4VuwgZ6/iqhlLXMt8ZRqisprU=;
        b=d7faL8zVpoBLsJ2lNblqt5R/ER3jAazCtoXaDZnNCqIPwtOUhRcC3l6j54XdN/h1Z2
         mcdHgY+HbUosDIfZHfAjuzBs0uenBPuzVrRYm5kaJvveCc1ez4iJQXq3WccvO3ugbdfU
         1CJ6yFaM3whITF4hzseb8iXsM4GhiY26SUUWagvAV12uLUhXI6BPOLPJMZBkJPVsDVwZ
         /JaOGYHmSWDYt97XHXqfV3G5sKbuaKNsHEn1/Qj4UU1WDlpgCPKduVTuCF7RRz9ziLCq
         fy9B5zaItPvcOZEVb2VwUB3uc7DrWEDiyu0imZugTf6Dw3mYhCgQuBYD+wEG8tZ5Z1h3
         HWwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jagdish Gediya <jagdish.gediya@nxp.com>,
	Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.9 41/67] mtd: nand: fsl_ifc: Read ECCSTAT0 and ECCSTAT1 registers for IFC 2.0
Date: Tue, 27 Mar 2018 18:27:33 +0200
Message-Id: <20180327162729.280789939@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109230678306438?=
X-GMAIL-MSGID: =?utf-8?q?1596109230678306438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jagdish Gediya <jagdish.gediya@nxp.com>

commit 6b00c35138b404be98b85f4a703be594cbed501c upstream.

Due to missing information in Hardware manual, current
implementation doesn't read ECCSTAT0 and ECCSTAT1 registers
for IFC 2.0.

Add support to read ECCSTAT0 and ECCSTAT1 registers during
ecccheck for IFC 2.0.

Fixes: 656441478ed5 ("mtd: nand: ifc: Fix location of eccstat registers for IFC V1.0")
Cc: stable@vger.kernel.org # v3.18+
Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
Reviewed-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/fsl_ifc_nand.c |    6 +-----
 include/linux/fsl_ifc.h         |    6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -255,11 +255,7 @@ static void fsl_ifc_run_command(struct m
 		int sector_end = sector_start + chip->ecc.steps - 1;
 		__be32 *eccstat_regs;
 
-		if (ctrl->version >= FSL_IFC_VERSION_2_0_0)
-			eccstat_regs = ifc->ifc_nand.v2_nand_eccstat;
-		else
-			eccstat_regs = ifc->ifc_nand.v1_nand_eccstat;
-
+		eccstat_regs = ifc->ifc_nand.nand_eccstat;
 		eccstat = ifc_in32(&eccstat_regs[sector_start / 4]);
 
 		for (i = sector_start; i <= sector_end; i++) {
--- a/include/linux/fsl_ifc.h
+++ b/include/linux/fsl_ifc.h
@@ -734,11 +734,7 @@ struct fsl_ifc_nand {
 	u32 res19[0x10];
 	__be32 nand_fsr;
 	u32 res20;
-	/* The V1 nand_eccstat is actually 4 words that overlaps the
-	 * V2 nand_eccstat.
-	 */
-	__be32 v1_nand_eccstat[2];
-	__be32 v2_nand_eccstat[6];
+	__be32 nand_eccstat[8];
 	u32 res21[0x1c];
 	__be32 nanndcr;
 	u32 res22[0x2];
