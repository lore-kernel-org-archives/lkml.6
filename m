Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsiugdHjcuruIHga4fDsBWXps3kOU6CpaI0NqymCeRHYlAcf0e0RpVA2uMiwZ91hq+Oy1T/
ARC-Seal: i=1; a=rsa-sha256; t=1521484031; cv=none;
        d=google.com; s=arc-20160816;
        b=u/721JA1fVgW1NrlR4kRixxHRNATV70t7LF3pOpQGLNhjEF02WYsmqYslN2WH3l7j0
         XQ38qrfQsRpwyP80WnTOrFLWKhAc0uatVJakQ08GnT9n6iysYxSCPD0Er/vTK2pn/XzO
         lYWdAL8Ij92rHos+gHQtokfCoW8fsvPe1Fq0mY3ZlRoTF33WywGbisA1AdO/nMmPAMPM
         YiI60RhqLFfWlrO0QQznM1VRgCxoIyUEm1QLT5i2sjPbjHjEfOd0+/AwHYMhhuvNJ0Al
         rIXixIYp6nBVWqchqVUsv8bXRT/5iTtSJOYbUTsYRO1/Lbl1EsP4FGanmLzCVxX8MIMw
         6meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LtatiJiyobRU1ZmtFkOk9YR6LT1ocdkHf9au6bgqSYM=;
        b=cbevG5+LhcFpNL5tzUR8hsmhPgYWwaZ3JdSxxXePn6CWTGIh34lNJ+JDvhms9TUV0F
         N49C9FYZLKpu0N9wq3bN9hkBbzkBPpd4uEtfL+Qv1UzarMrw3KgufoZrC9GNudYnOIVd
         z24B2USmdufJF/NCDScIonlY2WeSWcDThV4LG+Q4oCO2iY84mhaJcJBw6zDmZUXRz+3T
         faQJHi13Fc+yB2FyVXxkGHY37Ahu823ok4msFUDJg4wgOkBBlWSGjM3lgeoZZaMCx4pg
         nUtC/OEBd4eYRIEs2Di3/XSqr1TIM0PldmyQEgHQ9z4akb/9PZ0EnpxJ3q3Bvw1X+7+Q
         mGIw==
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
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 179/241] mtd: nand: ifc: update bufnum mask for ver >= 2.0.0
Date: Mon, 19 Mar 2018 19:07:24 +0100
Message-Id: <20180319180758.562318183@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390612053939105?=
X-GMAIL-MSGID: =?utf-8?q?1595391639709694884?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jagdish Gediya <jagdish.gediya@nxp.com>


[ Upstream commit bccb06c353af3764ca86d9da47652458e6c2eb41 ]

Bufnum mask is used to calculate page position in the internal SRAM.

As IFC version 2.0.0 has 16KB of internal SRAM as compared to older
versions which had 8KB. Hence bufnum mask needs to be updated.

Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/fsl_ifc_nand.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -907,6 +907,13 @@ static int fsl_ifc_chip_init(struct fsl_
 	if (ctrl->version == FSL_IFC_VERSION_1_1_0)
 		fsl_ifc_sram_init(priv);
 
+	/*
+	 * As IFC version 2.0.0 has 16KB of internal SRAM as compared to older
+	 * versions which had 8KB. Hence bufnum mask needs to be updated.
+	 */
+	if (ctrl->version >= FSL_IFC_VERSION_2_0_0)
+		priv->bufnum_mask = (priv->bufnum_mask * 2) + 1;
+
 	return 0;
 }
 
