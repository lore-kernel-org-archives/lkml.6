Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49hTzD/EmBnLwbJCa0QlzHOmER6DbqvjX8pv+HLhktXNBfO0M09eeqFIMzuhfdi74BahVZs
ARC-Seal: i=1; a=rsa-sha256; t=1523022026; cv=none;
        d=google.com; s=arc-20160816;
        b=e1E2gVB/gNxideFwWg5VbB90MqR/6BrdD/Z2LoTtAtpBaanxbyblN7lfdtXbbp4uDV
         dsUKS0ulIP0+B/sT7B+hXep2M9vn0dME+TfFq7bBAxWqy4He8QBeLGuMWNEdBbfeyqaA
         6Eh969vtiZHJbynVQH61IRvbHpNdUi6vd6UUr8lhyNwBzef/CH21Wsmn5tl0VrEyB3dS
         2FFdZadrwUZ3kwl//UxVp5GmlXREZrQG1OlJSFFg5zfyzLmanR/HuHTQ79zAtuJAXfiQ
         0P1J2oaWqZVzM9su0qrsAkvcIZwvWn+F8Y0GXYvE8bhHSINippsH+57TRpuw0RsY5akX
         Qx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OosutoFPDTgB65kXxAgXT2dwNIg744EsHOEZjz4/H6o=;
        b=c+hGnaxAofVg6G+TJTOKVOjqmGUa+Do+mr/UGVB0bfsUHQlNnnKbvOS5pANUDmgm7I
         An2SVh6pMx9DwqjwOZeo5PawVBHlPMqViG0qwywvnxD8/eiGQ3ZFr2EbkZcSr4s1qMsw
         OcHarlNRmxsnJ3vo5YRHYTUIKj0Qi/bJ3+MLMWc5Q7R8swDhdJDh0qfoT9D0/TeDKGOy
         0zkv7twdkwlTeQybWPtyTK/dwSXQjqFLKElBFhFTMfBdiHU2e3j6OFMuVDtHNGAKd8Wt
         j64wIaCa5m74EDN4Rp7UPz24NYuRAf9/ugfPigxPNnjm7MWDRWgUQa/PuzGQchVzG8gw
         ngig==
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
Subject: [PATCH 4.14 36/67] usb: dwc2: Improve gadget state disconnection handling
Date: Fri,  6 Apr 2018 15:24:06 +0200
Message-Id: <20180406084346.173607297@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003755017723426?=
X-GMAIL-MSGID: =?utf-8?q?1597004344458391246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3277,7 +3277,6 @@ static void dwc2_conn_id_status_change(s
 		dwc2_core_init(hsotg, false);
 		dwc2_enable_global_interrupts(hsotg);
 		spin_lock_irqsave(&hsotg->lock, flags);
-		dwc2_hsotg_disconnect(hsotg);
 		dwc2_hsotg_core_init_disconnected(hsotg, false);
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 		dwc2_hsotg_core_connect(hsotg);
@@ -3296,8 +3295,12 @@ host:
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
