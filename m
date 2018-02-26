Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226TTUHFvNhtmYhwKzpxXZsAN1rDQLS4ZTLwNhF8Lzomd7kvKSZlrnWtb3wOMPaQ0atFxkAj
ARC-Seal: i=1; a=rsa-sha256; t=1519676749; cv=none;
        d=google.com; s=arc-20160816;
        b=h9ep51mqHV+KlMrImvWgNblEpvxhYnVhvgG0VI2TK/24Q+X9ioVpQL5kNy5fLsR1UJ
         mC6O2wqtacwiuCcJjj060ZmHkKt+k4E1vq0+zH6iXhkzkREllgiSBba29hP1uvO38vV4
         55QaMRsx+YbVEz58w2Reptv28JigTjbtFU2+l/mW6M/LUT/8cdcER1WI/DMf/HKpG3zb
         gSyQs6RJuhOa3i/jUuA2K33XE2RVl+c91LzR0Q2azzp98+OzD1SwwiaZ0dQR+WSq6Hxk
         DNy+yaOBUeEovuadVAXJsm/GtxXYED9Ugfq/l0+ZOCJ/C2N2mS2PZsTOAqNBk06jP1wt
         pC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B5MVGdYJXi5Sp9tGEM4aZQ0r0jRHP105U8TcUSRGAaw=;
        b=Ai87S96y8l0SgQkT+ZzArJVmgcrmdumQ1H78rDFI90Lg/vhBiUd7iEI3BOY9nih/d4
         sdxvn9AmJ0tIGVNajrE299xnCo4oUoh3t/1ecmC1hwZnnP5uOHo7+r6oIYJY4bZ1/hkn
         HgbCKG9yg8vKvVu9wkYu9Lsr42wIBOS2IfQsVOe6GGerizAKiR6PHHIChOv//717yjoz
         O9z0NxoFZr5Qr9e39fZjy1expnLiNth6OeKxrvOUM4vio5qzHk5iFEord/7oXgTT2J5E
         +ZTHCcr8lfaFtk1myGB5D9718PmEKttn8lMm3SRm0n4MXoTxOkgyB3eX5GqWTBCugub5
         cHbA==
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
Subject: [PATCH 4.14 40/54] usb: dwc3: ep0: Reset TRB counter for ep0 IN
Date: Mon, 26 Feb 2018 21:22:17 +0100
Message-Id: <20180226202146.370534357@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496566604653259?=
X-GMAIL-MSGID: =?utf-8?q?1593496566604653259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit f035d139ffece7b6a7b8bfb17bd0ba715ee57a04 upstream.

DWC3 tracks TRB counter for each ep0 direction separately. In control
read transfer completion handler, the driver needs to reset the TRB
enqueue counter for ep0 IN direction. Currently the driver only resets
the TRB counter for control OUT endpoint. Check for the data direction
and properly reset the TRB counter from correct control endpoint.

Cc: stable@vger.kernel.org
Fixes: c2da2ff00606 ("usb: dwc3: ep0: don't use ep0in for transfers")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/ep0.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -884,7 +884,12 @@ static void dwc3_ep0_complete_data(struc
 		trb++;
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		trace_dwc3_complete_trb(ep0, trb);
-		ep0->trb_enqueue = 0;
+
+		if (r->direction)
+			dwc->eps[1]->trb_enqueue = 0;
+		else
+			dwc->eps[0]->trb_enqueue = 0;
+
 		dwc->ep0_bounced = false;
 	}
 
