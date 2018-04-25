Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+4o8OTfmC5e0i2kMHRdpFGiRMiXW2UxbmTZCalVO8mX2hL91juv3g9DrZD0b9LWACVUwky
ARC-Seal: i=1; a=rsa-sha256; t=1524653038; cv=none;
        d=google.com; s=arc-20160816;
        b=b8B0ie74G/ItV1IeCy6LJbWq1el/PiAdxEcK3raHtVSj4DgPwxTp1cn1DvaLSTiADJ
         YbDoEYQnSBwB1cvJVpli/nDg+5AHee94QmQsVE2nooAx6gx/9hQIwomV+hrUOmVEWwQh
         95y8wjt3WxDfbuYtxN1IhEHedJnB7l2WiOS2daUpDYPFWroQPMFUfMXViW6a7A6MFiiJ
         WiLJaFtF64/0MF5ObUb6sccxtU93wL/7jUWjznsINOkB1ywE0VwJKZUwFn/oQfpPh/PK
         h5w72BmviihxmNZTPcPS3nkxW2Cmu5E+lOlkGhhj5n8gr8PuxS696XtiKTkViSj49VVG
         BSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sd5j+4fuCe8W4xyCZKCbS4KUQWX//uCXGpzOjgNJ4xE=;
        b=OeutoPcE3CVD0xLKo1+jZ2uDFCq0mH8d47tbkIcKewNyD39b9vUTzuSATDiCObnoPv
         0+uuuxqnFNaXkbHlYplm34OaPIYNqlCJAHs2VXhvpI20XGVBH/JJi2jXtIs6VxI9/Yek
         OLuE+giFLm+VB6zxlUuvij/dQ7yc0WGoAYLefQvvg66WUl+7Nlwbwr4NJfphYPildT0X
         K3PcgtM2T4uHWGwfIYCcs88VYWc+HCNRHmq0ckf44Xoa1CAKHodMKt5LQllK+W+sZjEF
         RGtuMEn+1tHxSXcmK1t168acNCu7o7X7MLwpB7M9BAhvbkSKoc1GTVwPsljS9LRp/S6t
         OxiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 162/183] PM / wakeirq: Fix unbalanced IRQ enable for wakeirq
Date: Wed, 25 Apr 2018 12:36:22 +0200
Message-Id: <20180425103249.039715416@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714584976064007?=
X-GMAIL-MSGID: =?utf-8?q?1598714584976064007?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>


[ Upstream commit 69728051f5bf15efaf6edfbcfe1b5a49a2437918 ]

If a device is runtime PM suspended when we enter suspend and has
a dedicated wake IRQ, we can get the following warning:

WARNING: CPU: 0 PID: 108 at kernel/irq/manage.c:526 enable_irq+0x40/0x94
[  102.087860] Unbalanced enable for IRQ 147
...
(enable_irq) from [<c06117a8>] (dev_pm_arm_wake_irq+0x4c/0x60)
(dev_pm_arm_wake_irq) from [<c0618360>]
 (device_wakeup_arm_wake_irqs+0x58/0x9c)
(device_wakeup_arm_wake_irqs) from [<c0615948>]
(dpm_suspend_noirq+0x10/0x48)
(dpm_suspend_noirq) from [<c01ac7ac>]
(suspend_devices_and_enter+0x30c/0xf14)
(suspend_devices_and_enter) from [<c01adf20>]
(enter_state+0xad4/0xbd8)
(enter_state) from [<c01ad3ec>] (pm_suspend+0x38/0x98)
(pm_suspend) from [<c01ab3e8>] (state_store+0x68/0xc8)

This is because the dedicated wake IRQ for the device may have been
already enabled earlier by dev_pm_enable_wake_irq_check().  Fix the
issue by checking for runtime PM suspended status.

This issue can be easily reproduced by setting serial console log level
to zero, letting the serial console idle, and suspend the system from
an ssh terminal.  On resume, dmesg will have the warning above.

The reason why I have not run into this issue earlier has been that I
typically run my PM test cases from on a serial console instead over ssh.

Fixes: c84345597558 (PM / wakeirq: Enable dedicated wakeirq for suspend)
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/power/wakeirq.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -323,7 +323,8 @@ void dev_pm_arm_wake_irq(struct wake_irq
 		return;
 
 	if (device_may_wakeup(wirq->dev)) {
-		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
+		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
+		    !pm_runtime_status_suspended(wirq->dev))
 			enable_irq(wirq->irq);
 
 		enable_irq_wake(wirq->irq);
@@ -345,7 +346,8 @@ void dev_pm_disarm_wake_irq(struct wake_
 	if (device_may_wakeup(wirq->dev)) {
 		disable_irq_wake(wirq->irq);
 
-		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
+		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
+		    !pm_runtime_status_suspended(wirq->dev))
 			disable_irq_nosync(wirq->irq);
 	}
 }
