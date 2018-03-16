Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtjsnONCkC4cKoq2OpRPGU7mFgbtm1YqALfSJD3V/jgDb+kIo+5/McS2yJVNZMf8lWPVFQ3
ARC-Seal: i=1; a=rsa-sha256; t=1521214917; cv=none;
        d=google.com; s=arc-20160816;
        b=mXsggt/XTA7lgG86ne23ndTRogfmgxVzIHu5qdb0LVMGFar5m4JHlGgaaLUNAp/f8W
         OkaR9Hn9ugriT76aYO1JPR6cIAZkxlglEFztbsQxN7Y9XXjVHpaoBzHfjnG3i9Vi79RU
         i6yJ+iObBndhTDX81Vec/eCF8mmlWs3kRSwi9dGjq+9s1rAoQOfaPM2qUj21Pj1cLFmq
         Of0mQyUxDbBVAvr4P/LSLaWaQAXGKhxhOH+4g+qf0/IRlIuW3dvHaFlcNaeUd3KyYiGK
         +sBInnmCy9e6aXwk2bQFWa7BbIeyyprENZ+8l4RnGt70BhmraHhl05MFCAvbWBTcv8ru
         MBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MfQn6kftnZKYaTxHO0qKaLGrj+/l0j5IYN5UEzqoZ6c=;
        b=aEJxWbNaCfUB39R4FtoLIHcWiSwADDxEJBOaujKTmnoPNy8xN4K/8T2cTsR3xm6Lio
         m20k9/5pXpyc86gukumpdXQrxaj7dG4NgeSaTHB04ETXC12qS21AenVQHZrTuFkrcuP7
         1PvL68G6OJQruZqi8CnsY9iGx/FfEi2F0g9RujpgjF0A5ZY6j1WcW4ByDlBsndaV8CqO
         dmt8BXjiRmE7yYsFDP6TolQl6usfJD0/Kx6immUCDO9RPX45XdzcS9AcdIKSOaerNLYb
         ZF8lnuhlumt92Ssw0e/CeZjPqbvm5jzOpRzGNrt61FHmgzZWSVfZCZdDAmT7u8o3rtfx
         VniA==
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
Subject: [PATCH 4.15 063/128] mtd: nand: ifc: update bufnum mask for ver >= 2.0.0
Date: Fri, 16 Mar 2018 16:23:24 +0100
Message-Id: <20180316152339.922296731@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109087381270081?=
X-GMAIL-MSGID: =?utf-8?q?1595109453598555752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
