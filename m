Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo652wnINinzvjQiz1cPtSlU25dnkpFcAIw02G+t+faZdQylG+RId6KJO+Rjzz8leiiF2JT
ARC-Seal: i=1; a=rsa-sha256; t=1524837790; cv=none;
        d=google.com; s=arc-20160816;
        b=yDB95MfAIDJ9d/4mTqiWno3/uSujuNz76X2YVwacU8x+htiyVDip3RWRTSWrDdvHWl
         RDWQHSLDZUy2O9k+jEp0duEMze4J19FZoZ3ONPLPyirHn5TPq3WzORJ4IOxuqkFvdZaO
         AIt9BTBy+JR8qFrKyBPQAnZ1hkuu+O9eEAJMKdfhNFi8K22aromZ6iuV42o01XI59D3A
         K6NCyFjIqdFIqupSDCO+YSb79+EBJmtjRgj8wyJWvSqPagjjMCwRotYLgqI3L4rMVed5
         SdKb9hdgtVY5DzE3AQstPiU/oEoQvN+8Pa0KTNlDIQ2aZjkX9EWpFtJAyAFo5EHoNZXj
         G56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=uCINWFRzQSNWm+pvQVYs6LBbwuullYXeu0rlp1kVvoQ=;
        b=JaxBQbp2ceJBO03eTbVokJGut8oAp4kbW97XM3OmTo0SEALssrVDzmZYaQTS3t6Vr+
         BCApabEwGiOI1HV1GDwTYf0eq306adq/RFYgybvPni2j3OrejI5YjXlrLBQp+Ov5WqUo
         NlwghfMC9by6OVn7a0Rm1UhyaPUVZJ7PuSNDPIGtQCusS/CwsJFwBI1U/QYj0HX643Ut
         A7dh2njfLEZp90ShAXrC7bDKeGuWVKXLdFqUyjPm4NyW8Vm+Qn0FgpfGxLGus9sjom+i
         lTUx17nO6PV2mIPiVOHmya+goRHsHXdlmSZdNtLRecSgblHJ5Dtb2D5Xq5NQwv/ewj4h
         Wv8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101FE218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andreas Kemnade <andreas@kemnade.info>,
	Tony Lindgren <tony@atomide.com>,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.9 08/74] usb: musb: fix enumeration after resume
Date: Fri, 27 Apr 2018 15:57:58 +0200
Message-Id: <20180427135710.242461260@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908311697008283?=
X-GMAIL-MSGID: =?utf-8?q?1598908311697008283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Kemnade <andreas@kemnade.info>

commit 17539f2f4f0b7fa906b508765c8ada07a1e45f52 upstream.

On dm3730 there are enumeration problems after resume.
Investigation led to the cause that the MUSB_POWER_SOFTCONN
bit is not set. If it was set before suspend (because it
was enabled via musb_pullup()), it is set in
musb_restore_context() so the pullup is enabled. But then
musb_start() is called which overwrites MUSB_POWER and
therefore disables MUSB_POWER_SOFTCONN, so no pullup is
enabled and the device is not enumerated.

So let's do a subset of what musb_start() does
in the same way as musb_suspend() does it. Platform-specific
stuff it still called as there might be some phy-related stuff
which needs to be enabled.
Also interrupts are enabled, as it was the original idea
of calling musb_start() in musb_resume() according to
Commit 6fc6f4b87cb3 ("usb: musb: Disable interrupts on suspend,
enable them on resume")

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2710,7 +2710,8 @@ static int musb_resume(struct device *de
 	if ((devctl & mask) != (musb->context.devctl & mask))
 		musb->port1_status = 0;
 
-	musb_start(musb);
+	musb_enable_interrupts(musb);
+	musb_platform_enable(musb);
 
 	spin_lock_irqsave(&musb->lock, flags);
 	error = musb_run_resume_work(musb);
