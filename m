Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Zexu3GqrUyDPVmcErI4AeSAvWsJySGOIb4TB4yfcZq2d+D+kAhQRAAjVWEX8qOYNdyAb9
ARC-Seal: i=1; a=rsa-sha256; t=1522168899; cv=none;
        d=google.com; s=arc-20160816;
        b=qqfMRKGum1/WdSnR9IfuxU9CLTjxeqBFxRhI+AhCNQgxjKzxqY9ililBTS1TWhUcqZ
         XhWBwvWyzuftRTPN4VvDBrPceyS8oGJF0TVy7BWOGRRDE5PGtKm6/5Q0PN87LR8ElR6x
         OIG4UCCUDYd8MW7KMuVhD1DoFg7ERCn/bEy5nnUX5YLFC4jDGaJIDI74LdPWOdx15CsH
         iat9H3fjrUdhVvMesKj+q0DKeGWbJCRz4gtdHVDpX0/s1avLtjcuxCAg3igcgtzdbiIM
         o99l0f+ZbX7r6ukuGpshHym7FXatDKD2rZW4aeVyZOMrVq4+5OZmejRg+dcrcmRGu8Ck
         SvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IJTMP1R5FF5QEz6cJdwJG8Y28WvZia36iMhTyd1N81U=;
        b=lIM26Q8PLoGqNINE1/9J0tJGQ2yuUHU2qlxukFjvMXY6DVkMt/1DSqaWOp7VGgEc3A
         pLMOuprfvUwuSRdcE8vp7A+VUUJaDU8POhdsedNcCs/yl1MTMcHD6jO/sk/t907vavtE
         PBY/WyL7t0eTM28I4fS2PCeJ1VLE37FVtYiZrzafbKBnq2IvFMuz7W0+sOLGmQtsd2Ub
         OfkVHUm8fjihCkoeSXKPha9WINvQvFAEsCDvUDkNd8Mh+NTZXJU85P5ngOTSLPa5gDCN
         nS9WKRSvkxBfW59OCm9qEe10kqvq8iI+NSEa+WoSouB+H8ObhFF8txUJb5CwUKvXJtwB
         w4/g==
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
Subject: [PATCH 4.15 071/105] mtd: nand: fsl_ifc: Fix nand waitfunc return value
Date: Tue, 27 Mar 2018 18:27:51 +0200
Message-Id: <20180327162802.330352543@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109017538454485?=
X-GMAIL-MSGID: =?utf-8?q?1596109776238815847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -626,6 +626,7 @@ static int fsl_ifc_wait(struct mtd_info
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_runtime __iomem *ifc = ctrl->rregs;
 	u32 nand_fsr;
+	int status;
 
 	/* Use READ_STATUS command, but wait for the device to be ready */
 	ifc_out32((IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
@@ -640,12 +641,12 @@ static int fsl_ifc_wait(struct mtd_info
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
 
 /*
