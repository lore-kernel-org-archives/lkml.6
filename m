Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48mxfTA72G99dAy6UkGR4hQ3C++Xz+iVXugn4sGl2RcpQKQjQkvO2bN02fV/+MDJUpcsKqK
ARC-Seal: i=1; a=rsa-sha256; t=1524405900; cv=none;
        d=google.com; s=arc-20160816;
        b=o5FnAQeqfT7pz/KswyWBiuFyHKi3mArGsjLEcNNIpDbwK9Nc5bNGmZac6eI8gkUCG/
         lBruz2DjKyL+TIdQLXLMCHyYqohatEgWe7+S0gHpRHZaoiMwezl55+ky6HirIFE3u9Oo
         iyuCRTZebA5n8jtqWXLgr/uW5xlQO+ekEUg8aTk03ya7AyEHalMq8OOwEAqz/lZoaguP
         UoCBKUzDA/kCA0X9OMgOi1Uuh2LYLTcgjSSEuV03yrxffrfQ35cJktAKkEGAqcsc0Z4F
         hFbGogcOjzuX2TkINuUD4l3DHw3dWT7CER74RC7Aocbh07ZIQ/X7B5rQ5svwZsDqcg9b
         GFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9bdoWNWKNucVDzb/IdeuM9E3UxP1etpj8m4ezJqKocU=;
        b=LuEsT3ewP0o5K9/7OXDKqmJ24aYkWFZjqg1ABa40X9I+eA3lV1Rn1CQ4ANEBe5MLsy
         ntBNdotiE8Hyt2EnVDpitdKdRUOTiyOR4/DvTGy5oW6Gx1gyIDswE9tuGjXG1uw25xOv
         2dLLJl3cNRyqLBmP5WFuWAFdz4DMeCMn2UgSopJQY/T1KlPXRYJEWMQhjxMFKX32ulAA
         7zKjuB8+C5TVQmKmOC9ZP3l0X7TO2AnzYCj0JlBynKO75x6lnup7ZkjpLnXTU1N6dRQx
         WU5ulg3ylQTKOVC6qbUuiOq1YRlRXZSjbemrfReFaXSS05vJqLTOZiFVgCPDFZdiwW3u
         phlQ==
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
Subject: [PATCH 4.14 040/164] usb: dwc3: pci: Properly cleanup resource
Date: Sun, 22 Apr 2018 15:51:47 +0200
Message-Id: <20180422135137.047201042@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454910876862386?=
X-GMAIL-MSGID: =?utf-8?q?1598455441742410333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -212,7 +212,7 @@ static int dwc3_pci_probe(struct pci_dev
 	ret = platform_device_add_resources(dwc->dwc3, res, ARRAY_SIZE(res));
 	if (ret) {
 		dev_err(dev, "couldn't add resources to dwc3 device\n");
-		return ret;
+		goto err;
 	}
 
 	dwc->pci = pci;
