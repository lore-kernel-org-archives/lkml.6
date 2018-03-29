Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/35pVv+pYsOdOARt7Tjk8FeB6yC5yMl8sTjc4aEpjkUnPBOwFAP7J4D5AaN2oFwMyZwnZ/
ARC-Seal: i=1; a=rsa-sha256; t=1522346595; cv=none;
        d=google.com; s=arc-20160816;
        b=IueXD9mp+BVE4VcJ8xBpoNEfOzBrBfikP5VePShZ/ttNdnE4GMKPuHIcqXWEN2ZNXp
         NxCmfOPzehlZBv3Ti13vxOhgUWk8UwaEiTGV3NgIB6E0QLazCRvrNnggEpjS4l9uXjSN
         wnJ6tJt++ZpfjsoAOUIK/MWHn9ZH/B64ITaMNZ3oHJTxwNeNvvtg+tTjkjuJTAWNAjUH
         j5Orok7cje8AGQzL5EBljLA4kHM5hGJwvU1+9Hbubq70e5L0lZEQvQxIc/dVrLmP7A6O
         Q6dZEOh3feym0Hhyy/jLf0hOsay00zfMuKoMfMxEfp9N9pPY6sI0qbfNjjQuXJYeo1hp
         Pt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SGdWM/DYuuIOGZvWzWsIvUv7SCQ6iQABZ5LvVZXwErw=;
        b=Sm87BblcHv4gfxKNHaGQ5SPdbSV63uGK7tsNgojm2aMN3mKcULzYXzU+Zaig+2Xxiy
         A3SnmQPtiZM1yBKsd4BHDhtG9iBrw8EIHIDxOpzbtaL17TtirZ6ULRr7pGU8oBRoFqrI
         KdYGETD8ubE6eMPtcfsCqm6nzYKugahgV6Zab8asnXzH8eZSflYKAv1fxhwz//N2Yshy
         XgyxmAwhlm8iyXdFB/DMjGhg2EHDMI25ZQHU++FBDCtcYhA7vcRPwuVVt2kD0XkQ+1hE
         c59ENl+mUUI0iC4NfVN9GXh1hpawMLScRe4fegSmdN/jkIBHF4Ni6XKsgRvNq8nPFDly
         bMuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Holsety=20Chen=20 ?= <Holsety.Chen@moxa.com>,
	=?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>,
	Schuyler Patton <spatton@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 39/47] net: ethernet: ti: cpsw: add check for in-band mode setting with RGMII PHY interface
Date: Thu, 29 Mar 2018 20:00:20 +0200
Message-Id: <20180329175732.691321277@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296104396396575?=
X-GMAIL-MSGID: =?utf-8?q?1596296104396396575?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "SZ Lin (林上智)" <sz.lin@moxa.com>


[ Upstream commit f9db50691db4a7d860fce985f080bb3fc23a7ede ]

According to AM335x TRM[1] 14.3.6.2, AM437x TRM[2] 15.3.6.2 and
DRA7 TRM[3] 24.11.4.8.7.3.3, in-band mode in EXT_EN(bit18) register is only
available when PHY is configured in RGMII mode with 10Mbps speed. It will
cause some networking issues without RGMII mode, such as carrier sense
errors and low throughput. TI also mentioned this issue in their forum[4].

This patch adds the check mechanism for PHY interface with RGMII interface
type, the in-band mode can only be set in RGMII mode with 10Mbps speed.

References:
[1]: https://www.ti.com/lit/ug/spruh73p/spruh73p.pdf
[2]: http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf
[3]: http://www.ti.com/lit/ug/spruic2b/spruic2b.pdf
[4]: https://e2e.ti.com/support/arm/sitara_arm/f/791/p/640765/2392155

Suggested-by: Holsety Chen (陳憲輝) <Holsety.Chen@moxa.com>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Signed-off-by: Schuyler Patton <spatton@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/cpsw.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -996,7 +996,8 @@ static void _cpsw_adjust_link(struct cps
 		/* set speed_in input in case RMII mode is used in 100Mbps */
 		if (phy->speed == 100)
 			mac_control |= BIT(15);
-		else if (phy->speed == 10)
+		/* in band mode only works in 10Mbps RGMII mode */
+		else if ((phy->speed == 10) && phy_interface_is_rgmii(phy))
 			mac_control |= BIT(18); /* In Band mode */
 
 		if (priv->rx_pause)
