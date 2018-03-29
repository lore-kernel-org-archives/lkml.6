Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/zE8EcstHwnG5rWJaNM6rGHIsoPpZUMsgefVkGHXyIp2LsT0C4hQYyEiaRmPJsz8eg5yLO
ARC-Seal: i=1; a=rsa-sha256; t=1522346878; cv=none;
        d=google.com; s=arc-20160816;
        b=a8P20AMFdtH03MjWEsFt799aVWKe7cPzaVYBYuE1k3zYUadmRSuVfzQvjJuUSGiAZz
         k74mGg/ZgcFTIFFcbdEg3iP++nxkjC/8D7Ud5dMG8UWI7FRe//EP2p83T7GPZG6aIgxG
         1kOOuA9pywlLq+EU+fFWMcaFSnHsKq4TLkXsZ/7By5rGjJV6rA1G60Lgp+lzfyFk3/V6
         s5xNamK9Le7VwGPoEMtRdYxf4OuYFHrkK0iDB2i42ACijSq+PhkfpDnFCN4192TaKW3f
         ZOzk3YFFUnn5vexLaj4uskQ+w94wr94qDQkp+lT5wvgjmGxxi7HwRtfUxleB7ume5ch0
         z4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/pjYIfgTv+95VcBhOCLkfnIa77vY/CtV7o6cjne58V8=;
        b=fUq2tQ2D4uNFXL7mfdpPhStMvrSyvrK+B94KlxVZG7l6Ta/+Zc1IDLDcAZOdCaWh0H
         aYD084atqq7BMJbdSk6F9uJLFwh+eM5QipnLta+lzvq9mh1JZ47/EnUu/WeM5YTw5pwJ
         YtfqRI0QX6PtLeXTBl2EkHAi1/EIgGlpMUH/xcd4YHpfQIp1bMtjS6qvfYsfW03yvsDh
         3uLp68HRqiGFo3jL0tUn6R829GELw5QYW7HKtx5NxyQsVsrWAPkYW98/tVSgKi/YsN4T
         0r7spYQEtHaCamNK4QWMydKgaQvoYlHnHzCYLqlm187ra34qbpIf/iNR6J9cai7WNMNu
         wlcQ==
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
Subject: [PATCH 4.4 07/20] net: ethernet: arc: Fix a potential memory leak if an optional regulator is deferred
Date: Thu, 29 Mar 2018 20:00:43 +0200
Message-Id: <20180329175742.191382809@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296100956392169?=
X-GMAIL-MSGID: =?utf-8?q?1596296400484597561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -150,8 +150,10 @@ static int emac_rockchip_probe(struct pl
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
