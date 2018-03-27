Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+g5zWzKXrtp56UPrprWNVna1dG4TJgcdKRSdBkh3uCwr9JR7cX66s+G5vrpFnSUCLX5UvX
ARC-Seal: i=1; a=rsa-sha256; t=1522168698; cv=none;
        d=google.com; s=arc-20160816;
        b=que61nwbpVNOeQK0n4/yaM89Bo7hJQ5fxP0KzAuNYTM3zta/c0astZkhdd+UP9NsQ2
         CJU5x+Gb87hf9D8Oyl4YNigIveNL67brO/Om06z054iXBFmAmygV9pLQfyU3c+xhrddj
         kkrdD2Vm1+mmFLFynFsKmyxu0J1HSBtWPXxpBgm5UXh+iA2EEi+RUYqxFCS0EJPDOP9w
         5bGxCX7NMMjsksqqNkOrwTwex2QjRCpx7IT08Eo4eFZaBVQNFdEzImPqclsOagf2v+2b
         hTpfwvuD1EmYGPd6XZkZ/Nwk4dIgUJf/LaaujbGJa+gYZ0Vq8XKEsR8N3tXok8dCWSn0
         B1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KuOq4+X6VmB/CshTVEW7qvHngP1Bygzt0aJPt2SbDqs=;
        b=yj/MIdW7dw5Gg0JR8AB78Aq+kqoPMjBjypG795FplcqwxueJMQys92+Tk09r9LVOUG
         fiDKEXe6MM7anfpmyMopPn6j9tolyAewGXtxgkhvNywUbaRw4zwGg4bFn35x/uaty/Qr
         XIke6f7c4DHCIx2SbdETvTK4QblAaDZ1APdKkZ7xuDqerSlkdhej6JqQ2L1z0z08TUJg
         mHLqaOzhoDJnB4jVhxTwph9l3z44GrDH7mXmMZPdnsD0o3kbBYMjqwyrvdZjtxAtgzw9
         q9WJvMy9in8h1OSe3nl13a0vssOJzY6P2C2UmQVxS+LTAokU1stxDsf6JiJaxXnAsg6c
         4eoQ==
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
Subject: [PATCH 4.14 067/101] mtd: nand: fsl_ifc: Fix eccstat array overflow for IFC ver >= 2.0.0
Date: Tue, 27 Mar 2018 18:27:39 +0200
Message-Id: <20180327162754.143057893@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109199046549260?=
X-GMAIL-MSGID: =?utf-8?q?1596109565409686646?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -173,14 +173,9 @@ static void set_addr(struct mtd_info *mt
 
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
@@ -193,7 +188,7 @@ static void fsl_ifc_run_command(struct m
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_nand_ctrl *nctrl = ifc_nand_ctrl;
 	struct fsl_ifc_runtime __iomem *ifc = ctrl->rregs;
-	u32 eccstat[4];
+	u32 eccstat;
 	int i;
 
 	/* set the chip select for NAND Transaction */
@@ -228,8 +223,8 @@ static void fsl_ifc_run_command(struct m
 	if (nctrl->eccread) {
 		int errors;
 		int bufnum = nctrl->page & priv->bufnum_mask;
-		int sector = bufnum * chip->ecc.steps;
-		int sector_end = sector + chip->ecc.steps - 1;
+		int sector_start = bufnum * chip->ecc.steps;
+		int sector_end = sector_start + chip->ecc.steps - 1;
 		__be32 *eccstat_regs;
 
 		if (ctrl->version >= FSL_IFC_VERSION_2_0_0)
@@ -237,10 +232,12 @@ static void fsl_ifc_run_command(struct m
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
