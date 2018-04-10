Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49n8g+v2nbI3eu0Ff9h1BZCjFNmBxVNHhyN4L6BqX9u51Kg3F/Z9OKql2J6ZCmOYgxiQ6s9
ARC-Seal: i=1; a=rsa-sha256; t=1523399931; cv=none;
        d=google.com; s=arc-20160816;
        b=eO9dQP4p173EexQ1heSHWvpCUMeYOOgfNqxJmhB7/hf08kJKym0/YXZYaT3ymPV+l3
         sr9+gg9vrndG4yc50z7Ikh7kEWgiqmtvG3S/fY0dVo7gaYzRKpkddP5x4WqwA60qTJU8
         ti8PuMKclHMGJ3MTQsc2kjEompsIyVBmdpkS4GFFVMVd360fR1Sax5PY4Geqrs0YNH0N
         l3FK2C8t1uNGerw/oZIHjbDk3z8KDpE+FZr2cxi5YTN2+2gKvtc47Jj8grGWdxP3Brgy
         kAwJ5LXAtSepQXngi4Tj0BcyDYzUhRXbti6ycvwq9irntccwkJE+fQubbSDX043wzd3u
         dZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pN6C5zDUiJ0m/k/mZaKq0xAU+VQBxz9DiSAZVelq4pU=;
        b=ogo/yk2E/JwpVxsxVf5hvs4wvLufP/nfih/hSsBJBUxhbqYQsuu1/zSAsPFonLXG4i
         zZF5cvU7+oi+U+KvZsFc2yQu7vehYtNaNUy8X34zUH5DN7vxI4VNoyi+cIIxvmmsAgEf
         i4lqwLnOsZcH1cu72wOV81+YmHgXjE1wJ4IS/Da8wN5DvvJf68bt9PZVGmPxJJ6xrvv/
         XBLNumyMciKyBKEsCY6M+l8HCBD0/6wM3ec5/zpIm5fVplplT/XV/nmKr9btDCkJZMNn
         qkdDL9plhDt1A2ytaHts9b5ITZZTfRCKdXzNW3NguEjsI7FKCdTNscrxbEAc2UzYzFgH
         2XTw==
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
Subject: [PATCH 4.14 107/138] r8169: fix setting driver_data after register_netdev
Date: Wed, 11 Apr 2018 00:24:57 +0200
Message-Id: <20180410212914.642411927@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400244259520403?=
X-GMAIL-MSGID: =?utf-8?q?1597400606988530994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -8466,12 +8466,12 @@ static int rtl_init_one(struct pci_dev *
 		goto err_out_msi_5;
 	}
 
+	pci_set_drvdata(pdev, dev);
+
 	rc = register_netdev(dev);
 	if (rc < 0)
 		goto err_out_cnt_6;
 
-	pci_set_drvdata(pdev, dev);
-
 	netif_info(tp, probe, dev, "%s at 0x%p, %pM, XID %08x IRQ %d\n",
 		   rtl_chip_infos[chipset].name, ioaddr, dev->dev_addr,
 		   (u32)(RTL_R32(TxConfig) & 0x9cf0f8ff), pdev->irq);
