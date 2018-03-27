Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+h4yNPOLBRIGCpdCz7+IYuJB775VXHoiWgM8VPX2ExEWTG7kDQNnvru0L/pW56OYSCC41J
ARC-Seal: i=1; a=rsa-sha256; t=1522168349; cv=none;
        d=google.com; s=arc-20160816;
        b=rQIYJ4jGFrHz998A+MiRYg20yOZ74euovivTIgnEX0iSrLvRQncmCyrc3AMJW3YbjZ
         vn02ep6QEXjxzEMmMcCoipjuptUcXLL8+zn6f7HmXROLFn+/0i9hQ0IBk/e56Pf0poyi
         buNjyPcPt6nXI8bwml/qmX2uS7v3SCzjswwwPDC+SLRqlMIA7EbruupVzZrvUdxsiXxt
         VVf6ReXW3ayApfL8qKrQEQJ24mgx2fdPYl2LtriUEIgiht9tkc5FX8IuoWBhqyg31McI
         NS8beDGJjOyQuek1dH2/oq0qmSc+mAOrXpvFsqcEVvjrOtE+UwuGm7wVhHO5Hps9Hnjc
         6IWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=41qtkUHovDPKLh/wZvBW0ClTa4vVhk9Fa9KK7zkrTts=;
        b=n5cVeAnWDPOASbSQzsQvO7FzMFhHYXEIrrIHERdOAoNTTiTVFW2WG14fxMaKgIdg0Q
         FzVEQhNcFsrHVT8YtddqmYF9Ayb4MjjJLKsdAgZQa9RQ8dOat66H5mFzeqmLAoOnqJXN
         IchSe8UKz86y6beqd0h4s5w4w9pBDlVPWN+ZdkzH1nV5Ia5VzQq8d5O1eHhQgJ5AZ9Ss
         UkesuRwtmSY/uVfPUy9m4HgPDTDJnvyLsTjlZmTkYmNy0mdoOy2CFwFWZ8bR5s+2mvvc
         ctL6t63k1W8cmblodNiLOu2lnf4NErHkRIUkDMtaBt7qvlIQN8h9JnHPlDI9kzww0Nhu
         5pQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
	Jagdish Gediya <jagdish.gediya@nxp.com>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.9 40/67] mtd: nand: fsl_ifc: Fix eccstat array overflow for IFC ver >= 2.0.0
Date: Tue, 27 Mar 2018 18:27:32 +0200
Message-Id: <20180327162729.208870444@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109199046549260?=
X-GMAIL-MSGID: =?utf-8?q?1596109199046549260?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jagdish Gediya <jagdish.gediya@nxp.com>

commit 843c3a59997f18060848b8632607dd04781b52d1 upstream.

Number of ECC status registers i.e. (ECCSTATx) has been increased in IFC
version 2.0.0 due to increase in SRAM size. This is causing eccstat
array to over flow.

So, replace eccstat array with u32 variable to make it fail-safe and
independent of number of ECC status registers or SRAM size.

Fixes: bccb06c353af ("mtd: nand: ifc: update bufnum mask for ver >= 2.0.0")
Cc: stable@vger.kernel.org # 3.18+
Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/fsl_ifc_nand.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -201,14 +201,9 @@ static int is_blank(struct mtd_info *mtd
 
 /* returns nonzero if entire page is blank */
 static int check_read_ecc(struct mtd_info *mtd, struct fsl_ifc_ctrl *ctrl,
-			  u32 *eccstat, unsigned int bufnum)
+			  u32 eccstat, unsigned int bufnum)
 {
-	u32 reg = eccstat[bufnum / 4];
-	int errors;
-
-	errors = (reg >> ((3 - bufnum % 4) * 8)) & 15;
-
-	return errors;
+	return  (eccstat >> ((3 - bufnum % 4) * 8)) & 15;
 }
 
 /*
@@ -221,7 +216,7 @@ static void fsl_ifc_run_command(struct m
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_nand_ctrl *nctrl = ifc_nand_ctrl;
 	struct fsl_ifc_runtime __iomem *ifc = ctrl->rregs;
-	u32 eccstat[4];
+	u32 eccstat;
 	int i;
 
 	/* set the chip select for NAND Transaction */
@@ -256,8 +251,8 @@ static void fsl_ifc_run_command(struct m
 	if (nctrl->eccread) {
 		int errors;
 		int bufnum = nctrl->page & priv->bufnum_mask;
-		int sector = bufnum * chip->ecc.steps;
-		int sector_end = sector + chip->ecc.steps - 1;
+		int sector_start = bufnum * chip->ecc.steps;
+		int sector_end = sector_start + chip->ecc.steps - 1;
 		__be32 *eccstat_regs;
 
 		if (ctrl->version >= FSL_IFC_VERSION_2_0_0)
@@ -265,10 +260,12 @@ static void fsl_ifc_run_command(struct m
 		else
 			eccstat_regs = ifc->ifc_nand.v1_nand_eccstat;
 
-		for (i = sector / 4; i <= sector_end / 4; i++)
-			eccstat[i] = ifc_in32(&eccstat_regs[i]);
+		eccstat = ifc_in32(&eccstat_regs[sector_start / 4]);
+
+		for (i = sector_start; i <= sector_end; i++) {
+			if (i != sector_start && !(i % 4))
+				eccstat = ifc_in32(&eccstat_regs[i / 4]);
 
-		for (i = sector; i <= sector_end; i++) {
 			errors = check_read_ecc(mtd, ctrl, eccstat, i);
 
 			if (errors == 15) {
