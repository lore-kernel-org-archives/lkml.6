Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48rHcAqlAgkogf34BGrOmYkKOy9Tk3Hco6gc1qpZe1SGG381IIqFyqLUWNgmBw9dtoc26PP
ARC-Seal: i=1; a=rsa-sha256; t=1522168586; cv=none;
        d=google.com; s=arc-20160816;
        b=uTSNSmDFsoKGOjioqlRm9QEdzCXdP1eeemrmdONVo6Nknsb/i2sg/AgYC+6gwbUVjc
         ZBmgXd/4afVSbPcvCoANUbyMIAZ8lbD57EDizo32cy1pxnPl0fv35pQDFJDcGyIYHLQ5
         QAT9sZ6tzhbC3qnaSToJKh69bUDRui7junx1cRzaaV37Tn8KndirLWbKytukLcDwfT1v
         Dptdd13aZrRYqoSO4ajYaMJHn9a51R89E2KTO1Ye3jeWSBsUJvJKvXaK1xkaRQcxj2aS
         QvHz6C80V9THkywyaJoFOxFCFG/rFX4mP2/J/DnVrTs9/XTyzsYfzHNn+OrbsP72PeB+
         fYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=67e5QBRxL1rdgJSeBQlD6OJKBuKPQUH9uUN0jSdSGPk=;
        b=pELvurk+d/Y2k0iG26OMSsubVXrvezwq7Jdy81o23gXQrGn8MShyJAekGPZs1IrTg8
         L1IutiaEsE2dfj4OInMIK6s68bFxMrSgBrj1ooRyZPgEGrWxP9E8ZQgFxokDajShK9+Z
         F1Nru2BEUuRNWKOW9rVes2AXohAskPekq3miBQwc6lh/hJDdNMfdWdQzf8ucE0BIclfS
         4nUuji87dKt/WvDkW3JVdyL3Ow4uYOHulj8s1neNFez1hWM7W32PzxOWP+7ypJEnD9rf
         MB0kCTm1HIiy0Fzco0kiXIFeM+U1s0sTqWRliR5vt/ANIWmPh8bSBFe7IvnbHyR22q9g
         Fq+A==
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
Subject: [PATCH 4.14 026/101] clk: bcm2835: Protect sections updating shared registers
Date: Tue, 27 Mar 2018 18:26:58 +0200
Message-Id: <20180327162751.593619068@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109038866512632?=
X-GMAIL-MSGID: =?utf-8?q?1596109447615798536?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -653,8 +653,10 @@ static int bcm2835_pll_on(struct clk_hw
 		     ~A2W_PLL_CTRL_PWRDN);
 
 	/* Take the PLL out of reset. */
+	spin_lock(&cprman->regs_lock);
 	cprman_write(cprman, data->cm_ctrl_reg,
 		     cprman_read(cprman, data->cm_ctrl_reg) & ~CM_PLL_ANARST);
+	spin_unlock(&cprman->regs_lock);
 
 	/* Wait for the PLL to lock. */
 	timeout = ktime_add_ns(ktime_get(), LOCK_TIMEOUT_NS);
@@ -731,9 +733,11 @@ static int bcm2835_pll_set_rate(struct c
 	}
 
 	/* Unmask the reference clock from the oscillator. */
+	spin_lock(&cprman->regs_lock);
 	cprman_write(cprman, A2W_XOSC_CTRL,
 		     cprman_read(cprman, A2W_XOSC_CTRL) |
 		     data->reference_enable_mask);
+	spin_unlock(&cprman->regs_lock);
 
 	if (do_ana_setup_first)
 		bcm2835_pll_write_ana(cprman, data->ana_reg_base, ana);
