Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/fUWaGxXMCSTJ7ubyh0ILoiwBYiyyHsQjfrpKlsTMMRX33kszzx6DeP074KS9icgrnKMWC
ARC-Seal: i=1; a=rsa-sha256; t=1523021671; cv=none;
        d=google.com; s=arc-20160816;
        b=oXR1ElVpJCm2EktmFavqlMiV8oeAohMlux2a+mxwCtmW0/jCK89DFAuntPKwl9wcuK
         rp4kZLaewKpwVgu3g1O3Pw0KpaYUSuvK4xQ1++5ebPYgEf5e17F/VGdzlpUrmVTjaGOE
         Pac2EjgMVkb9ObIuc5g4GAWzafDnsIRiQ4x98J6lCY28lMMsCh0umvmVNyg7ZfyeuXqX
         mnfiaE6/I/yfn3ugGPe4/tA+3698RUYy8GmpW/Y+rqETgodfeCtfQJYm72756q1b9g28
         ltdK1UAZzx7y5BngtQwNLyB1QBO9yBdAOcPGYZmsHbTnRoBdDIqa9KF5UCOy6R1dHFxA
         DePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9AsfY96c0g0A50GPFl01UJNW5I29rd4dNj0pTU5GUB8=;
        b=JxejxcEuXc1xkMtyUEiNqMUQCvwNLLWSuqgdtb7JABcreQqBWO5hNBRL9N0Bfk5T0a
         GjnoL6nAi5Evl44fUKh9jWSpHJdPSVJrfrXS+l2coZ9jEPkpRE3u1pFiys9xSz7vTKzu
         4rpsqPbFyffCF3lPcR8bwhg3cnG3PGw5S9cVyuDKQOJtaweJdi/WKvBjGcEUsOSYFR4m
         Vlwz/1oUY75E1ujRU4mLnZ2kDiI6L9CCcQ/ZfJ7RsXMQoPdOcXgu0ZiVjv65KQrVYG3f
         69jozmhrZh+X+XXZGXEplU7ItGrdpbgKszcWSy+Jl9nA3t5WByosP+VaBtT46tZ3NEhz
         uWzA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wei Xu <xuwei5@hisilicon.com>,
	Guodong Xu <guodong.xu@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	YongQin Liu <yongqin.liu@linaro.org>,
	John Youn <johnyoun@synopsys.com>,
	Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
	Douglas Anderson <dianders@chromium.org>,
	Chen Yu <chenyu56@huawei.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org,
	Minas Harutyunyan <hminas@synopsys.com>,
	John Stultz <john.stultz@linaro.org>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 049/102] usb: dwc2: Improve gadget state disconnection handling
Date: Fri,  6 Apr 2018 15:23:30 +0200
Message-Id: <20180406084338.535787470@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003755017723426?=
X-GMAIL-MSGID: =?utf-8?q?1597003971969013091?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Stultz <john.stultz@linaro.org>

commit d2471d4a24dfbff5e463d382e2c6fec7d7e25a09 upstream.

In the earlier commit dad3f793f20f ("usb: dwc2: Make sure we
disconnect the gadget state"), I was trying to fix up the
fact that we somehow weren't disconnecting the gadget state,
so that when the OTG port was plugged in the second time we
would get warnings about the state tracking being wrong.

(This seems to be due to a quirk of the HiKey board where
we do not ever get any otg interrupts, particularly the session
end detected signal. Instead we only see status change
interrupt.)

The fix there was somewhat simple, as it just made sure to
call dwc2_hsotg_disconnect() before we connected things up
in OTG mode, ensuring the state handling didn't throw errors.

But in looking at a different issue I was seeing with UDC
state handling, I realized that it would be much better
to call dwc2_hsotg_disconnect when we get the state change
signal moving to host mode.

Thus, this patch removes the earlier disconnect call I added
and moves it (and the needed locking) to the host mode
transition.

Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: YongQin Liu <yongqin.liu@linaro.org>
Cc: John Youn <johnyoun@synopsys.com>
Cc: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Chen Yu <chenyu56@huawei.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Tested-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc2/hcd.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3220,7 +3220,6 @@ static void dwc2_conn_id_status_change(s
 		dwc2_core_init(hsotg, false);
 		dwc2_enable_global_interrupts(hsotg);
 		spin_lock_irqsave(&hsotg->lock, flags);
-		dwc2_hsotg_disconnect(hsotg);
 		dwc2_hsotg_core_init_disconnected(hsotg, false);
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 		dwc2_hsotg_core_connect(hsotg);
@@ -3238,8 +3237,12 @@ static void dwc2_conn_id_status_change(s
 		if (count > 250)
 			dev_err(hsotg->dev,
 				"Connection id status change timed out\n");
-		hsotg->op_state = OTG_STATE_A_HOST;
 
+		spin_lock_irqsave(&hsotg->lock, flags);
+		dwc2_hsotg_disconnect(hsotg);
+		spin_unlock_irqrestore(&hsotg->lock, flags);
+
+		hsotg->op_state = OTG_STATE_A_HOST;
 		/* Initialize the Core for Host mode */
 		dwc2_core_init(hsotg, false);
 		dwc2_enable_global_interrupts(hsotg);
