Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ZOfXx4TTGMptwiX1nxVGvRr+GpOwByIRseVT5hnG+sCSRQnIOtAgXgRZ7NG4KBhpFokq7
ARC-Seal: i=1; a=rsa-sha256; t=1524405645; cv=none;
        d=google.com; s=arc-20160816;
        b=WHEbI36LqaWMB3+sYN7Vw95VSSOBDbcv20GZxdPctAKShyvnr3E3wWDYPMFwmy8LyZ
         70vNiFhpGaQK1d5zr9Jx12S+bYGOqWS7wzWSSddbEJRAyYVwi13yrseMXGKbIW4a5FUA
         CBO/qXjJ8m5/QJcBnoNP+b++S6MnG1nI303vvwPJEJAWA9BxZWwWivgFdeAE3MtwpUl5
         Hfv1s4sZRz8yGuKI7SgB9gOZ7zPbyb74PXFSIW8fXo78EpItYmb8WsmAGebNnEhLi3i3
         +U06ZBsXu8iKSAe8LKPAl9hOl7lZdgB2MxD1D4d9Cwvc4vEwHbQOEQRlQhLF+rpTfG2G
         wSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=963wc504ovvP9hLMqUq9dWGHBsOsuBGDQY+mZGdkukI=;
        b=WZBOW3BthG0DPqVP86F9bYL1hzV6WGqgEDwC7Xc3a6BB3xM3rJu30d1WyquSkqk9Wc
         NgfC9oL/TGVIcV5OWsUyvolPV2sglVprGtln+1dnrVVqVKE40HKEQ5e7znzz9FiZAotC
         bKsUFwN5cOD1HXKPb3Z5xyIhczy4fhzbuMWwBo4W59ELuXSXoxoZ79y4Bpa7vkJ3uzbD
         OQ29/dV0K0nnRaLagElX+kmAEiGKDUcct5INUzCJomPx1HIJUNUJgPTrkOmPFk7bWWM6
         iZszhvt+aqhxiOjZ1NSadUuOGT49KDVUqyXx8dRxBhWrx3pim5iXPXz0TOu4ZkT5qDO9
         7D1w==
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
Subject: [PATCH 4.16 142/196] clk: bcm2835: De-assert/assert PLL reset signal when appropriate
Date: Sun, 22 Apr 2018 15:52:42 +0200
Message-Id: <20180422135111.587185330@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455174202804728?=
X-GMAIL-MSGID: =?utf-8?q?1598455174202804728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -602,9 +602,7 @@ static void bcm2835_pll_off(struct clk_h
 	const struct bcm2835_pll_data *data = pll->data;
 
 	spin_lock(&cprman->regs_lock);
-	cprman_write(cprman, data->cm_ctrl_reg,
-		     cprman_read(cprman, data->cm_ctrl_reg) |
-		     CM_PLL_ANARST);
+	cprman_write(cprman, data->cm_ctrl_reg, CM_PLL_ANARST);
 	cprman_write(cprman, data->a2w_ctrl_reg,
 		     cprman_read(cprman, data->a2w_ctrl_reg) |
 		     A2W_PLL_CTRL_PWRDN);
@@ -640,6 +638,10 @@ static int bcm2835_pll_on(struct clk_hw
 		cpu_relax();
 	}
 
+	cprman_write(cprman, data->a2w_ctrl_reg,
+		     cprman_read(cprman, data->a2w_ctrl_reg) |
+		     A2W_PLL_CTRL_PRST_DISABLE);
+
 	return 0;
 }
 
