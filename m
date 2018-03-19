Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtyuI0GTqs6+XfFAWuEu7jReuRIibo+aHdPLn5gPV+AviQ3tQJCLsuNx2BMUYogjJoq1d2v
ARC-Seal: i=1; a=rsa-sha256; t=1521483290; cv=none;
        d=google.com; s=arc-20160816;
        b=lI3V1djplpFUFqtx8YpVmkI9yePE+PxWUv+07DdZLc9Qy6EFSHvkonb/H7Qypt+WKk
         8lXk8MgiHPc219vZDbUvdiDlFRmFSgRm/pEcoLv3I9XInMyFV8IxUupPrbWpQF6x37Lm
         SGTvV6OAjuPEjICtuU4b/vFPOSb1mtk7WB1VpWtGPgrSsyji9kd2jGSQf+wAQkt4gvru
         cVJK+JkNEqOtSCx/6MyOHKOCyoXz8ZmGAHTFeT9vBvxqooopFi3ju3hECOdD0g+dWzKG
         tV7vkT5mI6p3cCyctvZ+rJA1af1GwP6mFtRSUetZJyH33uZunh5XkyNTK0JHrmtk1x8d
         KONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E6LqrSz3GwkxeRnNfzET8RnXqx2wqBO0xbeFNw9Y9GI=;
        b=ByGsXbscdhgeSJyO31q/LEObSdJIoUuoTjc4KBUxwuARUXx8aVaqeidChn+JZiBYyJ
         9Cq3M9/KfOPoX72e9SSwPZUra64iDWVoQBBrn0VYz8Lm9x2SjJm/xrvzZmpOqdGXeouz
         hatHpDh7elB8rB3JMxb5wnx4Tnyt4L89w3dozj8Ed1bQM+Zbn68F0oEYtyMpwoCP+1Ru
         hqzYH7lkuXntdVoFCmMVTLHMhQOhGm62ADObqdtAn1itBrmkQGHOgln+qkF5Y3/sNBGC
         aQyNgwmfUUKzRUN46AviwHrbLPtdn77AjbrSJiSonQX2DEwqMU+ztg+LZRLY9qc5DY+t
         AFyw==
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
	Rob Herring <robh+dt@kernel.org>,
	John Youn <johnyoun@synopsys.com>,
	Douglas Anderson <dianders@chromium.org>,
	Chen Yu <chenyu56@huawei.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org,
	John Stultz <john.stultz@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 068/134] usb: dwc2: Make sure we disconnect the gadget state
Date: Mon, 19 Mar 2018 19:05:51 +0100
Message-Id: <20180319171859.057406471@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390862547164468?=
X-GMAIL-MSGID: =?utf-8?q?1595390862547164468?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Stultz <john.stultz@linaro.org>


[ Upstream commit dad3f793f20fbb5c0c342f0f5a0bdf69a4d76089 ]

I had seen some odd behavior with HiKey's usb-gadget interface
that I finally seemed to have chased down. Basically every other
time I plugged in the OTG port, the gadget interface would
properly initialize. The other times, I'd get a big WARN_ON
in dwc2_hsotg_init_fifo() about the fifo_map not being clear.

Ends up if we don't disconnect the gadget state, the fifo-map
doesn't get cleared properly, which causes WARN_ON messages and
also results in the device not properly being setup as a gadget
every other time the OTG port is connected.

So this patch adds a call to dwc2_hsotg_disconnect() in the
reset path so the state is properly cleared.

With it, the gadget interface initializes properly on every
plug in.

Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: John Youn <johnyoun@synopsys.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Chen Yu <chenyu56@huawei.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Acked-by: John Youn <johnyoun@synopsys.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/hcd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -1385,6 +1385,7 @@ static void dwc2_conn_id_status_change(s
 		dwc2_core_init(hsotg, false, -1);
 		dwc2_enable_global_interrupts(hsotg);
 		spin_lock_irqsave(&hsotg->lock, flags);
+		dwc2_hsotg_disconnect(hsotg);
 		dwc2_hsotg_core_init_disconnected(hsotg, false);
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 		dwc2_hsotg_core_connect(hsotg);
