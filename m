Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427209AbeCBLYX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:24:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32797 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164949AbeCBIvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:51:31 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180302085129euoutp01115afb4173ca35907cbe363d5a75d4db~YDmJA9Rvz2751827518euoutp01X
X-AuditID: cbfec7f2-1c1ff70000011644-e6-5a991090ea69
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v5 4/5] regulator: core: Add voltage balancing mechanism
Date: Fri, 02 Mar 2018 09:42:48 +0100
Message-id: <1519980169-8491-5-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1519980169-8491-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7djPc7oTBGZGGaw6qG2xccZ6VoupD5+w
        Wcw/co7V4uyyg2wW3650MFlc3jWHzWLBy1ssFmuP3GW3WHr9IpNF694j7A5cHmvmrWH0mN1w
        kcVj56y77B6bVnWyefRtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGz90NrAXfbCoaPs5mbWD8
        od/FyMkhIWAisXLGH5YuRi4OIYEVjBLfjp5khnA+M0o8ONbB1MXIAVZ15EIsRHwZo8TDx5PY
        QbqFBP4zSsy6pg9SwyagJbGmPR4kLCJgI/H2xgFGkHpmgeNMEtenbmQCSQgLeEh0Lt3FDGKz
        CKhKPNzcDjaHV8BZ4v6Zm2wQF8lJ3DzXCVbDKeAi8fPBKjaQQRICS9gknly/D1XkInHoxGRm
        CFtY4tXxLewQtozE5cndLBB2tcTFr7ug6mskGm9vgKqxlvg8aQtYL7MAn8SkbdOZIZ7kleho
        E4Io8ZD40nIJaoyjxI5zZ6AhNJ1RonPqG+YJjFILGBlWMYqnlhbnpqcWG+allusVJ+YWl+al
        6yXn525iBEbv6X/HP+1g/Hop6RCjAAejEg9vxvsZUUKsiWXFlbmHGCU4mJVEeFs+AIV4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzxmnURQkJpCeWpGanphakFsFkmTg4pRoYpx6++FP/x7fl9RPL
        PyVEKzoe3XjMcrbdBatb4d/ntb7wtt39nOuc38zTVXfue524d0/5Tt3O7bq/k+/dL1O+LHXQ
        fFnfwrdG/9TmuMz7Vh92ot525ucartc8qW/77wpvNK0vVjB9+twvzub0bb/NqudMVy8uT1RT
        6xL90s1nUL2LPS/3hxzHCSWW4oxEQy3mouJEAJmzeZLaAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsVy+t/xy7oTBGZGGex+JGCxccZ6VoupD5+w
        Wcw/co7V4uyyg2wW3650MFlc3jWHzWLBy1ssFmuP3GW3WHr9IpNF694j7A5cHmvmrWH0mN1w
        kcVj56y77B6bVnWyefRtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGz90NrAXfbCoaPs5mbWD8
        od/FyMEhIWAiceRCbBcjF4eQwBJGiYmr5zN3MXICOY1MEtOOOIPUsAloSaxpjwcJiwjYSLy9
        cYARpJ5Z4CSTxJ+L6xhBEsICHhKdS3eB9bIIqEo83NzODmLzCjhL3D9zkw3ElhCQk7h5rhOs
        hlPAReLng1VsELucJRqPrmOfwMizgJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmCAbTv2
        c8sOxq53wYcYBTgYlXh4D3ycESXEmlhWXJl7iFGCg1lJhLflA1CINyWxsiq1KD++qDQntfgQ
        ozQHi5I473mDyighgfTEktTs1NSC1CKYLBMHp1QDY/6RC3fM/z7bbPDFb9ay46cjlXTlXPqS
        YiwLxb5cecKze/rxmwKHq1gN7qzx0VqVcXqfWfwGeWMm2w9NRjxlEVNjWSwiHB1WOi/bYjrj
        9TprRZnAP6xv8p5MP/XRduKGrC2zLdPZWVhfanfe/f/iSbxXLf/MKfnnLPZc/LnU4VYM748d
        Uf+V/JVYijMSDbWYi4oTAalF8TosAgAA
X-CMS-MailID: 20180302085128eucas1p1c8177a8396b555d1fb31207b1fb42b93
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180302085128eucas1p1c8177a8396b555d1fb31207b1fb42b93
X-RootMTR: 20180302085128eucas1p1c8177a8396b555d1fb31207b1fb42b93
References: <1519980169-8491-1-git-send-email-m.purski@samsung.com>
        <CGME20180302085128eucas1p1c8177a8396b555d1fb31207b1fb42b93@eucas1p1.samsung.com>
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

Coupling should be checked only if the system is in PM_SUSPEND_ON state.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f8adfe4..b24a987 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -105,6 +105,8 @@ static int _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data);
 static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV);
+static int regulator_balance_voltage(struct regulator_dev *rdev,
+				     suspend_state_t state);
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
 					  const char *supply_name);
@@ -3040,6 +3042,196 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
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
+		/*
+		 * Lock just the supply regulators, as the regulator itself
+		 * is already locked by regulator_lock_coupled().
+		 */
+		if (best_rdev->supply)
+			regulator_lock_supply(best_rdev->supply->rdev);
+
+		ret = regulator_set_voltage_rdev(best_rdev, best_uV,
+						 best_uV, state);
+		if (best_rdev->supply)
+			regulator_unlock_supply(best_rdev->supply->rdev);
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
