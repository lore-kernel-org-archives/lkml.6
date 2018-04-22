Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48eAMaSHkNgr2H8cNVqS0MQHwKzG41rNK3E7vqrZOLP2Yq7cpdA0kvMLUOYuFaSXbKuIb6j
ARC-Seal: i=1; a=rsa-sha256; t=1524406161; cv=none;
        d=google.com; s=arc-20160816;
        b=kcdYDp8xB8dpn5YqDLynIRQebjqAbURx2qQ2kNOHvu3HNMWPzm59sGH1neHm9Lem0m
         htWI/B4rnvlfRlKTk9EIQ6wra2GGLw8wNYkt1aKI/hthnYg/nZri0Rtwo8/jvkQPJKNB
         y33qkXntRInX/EV534rQL4RC+DOWIj2xYg/TcfynaLm1x7JjNTMhW8eHu4GIMYcx0CoX
         wlstCQHHxYpThEwBxbezrEwXJ1/UxON1Obw02DegsnNSUkUe0b1xYsEW5gA7WW0OvTyx
         4fN+wIWGIdzrXOcisZfU1KKciBsDowbTF2k3aqiGvxmV4q/I8qvkMkxzrolXRmn5vxkt
         ZBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7B/fMvBLbAlMCXj5zWsuE7hIfk2cZN8fi6dYC/C5G2k=;
        b=0kNEF5dEBlwNCObHc+7wuuVCn1FKsmOn3dIrydEy5hs6FAdORfAdXVU4ZxOzLDdut9
         9t+I33SRCF+sZsKStFcrl5B3XETOENN0yIYRvEjmD0/acHa5mj5TzSOxu4+sLvhbvbah
         WNL4dB7++z+qLwJKqXrXITbLt+E2dwndnHVaBOMFWaTh9A7eFovsxoCWotDMnwzoQO2C
         6/96DjYDWgJBQ2DJGaiUTEGmNwaeLfkf7IzalWNh6pQ6GwDBlP2QPt1SpgCiPhNQsMRj
         YBsEtlaxeTt8nAnnNSrPkz/8befwcq8v5g8rOOz+5l+S0X76Ym6MNSJagSE2+AD5wfWq
         lVPQ==
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
Subject: [PATCH 4.14 108/164] clk: mediatek: fix PWM clock source by adding a fixed-factor clock
Date: Sun, 22 Apr 2018 15:52:55 +0200
Message-Id: <20180422135139.846908715@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455171327314319?=
X-GMAIL-MSGID: =?utf-8?q?1598455714606850746?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
