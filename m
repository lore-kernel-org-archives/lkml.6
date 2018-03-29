Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/X8sZrylgtG1HjkKGcoRkc/bIkFwuKUMmInMNQ8FKfw2YsJtDzhegGUlAv7xIPnKaIiu7S
ARC-Seal: i=1; a=rsa-sha256; t=1522346758; cv=none;
        d=google.com; s=arc-20160816;
        b=avyfkNS74S5MAlvhOQecV2hv7LR66/H2+R76jdweaNr/giWzcJzLjvslrCcNFlbqEY
         2NyLnZj8hiEHc3Nrvj66NbLWcbjO/jXAG4atsqKiQFj9U4iG0Xf/emTdIRB9ww5OZoc4
         lh9qfLpHG189xnPx/oI2JFYMjaAxymtSgIal+54PlhmQWe5m+fqoIZy5SM5TgjB9CNvF
         O5smLj8mi1K3Gxql9bSzu7l5xUFz5d6ESczIAEvk/qwLb5GPbarvElysYhUEzTDpFjEr
         A01U3m6EpPbyFkYtF/52lqfIFlUoz6L2dvidYstSTnO+oTpkrA4FE1dKUafiRwasmEO4
         Yhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7wkI7kNWtUen1jIyyC7Xl37uMTWpnjkBt+bBCe/AqLY=;
        b=AIxOGq+cx8FpvP+cuw0k2V94Nr1HyPkm8sZVIs/djYS/KtoozXGueTWhyAygJPYmml
         4InrGisK9vBPDIs7r5XHUG30oagc0q1fCfK666+X8djVOxZxCaN1HXRQy0aKG4K+W2/J
         jjbrqkwe9Dq/7yzgq3d61CiogiTkgDdV5QXW4UTkvj3weLUqJI/YeyX2KS/Y+vy9RjD1
         TOAPmnzbfUJxaUmtkFjBdTRPcQ50KqKTDdq44yiqLUeh/LTIh1X/oygj0YddUxnAKi5M
         WgRa6XvLBLksc3SJ/Qdnkgwxb1++TIZ+EIZxtpdXAxwsEsnqVIy+bacm4bv9tvT5Ktq6
         wZJQ==
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
Subject: [PATCH 4.14 26/43] net: ethernet: ti: cpsw: add check for in-band mode setting with RGMII PHY interface
Date: Thu, 29 Mar 2018 20:00:21 +0200
Message-Id: <20180329175732.902609187@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296104396396575?=
X-GMAIL-MSGID: =?utf-8?q?1596296274468199835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
