Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+lvkTcM38A2SIYIJF47BESQej+h6BdoXLTjFjYrNEF5DmJ5ANFzcgGpATsl0xcERJd28gF
ARC-Seal: i=1; a=rsa-sha256; t=1523022072; cv=none;
        d=google.com; s=arc-20160816;
        b=gBRBZIpEbfdqbfePMoOtnJOUGu6Cu6+4yNWfs6W2bsB+und2h89bMOq2uFNN6xHC8r
         p0dDFYpESg6VcmAOY68QaRd5a+Bitohtw0hSrzHaAw7mUG0BWJPaZPqnS1TS788MaWpE
         SRpocqoyboyMGeUsWEwkq/CQyzWcG7Scu3DnGVc8sCpUFgaEI/kMwGfXiq9XB6/EAFQV
         B2XJyrrhaImk5qb/N2JceZYhkD56WmpRQR2suVxlgNWUVuJmFagtKSizrzXSjmSVIBoc
         Tndo3aDH31t20iKw/jBzJV+Wk6hQmvJDwj8YPZW77NvbguUXpp/YDks8/htYStGBn8Xt
         js5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qnnPgswsWQ++GfcLkGFlwq1wTrqk8+Qw2EAQNEuvEmE=;
        b=G9Gh86q0XpjRFEsR9LizbIO37+3YsTbGsT+U9vOycM8szfvIg+v53VeLIVBUET8M4X
         PEIi285selpLP5WZfWvO981JHy1x8fGl6uUwEYYdU3lRopUAj/f46htkHBeTMc/yHhgg
         wMixr9pSfatnbVjtwQDDA1v0zn25nngEV9+r7MRXLFBVxTfoKhb9WHRIEECNCEzdvqfw
         uvNjcFnn4YpnJODRpON0l/NmF7i2OTBQ31rEaA2qeZzZMpwSn4Sl7yDi5m3JpIQ6I2rN
         RPWGaRwVey2rtv3ha3RBGBhD+jFupivH/CwSfGgO2S9GHXsmpG43bNPcw+uS5KLnHOkK
         PQew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Olivier Schonken <olivier.schonken@gmail.com>,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 4.15 06/72] mtd: nand: atmel: Fix get_sectorsize() function
Date: Fri,  6 Apr 2018 15:23:41 +0200
Message-Id: <20180406084350.027693387@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004239503869181?=
X-GMAIL-MSGID: =?utf-8?q?1597004393053035316?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 2b1b1b4ac716fd929a2d221bd4ade62263bed915 upstream.

get_sectorsize() was not using the appropriate macro to extract the
ECC sector size from the config cache, which led to buggy ECC when
using 1024 byte sectors.

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Cc: <stable@vger.kernel.org>
Reported-by: Olivier Schonken <olivier.schonken@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Richard Weinberger <richard@nod.at>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Tested-by: Olivier Schonken <olivier.schonken@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/atmel/pmecc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/atmel/pmecc.c
+++ b/drivers/mtd/nand/atmel/pmecc.c
@@ -426,7 +426,7 @@ static int get_strength(struct atmel_pme
 
 static int get_sectorsize(struct atmel_pmecc_user *user)
 {
-	return user->cache.cfg & PMECC_LOOKUP_TABLE_SIZE_1024 ? 1024 : 512;
+	return user->cache.cfg & PMECC_CFG_SECTOR1024 ? 1024 : 512;
 }
 
 static void atmel_pmecc_gen_syndrome(struct atmel_pmecc_user *user, int sector)
