Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49efFo2OsnvAMXOrCD+5+67457aKuThk/8DTQGLGGCG4JKkDcJe+/Ik2VYXpVM+yZY3AsxS
ARC-Seal: i=1; a=rsa-sha256; t=1523472192; cv=none;
        d=google.com; s=arc-20160816;
        b=LKqgt4hUhoJCmK8AIoFQ8AFaY+QSGgcH11xU0taq6LOhyFD5aOHwJXn2iPceajYiI/
         vH9UMJ1h1X4bRhZKRc+5MJng5wOG5Kl8sI2tKBf27D00yGtHR+uqktcAo+n8jVItNN50
         a5f8iKnrIqYOjK+zlWfMSW+lmuh16idV2zJqteulRyDWv/b8TJM8Y2eUVfBWmgYyqITL
         Z9zY24qdSXPY2aCUBRDwS212NFQBJ/GQn3ISP5IJFg98t1Zol4FVQ8CC1laj9/rYt+n2
         XiKMPcJ//uiXvjhsJuOT9tweTz2oEB5Hu4YTcxI7fxixck1oI+S25Tb1Qtwvo+Mmzlp5
         GB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pJVUQeWS/ZKIsKpTqMoEqwMm9I5DhVXUpS9BQYw6Dvg=;
        b=Hom49TiDkwPbj5Hfl6qbtEE0aKcVdyTfJ1pxpvdpsrqnjLLa/daANQl6mmPUBFt5km
         LmDkMNi8gMnfitTYYfI4m4YJ20PFcGLR35DLgq2okHuYuut+qfCSSNehRPhiBR7hw1qA
         B70aXySYOOWS7IV37GZ+AZWi+RE/5U2Uto+RX2XUfpzNcMGURWF7jlUy8vffLt0dmnMx
         x0A9cl4c0uWTNh5MSvd5AO5LCRjT6xnHzeVY6XsMehLsdhaiHP2+iq7gzHYQQ5gsBPP/
         g1FyLU4HxHdbDiIrQ1BXNKaVmpifvFmpQHBNVkpNJ1hLv6RfSmGJS1Y3RzkKjm29Vjyw
         Bvog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 3.18 119/121] r8169: fix setting driver_data after register_netdev
Date: Wed, 11 Apr 2018 20:37:02 +0200
Message-Id: <20180411183504.172326748@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476378121653786?=
X-GMAIL-MSGID: =?utf-8?q?1597476378121653786?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>


[ Upstream commit 19c9ea363a244f85f90a424f9936e6d56449e33c ]

pci_set_drvdata() is called only after registering the net_device,
therefore we could run into a NPE if one of the functions using
driver_data is called before it's set.

Fix this by calling pci_set_drvdata() before registering the
net_device.

This fix is a candidate for stable. As far as I can see the
bug has been there in kernel version 3.2 already, therefore
I can't provide a reference which commit is fixed by it.

The fix may need small adjustments per kernel version because
due to other changes the label which is jumped to if
register_netdev() fails has changed over time.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -8278,12 +8278,12 @@ static int rtl_init_one(struct pci_dev *
 
 	tp->rtl_fw = RTL_FIRMWARE_UNKNOWN;
 
+	pci_set_drvdata(pdev, dev);
+
 	rc = register_netdev(dev);
 	if (rc < 0)
 		goto err_out_msi_4;
 
-	pci_set_drvdata(pdev, dev);
-
 	netif_info(tp, probe, dev, "%s at 0x%p, %pM, XID %08x IRQ %d\n",
 		   rtl_chip_infos[chipset].name, ioaddr, dev->dev_addr,
 		   (u32)(RTL_R32(TxConfig) & 0x9cf0f8ff), pdev->irq);
