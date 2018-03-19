Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsuCh5QAzsDC1D3Jzs4Z9llv1qe3V4f+s5vFsGK8P+QU/p++gQHuT/ZWdgb4yct1RLpzoHD
ARC-Seal: i=1; a=rsa-sha256; t=1521483344; cv=none;
        d=google.com; s=arc-20160816;
        b=jTWFonSDyVlNtiK5IZ4nRRzGHOL+TSM56+TgP4AVV/mJnBLXLugJinJL+0QHmDpd7P
         e8g807t71PtGLz1VM3gBulqd2KyXU+zhYj2ZVE3XdgDvG/U5djvQCt+mHxy9z4niYGGL
         QvaODRoBwhq6fQf4NMqfs7ExBI1uVdb5oHCy1ptBrzAn2OtSNEqSOMNS/iwT+pjsm5mk
         FxKMwdonV3SwAt/RZCyLJDYFwbs1+IPRv2PbTS8We7GBsV3BSlAieWfjx3pxLYl6F7M3
         XFmlSA7vpR2h8avex+0OfE5Y4jCRuEroAewcjYkVZb5ieQ1XdrE5El9VEGF4Ae+DyQvH
         6Afw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1RO4UiZ8opG76DaoePfZoeS9nYrKE1zOPT82lXPjcWo=;
        b=g6dDlOeTXS00w6hKI2+2YJBp92BeuEJhSdH6gxfMxAsTapLY5ajjHu/VT/XsuCrN7l
         UbP+5BiQVJT6J4/+N2PkIUSJzBifl1j9ip+FkgQdI/+qEjcruqxYaqou5uhFkK12X6f7
         LipAbnEXo1vhRo8luzHuVxdtwk+NIdNDzzdIgSvr/TAwbrAXDpRU808b9R3epbAffe2B
         BfGBgsTITrfHQ8wRgljJ5CV6i83HHXZOC1YtjzjQUeZhfhXLNuRtawy2F8UgAw81p2vJ
         C/PRhatsQCXNw7Kjusfg3fM5FeINGDEKQXNAJZmhzcif6hqpXr8j9e2bfOT6vhCVPJVA
         QzYg==
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
Subject: [PATCH 4.4 090/134] mtd: nand: ifc: update bufnum mask for ver >= 2.0.0
Date: Mon, 19 Mar 2018 19:06:13 +0100
Message-Id: <20180319171902.315537895@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390612053939105?=
X-GMAIL-MSGID: =?utf-8?q?1595390918895977569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
