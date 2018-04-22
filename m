Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/zX6X5Y777u2NfpWiHPOVfzIehGVvI2fDO8pprxN0gxAqIVS8YPwBuVC22NyuctgeoTt4k
ARC-Seal: i=1; a=rsa-sha256; t=1524406678; cv=none;
        d=google.com; s=arc-20160816;
        b=wi/vMo/hV7uwYxzzDM0fxcsYkyE3+v9quYGSFLM6qCndWPjSVKKZ/BMVFAOEAS0SRo
         asIkIE2WiEdg87jK4Z+eHa+5//9rosnikA49wNmVsNQD0l1U6z58Kqe21BhgtoaGypHp
         BUptMVEA36UGlWTW1ZDK0XuFB6DJcj9oONctk1l80gjpCfMnM9sWRbsIEdHXw5yEdYhq
         QUiq4Mr3AEuJ4joNIHOKT0nW49S0/U7xNLhlnPm7hCuBq2xwHzv5/CVOj7XDIRILwrXO
         f6lsqZAKvXYTr6BOJNvqf8I7WLugLiWSckR+oaznrHG+TXa6k348RAXLPC0CaOqOTs+c
         TK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=byi2qTHqPQaJtFYgMhkaQPCXJHTVYzlcUlRV/pzRHN4=;
        b=G1dT1vXbYjA0jsf78iC/1F6nMEzoBAVi7GK0B+RbrGtHyRYhT5MRxeK3HAv/tqoQE5
         V6VHum7QFeTer5/4hg3nd1XRSsMbzqrYRsZjPH0gtmsskB+f36IimcdHl+gLEq6f8NGk
         Cs0Eye3Oy5aVX3PgfZR2PRtYLqcoDfr1xD/1pHQ/+r+OT+cuWivCYliVzpTinlVQJ5h8
         zfDVYy9MDsl2OhYugUWH6m61Ys9mETEGHR0l50AHXbrUaDsc34wAoj0hHfVvXwxCLf4k
         L8nGPuwnziU13AeCVJOe23CkCaSEtVC3EyjN26NoE9BnIsJXqXtGJS8q/oGxm4zu5PPq
         td/Q==
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
Subject: [PATCH 4.4 62/97] clk: bcm2835: De-assert/assert PLL reset signal when appropriate
Date: Sun, 22 Apr 2018 15:53:40 +0200
Message-Id: <20180422135308.689207280@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455174202804728?=
X-GMAIL-MSGID: =?utf-8?q?1598456257586277402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 753872373b599384ac7df809aa61ea12d1c4d5d1 upstream.

In order to enable a PLL, not only the PLL has to be powered up and
locked, but you also have to de-assert the reset signal. The last part
was missing. Add it so PLLs that were not enabled by the FW/bootloader
can be enabled from Linux.

Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/bcm/clk-bcm2835.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -891,9 +891,7 @@ static void bcm2835_pll_off(struct clk_h
 	const struct bcm2835_pll_data *data = pll->data;
 
 	spin_lock(&cprman->regs_lock);
-	cprman_write(cprman, data->cm_ctrl_reg,
-		     cprman_read(cprman, data->cm_ctrl_reg) |
-		     CM_PLL_ANARST);
+	cprman_write(cprman, data->cm_ctrl_reg, CM_PLL_ANARST);
 	cprman_write(cprman, data->a2w_ctrl_reg,
 		     cprman_read(cprman, data->a2w_ctrl_reg) |
 		     A2W_PLL_CTRL_PWRDN);
@@ -929,6 +927,10 @@ static int bcm2835_pll_on(struct clk_hw
 		cpu_relax();
 	}
 
+	cprman_write(cprman, data->a2w_ctrl_reg,
+		     cprman_read(cprman, data->a2w_ctrl_reg) |
+		     A2W_PLL_CTRL_PRST_DISABLE);
+
 	return 0;
 }
 
