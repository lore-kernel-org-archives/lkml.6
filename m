Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+s3yufv5vgp0Xg13RACKdpkRfr4NCptQmnOXzCZAZmyV4DRIj144KVm1LpxjBdz5eyCs3N
ARC-Seal: i=1; a=rsa-sha256; t=1522346783; cv=none;
        d=google.com; s=arc-20160816;
        b=CP2eDOrEPX+GHRT3hR6Qcj/z9mT217UKYoCaRAubMYkINTM08U9sG7QnoAm+lCb7lz
         92IMJVJA7HMUsNbM375ApIpC5OnlXopFWVIXRhOir4we0Frkg0pndrxBy7DAemvJstGj
         /TVVh38MU5ed1xUdoLU5SW3AcpwSqDWjGCZPJ0iWR/onLV2S2V+GUjG3OS6tDPe38/57
         emFyPq5yJ0Jn+EJr6W9P5ug5UlW+ljoNlGrw136Ia9gzTDALEe+4VphP3Ci99Y7vt+jd
         fIPKFTdqzOaJZlk+it02lbQRCGfgrgRv/H/REbhZimHT4FImgrgwuzNWAju1YDjxLotS
         l3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KSF+rHImCvrjIFC1Y7W0rXiqPrgR0iNudp8wIcvHsDA=;
        b=l5GsqIPNMTR5GmhGslFnJG2OvbS0wvtVMuEGu/F+iX+U6bfRADRZMpaMMWJW21slxM
         wuMIBweoL7obLPZX6eNWTXnvvDDb1Liaxbke21a3p9nUau0XQILKPUQ8XO7Hxskal0oV
         SiTFWDg/+6CifswSReAcuywBDDkicRzOwoDG9hXJtBNOP/JCKAeQBYF5sIznJGdPz4OU
         wZ81T2Z0pOKdCgpBgVdk1SpS2jmx3XVujDrukBcE+jz3uucN9HknMlo92ZOG6SHjdOds
         +0Kp8I4Um1grG0Vg+X+UNOKCuvn9OIPn8LS/DenarSVQ6tSewhKFi3Iso/qlLBelkpbh
         DGrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 13/28] net: ethernet: arc: Fix a potential memory leak if an optional regulator is deferred
Date: Thu, 29 Mar 2018 20:00:32 +0200
Message-Id: <20180329175735.056901751@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296100956392169?=
X-GMAIL-MSGID: =?utf-8?q?1596296301054281865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 00777fac28ba3e126b9e63e789a613e8bd2cab25 ]

If the optional regulator is deferred, we must release some resources.
They will be re-allocated when the probe function will be called again.

Fixes: 6eacf31139bf ("ethernet: arc: Add support for Rockchip SoC layer device tree bindings")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/arc/emac_rockchip.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -169,8 +169,10 @@ static int emac_rockchip_probe(struct pl
 	/* Optional regulator for PHY */
 	priv->regulator = devm_regulator_get_optional(dev, "phy");
 	if (IS_ERR(priv->regulator)) {
-		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER) {
+			err = -EPROBE_DEFER;
+			goto out_clk_disable;
+		}
 		dev_err(dev, "no regulator found\n");
 		priv->regulator = NULL;
 	}
