Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoMXYH1NzEOhLVFtn5x70wRw+NV3TaDudCZGtAfU/6yr88iVPqc5pw6UTX0TGHc+dbf+lHA
ARC-Seal: i=1; a=rsa-sha256; t=1527155677; cv=none;
        d=google.com; s=arc-20160816;
        b=xAzMcl0ocn/QwjvpquA0n1h5n90RQFnaFqkS2ND+QPJgmXpBKSAIf6rPsIvqlXfDAN
         X/1rfof+bd81zJwLFniGlS8adp85nFMKlivjaULN1TtoBD+4t21QELEVKJmTvMMtEzZD
         sc+kp8eqnLH5waq8ScrDvG988fPizOGzSMVeipD8d5U6tw6bEf63NAkSMRfmfarIu1hH
         sTsQxrvM4ZEPxWArIdyJOnBUXgLUdNtGIYfRJkLASYO08gCKiMQwZGel9P02GozjzrQU
         UOURlqInzmeY5mnrPqCTOeg7GtnIMJNoFrkrF2ucXnhsI6KSuvCp0sgLfSKeyjX/mIY/
         inIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=AfiO4GzDqXJHXQS9sB5pv5H2IHOlCG52FAA5lTpBj0E=;
        b=APDjeIU5sZOeAXETAVosVfE/k04QsiCsH9tPXqn0Pd0UDIeXIj/uHrW4VGocS2ckF0
         au3zS+GdK/9rKAOcyNZvkBVklKt5ioWZ0I8FJprsvcRHwbQakgtLTaJELmaq/PfLJTvN
         5nagWHhiFkSZoUCWeWIX5b0bic6QNJNW2cZe2oZf4SjPxioeHO0zef2yTKeQHuLbCk1/
         OBes3J3wtfHj8v3+h4ieYG5Bz4ybB5BYGFAMnTYyukOngRDnYJhD6hA5ehqXBpbMulrZ
         CUnwBP/IJahUG5AReuPRJI4zWzpu10qErEvsmai5O1W/4OWxZz+/lucU1zPVxpGgnyNx
         GUBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tvRfD40U;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tvRfD40U;
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
Subject: [PATCH 4.14 075/165] usb: dwc2: host: Fix transaction errors in host mode
Date: Thu, 24 May 2018 11:38:01 +0200
Message-Id: <20180524093625.057778686@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338406021883806?=
X-GMAIL-MSGID: =?utf-8?q?1601338791910483424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minas Harutyunyan <hminas@synopsys.com>

[ Upstream commit 92a8dd26464e1f21f1d869ec53717bd2c1200d63 ]

Added missing GUSBCFG programming in host mode, which fixes
transaction errors issue on HiKey and Altera Cyclone V boards.

These field even if was programmed in device mode (in function
dwc2_hsotg_core_init_disconnected()) will be resetting to POR values
after core soft reset applied.
So, each time when switching to host mode required to set this field
to correct value.

Acked-by: John Youn <johnyoun@synopsys.com>
Signed-off-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Grigor Tovmasyan <tovmasya@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/hcd.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -2329,10 +2329,22 @@ static int dwc2_core_init(struct dwc2_hs
  */
 static void dwc2_core_host_init(struct dwc2_hsotg *hsotg)
 {
-	u32 hcfg, hfir, otgctl;
+	u32 hcfg, hfir, otgctl, usbcfg;
 
 	dev_dbg(hsotg->dev, "%s(%p)\n", __func__, hsotg);
 
+	/* Set HS/FS Timeout Calibration to 7 (max available value).
+	 * The number of PHY clocks that the application programs in
+	 * this field is added to the high/full speed interpacket timeout
+	 * duration in the core to account for any additional delays
+	 * introduced by the PHY. This can be required, because the delay
+	 * introduced by the PHY in generating the linestate condition
+	 * can vary from one PHY to another.
+	 */
+	usbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+	usbcfg |= GUSBCFG_TOUTCAL(7);
+	dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
+
 	/* Restart the Phy Clock */
 	dwc2_writel(0, hsotg->regs + PCGCTL);
 
