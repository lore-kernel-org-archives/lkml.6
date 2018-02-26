Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226cdou+MUlDKxBCfpZhOBWGL3hc1Znvvn0vq8aOenop7ieiqWXcYLj0eQp5nrk3UcYrWvNx
ARC-Seal: i=1; a=rsa-sha256; t=1519676746; cv=none;
        d=google.com; s=arc-20160816;
        b=j+Vi2k3egP5JZqESbY/NI7wkPR/mLl2e+7sfX26pLBtsav/0TMyqB+rdzbiIjhEpcT
         sJ/xZ5HxH3oMCqRAFMv8lECj86wbJaQb0jT6Bve1fyvAGsiLbRqqppmEHulV55uK/bVk
         mhZ1MRChWGYXMJEwycDb8yF+4DaUue8qfjmL0j2Ro4hAoACAj5nHFutLAke5zfXKs6G5
         ws+n1wL1Ds7q60sMmulAMEjnU4plWeblXn6hJoH+OnoTn5wj5Sjk6TmuqHx8NFiLdXbN
         DByXedpxZZyv/LC3y7pcyo8xIahgMFIzjOXilykeiHq/4P2oQ8tIPXBpKklJKRWnrAGU
         +Wqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mmM/l6yL0f7/yOtjL+y2kdzv+e+iSJpEMW9wLW/QdeY=;
        b=s8FsoI8fpEnFldxSlaYoAcldeLkBbN+WgC98JfFLXaFuaaFEEEbqcfd45OI+JwDaQ2
         04B2p2OPHDYGRnjHGeassxoD6TaC9RPyGkI6z5629hYfXtkA3yNXaxibgFqzfPJitxff
         Gy1vev6o313E5fMBwdVwA/pLMXl7E38//G8Lv8vd/nmn7zToQ3T8dHyF6zKzldWqnL9I
         E5rPVRsYClMw003DDWKNLkSHveB9mgJZM8CHlEqyXvxCIGqUZBPHzZtYh6/VNIFW3dgI
         XIRevD0+g6cWWk7pWjYIGJ3yCsI/rouCrEJvmN4CTBe9TsyIyvlQurk+gcG4aO1VKf/O
         Vvrg==
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
Subject: [PATCH 4.14 39/54] usb: dwc3: gadget: Set maxpacket size for ep0 IN
Date: Mon, 26 Feb 2018 21:22:16 +0100
Message-Id: <20180226202146.319094222@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495949068185016?=
X-GMAIL-MSGID: =?utf-8?q?1593496563790801553?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2774,6 +2774,8 @@ static void dwc3_gadget_conndone_interru
 		break;
 	}
 
+	dwc->eps[1]->endpoint.maxpacket = dwc->gadget.ep0->maxpacket;
+
 	/* Enable USB2 LPM Capability */
 
 	if ((dwc->revision > DWC3_REVISION_194A) &&
