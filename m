Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu90XiVsnloK9ie6Q6AtFoLNtAQb0JJKsI9y7C6ahfUB/nt4tvFaUusdHvirbUEUPaMG4Ki
ARC-Seal: i=1; a=rsa-sha256; t=1521484238; cv=none;
        d=google.com; s=arc-20160816;
        b=rYZZbKmtnf0aRDT0ldusJJILX5NDTABlLI9wXdz5GWpz0jsC2/Sxmp00u/0L+kBsC8
         NGxvoJgOYCDz8fFYPumWelIa5n3vWSrz1cxovcNzLqLJRRzAAX1MpKgMgSypIAeXwBwH
         vzHU4SGbY3AfEgG+2SEGHhFsJxwFN/95qbMSLcru4ExJIa1AhUH8sM/7C0S9YGTYu2Fy
         2TjJjyj0oqwmeN1gkD378SbU1Xf2ivtE31A2MWpSf94Rcj+teAze3eRio74o/PDYyKnj
         67zwCqTKclF47mQeSihWhEbs60j1aveSnMK9LbgHVexTJBqJ0HSlj4IccF4oEgzeWz8V
         Vr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MZfQoroOtUsjJW3Sqo12HopZNF2Z3OusX90/KCvf30g=;
        b=MOpRW+/kHZ8np/euZm0XsO4nc1eCTANqe4/lpFUtXeX97/5zYROSicw4cEwjs8WKyi
         0dDUzPD7cOPazv7o2VBdSjftqaSeM0pna1BtD4iz84htGWFPkpsoBA4iwugHC4m7BB99
         /Kr1jX709cOOMHWjdnLqSZRR0wyvBG9qjLOjv26YF4ce+7lOWUmutJEybQSQBOIoQnz4
         qD31PVvN9E42LADN4AFFGxNqsTZqpbvwY7zyTddiN9eWNNp7BMKCh++PreZHtxcb3ARO
         mFT42iIKVIvYdj51k9z2tUhOyTwhKCOnygd9BfNm+KJlZ5gedF7z36G19E46uRsB3OBg
         4r0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wei Yongjun <weiyongjun1@huawei.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 40/41] USB: gadget: udc: Add missing platform_device_put() on error in bdc_pci_probe()
Date: Mon, 19 Mar 2018 19:08:40 +0100
Message-Id: <20180319180734.792136619@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391041891799420?=
X-GMAIL-MSGID: =?utf-8?q?1595391856832329882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 8874ae5f15f3feef3b4a415b9aed51edcf449aa1 upstream.

Add the missing platform_device_put() before return from bdc_pci_probe()
in the platform_device_add_resources() error handling case.

Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3.0 device controller IP BDC")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/bdc/bdc_pci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/gadget/udc/bdc/bdc_pci.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_pci.c
@@ -82,6 +82,7 @@ static int bdc_pci_probe(struct pci_dev
 	if (ret) {
 		dev_err(&pci->dev,
 			"couldn't add resources to bdc device\n");
+		platform_device_put(bdc);
 		return ret;
 	}
 
