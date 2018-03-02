Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt+5zB4Qk2/b7A+BtF1bAwaJvZP/sPSAqvTSlUCS1sdE526b7eIuX/dWnhu6SMiLtFZn86f
ARC-Seal: i=1; a=rsa-sha256; t=1519981229; cv=none;
        d=google.com; s=arc-20160816;
        b=MtvGr7wG0Vy3aYrYhsfvCHUo2nwjuPt0dixEfePgo0Oqi0ax/sp7xR388dkghVvdVy
         sCw2Z250u0jR2xJf9TDOSf/AQDV9tUBiBs3GbUWgek3v/sAiSWY0CQo4m7qeLDPSermH
         d2An+blu0n5uVsclcMbCyIiaXsIkYlfti/1lNxnPT+uLpPVAKxaUGFBFIdJp46S+u0CZ
         NqznoTRwCtmiulmQFg77AzRx+yj7Z0DcIGhWzrsFAi9HpNJqak7nFa5n0t3YY74mQeO/
         3lNjZ5s4IF5YYxav+YSs1L8D18a2ulQDw0EixMB27t2ia9bjaRfXRBHybXb4jFSDmXlB
         ChmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K7wvkp3kwAR+MQYzdibv2dTpTDeVEn1zh0HE8DgnKKI=;
        b=JaZ075SKooUHEwQeRLYXTuWOO+zsHYqkrexF+nkdthMFNRZW8Ttm+eo1MSr5NgILlV
         9zjnWb8y0lhVgjShRiN+4s08Meij031J/FvrY074nhOOQEAxrgBeCqUhhur61E07ftqG
         GJ3Ukq0OaXzBNABFql/4pH6/AGs5B6cknXN7H4iRYmOty35VrNSDvb3pIcLu3XGUcXMp
         WS/ZR8LmkBGW7YCMaDL9F+CtaQLYm6BTNQl86YwzPVQJsmBj4WSNamNzWZzI/ldTfeaA
         ldxGLILTYJFAyW7KJDk4fjzW198+t7WUh+8acyfbKqLNHn5rvFiIuAmbEzvqJwqRodBU
         dOnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 030/115] net: mediatek: setup proper state for disabled GMAC on the default
Date: Fri,  2 Mar 2018 09:50:33 +0100
Message-Id: <20180302084505.104539975@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815718582713784?=
X-GMAIL-MSGID: =?utf-8?q?1593815838187135608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>


[ Upstream commit 7352e252b5bf40d59342494a70354a2d436fd0cd ]

The current solution would setup fixed and force link of 1Gbps to the both
GMAC on the default. However, The GMAC should always be put to link down
state when the GMAC is disabled on certain target boards. Otherwise,
the driver possibly receives unexpected data from the floating hardware
connection through the unused GMAC. Although the driver had been added
certain protection in RX path to get rid of such kind of unexpected data
sent to the upper stack.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1959,11 +1959,12 @@ static int mtk_hw_init(struct mtk_eth *e
 	/* set GE2 TUNE */
 	regmap_write(eth->pctl, GPIO_BIAS_CTRL, 0x0);
 
-	/* GE1, Force 1000M/FD, FC ON */
-	mtk_w32(eth, MAC_MCR_FIXED_LINK, MTK_MAC_MCR(0));
-
-	/* GE2, Force 1000M/FD, FC ON */
-	mtk_w32(eth, MAC_MCR_FIXED_LINK, MTK_MAC_MCR(1));
+	/* Set linkdown as the default for each GMAC. Its own MCR would be set
+	 * up with the more appropriate value when mtk_phy_link_adjust call is
+	 * being invoked.
+	 */
+	for (i = 0; i < MTK_MAC_COUNT; i++)
+		mtk_w32(eth, 0, MTK_MAC_MCR(i));
 
 	/* Indicates CDM to parse the MTK special tag from CPU
 	 * which also is working out for untag packets.
