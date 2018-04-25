Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZrRSXCae9nYzYO5F4WnS9diyx8Ud1sGaVlsuftB13oRW4zzB0EwNktDf5CWdBOoi2sdWlXN
ARC-Seal: i=1; a=rsa-sha256; t=1524653030; cv=none;
        d=google.com; s=arc-20160816;
        b=nEdPVrGONE3l3JcFDwTbl13SSYON1/BiILUDbOHduohWd1KJ+Aw6VnxEdQhRjtTwVg
         qReFbshhvpNbo8HwB1Yn9QM6NMezL3IfEp2c0asklTUAXieOr9hy3T0sJqWKgzK/SbHr
         ND5itN1SmAu90NeC3Zaxy87i3Degzvu4YCOt9V1OYA2eLQchMFM8uNdoHrgTiuWlB23x
         ZkdrhRHEnDXr5M2U0mEIoFsAdolsb09/1Qvgeaq+9Z89IcArLhQEj0kWWLiPuAaXjqLQ
         yOr2D1LztXfdmX8a6DV9170mzwZbI+C9omnIzaYNulSk/JD5p0ZDYB+fLmh//SPtBaf0
         w0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iiHLzrSOFW8N3rz+uvEO2/yy2QwmxXnDvk/mKafpwVc=;
        b=Jl8jZVwOW4yseP6ln/UIYEq2eI4pGU3yk5VrOX1uAVotmcG7bM+OztkM8mQ7JUotYo
         PxOCUOjIsn+cONE9W/3uoCzaxOzFrxU1JYs0QFCwhTPtTpKct8LGQKWxo7ZsXKFwVwtO
         VCrdkZE++/eFO+jlAoxFI89mayuzwjbsEKrZ2xtxo69LJud+3c6qiJcdIrIQ7K8cuewj
         pYYp0cqHmjiTtlmU1NS744LNw9CagmXV1LXHPcRNwH9n83Cz/vP1TKUaPgLGJw2675KN
         1Guqnr4pa08qbjYZwgWiYjxx6dJhUJJoyCdGzMr54unfdnHZ4tor6q24bOve2iRmscKR
         cAEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Niklas Cassel <niklas.cassel@axis.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 159/183] net: stmmac: discard disabled flags in interrupt status register
Date: Wed, 25 Apr 2018 12:36:19 +0200
Message-Id: <20180425103248.926651440@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714576410849299?=
X-GMAIL-MSGID: =?utf-8?q?1598714576410849299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@axis.com>


[ Upstream commit 1b84ca187510f60f00f4e15255043ce19bb30410 ]

The interrupt status register in both dwmac1000 and dwmac4 ignores
interrupt enable (for dwmac4) / interrupt mask (for dwmac1000).
Therefore, if we want to check only the bits that can actually trigger
an irq, we have to filter the interrupt status register manually.

Commit 0a764db10337 ("stmmac: Discard masked flags in interrupt status
register") fixed this for dwmac1000. Fix the same issue for dwmac4.

Just like commit 0a764db10337 ("stmmac: Discard masked flags in
interrupt status register"), this makes sure that we do not get
spurious link up/link down prints.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -562,10 +562,12 @@ static int dwmac4_irq_status(struct mac_
 			     struct stmmac_extra_stats *x)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 intr_status;
+	u32 intr_status = readl(ioaddr + GMAC_INT_STATUS);
+	u32 intr_enable = readl(ioaddr + GMAC_INT_EN);
 	int ret = 0;
 
-	intr_status = readl(ioaddr + GMAC_INT_STATUS);
+	/* Discard disabled bits */
+	intr_status &= intr_enable;
 
 	/* Not used events (e.g. MMC interrupts) are not handled. */
 	if ((intr_status & mmc_tx_irq))
