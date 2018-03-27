Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Qd12BSEqJb7Qi6/L1/O3nN9ATE0b5DNlR9gORN46yrY7JJkJoIpfKf7E+8k2bTp/WvsP5
ARC-Seal: i=1; a=rsa-sha256; t=1522168696; cv=none;
        d=google.com; s=arc-20160816;
        b=nqQe8UL92NgBU/vtCnf2y+Qeatj9u86l+J/xhNPPb34v4C5gnGGWG6k1rFogdBs8Uv
         nu7ooHoIpYBCOXmSPW9gYWPPsvB6xM5q8LTYRf/gI6R6B8RYk7XrFN8IcuD21QIqKpEt
         6452HczwlSIbovqE3lYMZg2BWuniNEQ3F411w7wbrNWgVWH6yMz/SIe5VhDYGi4LV6aN
         bSF0QAyzafkEaqNZ+P0KL0YDRtdQVLOM4oMsyCEwjKJ0i9iRD4QdA9HlkY2pdk9jtoX6
         WwqM/UMxXqG0LjTnEW8ay/TwnMd/j1MnZtf9xWL7FszLvnbNezbjlm8fJTNg3P03zgaP
         /4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QHP2ZcPBG+0xEFyIqfY3BQfMCySYFonJxY04NxxoJXE=;
        b=mHVSCa9r19IHDMHGq+SvKx933Y7JIdBNCdlSdTSv6Syw3KqtRB4tCxwbDI2L8SeKr/
         mYYRwF8gevEWyMmhB77VZ2MxfuknH39MzmINP4+yl5sUspbmknbfBVHjhE/deT6AJJ57
         WZVzMM4yo4g4zp2BIMAcJ2KrVxYcog+MX/CixOL4SU9gI1XmY6ULpbkpzkQY/unrRfSW
         84c3nqmZMwp6MIXgpcR1ZbuMkKz9klIVdFzdf4g9GDk2lcSxR/F17i3dlCNvdDhZNaxM
         Kpojpr3ox3UPNE1nZMMZecUqzIGx1+O5WpkzyYfvDDWU5ild/IujibAh5pWlxUNTXoMZ
         m3hg==
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
Subject: [PATCH 4.14 066/101] mtd: nand: fsl_ifc: Fix nand waitfunc return value
Date: Tue, 27 Mar 2018 18:27:38 +0200
Message-Id: <20180327162754.077695792@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109017538454485?=
X-GMAIL-MSGID: =?utf-8?q?1596109562824202038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
