Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/CwfSGR/SnxuDx9dpkhbp8ACK4rRRDE7ekFCzUx8YcinDDDV4xeoXeHGot+dL2faSCvQiS
ARC-Seal: i=1; a=rsa-sha256; t=1524406705; cv=none;
        d=google.com; s=arc-20160816;
        b=Svyo/m9KBj2bLYOudC6Va7Wtc9eWwvReOsrYWx7DsLyQyqPGyrUeLMoLhE96qT6elE
         QWK5KOYh8pHOlJba8o3Wp9f5Ou+o6rkjPiB7rUpcHBIKhB1vtK81eRvQkcemoL8TBm0s
         kiHYjFMtHd16Y5nx2jWanH4oAwQ3rLp1v+RjjVJga8PJ51pwa45bN1GvSbl8e/Jx/bGn
         tbvfcXFgz7WAaUbjkydQMzUsH19Ha/TcqADOiwR9ZOYVEtRsGPx3I5MHYv6ZRZ4+sn2B
         i6yv/6rT+OZhl+WXUz8lrbRTyr/GzyHEx0/k40szOOE6lMxye7Y+tiihqv/A38pUhWki
         XBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lfG+RacQBLUxbaS9cXZvPo9u4jttmcZr1h7FATCGn0Q=;
        b=rUw90OfYfTJFrGGaHLGafaEiPSkpMHZ35LahyRr9YaQkyoBYNRQPG4eRwJksTlYkC7
         d2QgSnuadaTkLPQYWcX2MQ4gE43dptNBTLVa2qatbl3p5/JqDcQLi6qXimv/GyD+BNuW
         5eQdGbVoUE4TDm4eC5onBHiUUUNndi1Fu0P211W5UiEWCOiWQIJPDGJII44zWgiBvIAZ
         NfEvXvj1gz8vjL4jn9y7923vRgy9hM60oInhCMqRISIJWcLyi47hD7B1c87HJNdPk67G
         SmgIUEVMDBO/9T1ObCCfEVnyMGPvY72wYScq0T8wrTSrHCZaSIzbbYZsfzVGQdBaUKyC
         XlGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thinh Nguyen <thinhn@synopsys.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.4 38/97] usb: dwc3: pci: Properly cleanup resource
Date: Sun, 22 Apr 2018 15:53:16 +0200
Message-Id: <20180422135307.458166318@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454910876862386?=
X-GMAIL-MSGID: =?utf-8?q?1598456285375540605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit cabdf83dadfb3d83eec31e0f0638a92dbd716435 upstream.

Platform device is allocated before adding resources. Make sure to
properly cleanup on error case.

Cc: <stable@vger.kernel.org>
Fixes: f1c7e7108109 ("usb: dwc3: convert to pcim_enable_device()")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/dwc3-pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -167,7 +167,7 @@ static int dwc3_pci_probe(struct pci_dev
 	ret = platform_device_add_resources(dwc3, res, ARRAY_SIZE(res));
 	if (ret) {
 		dev_err(dev, "couldn't add resources to dwc3 device\n");
-		return ret;
+		goto err;
 	}
 
 	pci_set_drvdata(pci, dwc3);
