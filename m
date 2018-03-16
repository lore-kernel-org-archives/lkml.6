Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtEO6F1ZnhwMEX6RnQPlowI0lBTaFajM2777gTFaZA47Ib8RctgoWOkVgdhadvF2paun6oH
ARC-Seal: i=1; a=rsa-sha256; t=1521214568; cv=none;
        d=google.com; s=arc-20160816;
        b=XFxSCYzNBqhsORbRewlWo6ClQC/By1qcBZV3y9+bGiZX0WrGQBPFwsspqm/oFU8E0r
         ybJMtT8kJqO//dVQQk27+CYzXolZTLtVadahfyf2VefciwSbxzdAhG7hL7ky4xJ9ETPZ
         ZKouyEAYt5EPvDrNM38LVTFC+Eo14bw04w3/uPpyEcKvW8XH1Ur5kmSEGpjvWTL2qoQU
         ZFwr6VnAvkB0jZSFzNKDJX3u5l+WtURVHoEfF4Yk/uisEByIJcnrIUcQdhRNkCwzvycd
         rwOQrCnOnbvowPe10RIfSZmMdKbw5Na3TAD5d9SS7Ezui201gWDkgOgzWknJQdltpoUi
         mMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N4Oab79iJZE3/zHkzBQovFq80SxfamTzNAcWLM0Cd+I=;
        b=T6oASBNjB5bec6p1i/ebCNsw3Os6N6vwCOdMHrYhDZcLVfANjVXjl9a3TlFKLs38sf
         U3uHlbtKRFx6zFkLhHprEeL4dAj8pRNQmdaMCt6ztRXzGVw6rpuaiyPSuRwPMoPdIjOe
         4k1FMVxoUvpDrD1I9lbtTIYcGPh8M5KgqdjWrJZNsBXPHfp1lmewMPKjcKw8ewdz0Jqv
         8wc1J6WZRlYPubPTNcpcKDJ3Q1G4FquLQjvzA7d25BXqK8kCgQ32/DZHzOAl0Z897JKH
         gaeKbpi4U5JDvRka6yEUP948Iu2ylD7rar64QFZr3dIJuUhN+ZfSFAHbK/0jrixYSGIB
         xH/Q==
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
Subject: [PATCH 4.14 052/109] mtd: nand: ifc: update bufnum mask for ver >= 2.0.0
Date: Fri, 16 Mar 2018 16:23:21 +0100
Message-Id: <20180316152332.793870987@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109087381270081?=
X-GMAIL-MSGID: =?utf-8?q?1595109087381270081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -916,6 +916,13 @@ static int fsl_ifc_chip_init(struct fsl_
 	if (ctrl->version >= FSL_IFC_VERSION_1_1_0)
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
 
