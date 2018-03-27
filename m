Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49qwpWrGl4R/RKfU3l9BjhXHgB4ejdE5qsteL7PB6KmR0iFqjRxraBvnzZDmJ9xWqH70cen
ARC-Seal: i=1; a=rsa-sha256; t=1522168922; cv=none;
        d=google.com; s=arc-20160816;
        b=uK9m4G4RLTg+r2suG3lfSrKk0WmhOqnc61zeWYQBpFknPlp7VH1Wa/naty8sUV3qsu
         xIv5tVqliCm16DLhSoO79jxlB0FJwOyJyQ5cRmqmOXx8l8NUUdpOzJ+LCycJL+NhJPij
         TGhvi9tCI4b4q6pxj2eBjkstwvlpKqsUauL09vWran3tHBkbkJ7YIBzaiOgnz4X4DWKn
         G8n9LTaorSwqJuFcQKWafHtbdWnX4dw9PjR+AAUF3ghn6Zz4TSw5Fg9/oQzWdHlVtA8O
         9hEQc6oSED+Uu6tgzh6iUqYzfIWjZtGTkvY+Uq7P+biMADKw7uFcWAr6euQStxFvC4Vp
         0Kcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BdvJ8kfOktANeU3E23TEjwvbXTjKfI5QLc67m55AzkI=;
        b=dIbR96wHDL3ZEsLk3L2Kjmt87ZTb+gs1SSaOUjvTxMSH727RTr12UPK+fHbSGYQR0J
         56MNQDKe4+96snxcnL8pQcD9RGwRUlGPEyRFFZE7P9d5H/YgDwX/wGjzyZ4j1pN9ekru
         tejyYntRGKXTwn/sNMPfKw4FAcC2OqZNO7UxB5xKPv7IWfWJ2cT8pugpCRyYoghjjBVA
         8h1S3F+WeN5f0e/q9oCyp19tonMF5No/5X3RQLspRvy2CSjVwJ2P3VG0IicI13IBF9ba
         KfJVefq0ByM5YEawdALI2pqcZYRQ6alOSrt33oHqDbseHzDXUMFcWEk3XtQs/0KEBui0
         /NpA==
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
Subject: [PATCH 4.15 073/105] mtd: nand: fsl_ifc: Read ECCSTAT0 and ECCSTAT1 registers for IFC 2.0
Date: Tue, 27 Mar 2018 18:27:53 +0200
Message-Id: <20180327162802.457045203@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109230678306438?=
X-GMAIL-MSGID: =?utf-8?q?1596109799838866673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -227,11 +227,7 @@ static void fsl_ifc_run_command(struct m
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
