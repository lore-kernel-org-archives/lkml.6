Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs9D5UTvZ/qEy6owdN/jmI7q7RGRxKq716gbxl+qHvFc7vdtTBrhnLWJ5AZRpBnd7AZ300j
ARC-Seal: i=1; a=rsa-sha256; t=1521484120; cv=none;
        d=google.com; s=arc-20160816;
        b=X6EIk8StlGClFlCt1tSEm790L5jpNV2Dqy9NMEwefVh/r/Fmpby6y8Ie9bF0oArceP
         ntki/lJHLnuN8K0Dl6zFLIQtJlbC+46qCjoLv+bn4rWL/TMs4/iM0iVGHE9/0gJYaohO
         LGa1+K/6Rvmo+LWFYd+79FHW8f2xc/RQ+KvsUZNl3FTQ8DSYhEOu1u2cu5TOOSvzhzAm
         FlEKv6N3cxT7eGMrwWohdS4SMe1Bzi0fv6sol+pA7G7cUZsHwRmva//G3X+IZaT95wZy
         0IV0BPnRGTLWpwoud4cv+jyI9qv5FRupFbeuBrhCEp0T+/RhYiAV89EmXLLRgYi5Tuh0
         PFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lAS8Na9F7Kwjhz/+VCRy7dkG8SwZoZUBhm4qpqmYk1I=;
        b=TyiZD4//gdHRUUGfUiOmW0cI9DTAm441YcEK+pAP0e/3+JV+aXMWNJ0gQEzgR0JARq
         ICOhGpvGvBnU8wkY9/5rGpU37nk+oyGHjiMS0IJlDrRCEjwpu5kz7MIC/6wOO1P2OjUh
         d2+eqTqTroaS85FXcdQcNdXVcK7Z8/pHII3MwPYmiWvU+5CmKSwVzSIlMdjgRSXUkqy2
         Ersk4ZouV3SMR6wlZPIzjGj7Fv7COCksD0ebgBJEWkIHIECd4WvxopYEvcdwhqad7XZt
         Veqh8/6jyAoi1rx+3/Rx3QfLqexmkNQZYR7jc6P/5iEz1g/9ek4SQ0U5iyHMmaYN0fyp
         AaHQ==
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
Subject: [PATCH 4.9 239/241] USB: gadget: udc: Add missing platform_device_put() on error in bdc_pci_probe()
Date: Mon, 19 Mar 2018 19:08:24 +0100
Message-Id: <20180319180801.068116443@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391041891799420?=
X-GMAIL-MSGID: =?utf-8?q?1595391733388944367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
