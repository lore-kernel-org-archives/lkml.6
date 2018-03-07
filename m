Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsFRRXNRO04L46Q9iwwOweZ5aQcSkJGkgBOeP57rUGI9E7bYjmieKTQ4lxUWgZeVYNhHC8S
ARC-Seal: i=1; a=rsa-sha256; t=1520451693; cv=none;
        d=google.com; s=arc-20160816;
        b=Wdn35mlzghT79++PMxLN7+l1HI6lNkldz9sAtcoJQuJ68UK2XINitkzi6kRwOo3u7I
         qisFZ624gxmGPjwZSakzfUERZ/kYmfxCV6e5bbaNn8ALAugj3utyEPAR3icDjwjVQ7NK
         pCgOWwcrYRNVzSKQvpq4//rVnGUwJSp2pzkI3kUhqrCd9Dj27B05JOHpPBPyZz/A8gzb
         ULX/jPQHA6dlDSOQfyATTAg49wJQr8w/b17WHKpuk8+ZPNzI8aRTDdTXseKRGW30aT1E
         7K0JYiBafnAl704p7fq0b+K6LZrVuvVa86jcXqkP+n2xwzO9k2MlH7uMBmfdctP0JxBb
         wlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jUNX888lgMji6Xm/BRJfbdzZbTPlopaVEy21SQENzuE=;
        b=cLmHFbTHGhZo+RjzC/LtCPZujAGnZ96Ws5hKwvs36DsfWFLEEHOOhfMc/Rb1zoAxTT
         CcBKQxYxJatovNdywhjwgAmimYnOfWGszfBI3uTwkOf8vik0Goa971k/w8ZpryZUUMwC
         nsrSsb5oP27bZTgy1nQWhPFSCw+JLWJ4K97L2sfrVAZT3nHaMHFxw0BeCnW10Ux5cZLX
         hO1k3Z+Ue+iRdtTvMN9TAZR/hmhwscJOekSpuj57KKbyoC/vNwPtziw/OuxjhPY//pxF
         ZFbQSnBcOv7dD1armwlXm19AznuOD+BBPlBQTK5hCXYmLbbmKAYc+nDBEKLyq8gFMEXH
         wkjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 056/122] net: phy: fix phy_start to consider PHY_IGNORE_INTERRUPT
Date: Wed,  7 Mar 2018 11:37:48 -0800
Message-Id: <20180307191737.297732221@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309154741334905?=
X-GMAIL-MSGID: =?utf-8?q?1594309154741334905?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>


[ Upstream commit 08f5138512180a479ce6b9d23b825c9f4cd3be77 ]

This condition wasn't adjusted when PHY_IGNORE_INTERRUPT (-2) was added
long ago. In case of PHY_IGNORE_INTERRUPT the MAC interrupt indicates
also PHY state changes and we should do what the symbol says.

Fixes: 84a527a41f38 ("net: phylib: fix interrupts re-enablement in phy_start")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -844,7 +844,7 @@ void phy_start(struct phy_device *phydev
 		phy_resume(phydev);
 
 		/* make sure interrupts are re-enabled for the PHY */
-		if (phydev->irq != PHY_POLL) {
+		if (phy_interrupt_is_valid(phydev)) {
 			err = phy_enable_interrupts(phydev);
 			if (err < 0)
 				break;
