Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49LGaUOdhLEaompD8zITN/ticJ0KyhP9ZrexN5RTKpxnAYEGndyLd053iI8XXmbFE4UoTGh
ARC-Seal: i=1; a=rsa-sha256; t=1522168772; cv=none;
        d=google.com; s=arc-20160816;
        b=0UkNiNNxQ/kRYAPW9x/eSZiMqBQNEir7AhnklxnH0G1klIaPA1ryzUsCI+VItZZxWf
         WfGir4bmpEwNQYIJYh4/dRCYD2OeJ6nMFmxQ0QxeJtNIfMYdwvuePFuDO8mh/cwQeHlp
         dfQzpUw0RAjA8av5uvWH6QU+q5ZJeSBD1PKDl7b7Bl31SLRiqnQC2c9misr2uaUu/Cc0
         fgdSfujjTK/jmYSChCbkVuvcBbxbtLudDDCh1mtAXvFNiPCPG8AHm0V010j8UFdTvWWk
         EVdJ0wfkzw9QrvG6/DiV10GfAnlzBOomxjx+/ju4FQUooQ70EwYsfBLkdCGJTfOxrq3z
         MJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nKVNQU6a0E2XAHYQUqt9LbsAn+VgGWBYRGJiHHJXHjo=;
        b=XuWkn5NpG/4UkC48YKn/HFfug7h9t9hZJn7GNYVmZy1TYSCjEbxQRsug9ylCAE7xAJ
         OHRHrr4YLg0dVzNRjTCjtNILgJzvuCcwWKK9GvFtwKS9geKD1tqihurzNqWsUxbOehZf
         cNR8ngJSi2qfyq27trz+wI7nahkPNeGbi4Ziss6n94BNk96p0FMSwgIfuztQ21N59WTa
         2tCl7Tbcnvu8aAXGE6p5J/vxjN1Z9FqNK6wkreUsYM29B5qub/hx7VBe2WlyG5qWbt5s
         qG77MAuLnOAaI8rH86L8KdUp4U9tfP0bVKMCNJrhBZG2YUToDrtZpgtIRMCITAO7voU2
         U9Cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Eric Anholt <eric@anholt.net>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.15 026/105] clk: bcm2835: Protect sections updating shared registers
Date: Tue, 27 Mar 2018 18:27:06 +0200
Message-Id: <20180327162758.996892482@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109038866512632?=
X-GMAIL-MSGID: =?utf-8?q?1596109643156778552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 7997f3b2df751aab0b8e60149b226a32966c41ac upstream.

CM_PLLx and A2W_XOSC_CTRL registers are accessed by different clock
handlers and must be accessed with ->regs_lock held.
Update the sections where this protection is missing.

Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/bcm/clk-bcm2835.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -623,8 +623,10 @@ static int bcm2835_pll_on(struct clk_hw
 		     ~A2W_PLL_CTRL_PWRDN);
 
 	/* Take the PLL out of reset. */
+	spin_lock(&cprman->regs_lock);
 	cprman_write(cprman, data->cm_ctrl_reg,
 		     cprman_read(cprman, data->cm_ctrl_reg) & ~CM_PLL_ANARST);
+	spin_unlock(&cprman->regs_lock);
 
 	/* Wait for the PLL to lock. */
 	timeout = ktime_add_ns(ktime_get(), LOCK_TIMEOUT_NS);
@@ -701,9 +703,11 @@ static int bcm2835_pll_set_rate(struct c
 	}
 
 	/* Unmask the reference clock from the oscillator. */
+	spin_lock(&cprman->regs_lock);
 	cprman_write(cprman, A2W_XOSC_CTRL,
 		     cprman_read(cprman, A2W_XOSC_CTRL) |
 		     data->reference_enable_mask);
+	spin_unlock(&cprman->regs_lock);
 
 	if (do_ana_setup_first)
 		bcm2835_pll_write_ana(cprman, data->ana_reg_base, ana);
