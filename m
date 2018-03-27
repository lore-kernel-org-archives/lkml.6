Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/a3oGUjtIhx79RbQpCVY1ZTQeeyeru5fZxhyECMjlM4FRrAT/kJXxwVdjZzS7+TuPgmW8k
ARC-Seal: i=1; a=rsa-sha256; t=1522168247; cv=none;
        d=google.com; s=arc-20160816;
        b=vULfuWo4fU58fC30xw2FcQsYv6eUcqlww9408d9v3Yw+pYLgfMvIih80tzwiQhCTij
         KSHhruizb+Le/gfbv9zpMRUYstU4i+vJmMYtPw25Mt8p44neQWSXeYyEWb5PA6m82Q+w
         GV8NBOc95B5+Ou1w+GQkTowgCtwu65IFWGuCj82MSWwPxH7unDok5WV+Cbt/vZtznSNI
         L+1+RSKCd+ft1BQ1hqBPELE//NR4nhkQYzI0I2J6tUtkeS3AcCQhSLuI77UPSoe6Cj8t
         bM6/V9aISzLq4CPw0Z+7cSjU3T4UboMrt7+qEg7PCzUbe4P+z05iwWvw/5dV5w+k7cqy
         M7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tknT5t6PiLR8Rr/sHO2gxgfbumwh9Yv238OeoK8usK4=;
        b=CTECpSEAZg5fr4cYmcRAoPCwnK88Hf163nV89Xe6HZjRBv4ken+ye8sAMSrZgYhbBv
         o6ceySsI+jE2koyXJilJ0XvG8rz18zSUt5u9wcIm1D+FqlPa/Gxlo8sM0dr4iJMPXlNT
         0Nraecw/ZPFCbuHJFZ6+usxMSmNCFpurOoWXCbyHWz09nigeECgyHfBDSQVUjes1ezd9
         jHkLz5e/XguSWdoWwFU1NFgp9rMsIeRSnVozSyghnw2BLSZCUCkD3DFh5FAi7ZZRZiZT
         1D/bdT6kH82D98x4IU4XFjXkdNk5xbWmTtKYRdeFf8S98Szdsr5M/IY1fGhZodt8thD2
         XvuQ==
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
Subject: [PATCH 4.9 11/67] clk: bcm2835: Protect sections updating shared registers
Date: Tue, 27 Mar 2018 18:27:03 +0200
Message-Id: <20180327162727.316212345@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109038866512632?=
X-GMAIL-MSGID: =?utf-8?q?1596109092434243988?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -566,8 +566,10 @@ static int bcm2835_pll_on(struct clk_hw
 		     ~A2W_PLL_CTRL_PWRDN);
 
 	/* Take the PLL out of reset. */
+	spin_lock(&cprman->regs_lock);
 	cprman_write(cprman, data->cm_ctrl_reg,
 		     cprman_read(cprman, data->cm_ctrl_reg) & ~CM_PLL_ANARST);
+	spin_unlock(&cprman->regs_lock);
 
 	/* Wait for the PLL to lock. */
 	timeout = ktime_add_ns(ktime_get(), LOCK_TIMEOUT_NS);
@@ -644,9 +646,11 @@ static int bcm2835_pll_set_rate(struct c
 	}
 
 	/* Unmask the reference clock from the oscillator. */
+	spin_lock(&cprman->regs_lock);
 	cprman_write(cprman, A2W_XOSC_CTRL,
 		     cprman_read(cprman, A2W_XOSC_CTRL) |
 		     data->reference_enable_mask);
+	spin_unlock(&cprman->regs_lock);
 
 	if (do_ana_setup_first)
 		bcm2835_pll_write_ana(cprman, data->ana_reg_base, ana);
