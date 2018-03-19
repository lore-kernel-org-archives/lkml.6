Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt3K8MqcdycWnnJjcmeowFBpElcYqQ2pjpaTp0Pez2IWE08eEDiYGWLx6PNUVCDPbQj2TxS
ARC-Seal: i=1; a=rsa-sha256; t=1521483051; cv=none;
        d=google.com; s=arc-20160816;
        b=WNV3YpuCkxYUq8C2fKax8Ka2d0GmAliEGiMrzdM3m1hHrbzCGphTiFdl2JhnWr+Z5X
         ihUTa3saHY3UKfLrrc2qZH9eSlrL618JYh5UmArA2cH+B0tgQcITpGqQhNSGJCFx7tVt
         3U8Z1p3fRTlG/WoGQ6aNirtKfsY30D4U0t3lSb1Fu/JkVf+pFoLrVYbnp6wCDKHQqMth
         zMJ0yg32SLJLfBHPXJaDDb29ok9SwchqQDjnicZy+bPRjBmEliQHEtnRiIiRTUARJVUo
         Pv3XiBJFXNTAzYnlydxCmBojl3DTw5eCe0fCCOatSDHzDcSc+irfvTTYRY7Gkm+Gvhkz
         ugUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8a0WmJu7ZkCWRKL6de5eiMpuWJSzhSytQTp8IdNgr3A=;
        b=VBwaKP00yYVQ0sweIo7CtS2QoSJ+7GbTd1u3M+PmA/inse7nRnuwVngY9iIgShudAj
         c94Yo0YIbttZTTyqT+IvSm+M0N5AwJUmoH8S40z5zo68HF73fBMv1lwxWWHmVEfLVqp1
         BQOK17IxIcUf25v6+LaOC7k0jt8CQyK2sqnEucI32eo7HLVUkQg3cYoDbmEovPcVoHID
         RvLA3eCDtdIdXWyMkvvf/9YcMTSJGPONdndn5htYU63pd3A+0fbHqa6atDTUrVA8lOsq
         YHxjtQIXSxyTOnfsFtGo4nS6cgu6QoitaLExsfaEo9BThahHyTY01KL6++nVl/DH9pBE
         MN/w==
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
Subject: [PATCH 3.18 50/68] mtd: nand: ifc: update bufnum mask for ver >= 2.0.0
Date: Mon, 19 Mar 2018 19:06:28 +0100
Message-Id: <20180319171834.894823078@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390612053939105?=
X-GMAIL-MSGID: =?utf-8?q?1595390612053939105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -988,6 +988,13 @@ static int fsl_ifc_chip_init(struct fsl_
 	if (ver == FSL_IFC_V1_1_0)
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
 
