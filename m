Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuMskbqq2lnm7yVO5EdOjgfDNCRqZVMF0aTEenIfMPFLw3qN7RyKwC4AHFkm5gduMV0Crcr
ARC-Seal: i=1; a=rsa-sha256; t=1521483463; cv=none;
        d=google.com; s=arc-20160816;
        b=TcWpWQb1pyQ0Uwo4W7q9cMhfmJa48mySkGjMJI2hsbebMFfeqF30wow9A4t5kq5Sw5
         xWwU7tbU9KnkT7O5XRCR07XFDLfT/xDfrZjwZKxSZoXYRm45EzwCXYUkXbw3sUx09lfQ
         QmFTFvYNs4w99fe0T3Ccx91YtPz8+YleVoPAsmVxmkzgy5d1JmOrqQMk77WTcqTvzxPD
         VY6TiEHdxb8HI2K9BUnB3BYdZxLBdvKVpIfHB4wkAtySjTCQuL0YgqvM4GOCEfFTRV78
         mVNlPJiGzviCd6jzjF03qdPQRLqs08JIQRBvEqUFvR4lcDGolWxdw7Sypb1ts5JuvaDl
         itZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uSFhdWT74IFcn7guKWJq/6oQUDS2qOK5MOaLqaNUT5M=;
        b=pS1BdNz/elW/AD48Yxp1tKFAEohbeM+ACBf+/t7Fc3kRsxwJ5la8QlCybrYCDJV/Ew
         a8RZFHUGKFWAzUvSgpMg6nfGNxphdasWvBGQZpYY+/rh4C8Xd8GH2ezJGTzBVuvoDEdU
         +/zuLtp8Mi8dr1dVscinUGGEnFPm+yx16riRlWsGFh/8KXTCG25OIx02clLNLAjGKEzX
         WHwksccw8iUimJzXvZUsqybBOkMl+OA09uwYbgN+/cBfDISfwn45/kNVONC+Y8mxvBGV
         /jAeEXYylBe1xTuo1BJYakqlsbYFNbRZTiYgEVcJL070cYhM0v323EPcue1q7S87Hk60
         ApDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Srinath Mannam <srinath.mannam@broadcom.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.4 133/134] usb: gadget: bdc: 64-bit pointer capability check
Date: Mon, 19 Mar 2018 19:06:56 +0100
Message-Id: <20180319171908.434936208@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391044924888972?=
X-GMAIL-MSGID: =?utf-8?q?1595391044924888972?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinath Mannam <srinath.mannam@broadcom.com>

commit c8e4e5bdb62a5ac6f860ebcaaf7b467b62f453f1 upstream.

Corrected the register to check the 64-bit pointer
capability state. 64-bit pointer implementation capability
was checking in wrong register, which causes the BDC
enumeration failure in 64-bit memory address.

Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for
Broadcom USB3.0 device controller IP BDC")

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/bdc/bdc_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -475,7 +475,7 @@ static int bdc_probe(struct platform_dev
 	bdc->dev = dev;
 	dev_dbg(bdc->dev, "bdc->regs: %p irq=%d\n", bdc->regs, bdc->irq);
 
-	temp = bdc_readl(bdc->regs, BDC_BDCSC);
+	temp = bdc_readl(bdc->regs, BDC_BDCCAP1);
 	if ((temp & BDC_P64) &&
 			!dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))) {
 		dev_dbg(bdc->dev, "Using 64-bit address\n");
