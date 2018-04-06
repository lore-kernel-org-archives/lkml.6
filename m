Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/kE1kpOg1No7yMDVfmJhsUEuahvda4avy26bM0GZZDkqhym63oRCEcKWeLtGs5LxdJWSmZ
ARC-Seal: i=1; a=rsa-sha256; t=1523021151; cv=none;
        d=google.com; s=arc-20160816;
        b=URXvC1YcNNW8q45ZyHnJ4i3myrvFkiVmXLRF9yCtfYnSZWS9plJq2SFPKf+p7C0kcS
         bPGrnyb2h1VA25zM8cMRRja6j9ed8sqBN7c1Ly1O7qg96QEeUVeHbiPQRDexdR9Umf/U
         6SdqYrQqDlb/9nhuq1dEdMNr+85cmXG0iSlUcWzogI884CNV1U/zrWBkuAY9lEPTn3rL
         61rOLavZm1OPPb6RTitCsfKgc/qRtdg5OhISsV/0NmubK3SsZOGafa4/zqAOmZzxDP4r
         KiCBvsaSt5YvlNoAdIgLYE4XD+/YrD8Y6eGOyBtjSMpDnDsn//sxvGiRaRzGTdrQ95jn
         uu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tBBfd8tvpWguKgQRWpI5e9kvWBY618u223riWJFRcMU=;
        b=SM1sqboGWkMRef9vdpNyH9sJfozHWRcRYLJmIKUQmYJlylKsiVqAgY7IiAMsa7oS2t
         nK1lX+JWMaR4IVWwDgQ4JBoQj6jPq013VNhNWCiTtSZaIBodbCZkXNtitFDWxJ99UT+4
         OuOzQUIqKDBnRuahV7P71In7rjBqdmXqd0/Q+Lqp2seu4fmgEKu8yetNDvgCfdmBCgN2
         yEvROVdQdKvR2ToaYNx+6hi0pWv4QJGP85iZPYKXqYgfPEb436bikpfcJlZor3Mk9H24
         ZxanyKILoMSx3aqhvu7rZXyTLC2rvZ4lh5j9xPn0DdRy26zrtv2fx0DAH4gHoX1RLfVB
         o/zA==
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
Subject: [PATCH 3.18 26/93] net: ethernet: arc: Fix a potential memory leak if an optional regulator is deferred
Date: Fri,  6 Apr 2018 15:22:55 +0200
Message-Id: <20180406084226.098291136@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003426639463379?=
X-GMAIL-MSGID: =?utf-8?q?1597003426639463379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
