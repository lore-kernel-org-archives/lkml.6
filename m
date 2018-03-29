Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+N+ar4eTRDWTFwSaHYv/4TbXzpS4IzFXqvHGYr4Y3mk1Q2ami8qBQUOHrXsU/cMHb/BYZ9
ARC-Seal: i=1; a=rsa-sha256; t=1522346755; cv=none;
        d=google.com; s=arc-20160816;
        b=wKf7ywsD5UwiU6rETLG0RV0TK/UHFRxneNeD//mi22fwz4c7oVmIvyZZr5t9nRg9Ic
         JzZjP0F2AiEdtTrUcZ6NiLt3oRDUKkKQXXHCbZrtO779vL3eFQBqZDR8G6xaWfVaVHeg
         D99ZcKo7fG6Xr0eewUjtBpXedFdvkRoqxIqD0nUzXtheSfcifEUBCYJEnM6eCpGau5Gk
         /kZ2HKxWLPnq8Y0QJ5qDjXP69Q59uKiVvTPBv21xF2vZFskSw/70IYyN3vX7FZ0Uj2dD
         owmd9BItro4PWP/QLIFrFMh9w0/lt9ZO/9v6kqoxwidF3hLie+AiqHVU4+F0AFWvbcPP
         TgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2Mt+6/fVPVh+djQD/LWxFfz7YRZir3WOAsMN2wJTojI=;
        b=GblP7LC7x8sqBlAmnrOghZiDiOtgxjDF19j/duUAY58S6cCL++uINVkTfa20oi6ee9
         fzNZL1LkbuUgMZjmHd3CI7Cwl3KDUgztZxyRyA0wpvQZUb+GyJEbHVP/r9nfrtk2vIl9
         fG/G/FemfS+02l01NfJh1jIEczSJmmpcIz/7xkYh13aEeXYCtHGc7a6SUANKo4ynApLK
         5h8dfmv+yawMfFVkYAxrPQ5tV6ZtnWsJoakytrsmAplBhc0mboGd8p4Dceg4I1dTgWoD
         k5bY5EWOGwbOC2Bg2MqZP2LGOVbEPluancq24Xn8mS9qzc820MQjNCGZVWHNIZyvjmjs
         JK+Q==
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
Subject: [PATCH 4.14 25/43] net: ethernet: arc: Fix a potential memory leak if an optional regulator is deferred
Date: Thu, 29 Mar 2018 20:00:20 +0200
Message-Id: <20180329175732.815479497@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296100956392169?=
X-GMAIL-MSGID: =?utf-8?q?1596296271493944413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
