Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x224stheKRs3GKjDpZvBhwmEdTXkJ5a+uFDhiA7z7kbwzYfFvHzzNEA1PVBri0lF/VGPtFmI6
ARC-Seal: i=1; a=rsa-sha256; t=1519831347; cv=none;
        d=google.com; s=arc-20160816;
        b=p+qsdLXZzW6v/vsG1fECphDFQO3OYlRmLvX2EJgnECS7X14YPw3vapjPH61RWBgNUR
         0CJnSZMHBzwg5xK/66N331Y7cQskKAUpC2tfp7Mn+ok2EgnYhXlO7QPPL4zqC8TAa6Ob
         yS5yWRhVNyYeQDk+yhPBu+sUcjSAf/3okLke6L85IC1zte/2T/vx9ZEiSSSLRE/KWf2B
         pGdPFoJu2LoCwqnBXwVDooK73yW5sE1pExR4d+wqPdqxFfB/UkargrfTCzslKdw7taD9
         Qv8i2Q0njpWqvxQL27Onb1NnwRd0GueM4I2TRqvOe0V5g5kQ1COfd/MuqUYO8XHAQWgN
         aqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=o7xGbiYGzyS8HQaxfo3P7evG+W8BdH4l0ByUI/uk+zw=;
        b=QeQ03rJcwqrFSA5X1oC4mSdCjRwiWcbE/Au55tXRTxBgl7H+K3uL5fzZFYM+HNTGm9
         eQdl6Ptc0tanUX6sVCvTrqvoY/6TJ1a2E11y/wv7lGnCdydBxjX4UMvU6tuyRdIiT6b5
         h7cJq5nJxa0v5Vj5M3js5GNCS9bsF57pCqncZvWH/NJtrfzzOf+DRlog5wTCUK9MzKKD
         S+CFV0hi0pIQGh0BT4dxJ76gzE1JAkNVdm0Teu8sMMafLPnrXtBlNwkeShDLmb+guPXs
         F7R6ZszuQKZqU7yxyRCrtZVfVeTSMW/QkUjLrRmumJl3Swcl4KFmetj/c7yb6MAeDdMP
         pTMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Bin Liu" <b-liu@ti.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.674591392@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 077/254] usb: musb: da8xx: fix babble condition handling
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658674928298239?=
X-GMAIL-MSGID: =?utf-8?q?1593658674928298239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bin Liu <b-liu@ti.com>

commit bd3486ded7a0c313a6575343e6c2b21d14476645 upstream.

When babble condition happens, the musb controller might automatically
turns off VBUS. On DA8xx platform, the controller generates drvvbus
interrupt for turning off VBUS along with the babble interrupt.

In this case, we should handle the babble interrupt first and recover
from the babble condition.

This change ignores the drvvbus interrupt if babble interrupt is also
generated at the same time, so the babble recovery routine works
properly.

Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/musb/da8xx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -350,7 +350,15 @@ static irqreturn_t da8xx_musb_interrupt(
 			musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
 			portstate(musb->port1_status |= USB_PORT_STAT_POWER);
 			del_timer(&otg_workaround);
-		} else {
+		} else if (!(musb->int_usb & MUSB_INTR_BABBLE)) {
+			/*
+			 * When babble condition happens, drvvbus interrupt
+			 * is also generated. Ignore this drvvbus interrupt
+			 * and let babble interrupt handler recovers the
+			 * controller; otherwise, the host-mode flag is lost
+			 * due to the MUSB_DEV_MODE() call below and babble
+			 * recovery logic will not be called.
+			 */
 			musb->is_active = 0;
 			MUSB_DEV_MODE(musb);
 			otg->default_a = 0;
