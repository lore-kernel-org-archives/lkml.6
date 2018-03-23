Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvLDdkiIui9ACj0uTR6kvfXdtOjfgFeDQiu8K0w9MRz4o3w1Ox2du08jGgh1zqq1Ow0Xrrv
ARC-Seal: i=1; a=rsa-sha256; t=1521800260; cv=none;
        d=google.com; s=arc-20160816;
        b=a+Egb9rmZBqjCgET8IFrg/C/e4FGece94wRmxr6pT+5AT66yENk38RaTsdNSClCCEJ
         gwMUj0QouYjQkvDfBsvWXwQQuq7iz8qf8q+uZDnYqX54NSVgZuMxx6uNEpRhOknmE4wN
         Hoz1PJyJz2IlVW18Y4/bNbcMFy7s2NVFJ2eQ4q4TEuYWLOblY7o9FN6aPtzE/rRlq/4g
         qWFb1F/VOaUyPYuXRjdGGTtoxGKm0uFjoEZCDsNG6B87TULZG/RxGMQHjXhf39Co4prz
         U/WznSFp92sszAr2/OADU7hgVI1SSfhE2pJT0aUgmfYiChMxtWjPD2OeYLEVA5ycp0AZ
         1MAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vac8CuDenUL8je0QDjwc0QQHoOUnCEozdPoyzlrFeHA=;
        b=eeFrDQBr6vcxxYbK6Fnc33LpB1qZnJmK1cWmrkKHDrW6YyRijcSIYv21ZKzJBj5kY2
         s5A0Lx1ZhszlGI6kqIFqvj/RLtPeru/NqDaoAzGqb6sZI5Qb7NOrD0tEJb0aPxfsn3h2
         0alX55t87KOSgcZcVv61LrB6RhlfrBHTLLFvlFTSY316vHsgoDbqnFsrzbNIaGB2lYLM
         fsQoQvD9GC+sw1r0PKh2kUh1pKFS1RkjX4+z4/B8jTcq/lmyO4rJyqwtJsjQ9nmZDQ4p
         WCEjUc1RIsuYPTSWCCi1YwEdbXq4DkQ3vTXOsUr9X5rvwE7cnzv4kutmAg+E0HpR86iS
         hdvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 90/97] pinctrl: Really force states during suspend/resume
Date: Fri, 23 Mar 2018 10:55:17 +0100
Message-Id: <20180323094202.520488518@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722021029540326?=
X-GMAIL-MSGID: =?utf-8?q?1595723229764772036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>


[ Upstream commit 981ed1bfbc6c4660b2ddaa8392893e20a6255048 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/core.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -979,19 +979,16 @@ struct pinctrl_state *pinctrl_lookup_sta
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
 		 * For each pinmux setting in the old state, forget SW's record
@@ -1055,6 +1052,19 @@ unapply_new_state:
 
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
@@ -1223,7 +1233,7 @@ void pinctrl_unregister_map(struct pinct
 int pinctrl_force_sleep(struct pinctrl_dev *pctldev)
 {
 	if (!IS_ERR(pctldev->p) && !IS_ERR(pctldev->hog_sleep))
-		return pinctrl_select_state(pctldev->p, pctldev->hog_sleep);
+		return pinctrl_commit_state(pctldev->p, pctldev->hog_sleep);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
@@ -1235,7 +1245,7 @@ EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
 int pinctrl_force_default(struct pinctrl_dev *pctldev)
 {
 	if (!IS_ERR(pctldev->p) && !IS_ERR(pctldev->hog_default))
-		return pinctrl_select_state(pctldev->p, pctldev->hog_default);
+		return pinctrl_commit_state(pctldev->p, pctldev->hog_default);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pinctrl_force_default);
