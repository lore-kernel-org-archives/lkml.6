Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtcL1qKC6x3aagkWqtkr/rsP6k348SzL1QoeHP4YpQcHvS+PCkSR0utDApC+MzOZ8Pp7dri
ARC-Seal: i=1; a=rsa-sha256; t=1521484126; cv=none;
        d=google.com; s=arc-20160816;
        b=cBlP9Ggmq6Eh43z8paEL697K3eRfmQl2y4XhrOAiFexSEe59H/mDVGBWNFtgO9Kqtz
         G5I+kHM8XCEkodzrDzQv3iymPCT0zBBgBTF5YJkhkiLxvhfdjT2jx69832KkilVRPbVC
         /Y6ZpIu38nrAQF4a1sFZQdUUYoty0ugLl7qkkAK1rTMlbWGOXgB9BxksJg9uUM5jU8Xl
         mkLgxpooDXYRbDbAYlh5XtRToAE/bU+N9GljOGXfR0APaDvzUDgNEnonfPSOf2USXGxm
         nBtJm4ekwdsph42pBcXDEalBJ4fzdoCZXRBznfIP6wRhbzbWHaGB9M2MW7VpoqXrkDI/
         Jxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uh+k10GLligx4bglF1bgAB6zBxznwM/VWBePCTO+sFY=;
        b=TKTEhc9eHtQSCqP4m1LMO3nTkNACtcgNV6dcvr05QOpImsRl+nci2sJJmsjDZna8EV
         ICc67WYAGTvpmx52+afDzrEAeMRP3FWkTynlY0NtKaR37pknNqZqA249OQqNywcrRbAZ
         kqyH9/2cc1axjvgQu9o3K+K9ERW32LudsEI26fCHAJFpX/2fvO857q1rUZ01EtSlp499
         9SCSiL7zSKsoJnDdbtAf8/TlGorLpmy2iyfoR9FuSGJuHAa91d1PVuqtxPkRnQ4lL0OC
         bWxgRTXr5Kphbw3MbuK8vMod//IB7X6TxcqxQHXExyh1BtqtZs7ZOmzjgv+Djk/U4XOu
         cD7g==
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
Subject: [PATCH 4.9 241/241] usb: gadget: bdc: 64-bit pointer capability check
Date: Mon, 19 Mar 2018 19:08:26 +0100
Message-Id: <20180319180801.149222902@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391044924888972?=
X-GMAIL-MSGID: =?utf-8?q?1595391738887099974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
