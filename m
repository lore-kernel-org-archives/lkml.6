Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpo909+IQXF0M+E6BnmAjI5lF2wzw/1ORRI8SIio/rSNJEhYDWx0dPqknUIZVMy2w1YIkTN
ARC-Seal: i=1; a=rsa-sha256; t=1527155675; cv=none;
        d=google.com; s=arc-20160816;
        b=SdAAHFsKFKMKVW/YR0GJT7p2RxQl3Vxat8xG0FFxbtqOvs2wHteIBws4zFsNtYF3PC
         jS3x21HYmKgmfSubauq2u4/Fem7c5NXMaXDFGOkxPcoTd4oJEzmY0eRe/tbtFWvf9rI0
         k7xr7DdOupLBHGNzrhguno/kyLDYSIcSCvxgXw44HvdY2I+c+8B+RJionGxV9XDIFv+U
         LG1/zc2PVnFJwFCILuZyKSkCw2auxIXNl+IMkkrzoq1VmZ+YjFTwdjNF0LQic6wJ82Kt
         8TTJnRBBC5a+va0DNSBStM5Wnu5ksB7NUecW8bv9T6SCDO9NN7/r/EhlKlI357O6zsL8
         5gmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=TE0Ykb2IogWqoNG9WyWWcuOK6iXO3oft1CEvfkHhpjs=;
        b=o5ut0n8ieTIzPLPzid3PUZBYpdpDbiVu9fLNeskv/n4tC88LxmIGX/l28Q4bIUUECT
         odFAZxhVxyOErNgq1tWD0CA6m12UQRm58JPh5YwiH7dqgk1oYIBPBGTVnmQPobx2H2lw
         Jh9XYy+92AKLNAckW1/q53d+ywylD79iBRP3y7bmia4G/h06uwmAN25bwiVMrMly7hk8
         zi1XgDBvYjyjoiZIgjzWbr0anHUach7TZAtKMyz/xx1v+/1WO163aDO2rkhYLKhKtMys
         8cZ7EARqZcVwsfmXK8gemo3WtTAfcnWN7fZfZlrkc0SMSx3lfc8eUFHRR5wHTuR7qMh6
         DObg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XaN5jjpO;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XaN5jjpO;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	John Youn <johnyoun@synopsys.com>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Grigor Tovmasyan <tovmasya@synopsys.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 074/165] usb: dwc2: hcd: Fix host channel halt flow
Date: Thu, 24 May 2018 11:38:00 +0200
Message-Id: <20180524093625.012265731@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338788755014756?=
X-GMAIL-MSGID: =?utf-8?q?1601338788755014756?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minas Harutyunyan <hminas@synopsys.com>

[ Upstream commit a82c7abdf8fc3b09c4a0ed2eee6d43ecef2ccdb0 ]

According databook in Buffer and External DMA mode
non-split periodic channels can't be halted.

Acked-by: John Youn <johnyoun@synopsys.com>
Signed-off-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Grigor Tovmasyan <tovmasya@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/hcd.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -979,6 +979,24 @@ void dwc2_hc_halt(struct dwc2_hsotg *hso
 
 	if (dbg_hc(chan))
 		dev_vdbg(hsotg->dev, "%s()\n", __func__);
+
+	/*
+	 * In buffer DMA or external DMA mode channel can't be halted
+	 * for non-split periodic channels. At the end of the next
+	 * uframe/frame (in the worst case), the core generates a channel
+	 * halted and disables the channel automatically.
+	 */
+	if ((hsotg->params.g_dma && !hsotg->params.g_dma_desc) ||
+	    hsotg->hw_params.arch == GHWCFG2_EXT_DMA_ARCH) {
+		if (!chan->do_split &&
+		    (chan->ep_type == USB_ENDPOINT_XFER_ISOC ||
+		     chan->ep_type == USB_ENDPOINT_XFER_INT)) {
+			dev_err(hsotg->dev, "%s() Channel can't be halted\n",
+				__func__);
+			return;
+		}
+	}
+
 	if (halt_status == DWC2_HC_XFER_NO_HALT_STATUS)
 		dev_err(hsotg->dev, "!!! halt_status = %d !!!\n", halt_status);
 
