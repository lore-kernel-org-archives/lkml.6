Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsP6krbTdcD+3IeQpYa4SM/u5h9GdRd5Lvph4zyIxRsXLnRHNAivi0/jsXdduafeTd7+kRP
ARC-Seal: i=1; a=rsa-sha256; t=1519676159; cv=none;
        d=google.com; s=arc-20160816;
        b=u9dz6KCiF47Lb8j82ppMYifnMvjlNADHfKrV0oVD7epM1dka3WWOZgNHwdeuDFmexw
         skO2KNHk3U7I2oVLSXG86wjow/WQ+PRPPVdt65Y36H0BWlT+UJK3b1qlleUHjPaJlfty
         4iz0CucXQc8oMKRNKyaxzgqG4oarz6gxbzuVfmq/pB1wAhpvVcCW2pAIgQg1UXAgTpj/
         cYCLvJQRnIHFxlGVHUXKG0dZ4K7AN8Ip5QC75vz1mfnjSwwyty/DEMxc6Mp5pO7ipC0M
         tjLtnBqWRI6L4JtP4eGSgnO3AV/Qtn2T8q/MGrR5csdove0+cVg539Le3L7yshxCQtOq
         bdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4PTQw0kHNdZH6Cfhz9cdkjANEgZjIsmCNRKMiUPqaOY=;
        b=IgveHrxccS0RU3YGT2MxdVVxC2JvYh6NC35fprbeHV+pn8mhjzttmwx6vzV6S2NNcm
         QnA/8qQbDNRPp1xHi+jB+KbEq9Yqkd4Cl35Nd4mcZdFCAgTqgQo0lSw9WsjMAnucID3Y
         sFsSS40ftYK6vakan1icqCvbwrGWzC80sm5fQyUWBJNVfxpXFBFjUmeruqzVLEbk+jxx
         UIz5hHyHfl0uk4NHUKNMm4jmP0+rA9nrdvlqxqeidUwYaf6kU7+i9KY0vWRxEzujkRJj
         FtmPPZGmGwxa9UFm5kBusYtLm/527dvi3TL+BuvKkUVzmt7k9+fsKB0/chqnaHgBMDj3
         9Seg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thinh Nguyen <thinhn@synopsys.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 3.18 11/13] usb: dwc3: gadget: Set maxpacket size for ep0 IN
Date: Mon, 26 Feb 2018 21:15:39 +0100
Message-Id: <20180226201527.731997055@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201527.242286068@linuxfoundation.org>
References: <20180226201527.242286068@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495949068185016?=
X-GMAIL-MSGID: =?utf-8?q?1593495949068185016?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit 6180026341e852a250e1f97ebdcf71684a3c81b9 upstream.

There are 2 control endpoint structures for DWC3. However, the driver
only updates the OUT direction control endpoint structure during
ConnectDone event. DWC3 driver needs to update the endpoint max packet
size for control IN endpoint as well. If the max packet size is not
properly set, then the driver will incorrectly calculate the data
transfer size and fail to send ZLP for HS/FS 3-stage control read
transfer.

The fix is simply to update the max packet size for the ep0 IN direction
during ConnectDone event.

Cc: stable@vger.kernel.org
Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2345,6 +2345,8 @@ static void dwc3_gadget_conndone_interru
 		break;
 	}
 
+	dwc->eps[1]->endpoint.maxpacket = dwc->gadget.ep0->maxpacket;
+
 	/* Enable USB2 LPM Capability */
 
 	if ((dwc->revision > DWC3_REVISION_194A)
