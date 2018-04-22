Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49zELzxfhIj1UX6iureafAAOJQkLaF2UQ+Q83f0VhCvjfR63iVOBjgmmGLAl86aNQzdVgey
ARC-Seal: i=1; a=rsa-sha256; t=1524405653; cv=none;
        d=google.com; s=arc-20160816;
        b=CNbMTuXhkuZ691kTEpPdn6pldGENqeUWEB9Fj6uLE8Xy3HyH0Ao1mNgA2WtPNkdr0i
         WdrREHpbPbGbzp9zTWkcx7fHISV73QS6xzp6zEBs/o4aPoDUzy74Ck6mWrpeYUyedIiV
         QFzrCEiGmJzV7kwjv0mvO0ROWQKwNPJLKIKzAI9bQzKJRGols8W7FcmBevGbOdeBZkv3
         /AKvSdb7apX/FOR9Vvfn9M0gwIVKf89GCoqEUeBryaGgY7CXO3pObg7T0d3W6wN8GfP/
         7NQDAlxx6c7Gvk9oKT9+wvITCvrSpxkDO1kQ8Lz86zkFTo7qIotPXUCrcH6f130hmZyH
         yHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CtUaahiZtycWWYompxwRDji4YJlX8yH5Rn+1bim4ZkY=;
        b=dLw0b6AFfTdFAR7IwcUd/1JArAxhTVyIvhN3E9TyfiV24NJUWoIRcWY0drEVW0dHmb
         1CSEbaYenK0zJXkUXNkCusqisPlZ/kRwZVRVJLR4qZHlZKb/cN5nZ26gmJppfV8Z9V3P
         UNKQ9zkECWk3g7L43pehgDokAaoJEysFeg0lq80pQRvC0LzN9fXQYmpPMugqnf8Nd3Ur
         3V4XiGErR1eVsLI6+E93qapmdGybaH3t2KUcnjKYv+gCZ1yVSnKWvZRkPS7GFNs2cwog
         +HWK7lzER8RbTrH82JOcSJzBh7pL7zzsFujcpXtxPIdwy4dWETc7V5TcUrXzFjfhepro
         j1/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Zhi Mao <zhi.mao@mediatek.com>,
	John Crispin <john@phrozen.org>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 4.16 145/196] pwm: mediatek: Fix up PWM4 and PWM5 malfunction on MT7623
Date: Sun, 22 Apr 2018 15:52:45 +0200
Message-Id: <20180422135111.731088434@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455182201942896?=
X-GMAIL-MSGID: =?utf-8?q?1598455182201942896?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>

commit 360cc036563db27881ce08049f69138438f2ddd0 upstream.

Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
programming on PWM hardware causes waveform cannot be output as expected.
Thus, the patch adds the extra condition for fixing up the weird case to
let PWM4 or PWM5 able to work on MT7623.

v1 -> v2: use pwm45_fixup naming instead of pwm45_quirk
v2 -> v3: add more tags for Reviewed-by, Fixes, and Cc stable

Cc: stable@vger.kernel.org
Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Zhi Mao <zhi.mao@mediatek.com>
Cc: John Crispin <john@phrozen.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pwm/pwm-mediatek.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -29,7 +29,9 @@
 #define PWMGDUR			0x0c
 #define PWMWAVENUM		0x28
 #define PWMDWIDTH		0x2c
+#define PWM45DWIDTH_FIXUP	0x30
 #define PWMTHRES		0x30
+#define PWM45THRES_FIXUP	0x34
 
 #define PWM_CLK_DIV_MAX		7
 
@@ -54,6 +56,7 @@ static const char * const mtk_pwm_clk_na
 
 struct mtk_pwm_platform_data {
 	unsigned int num_pwms;
+	bool pwm45_fixup;
 };
 
 /**
@@ -66,6 +69,7 @@ struct mtk_pwm_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
 	struct clk *clks[MTK_CLK_MAX];
+	const struct mtk_pwm_platform_data *soc;
 };
 
 static const unsigned int mtk_pwm_reg_offset[] = {
@@ -131,7 +135,8 @@ static int mtk_pwm_config(struct pwm_chi
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
-	u32 resolution, clkdiv = 0;
+	u32 resolution, clkdiv = 0, reg_width = PWMDWIDTH,
+	    reg_thres = PWMTHRES;
 	int ret;
 
 	ret = mtk_pwm_clk_enable(chip, pwm);
@@ -151,9 +156,18 @@ static int mtk_pwm_config(struct pwm_chi
 		return -EINVAL;
 	}
 
+	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
+		/*
+		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
+		 * from the other PWMs on MT7623.
+		 */
+		reg_width = PWM45DWIDTH_FIXUP;
+		reg_thres = PWM45THRES_FIXUP;
+	}
+
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
-	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, period_ns / resolution);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, duty_ns / resolution);
 
 	mtk_pwm_clk_disable(chip, pwm);
 
@@ -211,6 +225,7 @@ static int mtk_pwm_probe(struct platform
 	data = of_device_get_match_data(&pdev->dev);
 	if (data == NULL)
 		return -EINVAL;
+	pc->soc = data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pc->regs = devm_ioremap_resource(&pdev->dev, res);
@@ -251,14 +266,17 @@ static int mtk_pwm_remove(struct platfor
 
 static const struct mtk_pwm_platform_data mt2712_pwm_data = {
 	.num_pwms = 8,
+	.pwm45_fixup = false,
 };
 
 static const struct mtk_pwm_platform_data mt7622_pwm_data = {
 	.num_pwms = 6,
+	.pwm45_fixup = false,
 };
 
 static const struct mtk_pwm_platform_data mt7623_pwm_data = {
 	.num_pwms = 5,
+	.pwm45_fixup = true,
 };
 
 static const struct of_device_id mtk_pwm_of_match[] = {
