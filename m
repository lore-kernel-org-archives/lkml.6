Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+k5eQZz2YT6WMXu7QxQafgX19dtmLO8DjUvpfjN62CDKFcsCf/KKp2aAsXaC4D6TUH431y
ARC-Seal: i=1; a=rsa-sha256; t=1522346593; cv=none;
        d=google.com; s=arc-20160816;
        b=omzJRm7L4h4qI5LbVyAeF8YqsgVPg2PMR49lAjwFmNMGD2nURzkKdyXsJ4IMVyf6lp
         qP2Kew7sJ5JBSrtAeUve7Ab28AvaMYGQhWQTRzzMJDVV5mSOT2JvrXMg58xjGPz6iCOr
         Ozx83LwEu1pYevirxsYd7CE5q43FIGU7N9pAhEmTpvCoCw6jCbRVkmeJxX7bKsCR4WIb
         DH+xspZxYdB1LWairVyZT8D3AMUHuqqmocy00vd+ExGuWQbT30wh1FN4gbsnoWLLEW8J
         /vH8HwD90cDCSErTufwGFso3Z/NHkZYEEr1YlUJgsl4SQ5YDnxNpUZPhRQxxcmS+0xPz
         ttdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vf9BqgNJ2dB4j8Wmc5K4+8DoKOUDtoQME8lwZGla3kM=;
        b=Xk56ISdAs4kbQ9pHp4Y9c1uOEQhR8/bNlIsXDh1f/Vm0dCsqJANltgYLhR+X4mU9l/
         efT8sX3eeCuGW8vI02lpQw1eQpyAq1QmUtOyM4Q4sN8wMJ0DMYsD7LA0OSOgSy69Y96U
         /30LhgX29Uy6/9karxalWa/ay/vS38VIzegVTd8CGNJOzRpqdLEEQLZa+YQIjsPQp8PE
         X1GGWOzOcVLEhicM40NiVBhZgaV0EeKoPaJ0H/n3CeN6FWJJtk2pC9aEPAgG1vNWMlQx
         hS3bEgpllE49CRAyrwM9evqjartQlp0666AXn1vZS5bf2UKXlrM+t5BkTXlIExHfOJIn
         Jquw==
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
Subject: [PATCH 4.15 38/47] net: ethernet: arc: Fix a potential memory leak if an optional regulator is deferred
Date: Thu, 29 Mar 2018 20:00:19 +0200
Message-Id: <20180329175732.583504399@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296100956392169?=
X-GMAIL-MSGID: =?utf-8?q?1596296100956392169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
