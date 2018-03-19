Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuTSKzV28FlQa7G7DYMjS1CGjSKD3WGEetnMUAsxfPtJNnk4Ma8FlRr9O4yWr9gkK5h+vvQ
ARC-Seal: i=1; a=rsa-sha256; t=1521483461; cv=none;
        d=google.com; s=arc-20160816;
        b=AxB+dSJ7fqgAf9qhW5l61B8Cj1fuLdYc7AtTyoFu4rYGmfWQHugdJtLuXU2liefOPY
         l76dmgb6oPLsci8KwCnxvOrBOcomP1EoDckoAMv0ciRreO/IlhJPgkgR27ydauWpMS8L
         YN5nmlplUFpCpMQ40HRpCsBd1+ZdgdwzDKAhJ+tklpPwILAB/Z1eoORvEXDD7UA5fRHP
         D88VnIeB59GvMLj0M9bhLk2zMh8gu7i5gapS0r09/UDPdluz8qk4uTCLXfXPBdQo3dDo
         hzc3LufNgOM8FdIdTSvZWUq/jRBAqglaudr886gL6JGdI3yVRx7K0y3ODeuG7TWRuLjP
         CFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zNlrSLHVtDMWSXr05qYWugqjOlRXxUt4oyf5OxDIRbw=;
        b=JXkVgaBsYwzg9CbD+HIxG1Z27p+v/MmI4ZksuhH2Ys1ZPffE4G9PVmCHq5QwwhWi2A
         Umterv/mnU2F15xIbiN54u6Y0MQjieShtFVaXwQQD/16IS0hm9yoJTs1gF9Jivt/wYjK
         YRUuP9FxyPZsqF0M4TommYbUmq56sK0/ECaEVdmAGmLdYC1YUjpJuZ2q+QCRTQTDPP4P
         Xx9iGsCGJjSD0c//Y/EknYO0XgaIqnZM98iq/AhtY0Suq7o+3nK37roSuWkjJzvoQwV3
         9eBft19SeK83j7wcEcpHCo7qESKgSNVkVUUgm3lyR5ks+LiRyaMCtHPMNckidY8IcDFy
         EsmA==
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
Subject: [PATCH 4.4 132/134] USB: gadget: udc: Add missing platform_device_put() on error in bdc_pci_probe()
Date: Mon, 19 Mar 2018 19:06:55 +0100
Message-Id: <20180319171908.304050554@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391041891799420?=
X-GMAIL-MSGID: =?utf-8?q?1595391041891799420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
