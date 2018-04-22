Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+C6S+HdkzQ9VAGxxcM5D0ui4rvKklxjrmuwFMoRmhpkvwcvGecJMjc5zSgSVsuKuv5Xui1
ARC-Seal: i=1; a=rsa-sha256; t=1524405993; cv=none;
        d=google.com; s=arc-20160816;
        b=JycNPX4kjPlfTTs1Xt+BX3FySGzp6elalWXzjKKwl2ttTAU24ZLvJAUyq1ctY+sXlR
         Z7VL4m5jSd6pzHDIUcP+j8NbgTW8adFYRbsNT1ea26uYH+KoXB3XQJ87Sa6EfxZpwlmh
         NM0EumeElVxtlf1HBggNLroh4eIPuYG6W9L5TobHmVs6DBE76m6tJKCai93eAJfCRdOD
         iZjJzxcuv/13Hq+AGoH7804uLw4sl7KiqmRBGTQpLVCOsZy2X8E904Icu7FIlnMN2Of7
         ccDRTEqknfNxTozzIc3di3cqKNh5K/seDaZ7ks4ZxYwotdXA+cboI8Aem+OjbX+U6kRt
         xLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RXcD1OMU0Lzmch6hvHrpw9Ew7HRRvy+14no/m+Qzaw8=;
        b=UO8BsFjKW1fcj4dKy6UsbV2QsI/SKh6yZ9T9SGyyeEluCqbb67LDS4xLRHpUk7FXlP
         JYBuFUhL2SqirNdVAMW23zxVfJ7aRMBI0icLvqN4npVsJs7eqYjCxPbNbgQZHCMDWem5
         qIGcqHyFEJBc96rrJCIXTV6yNTT9yGqIFUS8IRfXLw8/r7sveMeZj1T1iAlFs9euYgD3
         I3blcjXIsoGjGqjBwIbo2R3BO/LTW495aDI6EnYgQgVVEOwnYMyKYvV7jFPMstnJlF/M
         6x8NXAeDgD5UDnPtuvRX9beBeOs5UIJshcO4JCCyVQSu6mFezUwzCdXzeJ/LzIacD5o2
         3dZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roger Quadros <rogerq@ti.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 039/164] usb: dwc3: prevent setting PRTCAP to OTG from debugfs
Date: Sun, 22 Apr 2018 15:51:46 +0200
Message-Id: <20180422135137.003707753@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455019200720449?=
X-GMAIL-MSGID: =?utf-8?q?1598455539036773895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@ti.com>

commit daaecc6541d014dca073473ec8a4120c0babbeb4 upstream.

We don't support PRTCAP == OTG yet, so prevent user from
setting it via debugfs.

Fixes: 41ce1456e1db ("usb: dwc3: core: make dwc3_set_mode() work properly")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -128,6 +128,9 @@ static void __dwc3_set_mode(struct work_
 	if (dwc->dr_mode != USB_DR_MODE_OTG)
 		return;
 
+	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG)
+		return;
+
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_HOST:
 		dwc3_host_exit(dwc);
