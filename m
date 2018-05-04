Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeEDX5e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 19:57:34 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36632 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeEDX5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 19:57:32 -0400
X-Google-Smtp-Source: AB8JxZrMTSCPPhFAKQ7u7l4Vi8Vy4M6737Jc+GOuA8BMuS8nXQ26y6f8pUPaInazjLdIefssCYfnJA==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] pinctrl: qcom: fix wrong pull status display for no_keeper SoC
Date: Fri,  4 May 2018 16:57:28 -0700
Message-Id: <20180504235728.805-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Péron <peron.clem@gmail.com>

DebugFS strings about pin pull status for no_keeper SoC are wrong

Fix this by adding a different string array for no_keeper SoC

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Hi Linus,

Forwarding this patch which was posted to linux-arm-msm@ only. LGTM, please apply.

@Clémen, please use ./scripts/get_maintaine.pl to find appropriate recipients
for future patches.

Regards,
Bjorn

 drivers/pinctrl/qcom/pinctrl-msm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index fa4e94fedb8c..c3c77b86eff7 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -504,13 +504,19 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 	int pull;
 	u32 ctl_reg;
 
-	static const char * const pulls[] = {
+	static const char * const pulls_keeper[] = {
 		"no pull",
 		"pull down",
 		"keeper",
 		"pull up"
 	};
 
+	static const char * const pulls_no_keeper[] = {
+		"no pull",
+		"pull down",
+		"pull up",
+	};
+
 	if (!gpiochip_line_is_valid(chip, offset))
 		return;
 
@@ -524,7 +530,10 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 
 	seq_printf(s, " %-8s: %-3s %d", g->name, is_out ? "out" : "in", func);
 	seq_printf(s, " %dmA", msm_regval_to_drive(drive));
-	seq_printf(s, " %s", pulls[pull]);
+	if (pctrl->soc->pull_no_keeper)
+		seq_printf(s, " %s", pulls_no_keeper[pull]);
+	else
+		seq_printf(s, " %s", pulls_keeper[pull]);
 	seq_puts(s, "\n");
 }
 
-- 
2.17.0
