Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuwbHSy/nRu/9wgOdUyS8klV1PlAHAfkD6eMVpjhaXsZptgcmOCUjPZKdsDPw2aFj4iRPa4
ARC-Seal: i=1; a=rsa-sha256; t=1519676497; cv=none;
        d=google.com; s=arc-20160816;
        b=rWzGN1N6WUBtzWsKhkYew+CJgN3s194NSf4f8kbH7F3cTJubLtb3m2oshYrOk39HR5
         Odd+B28JgK89cuxNP04j3eN9Lphv02J6HsIPRiywAmtA3uibMHOaFZGNW8P7Usb78Wos
         QDxiKHP9Y9iH908c9LQCNaknf31jf+HtSoqH1i9yKZt+BAEa1/Wl/Sg1VOCiz3xTk+47
         3MAgrSSh7uaHFWvlC1WpcDxsohUjWwVdk1JORJIt/KcsY7jO0DsyLiHq9kSAJ5zxpOXz
         3iXsmSmryGUBD60rvLK7gYawuwj7QSsNGpj8UimlEqzoRpS/vT16jedmbzLEOHSTKiDL
         nDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7wU8ynKX5FUmd+2+4oUjmzoqRHtXoTNiPHkTcSlu/0M=;
        b=dwUUAZKgB6QyzVSmV0K4vKWmk4PMbW02wog1gngPOoKWdZc4sZKhyN1Z9fnp34lxkf
         fQr0Lbai3zJRBybeLzr0e3aBd5gVVHq4C0KnMjVzJstMnoROBN81zk2VUMcK6Rik2JyG
         kyHOrLUYUoNXA9psd6368fTKoq2eNN66U+mlgTMCNP6SDqN/YG+Dk3Wufq/3D2WX0Am1
         1k+olRhAmlevDIPuRPcROOQ08OxT8ma1jZykDgagP+C6c9fnCKG7gIL3o2qJi12C1yh1
         9hO5+XOggzCb1oUZU+4pEQnoYbc/0y/z+ewnDfyHyJ46Hf4Wxnjm4rQ+ZRnEmN4oVhiD
         h52g==
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
Subject: [PATCH 4.9 18/39] usb: dwc3: gadget: Set maxpacket size for ep0 IN
Date: Mon, 26 Feb 2018 21:20:39 +0100
Message-Id: <20180226201644.476471017@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495949068185016?=
X-GMAIL-MSGID: =?utf-8?q?1593496303201893931?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2528,6 +2528,8 @@ static void dwc3_gadget_conndone_interru
 		break;
 	}
 
+	dwc->eps[1]->endpoint.maxpacket = dwc->gadget.ep0->maxpacket;
+
 	/* Enable USB2 LPM Capability */
 
 	if ((dwc->revision > DWC3_REVISION_194A) &&
