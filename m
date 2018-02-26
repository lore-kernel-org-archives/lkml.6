Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225qhid2A0HS/kSvQ321NwSsZ4rKDVJ3PbTL/tLwqHRGCxHQyW4FypZY6wNoxYwVnqDXntDq
ARC-Seal: i=1; a=rsa-sha256; t=1519676883; cv=none;
        d=google.com; s=arc-20160816;
        b=yzxumoKrizPgOlkoxGU/AYfD4ZjcXfZ7ABZZGYUAiE1yz9r5i/cay7EJCWyrBV3ibO
         kLhVqscADnJnEOHv6M2zRlzQd4qi0Z4RGlDP1lOT3p07fQrT8OkhGh+cYOJvtFjoXcKY
         XNSKYXJ6K1KFhLu8tofexKkqJafrlRcp1uY470pPT3NpP2TswshSuL4KRiQJwbxYmTvF
         2Ts+IcnNr6IDWHM609WuxNx1UAwhiFa98kANIxhD5eKevWURWTv1feMd3Oe+EAqOMyus
         hZPS4aIn3boAUkYJQGFhz3OfiSlev+3sZJwH0PBw81Ll3JepHx3OB5cmrD2OfIqSeO/i
         xzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LEY2rx1nlnRYLhmdK969GB2O1P4v38WE2hbcpfkiZZk=;
        b=Kr72GtfF4dwx27OFy7Gj8XvLJ2Dy2Yw/QPqjq1KZRX2ZzCYb/itUelJo+Vj8oewM2R
         TgCFu0KkoppvvN16s16n+mVc1Qgdlao7COPSm0vV9iRAmlPCV7Tu5YokAxrZciPDmH5Y
         LLrjohSLb2yUHmZzdk5s2SfEzxwxbBwf/5KXTVPQLjfLQYorABgvwzq+c6zAl+oMX0J/
         42ai3DTwoIN/JOaeHxg2vlQ2Rw49C3DGV97VpqyoQYczFjUQ7eEkBY8m2Vn2E7jKw6AU
         NnHxFZgedCdpdXDOplRyueyi1WI+QrTR7DOpM2gafbO8hmBRvhdWpZ+A/O/17fh+dA4L
         tiNQ==
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
Subject: [PATCH 4.15 46/64] usb: dwc3: ep0: Reset TRB counter for ep0 IN
Date: Mon, 26 Feb 2018 21:22:23 +0100
Message-Id: <20180226202155.420348783@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496566604653259?=
X-GMAIL-MSGID: =?utf-8?q?1593496707594247421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -858,7 +858,12 @@ static void dwc3_ep0_complete_data(struc
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
 
