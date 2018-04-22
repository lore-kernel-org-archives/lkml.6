Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48lFYkUG0NAmCHWI7zo58KeWntxEjNK9cBH+DQXjSglCQJw8flLywFXBDTnBJvWWrzIydhC
ARC-Seal: i=1; a=rsa-sha256; t=1524406395; cv=none;
        d=google.com; s=arc-20160816;
        b=Ov3crQ4m+HZGGbwpzs2rB0hvwSejxjsDbFsMepT5A0ksEu4b+wC7O9i2NbeKB0UCAS
         /ThBzlkxhVGZW3oEHEiT8mwDMfmhf9tjeYvuxB8CL8G17LGrraFtqekPRFWejGfb1tmC
         NoDR1sbNkL6NZahnNjn1x+nLU1b2fFr3i4MzF6ZNtElIbSD7KMZrP7h0Wck5gbEmssWH
         +10SKap8at36MI7mRIZojpBTpUS0B9ORDQuQD5ZL4RKoaFhYDnpb1ZfUGHr5sYC9OdTu
         M1ZqDl1qoizVPBb5EjKOmIspb2OY5uoMEl38t3bJ6iMsMtKqosXamQehrarRT7frcX9R
         YPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8mk9VWPCQgEgWfwpnN6e1EQVtckD0NqFI2U4ToBlHxo=;
        b=THD5YgSeDIVGE23oUEGaGAkSCufReRWD2SrEHdQvItqU/zpDE4Fi6kNKHNG0GHbd9l
         vtBIXc7KOiLV974nqivQ5ioP+JEQZyS78qeyCiLpH2xttWPMld/Q/Sq124iUtRsWcJ8x
         duAfOq61mUqdtKsreoRDi9YitKzETbxnhFNmo+i1jGp0JzuWF6QTpSE7SHAg3n5kgEIp
         Q8Xf/5XmrfaIKZLKI+yxVCT5CBVGyQ9gykevY+5i3I/Xf82wnl1Qzmer1xIFSBQ7aQ2f
         Qsg8yFr3VMGT/JBxAYh3bWGtu50P5d5OXk8rBcRSV6sFU2Kg3pW6pKUKmpZvYZUQLbAZ
         RQ9Q==
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
Subject: [PATCH 4.9 54/95] clk: bcm2835: De-assert/assert PLL reset signal when appropriate
Date: Sun, 22 Apr 2018 15:53:23 +0200
Message-Id: <20180422135212.631400939@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455174202804728?=
X-GMAIL-MSGID: =?utf-8?q?1598455960049138446?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -545,9 +545,7 @@ static void bcm2835_pll_off(struct clk_h
 	const struct bcm2835_pll_data *data = pll->data;
 
 	spin_lock(&cprman->regs_lock);
-	cprman_write(cprman, data->cm_ctrl_reg,
-		     cprman_read(cprman, data->cm_ctrl_reg) |
-		     CM_PLL_ANARST);
+	cprman_write(cprman, data->cm_ctrl_reg, CM_PLL_ANARST);
 	cprman_write(cprman, data->a2w_ctrl_reg,
 		     cprman_read(cprman, data->a2w_ctrl_reg) |
 		     A2W_PLL_CTRL_PWRDN);
@@ -583,6 +581,10 @@ static int bcm2835_pll_on(struct clk_hw
 		cpu_relax();
 	}
 
+	cprman_write(cprman, data->a2w_ctrl_reg,
+		     cprman_read(cprman, data->a2w_ctrl_reg) |
+		     A2W_PLL_CTRL_PRST_DISABLE);
+
 	return 0;
 }
 
