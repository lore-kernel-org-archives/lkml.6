Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs/kr3IlimUHpc3siYJj4TfhXO7yr8xbal2bWQwXTgtn+3S/GBJstnQFBQQ5U9SbCUMjrR5
ARC-Seal: i=1; a=rsa-sha256; t=1519412103; cv=none;
        d=google.com; s=arc-20160816;
        b=uCvqzJRt0uHVPZyqNtV2pQYRGQ92HPlzcNdTbuXoWzVQgOCyMDoeTInMa8VBxnX4SQ
         FAbdnLgWqip9XuLo4K1hcjm4ttBi9zNf+S0Yk2YgkyhisLRVF2pMo590Ab9HS4zNYE8h
         NzqSELCB7qWQvEQsMIYDwJzCEcy2lMu8kc76oAWLMjhCX78ogidMiGdpZn1j4P7hUKw8
         3gsQEIKgaxY/PMW8p/tfQaMpa+Qx6iIoh3RVGN4Sd+TDzqeiWgoChMsJDtvIVstPIOV8
         ta9GYXvMwlCohxkUDxlR9se0zBd6ito+gVEYzFkTvPx+fLTxEO0Mw2ZnhnbWnf/kJT7p
         26xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qc6i25+JDID8p2V3EN9h2bszPyJwdPxFeEPfTY+3PlM=;
        b=ApnlS5ctYPA4N5Dy9Noo6ncTp8coSToikrn2m1GPiSMDgVs4JQEKq/XZjQqVk5NKUs
         k9WrJmmKiBrM1R1VAMTxqDjv2Lki3RCHGariHQ80qvgii7ZDslr4bgwnn03KHKzWEq3Y
         uCYKSGsH+AFQpKHwr2SR2FEA48p0du/ZCXkmIs6IDBlMuEQrrUtjo2lka8gVcCtmxW2E
         qBziazrfT9DZiFZHmaoxEL1tvtDeHYhHGJh+MUZ+qyq2loRovIU349o1WtdiLN3S95UV
         PCdByStGHjqpv14ZrJK/qPlv9+sn4+Kq8lJpgEszVPTXEjxop1BG/jEB5feOoU4dhMiU
         D84A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shaohui Xie <Shaohui.Xie@nxp.com>,
	Yangbo Lu <Yangbo.lu@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 127/159] gianfar: Disable EEE autoneg by default
Date: Fri, 23 Feb 2018 19:27:15 +0100
Message-Id: <20180223170758.526380185@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218460096421135?=
X-GMAIL-MSGID: =?utf-8?q?1593219066407144857?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Manoil <claudiu.manoil@nxp.com>


[ Upstream commit b6b5e8a691185606dfffff3198c89e3b4fd9d4f6 ]

This controller does not support EEE, but it may connect to a PHY
which supports EEE and advertises EEE by default, while its link
partner also advertises EEE. If this happens, the PHY enters low
power mode when the traffic rate is low and causes packet loss.
This patch disables EEE advertisement by default for any PHY that
gianfar connects to, to prevent the above unwanted outcome.

Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
Tested-by: Yangbo Lu <Yangbo.lu@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/gianfar.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -1792,6 +1792,7 @@ static int init_phy(struct net_device *d
 		GFAR_SUPPORTED_GBIT : 0;
 	phy_interface_t interface;
 	struct phy_device *phydev;
+	struct ethtool_eee edata;
 
 	priv->oldlink = 0;
 	priv->oldspeed = 0;
@@ -1816,6 +1817,10 @@ static int init_phy(struct net_device *d
 	/* Add support for flow control, but don't advertise it by default */
 	phydev->supported |= (SUPPORTED_Pause | SUPPORTED_Asym_Pause);
 
+	/* disable EEE autoneg, EEE not supported by eTSEC */
+	memset(&edata, 0, sizeof(struct ethtool_eee));
+	phy_ethtool_set_eee(phydev, &edata);
+
 	return 0;
 }
 
