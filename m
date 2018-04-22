Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49008uiaDLknjgJc/YqU7w8SPua4/DKFgAx37QWVsg/Trb5fF0STRUMF3Ku8yfyuh5rP/FU
ARC-Seal: i=1; a=rsa-sha256; t=1524405642; cv=none;
        d=google.com; s=arc-20160816;
        b=CCcBhVqB2y2jinnaXD3CtzfpTHBwoFOC59M/0Qhk3swmUcFLL2S2Fhqec0BcafMIi3
         eeFV7E+lRcoIh0fwIfY53ECH+IDXoMIonJ9mNzAZSO7ebJG/jzbfJWVuqSbIMuN5RFSJ
         iriH+o3gN40ivXWF3+6Te9s/YBKWoTyHPtjThTV7hY0jkiXOmVGPrDTffsR2ao+STXrM
         LsLhqoMUNGrUL3dTXAXNI8MhUV3EruiZKCC0kX39ckJevv9YhRmreS+pj8aPZHVLOu5E
         4HmnHDelOQuP/U6mB45NbTgBjOLUk6Jkq5W8a5iYEHzhHQlifxVZm275TAf77hlNR0v7
         IEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dq23yj7PLU17FUb4g8P94A0E1FAdfWnsYMrGAs9SXc4=;
        b=UdBmU3aRESmnEJkgjqJlGCXQWjZslOAewYwDRlB7s6LM7k4RXoX/rrke48/iuL0l9Q
         4uHipmJ+shutVdtBuwe9W8KSLJpVfNOjvMaUw6+5+eT7u3hLMmEYX708w9M/I9BQ+kU0
         swRkMntwqT0vepdfx9lFS3ChQcvncguk4shixHdBmBPrEs/8HdTY26ikiGAgoajyutbZ
         lfdR6qnhrXNlZxhc/6YE1yn4lnUkYoC14Fzlw763V0pDxqqTblaRLNPyV41cBxCjV1k5
         PYkxcKQ/vt8IHmbNLyTr6HI6hq0AVRV8e7S13Urytx18ndKvTps1s+hFwaSZafYu7YMN
         DvBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.16 141/196] clk: mediatek: fix PWM clock source by adding a fixed-factor clock
Date: Sun, 22 Apr 2018 15:52:41 +0200
Message-Id: <20180422135111.539406770@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455171327314319?=
X-GMAIL-MSGID: =?utf-8?q?1598455171327314319?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>

commit 89cd7aec21af26fd0c117bfc4bfc781724f201de upstream.

The clock for which all PWM devices on MT7623 or MT2701 actually depending
on has to be divided by four from its parent clock axi_sel in the clock
path prior to PWM devices.

Consequently, adding a fixed-factor clock axisel_d4 as one-fourth of
clock axi_sel allows that PWM devices can have the correct resolution
calculation.

Cc: stable@vger.kernel.org
Fixes: e9862118272a ("clk: mediatek: Add MT2701 clock support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/mediatek/clk-mt2701.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -148,6 +148,7 @@ static const struct mtk_fixed_factor top
 	FACTOR(CLK_TOP_CLK26M_D8, "clk26m_d8", "clk26m", 1, 8),
 	FACTOR(CLK_TOP_32K_INTERNAL, "32k_internal", "clk26m", 1, 793),
 	FACTOR(CLK_TOP_32K_EXTERNAL, "32k_external", "rtc32k", 1, 1),
+	FACTOR(CLK_TOP_AXISEL_D4, "axisel_d4", "axi_sel", 1, 4),
 };
 
 static const char * const axi_parents[] = {
@@ -857,13 +858,13 @@ static const struct mtk_gate peri_clks[]
 	GATE_PERI0(CLK_PERI_USB1, "usb1_ck", "usb20_sel", 11),
 	GATE_PERI0(CLK_PERI_USB0, "usb0_ck", "usb20_sel", 10),
 	GATE_PERI0(CLK_PERI_PWM, "pwm_ck", "axi_sel", 9),
-	GATE_PERI0(CLK_PERI_PWM7, "pwm7_ck", "axi_sel", 8),
-	GATE_PERI0(CLK_PERI_PWM6, "pwm6_ck", "axi_sel", 7),
-	GATE_PERI0(CLK_PERI_PWM5, "pwm5_ck", "axi_sel", 6),
-	GATE_PERI0(CLK_PERI_PWM4, "pwm4_ck", "axi_sel", 5),
-	GATE_PERI0(CLK_PERI_PWM3, "pwm3_ck", "axi_sel", 4),
-	GATE_PERI0(CLK_PERI_PWM2, "pwm2_ck", "axi_sel", 3),
-	GATE_PERI0(CLK_PERI_PWM1, "pwm1_ck", "axi_sel", 2),
+	GATE_PERI0(CLK_PERI_PWM7, "pwm7_ck", "axisel_d4", 8),
+	GATE_PERI0(CLK_PERI_PWM6, "pwm6_ck", "axisel_d4", 7),
+	GATE_PERI0(CLK_PERI_PWM5, "pwm5_ck", "axisel_d4", 6),
+	GATE_PERI0(CLK_PERI_PWM4, "pwm4_ck", "axisel_d4", 5),
+	GATE_PERI0(CLK_PERI_PWM3, "pwm3_ck", "axisel_d4", 4),
+	GATE_PERI0(CLK_PERI_PWM2, "pwm2_ck", "axisel_d4", 3),
+	GATE_PERI0(CLK_PERI_PWM1, "pwm1_ck", "axisel_d4", 2),
 	GATE_PERI0(CLK_PERI_THERM, "therm_ck", "axi_sel", 1),
 	GATE_PERI0(CLK_PERI_NFI, "nfi_ck", "nfi2x_sel", 0),
 
