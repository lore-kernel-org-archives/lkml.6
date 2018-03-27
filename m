Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4805cXxm2tL45KpRS8QJnImjUrzkfcRBaJBSq5yZzlVHVBa26jYktETvfQAXyJFNp/d+CJE
ARC-Seal: i=1; a=rsa-sha256; t=1522168412; cv=none;
        d=google.com; s=arc-20160816;
        b=FofRu1N8HzJ8AcgNeU9rvu0KZLCpda+yMMIE4YamNPTEjsVRApObEG7nLeF/+GJnNu
         BfK4EXHgBwT7vsoD7PdE/pt49pNOPV1MwanAd+svygHsSqiiN443+ZjRi/f8nG+SXkWe
         5bmnx3Vnrp7LukUm4xSN419DWW3woj1+tXG4f7AoUGlVgKk0Gmsm8wJ2v4TaE1iYVoyL
         f8WUyeRiP2ZDVlKxN4cxB/ujuCjPH7d/Tn9ddJY2RF0APDL9Xq17ZEUJv7hpNkytoeiw
         k2/19JJmWCcONOMauIIX6ovFE32S28qTL4xIbIAnUU2k7fHvlZXeO8kKMaWzIMF0HPLR
         zx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dzVmKpvh7MVK3QfvpXMD7f+o8SehUNRV4AypIuCcY9I=;
        b=NhQxr4uaoJRainfaxyxE+YjDcAYBGb7ruQjNLRUdh61w5M1xZ+CC7qbj/P2JRjnD+P
         vbxvRTIL8eqEV7/OfZOpihOnyc5LzGxmHhG9UUdTh49wZvpBWnuNTYm1QelXB2OKY3xW
         lTIGh29fnE0QodugQ+pgwxfNnDsl6Ty92MQOkVfQqLNihzymq9UDbTIJnAnhY71eQn8h
         8BBN9vtMIDsSzWm4W7v9ro1Q+skBvWqc0f2BSgZtl5INikVkWW7auNlUvXHW+6M/Pg5m
         2sKh7QuEpDHKq1j4TJxebbTNFNlnMn9xI7oNHaHIMHDye3QyXxZ7/jHC5LjevwE/7g8G
         jUdA==
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
Subject: [PATCH 4.9 39/67] mtd: nand: fsl_ifc: Fix nand waitfunc return value
Date: Tue, 27 Mar 2018 18:27:31 +0200
Message-Id: <20180327162729.151278230@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109017538454485?=
X-GMAIL-MSGID: =?utf-8?q?1596109265365225418?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jagdish Gediya <jagdish.gediya@nxp.com>

commit fa8e6d58c5bc260f4369c6699683d69695daed0a upstream.

As per the IFC hardware manual, Most significant 2 bytes in
nand_fsr register are the outcome of NAND READ STATUS command.

So status value need to be shifted and aligned as per the nand
framework requirement.

Fixes: 82771882d960 ("NAND Machine support for Integrated Flash Controller")
Cc: stable@vger.kernel.org # v3.18+
Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
Reviewed-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/fsl_ifc_nand.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -656,6 +656,7 @@ static int fsl_ifc_wait(struct mtd_info
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_runtime __iomem *ifc = ctrl->rregs;
 	u32 nand_fsr;
+	int status;
 
 	/* Use READ_STATUS command, but wait for the device to be ready */
 	ifc_out32((IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
@@ -670,12 +671,12 @@ static int fsl_ifc_wait(struct mtd_info
 	fsl_ifc_run_command(mtd);
 
 	nand_fsr = ifc_in32(&ifc->ifc_nand.nand_fsr);
-
+	status = nand_fsr >> 24;
 	/*
 	 * The chip always seems to report that it is
 	 * write-protected, even when it is not.
 	 */
-	return nand_fsr | NAND_STATUS_WP;
+	return status | NAND_STATUS_WP;
 }
 
 static int fsl_ifc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
