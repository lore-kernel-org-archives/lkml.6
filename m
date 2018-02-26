Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ymjIctGH3P/7glt+DdiviSmTADGIM0WxD84tOzbOPQdwQmMue8cezznLayXYEW3j66+ye
ARC-Seal: i=1; a=rsa-sha256; t=1519676215; cv=none;
        d=google.com; s=arc-20160816;
        b=aMxyh+Ql4+x6fTvQEzWm+KCB8MG5VoRfctH3tZwl9vm/tk3Bxi2FwpbHJW5CDnkqEe
         Z8wy05g71Izh7er+tqlgI9xJTqt2UGH0d6AdT/3bsGOfsKlsStXkk7kM1eyrJGKI2Wsj
         B27txrLFPAuJ/0j+5capeUFxgghC3A4uuD7noWNi3Bbwp8rVGU6yoNPhzMWZr5PRyy+f
         hDa1xTkuw2DEekudsAlXrGeXGJGbmWJukTYKyb5f30cD/0O9rttcvGvuMenPxnjeQm3y
         lwx1zBpHXTb0VsNPJuxNoqqexadNzYIScD0O4zoqoXGndf5sl47LKQ4zdwu+7w/E2NfR
         os3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q6UZMc+/8uPu8CaiMktjWWwwfML/AwaxHuYqKCKYSDE=;
        b=vZb/S1aYe9FFL5UO7mfaaYv/v5v8+ZYYUCpXhpDagIHz7ADathyW5bBynu0qygmJuT
         fEPlblBrerjHvN/a3mRrKn9J5Bs2BnrtR0gwhZsAJIo55Tt+WFizr7kEuAo/1YYysLon
         Rbh2jhN++ZHv0+dcz4h19/FwQEAMJa7E+0dxpGCBafbLcC1HIx3ODQBLm8Od8M+14sDX
         njWbDav4BGaoEunUbPZlqSrkb4QWFZ0pXTgV+phIZVsjcn4XEjc4ZryLBmlk27W9xYuG
         jKwomjQSkRTyMyW6kdphSiJJCI9z+eEcbTqrUWBKjS86h/0AGxJrjpROsMJPdzNYa2Dn
         +W0A==
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
Subject: [PATCH 4.4 17/22] usb: dwc3: gadget: Set maxpacket size for ep0 IN
Date: Mon, 26 Feb 2018 21:16:17 +0100
Message-Id: <20180226201559.477409900@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495949068185016?=
X-GMAIL-MSGID: =?utf-8?q?1593496007258868284?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2393,6 +2393,8 @@ static void dwc3_gadget_conndone_interru
 		break;
 	}
 
+	dwc->eps[1]->endpoint.maxpacket = dwc->gadget.ep0->maxpacket;
+
 	/* Enable USB2 LPM Capability */
 
 	if ((dwc->revision > DWC3_REVISION_194A)
