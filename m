Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeEBG5j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 02:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751021AbeEBG5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 02:57:37 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525151013-28291-1-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
References: <1525151013-28291-1-git-send-email-tdas@codeaurora.org>
Message-ID: <152524425583.138124.2497854182982735033@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1] clk: qcom: gdsc: Add support to poll CFG register to check
 GDSC state
Date: Tue, 01 May 2018 23:57:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w426vhX2020086

Quoting Taniya Das (2018-04-30 22:03:33)
> @@ -45,15 +50,28 @@
> 
>  #define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
> 
> -static int gdsc_is_enabled(struct gdsc *sc, unsigned int reg)
> +static int gdsc_is_enabled(struct gdsc *sc, bool en)
>  {
> +       unsigned int reg;
>         u32 val;
>         int ret;
> 
> +       if (sc->flags & POLL_CFG_GDSCR)
> +               reg = sc->gdscr + CFG_GDSCR_OFFSET;
> +       else
> +               reg = sc->gds_hw_ctrl ? sc->gds_hw_ctrl : sc->gdscr;
> +
>         ret = regmap_read(sc->regmap, reg, &val);
>         if (ret)
>                 return ret;
> 
> +       if (sc->flags & POLL_CFG_GDSCR) {
> +               if (en)
> +                       return !!(val & GDSC_POWER_UP_COMPLETE);
> +               else
> +                       return !(val & GDSC_POWER_DOWN_COMPLETE);

This is confusing, but also is correct, because this function is
returning if the gdsc is enabled or not, and that also happens to be
false when the gdsc is not enabled and this bit is set.

> +       }
> +
>         return !!(val & PWR_ON_MASK);
>  }
> 
> @@ -64,17 +82,17 @@ static int gdsc_hwctrl(struct gdsc *sc, bool en)
>         return regmap_update_bits(sc->regmap, sc->gdscr, HW_CONTROL_MASK, val);
>  }
> 
> -static int gdsc_poll_status(struct gdsc *sc, unsigned int reg, bool en)
> +static int gdsc_poll_status(struct gdsc *sc, bool en)
>  {
>         ktime_t start;
> 
>         start = ktime_get();
>         do {
> -               if (gdsc_is_enabled(sc, reg) == en)
> +               if (gdsc_is_enabled(sc, en) == en)

I still don't like this == en logic. How about this patch on top? If you
can test it out, I'll merge your patch and then my patch to make this
all easier to read. Note that I changed the off case for
POWER_DOWN_COMPLETE to be a double negation.

---8<---
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 2a6b0ff7d451..4696e241db89 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -50,7 +50,13 @@
 
 #define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
 
-static int gdsc_is_enabled(struct gdsc *sc, bool en)
+enum gdsc_status {
+	GDSC_OFF,
+	GDSC_ON
+};
+
+/* Returns 1 if GDSC status is status, 0 if not, and < 0 on error */
+static int gdsc_check_status(struct gdsc *sc, enum gdsc_status status)
 {
 	unsigned int reg;
 	u32 val;
@@ -58,21 +64,32 @@ static int gdsc_is_enabled(struct gdsc *sc, bool en)
 
 	if (sc->flags & POLL_CFG_GDSCR)
 		reg = sc->gdscr + CFG_GDSCR_OFFSET;
+	else if (sc->gds_hw_ctrl)
+		reg = sc->gds_hw_ctrl;
 	else
-		reg = sc->gds_hw_ctrl ? sc->gds_hw_ctrl : sc->gdscr;
+		reg = sc->gdscr;
 
 	ret = regmap_read(sc->regmap, reg, &val);
 	if (ret)
 		return ret;
 
 	if (sc->flags & POLL_CFG_GDSCR) {
-		if (en)
+		switch (status) {
+		case GDSC_ON:
 			return !!(val & GDSC_POWER_UP_COMPLETE);
-		else
-			return !(val & GDSC_POWER_DOWN_COMPLETE);
+		case GDSC_OFF:
+			return !!(val & GDSC_POWER_DOWN_COMPLETE);
+		}
+	}
+
+	switch (status) {
+	case GDSC_ON:
+		return !!(val & PWR_ON_MASK);
+	case GDSC_OFF:
+		return !(val & PWR_ON_MASK);
 	}
 
-	return !!(val & PWR_ON_MASK);
+	return -EINVAL;
 }
 
 static int gdsc_hwctrl(struct gdsc *sc, bool en)
@@ -82,33 +99,33 @@ static int gdsc_hwctrl(struct gdsc *sc, bool en)
 	return regmap_update_bits(sc->regmap, sc->gdscr, HW_CONTROL_MASK, val);
 }
 
-static int gdsc_poll_status(struct gdsc *sc, bool en)
+static int gdsc_poll_status(struct gdsc *sc, enum gdsc_status status)
 {
 	ktime_t start;
 
 	start = ktime_get();
 	do {
-		if (gdsc_is_enabled(sc, en) == en)
+		if (gdsc_check_status(sc, status))
 			return 0;
 	} while (ktime_us_delta(ktime_get(), start) < TIMEOUT_US);
 
-	if (gdsc_is_enabled(sc, en) == en)
+	if (gdsc_check_status(sc, status))
 		return 0;
 
 	return -ETIMEDOUT;
 }
 
-static int gdsc_toggle_logic(struct gdsc *sc, bool en)
+static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status)
 {
 	int ret;
-	u32 val = en ? 0 : SW_COLLAPSE_MASK;
+	u32 val = (status == GDSC_ON) ? 0 : SW_COLLAPSE_MASK;
 
 	ret = regmap_update_bits(sc->regmap, sc->gdscr, SW_COLLAPSE_MASK, val);
 	if (ret)
 		return ret;
 
 	/* If disabling votable gdscs, don't poll on status */
-	if ((sc->flags & VOTABLE) && !en) {
+	if ((sc->flags & VOTABLE) && status == GDSC_OFF) {
 		/*
 		 * Add a short delay here to ensure that an enable
 		 * right after it was disabled does not put it in an
@@ -118,7 +135,7 @@ static int gdsc_toggle_logic(struct gdsc *sc, bool en)
 		return 0;
 	}
 
-	if (sc->gds_hw_ctrl)
+	if (sc->gds_hw_ctrl) {
 		/*
 		 * The gds hw controller asserts/de-asserts the status bit soon
 		 * after it receives a power on/off request from a master.
@@ -130,8 +147,9 @@ static int gdsc_toggle_logic(struct gdsc *sc, bool en)
 		 * and polling the status bit.
 		 */
 		udelay(1);
+	}
 
-	return gdsc_poll_status(sc, en);
+	return gdsc_poll_status(sc, status);
 }
 
 static inline int gdsc_deassert_reset(struct gdsc *sc)
@@ -210,7 +228,7 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 		gdsc_deassert_clamp_io(sc);
 	}
 
-	ret = gdsc_toggle_logic(sc, true);
+	ret = gdsc_toggle_logic(sc, GDSC_ON);
 	if (ret)
 		return ret;
 
@@ -266,7 +284,7 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 		 */
 		udelay(1);
 
-		ret = gdsc_poll_status(sc, true);
+		ret = gdsc_poll_status(sc, GDSC_ON);
 		if (ret)
 			return ret;
 	}
@@ -274,7 +292,7 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	if (sc->pwrsts & PWRSTS_OFF)
 		gdsc_clear_mem_on(sc);
 
-	ret = gdsc_toggle_logic(sc, false);
+	ret = gdsc_toggle_logic(sc, GDSC_OFF);
 	if (ret)
 		return ret;
 
@@ -303,12 +321,12 @@ static int gdsc_init(struct gdsc *sc)
 
 	/* Force gdsc ON if only ON state is supported */
 	if (sc->pwrsts == PWRSTS_ON) {
-		ret = gdsc_toggle_logic(sc, true);
+		ret = gdsc_toggle_logic(sc, GDSC_ON);
 		if (ret)
 			return ret;
 	}
 
-	on = gdsc_is_enabled(sc, true);
+	on = gdsc_check_status(sc, GDSC_ON);
 	if (on < 0)
 		return on;
 
