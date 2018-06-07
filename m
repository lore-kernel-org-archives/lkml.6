Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pDt9B0xXGVsmeQAAmS7hNA
	; Thu, 07 Jun 2018 16:05:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6A3FA607E7; Thu,  7 Jun 2018 16:05:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B6A8360590;
	Thu,  7 Jun 2018 16:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6A8360590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936056AbeFGQFR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:05:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39229 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933000AbeFGOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:03 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0005Zs-6G; Thu, 07 Jun 2018 15:09:02 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb0-0002oO-UI; Thu, 07 Jun 2018 15:08:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.820464354@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 089/410] pinctrl: Really force states during
 suspend/resume
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

commit 981ed1bfbc6c4660b2ddaa8392893e20a6255048 upstream.

In case a platform only defaults a "default" set of pins, but not a
"sleep" set of pins, and this particular platform suspends and resumes
in a way that the pin states are not preserved by the hardware, when we
resume, we would call pinctrl_single_resume() -> pinctrl_force_default()
-> pinctrl_select_state() and the first thing we do is check that the
pins state is the same as before, and do nothing.

In order to fix this, decouple the actual state change from
pinctrl_select_state() and move it pinctrl_commit_state(), while keeping
the p->state == state check in pinctrl_select_state() not to change the
caller assumptions. pinctrl_force_sleep() and pinctrl_force_default()
are updated to bypass the state check by calling pinctrl_commit_state().

[Linus Walleij]
The forced pin control states are currently only used in some pin
controller drivers that grab their own reference to their own pins.
This is equal to the pin control hogs: pins taken by pin control
devices since there are no corresponding device in the Linux device
hierarchy, such as memory controller lines or unused GPIO lines,
or GPIO lines that are used orthogonally from the GPIO subsystem
but pincontrol-wise managed as hogs (non-strict mode, allowing
simultaneous use by GPIO and pin control). For this case forcing
the state from the drivers' suspend()/resume() callbacks makes
sense and should semantically match the name of the function.

Fixes: 6e5e959dde0d ("pinctrl: API changes to support multiple states per device")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pinctrl/core.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -977,19 +977,16 @@ struct pinctrl_state *pinctrl_lookup_sta
 EXPORT_SYMBOL_GPL(pinctrl_lookup_state);
 
 /**
- * pinctrl_select_state() - select/activate/program a pinctrl state to HW
+ * pinctrl_commit_state() - select/activate/program a pinctrl state to HW
  * @p: the pinctrl handle for the device that requests configuration
  * @state: the state handle to select/activate/program
  */
-int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *state)
+static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
 {
 	struct pinctrl_setting *setting, *setting2;
 	struct pinctrl_state *old_state = p->state;
 	int ret;
 
-	if (p->state == state)
-		return 0;
-
 	if (p->state) {
 		/*
 		 * The set of groups with a mux configuration in the old state
@@ -1067,6 +1064,19 @@ unapply_new_state:
 
 	return ret;
 }
+
+/**
+ * pinctrl_select_state() - select/activate/program a pinctrl state to HW
+ * @p: the pinctrl handle for the device that requests configuration
+ * @state: the state handle to select/activate/program
+ */
+int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *state)
+{
+	if (p->state == state)
+		return 0;
+
+	return pinctrl_commit_state(p, state);
+}
 EXPORT_SYMBOL_GPL(pinctrl_select_state);
 
 static void devm_pinctrl_release(struct device *dev, void *res)
@@ -1235,7 +1245,7 @@ void pinctrl_unregister_map(struct pinct
 int pinctrl_force_sleep(struct pinctrl_dev *pctldev)
 {
 	if (!IS_ERR(pctldev->p) && !IS_ERR(pctldev->hog_sleep))
-		return pinctrl_select_state(pctldev->p, pctldev->hog_sleep);
+		return pinctrl_commit_state(pctldev->p, pctldev->hog_sleep);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
@@ -1247,7 +1257,7 @@ EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
 int pinctrl_force_default(struct pinctrl_dev *pctldev)
 {
 	if (!IS_ERR(pctldev->p) && !IS_ERR(pctldev->hog_default))
-		return pinctrl_select_state(pctldev->p, pctldev->hog_default);
+		return pinctrl_commit_state(pctldev->p, pctldev->hog_default);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pinctrl_force_default);
