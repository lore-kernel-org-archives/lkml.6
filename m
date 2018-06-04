Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbeFDOBU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:01:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41135 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbeFDN75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:59:57 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180604135955euoutp015201352e05ba079b0892c7ad8b1455cb~0_cRVsQ_92384223842euoutp01F
X-AuditID: cbfec7f4-6f9ff700000043e4-86-5b1545da86ae
From: Maciej Purski <m.purski@samsung.com>
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 4/7] regulator: core: Implement voltage balancing algorithm
Date: Mon, 04 Jun 2018 15:59:21 +0200
Message-id: <1528120764-14316-5-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7djPc7q3XEWjDa71sVpMffiEzWJf3282
        i02Pr7FaXN41h81i9pJ+FosFL2+xWKw9cpfdYv8VLwcOj29fJ7F4bFrVyeaxeUm9R9+WVYwe
        x29sZ/L4vEkugC2KyyYlNSezLLVI3y6BK2N7f0FBt1VF66evTA2MZ3S7GDk5JARMJH59eM7S
        xcjFISSwglGi42ILlPOZUWLtrAvsXYwcYFWT96ZBxJcxSvRea2CHcP4zSnz9tYgZpIhNQEti
        TXs8yFQRAVeJ7z1nwQYxC9xglLhy6DwjSEJYwFti4oXdzCA2i4CqxIm/19lAbF4BF4kpP06w
        QZwkJ3HzXCdYDSfQoLezNzGCDJIQmMAm8f7IbHaIIheJxp1foWxhiVfHt0DZMhKXJ3ezQNj5
        Eq3PHkPFKyT29Z5mhbCtJQ4fvwhmMwvwSUzaNp0Z4kteiY42IYgSD4mnlyaCtQoJ7GOU2NfD
        PIFRcgEjwypG8dTS4tz01GKjvNRyveLE3OLSvHS95PzcTYzAWDz97/iXHYy7/iQdYhTgYFTi
        4dWwEo0WYk0sK67MPcQowcGsJMJ72gIoxJuSWFmVWpQfX1Sak1p8iFGag0VJnDdOoy5KSCA9
        sSQ1OzW1ILUIJsvEwSnVwGgmqanUsv8bP5OJvOKyZus4/mc1gRs5c2Zs2aCXOm97v9Q3ocCl
        pSqmeQdCpcRj8tsqUlrtJ2xXYnb92fVh9dsPElbaiscv/Z5o2qZ9QCg6Om/tnPp7Ox1rah+/
        VT3Qxbn2osiKk4e7191ifhrrEmmexOm2b9WZvq6FhtVqJwx3WpXJyDy/osRSnJFoqMVcVJwI
        AJbOjojBAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e/4Nd2brqLRBhvuqlpMffiEzWJf3282
        i02Pr7FaXN41h81i9pJ+FosFL2+xWKw9cpfdYv8VLwcOj29fJ7F4bFrVyeaxeUm9R9+WVYwe
        x29sZ/L4vEkugC2KyyYlNSezLLVI3y6BK2N7f0FBt1VF66evTA2MZ3S7GDk4JARMJCbvTeti
        5OIQEljCKLFj/RLmLkZOIKeRSeLjO1WQGjYBLYk17fEgYREBV4nvPWdZQOqZBW4xSqx/dZQF
        JCEs4C0x8cJusF4WAVWJE3+vs4HYvAIuElN+nACzJQTkJG6e6wSr4QQa9Hb2JkaIXVkSC64s
        Yp7AyLOAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYBhtO/Zzyw7GrnfBhxgFOBiVeHgb
        bESjhVgTy4orcw8xSnAwK4nwnrYACvGmJFZWpRblxxeV5qQWH2KU5mBREuc9b1AZJSSQnliS
        mp2aWpBaBJNl4uCUamDckbcgwOxXz5/X31RWvzmde9LmllYyr6mu7O0o1X/NDxY4BcX1Hih5
        2fRvVsB9iccxFZkr7F8yqCap15/ZUyjdf5dl6+cYe1nJt7/zJwg4ZVrfNr38g2vpn1UfMmce
        dyyZ+jCu5cDNXW/F2OQ+ul4sV0/x2aphy/OpldF7S7la/Twdj8lKxR1KLMUZiYZazEXFiQCu
        UedVHwIAAA==
X-CMS-MailID: 20180604135953eucas1p2ec281df0793bc73e79f3000837abcb04
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180604135953eucas1p2ec281df0793bc73e79f3000837abcb04
References: <20180530144505.GB5705@atomide.com>
        <1528120764-14316-1-git-send-email-m.purski@samsung.com>
        <CGME20180604135953eucas1p2ec281df0793bc73e79f3000837abcb04@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Odroid XU3/4 and other Exynos5422 based boards there is a case, that
different devices on the board are supplied by different regulators
with non-fixed voltages. If one of these devices temporarily requires
higher voltage, there might occur a situation that the spread between
two devices' voltages is so high, that there is a risk of changing
'high' and 'low' states on the interconnection between devices powered
by those regulators.

Introduce new function regulator_balance_voltage(), which
keeps max_spread constraint fulfilled between a group of coupled
regulators. It should be called if a regulator changes its
voltage or after disabling or enabling. Disabled regulators should
follow changes of the enabled ones, but their consumers' demands
shouldn't be taken into account while calculating voltage of other
coupled regulators.

Find voltages, which are closest to suiting all the consumers' demands,
while fulfilling max_spread constraint, keeping the following rules:
- if one regulator is about to rise its voltage, rise others
  voltages in order to keep the max_spread
- if a regulator, which has caused rising other regulators, is
  lowered, lower other regulators if possible
- if one regulator is about to lower its voltage, but it hasn't caused
  rising other regulators, don't change its voltage if it breaks the
  max_spread

Change regulators' voltages step by step, keeping max_spread constraint
fulfilled all the time. Function regulator_get_optimal_voltage()
should find the best possible change for the regulator, which doesn't
break max_spread constraint. In function regulator_balance_voltage()
optimize number of steps by finding highest voltage difference on
each iteration.

If a regulator, which is about to change its voltage, is not coupled,
method regulator_get_optimal_voltage() should simply return the lowest
voltage fulfilling consumers' demands.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c5478d2..0b366c5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -105,6 +105,8 @@ static int _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data);
 static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV);
+static int regulator_balance_voltage(struct regulator_dev *rdev,
+				     suspend_state_t state);
 static int regulator_set_voltage_rdev(struct regulator_dev *rdev,
 				      int min_uV, int max_uV,
 				      suspend_state_t state);
@@ -3126,6 +3128,187 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 	return ret;
 }
 
+static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
+{
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
+	int max_spread = rdev->constraints->max_spread;
+	int n_coupled = c_desc->n_coupled;
+	int desired_min_uV, desired_max_uV, min_current_uV = INT_MAX;
+	int max_current_uV = 0, highest_min_uV = 0, target_uV, possible_uV;
+	int i, ret;
+
+	/* If consumers don't provide any demands, set voltage to min_uV */
+	desired_min_uV = rdev->constraints->min_uV;
+	desired_max_uV = rdev->constraints->max_uV;
+	ret = regulator_check_consumers(rdev,
+					&desired_min_uV,
+					&desired_max_uV, PM_SUSPEND_ON);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * If there are no coupled regulators, simply set the voltage demanded
+	 * by consumers.
+	 */
+	if (n_coupled == 1) {
+		ret = desired_min_uV;
+		goto out;
+	}
+
+	/* Find highest min desired voltage */
+	for (i = 0; i < n_coupled; i++) {
+		int tmp_min = 0;
+		int tmp_max = INT_MAX;
+
+		if (!_regulator_is_enabled(c_rdevs[i]))
+			continue;
+
+		ret = regulator_check_consumers(c_rdevs[i],
+						&tmp_min,
+						&tmp_max, PM_SUSPEND_ON);
+		if (ret < 0)
+			goto out;
+
+		if (tmp_min > highest_min_uV)
+			highest_min_uV = tmp_min;
+	}
+
+	/*
+	 * Let target_uV be equal to the desired one if possible.
+	 * If not, set it to minimum voltage, allowed by other coupled
+	 * regulators.
+	 */
+	target_uV = max(desired_min_uV,  highest_min_uV - max_spread);
+
+	/*
+	 * Find min and max voltages, which currently aren't
+	 * violating max_spread
+	 */
+	for (i = 0; i < n_coupled; i++) {
+		int tmp_act;
+
+		/*
+		 * Don't check the regulator, which is about
+		 * to change voltage
+		 */
+		if (c_rdevs[i] == rdev)
+			continue;
+		if (!_regulator_is_enabled(c_rdevs[i]))
+			continue;
+
+		tmp_act = _regulator_get_voltage(c_rdevs[i]);
+		if (tmp_act < 0) {
+			ret = tmp_act;
+			goto out;
+		}
+
+		if (tmp_act < min_current_uV)
+			min_current_uV = tmp_act;
+
+		if (tmp_act > max_current_uV)
+			max_current_uV = tmp_act;
+	}
+
+	/* There aren't any other regulators enabled */
+	if (max_current_uV == 0) {
+		possible_uV = target_uV;
+	} else {
+		/*
+		 * Correct target voltage, so as it currently isn't
+		 * violating max_spread
+		 */
+		possible_uV = max(target_uV, max_current_uV - max_spread);
+		possible_uV = min(possible_uV, min_current_uV + max_spread);
+	}
+
+	if (possible_uV > desired_max_uV) {
+		ret = -EINVAL;
+		goto out;
+	}
+	ret = possible_uV;
+
+out:
+	return ret;
+}
+
+static int regulator_balance_voltage(struct regulator_dev *rdev,
+				     suspend_state_t state)
+{
+	struct regulator_dev **c_rdevs;
+	struct regulator_dev *best_rdev;
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	int n_coupled;
+	int i, best_delta, best_uV, ret = 1;
+
+	c_rdevs = c_desc->coupled_rdevs;
+	n_coupled = c_desc->n_coupled;
+
+	/*
+	 * if system is in a state other than PM_SUSPEND_ON, don't check
+	 * other coupled regulators
+	 */
+	if (state != PM_SUSPEND_ON)
+		n_coupled = 1;
+
+	/*
+	 * Find the best possible voltage change on each loop. Leave the loop
+	 * if there isn't any possible change.
+	 */
+	while (1) {
+		best_delta = 0;
+		best_uV = 0;
+		best_rdev = NULL;
+
+		/*
+		 * Find highest difference between optimal voltage
+		 * and current voltage.
+		 */
+		for (i = 0; i < n_coupled; i++) {
+			/*
+			 * optimal_uV is the best voltage that can be set for
+			 * i-th regulator at the moment without violating
+			 * max_spread constraint in order to balance
+			 * the coupled voltages.
+			 */
+			int optimal_uV, current_uV;
+
+			optimal_uV = regulator_get_optimal_voltage(c_rdevs[i]);
+			if (optimal_uV < 0) {
+				ret = optimal_uV;
+				goto out;
+			}
+
+			current_uV = _regulator_get_voltage(c_rdevs[i]);
+			if (current_uV < 0) {
+				ret = optimal_uV;
+				goto out;
+			}
+
+			if (abs(best_delta) < abs(optimal_uV - current_uV)) {
+				best_delta = optimal_uV - current_uV;
+				best_rdev = c_rdevs[i];
+				best_uV = optimal_uV;
+			}
+		}
+
+		/* Nothing to change, return successfully */
+		if (!best_rdev) {
+			ret = 0;
+			goto out;
+		}
+
+		ret = regulator_set_voltage_rdev(best_rdev, best_uV,
+						 best_uV, state);
+
+		if (ret < 0)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
 /**
  * regulator_set_voltage - set regulator output voltage
  * @regulator: regulator source
-- 
2.7.4
