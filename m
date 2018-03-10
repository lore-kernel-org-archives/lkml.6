Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvSqhHx8B33Z09R8PPBbOVnx13MEOYmGAestqk61wpslcozgOe9hjbFrbzq7K+ML4vqak3K
ARC-Seal: i=1; a=rsa-sha256; t=1520641334; cv=none;
        d=google.com; s=arc-20160816;
        b=IXrfErufwX5ZnlXovHtRA0oJkHW6b6ATsR/nK/mNKZV+9dHAFdUzaqS7DgPXmr0nlb
         /Bade4/Gcp2LHAJOMv4nlBKkQUCEWdCAhxHCT6W/GYpoOnurIRz9bC1Zu6sOOYTQaJ7x
         R4R34FjGjUCoXInbCZM5kLSUXJD3sTetFYP8rNpTfuOC9nMibiSgAIlZS/omys1/WICK
         SGbPaAlPNqfK/MZDZQwnj/MRaLC5/+58P2Oo66/1wNbkb7Juwgd3tt9s2htz8rMeTTDr
         V/HEj0PdWbX5vkI5fRobOw+pFkE6ml5qtDe1wGucC/5ueEjNsnF1DQkYPFHztARwzzdG
         MFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ylq1TC1Pra7mr41Zw0au2ETy4obUcQDK/9IYgx/S8kk=;
        b=aRhRHtmrW4vrqGqhyfWIISJ/StR0wcb5+XAhgIaBiA6PuMSwNlYpg316lX7I16C8EG
         DW09IaHqH253XjYP4BIbgDKpVotf9jUglZyNYAOeZSL3YRR0MbvLolX0hXAJF3eZAJmR
         uSm3Xx99gVAnsv/0kwE/C7BtwvnqNc0Bmapx0x7eWl+WVQ6zF9UgPyO1qqj8H3B4TfxH
         TdD1gwPV/xLTjHakpgXVM4f70ELSnIFTjeny0mzwe29n/QhIQjbURSmsUvMJuE9/03OU
         sRCdBQYkFLrOgJEh2unD2OS1I+MVx6j+uXRVkKevRaSMLNZyqS7jWludCaH95LDIEIKw
         d81A==
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
Subject: [PATCH 4.9 44/65] net: phy: fix phy_start to consider PHY_IGNORE_INTERRUPT
Date: Fri,  9 Mar 2018 16:18:44 -0800
Message-Id: <20180310001828.494433324@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508007761556448?=
X-GMAIL-MSGID: =?utf-8?q?1594508007761556448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -925,7 +925,7 @@ void phy_start(struct phy_device *phydev
 		break;
 	case PHY_HALTED:
 		/* make sure interrupts are re-enabled for the PHY */
-		if (phydev->irq != PHY_POLL) {
+		if (phy_interrupt_is_valid(phydev)) {
 			err = phy_enable_interrupts(phydev);
 			if (err < 0)
 				break;
