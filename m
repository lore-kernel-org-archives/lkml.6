Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ahP+62vRGO6LzgtnVCKsz7Zny9DLfSd5dN4IV5CT5eU2hnd4I3s7kC6gMepuzVwz98aGN
ARC-Seal: i=1; a=rsa-sha256; t=1523399586; cv=none;
        d=google.com; s=arc-20160816;
        b=OVZYnQiFvYX4l/Z5tQgdV4irRSzJ4TmVEX1zHA2L/M+o/vhXnmVElorL+16qv3KsXy
         Ln08I5NQxwzDk3+2mO+QrE5/gRNh4RqHR09Y7fqUkQv/dNEqEcUBxCgTxQtST65IVlCJ
         2gB9nBjpRM2snhvfB5BH4IXbgi3/xz2SgWM7LyxRHI0o1kBJ89K63yykykdFLgTNtIa+
         7MrZ2yYS/pVMd9PF8zAyGdIZccU92wQDBbDKlDLJ5Gt8iLgWIFqfjTK+Cb2zAwEvE1bq
         9DmZX9ZbboIL7Qwta8Y5iIcmUJ/uYhDdwE7ezfMBbI3HxlxadRqIFCekoiSRmNFWqqms
         p/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dvhN93XXhp4ZFxpFFc6JoYyxx0GU5TFXMVbIlU34v3A=;
        b=Pp/lV6dOnF9KM6c7BgS2ObuFYJfD2bp66/mPsmOaLmWigBOrbLOUWM9BKyJstm8HRK
         Hrsyj2KQvjRdCoJryU7Tbrr0C8eu+dBf045NHyJewFrjckvvQec5R7HHPnsFmUAeQVWg
         p24dEQTWeZs3adljkUMC6GpmEDyzKTsiA09O0R54b2RbIk5jjpBDlKZ8SVYwOd0hO2tR
         +VW2xuJ3JyPyVPs1+4R0NIso6RoMFWlXtTPgPEkZ3JkOESKWOv6RlQv3wJyDqhi8gjoT
         yLFs1nQO8VJpc8zDSc7g2GgPWcdvmgPjC7FDqk7bQjqiar03RZOjO/qGQZNYj40W2GJj
         RAdQ==
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
Subject: [PATCH 4.15 133/168] r8169: fix setting driver_data after register_netdev
Date: Wed, 11 Apr 2018 00:24:35 +0200
Message-Id: <20180410212806.641864901@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400244259520403?=
X-GMAIL-MSGID: =?utf-8?q?1597400244259520403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -8699,12 +8699,12 @@ static int rtl_init_one(struct pci_dev *
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
