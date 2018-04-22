Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+WwID+r4BUvUO8VnfNPYN8fGfK+ykXxg69aHb8xDQzkb+7oirqKjJBfDBF1HKYSBQjuW2C
ARC-Seal: i=1; a=rsa-sha256; t=1524405497; cv=none;
        d=google.com; s=arc-20160816;
        b=phL7zlLWHK0msdd0+C1CoS2u2dxBo6vtzg1tI8aAhyWaYG59UDM4SRiAFg/IInOpHh
         7UOvibMrT4sgalVkdrz15xA5Q9wHQcZRTjR91comyW9yTm0wU0iMzvUmcZxPw1Y4erL5
         Tvrcpne/HEop08uNwfpdTtmQLfNX6Su6eQuYLSFfamMP9rJ3yZZdj7KmewjXZyWFg02w
         23hREsLYloPui/Sr+zqVElyIS8AZY/eM55ag1wn5ahD4Z+Q7NA9O7NMjQcRkYZKSV3V8
         DG/pEZGwJHPQfHiNGiwf3EyrHPhvS6KfYwaPTXfqVEIsblnTHaNzhgmDYbb9wV8MbKcM
         JTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=THwanSNOX8vsaN52sCQ3OJUhZ8iv/+SjORYG7eLXLOo=;
        b=pv4FnxuFRv4GeuLNFEcrEfcgq7VvgdUxgP2B0V4BNCawMwC6lRHp/v8T3c+rVmonng
         Tr6l/x0YPFnSJEJM1zoCGEMUAk/2Gs5bIvufWjFFp2r84VAGAEx0scM+JM7H4Jt06j29
         muCwiYrIGBJ0NB5GAnBuIxuLpvqQ8tFuE6rpZu5tDe6UmgTipnBFdw1oKstPzTTgrRxk
         uXO4ILuVK8QglLFJrGpoOAdN7CTgkks7HxkhK1NseIEbdkWyVJ4sHJJetJlwxW5EpIis
         R4Y6b7/4uRHs9/DHyczVwzeBvRtPFYFwgdA/GwHjIUUjcZUMItBB8FClWFdlOcz2K6c3
         QPgw==
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
Subject: [PATCH 4.16 042/196] usb: dwc3: prevent setting PRTCAP to OTG from debugfs
Date: Sun, 22 Apr 2018 15:51:02 +0200
Message-Id: <20180422135106.250936337@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455019200720449?=
X-GMAIL-MSGID: =?utf-8?q?1598455019200720449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -119,6 +119,9 @@ static void __dwc3_set_mode(struct work_
 	if (dwc->dr_mode != USB_DR_MODE_OTG)
 		return;
 
+	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG)
+		return;
+
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_HOST:
 		dwc3_host_exit(dwc);
