Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49daUzYGy15Zm9ZGgq57kQYZ+5yoaOdKAaBcCwQEOb3Cm282x3ZJRPwOnIVgKD6o3BkzviA
ARC-Seal: i=1; a=rsa-sha256; t=1522346881; cv=none;
        d=google.com; s=arc-20160816;
        b=Z1/1mtdPiRe8eUA7uEvqIlujcXd0bmlteGAhXAEdTMtX8TWfZpVpRm0Rl3pbtI9IiW
         aPzqRWSlaAUXJdeMl29bMjvj7JW+riMi0Z0iTVQkWduTgBSeCQrPTM847AuHMPbqQBur
         5GKh//r72TnqoY0UfsCL0zo151pZAP5hNB74bls3HY63qo0trcIyQcvHQEfLzh2jE2oy
         2UFiM+zUCz0ixOwCPznStA7mkHIV/vA9nnH9Yv/LPRE4ZTW+oGZsdkZqIc89XJgvrdy4
         Bd7SUf19pt0yE0uvVLncThGYEdqGaKKK916pzHiR5jL5SLOLG47INDrUQm+5lOXNp9+4
         +ZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JowGQqr5u1U7j6hJaGvSaSI6gM/2a5b7yzrIpEYTm3s=;
        b=q46zZX/M4tqmOlj8kIJ09IRTUJQxjW5kl4uUkMPGDg0q8FSWPhL44Rsn4+nogpnOd/
         QsiXNsLN8D2zTMJRIUE/xZPyhPa8T1SLpkZioyztgrYGwbpAyCeY87JnZy5I99n8twfF
         LLkwWDd/pPD3fdZN7+7xulZolXnb6hbPz5tg6ajah5RSMuZv5NMl26KltuEGfejZlIwT
         AS1hub44gvNC/eWJke3b1tp1WIcQ12pk32PGM32i3m+GgP/4/2P+Huatbsj3DFBOSULb
         Zo6pXTLa1WcBjJf3ZuoW3vJcEFQHumn4AfflPXbstST2vhO4kWNAd0rC92ZCfGsQAgn1
         qnYw==
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
Subject: [PATCH 4.4 08/20] net: ethernet: ti: cpsw: add check for in-band mode setting with RGMII PHY interface
Date: Thu, 29 Mar 2018 20:00:44 +0200
Message-Id: <20180329175742.233287305@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296104396396575?=
X-GMAIL-MSGID: =?utf-8?q?1596296403526626366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -878,7 +878,8 @@ static void _cpsw_adjust_link(struct cps
 		/* set speed_in input in case RMII mode is used in 100Mbps */
 		if (phy->speed == 100)
 			mac_control |= BIT(15);
-		else if (phy->speed == 10)
+		/* in band mode only works in 10Mbps RGMII mode */
+		else if ((phy->speed == 10) && phy_interface_is_rgmii(phy))
 			mac_control |= BIT(18); /* In Band mode */
 
 		if (priv->rx_pause)
