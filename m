Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+1CtlzC/HHEdYo3MgQ0EV22Q+LgjtfD1H7mnlGQKB3kxqKeW6zEmFFw0afodU8tkzjcFn8
ARC-Seal: i=1; a=rsa-sha256; t=1524405656; cv=none;
        d=google.com; s=arc-20160816;
        b=cS+cdwIl1MW/zcuNM5puKhw0HvykVCP0f4/QU5o3UjqQxTixMpCgRx1QKRY6a7z4a7
         whl+yVIZNt55J+M3jhv/oRig32quL2WJJYAIV5ec7OqfLCoP9DjpyzFRA1bMlIOB23tT
         1FCkeMvGViyjmgt9Qm3YAfgb55vrujlIcCcs8cXNCxCuPvGIbwKRo9+5+9Wbj9sifVcE
         GITARWSpUhq03GHWTt7Mz8DCEiAMfKsLZ3hnMIW1zI76fv/cw+PWOIZ6gziq29LTeFn1
         CAH46hZLuhDhLMe35ELQkbCVIzHkztEjJuKX5Zife3vYfWxJEZjCR7yhUWaZwlQYadL2
         Po5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AbautvUU74UxODa7A3zVABbtAlQ9YQ41gV1GKoszBs8=;
        b=ClDxU6zx1gTwOrhzuMVOH2My/dSvrSMG1pvTqKJobN0onUQNtH9qnegALVYhuBqgAN
         CILSiDoUeph5p84Zto1aJ9WglQUYFbnevaRVsYXmOkgQjVX1aeEdM9b8Qdg0dAdR+DZd
         NF9LIhSW+GokBzm+/rMipURXmkfipdgbmKLJBlUe9K6qkvTZJto4EhIFZbJ0HE8K4jiX
         JKc2+bVM97SpI++PK7N4N5qdojKQjwii4UiXFLIW1tpsU7+fdqyh4gE/d2GsHRIkvGws
         woBzAk+WS8APXzhIahnRzjvIC+vvtx5H74EoU6BpxeK9wbTOqvGn+EiDxCIwpnxdqhyQ
         stWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 4.16 146/196] pwm: mediatek: Improve precision in rate calculation
Date: Sun, 22 Apr 2018 15:52:46 +0200
Message-Id: <20180422135111.777676708@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455186062560771?=
X-GMAIL-MSGID: =?utf-8?q?1598455186062560771?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>

commit 04c0a4e00dc11fedc0b0a8593adcf0f4310505d4 upstream.

Add a way that turning resolution from in nanosecond into in picosecond
to improve noticeably almost 4.5% precision.

It's necessary to hold the new resolution with type u64 and thus related
operations on u64 are applied instead in those rate calculations.

And the patch has a dependency on [1].

[1] http://lists.infradead.org/pipermail/linux-mediatek/2018-March/012225.html

Cc: stable@vger.kernel.org
Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pwm/pwm-mediatek.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -135,19 +135,25 @@ static int mtk_pwm_config(struct pwm_chi
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
-	u32 resolution, clkdiv = 0, reg_width = PWMDWIDTH,
+	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
 	    reg_thres = PWMTHRES;
+	u64 resolution;
 	int ret;
 
 	ret = mtk_pwm_clk_enable(chip, pwm);
 	if (ret < 0)
 		return ret;
 
-	resolution = NSEC_PER_SEC / clk_get_rate(clk);
+	/* Using resolution in picosecond gets accuracy higher */
+	resolution = (u64)NSEC_PER_SEC * 1000;
+	do_div(resolution, clk_get_rate(clk));
 
-	while (period_ns / resolution > 8191) {
+	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
+	while (cnt_period > 8191) {
 		resolution *= 2;
 		clkdiv++;
+		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
+						   resolution);
 	}
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
@@ -165,9 +171,10 @@ static int mtk_pwm_config(struct pwm_chi
 		reg_thres = PWM45THRES_FIXUP;
 	}
 
+	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, period_ns / resolution);
-	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, duty_ns / resolution);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, cnt_period);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 
 	mtk_pwm_clk_disable(chip, pwm);
 
