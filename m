Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938339AbeBUPaD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:30:03 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:42870 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938295AbeBUP36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:29:58 -0500
X-Google-Smtp-Source: AH8x227l90gbYDnuzxlKZuFqhC4vp6MhqsvEEBKDsZLba8uonwrfR9WjS4MeLA4L1ifd6LCv/phNVA==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH V2 5/7] thermal/drivers/cpu_cooling: Add idle cooling device documentation
Date: Wed, 21 Feb 2018 16:29:26 +0100
Message-Id: <1519226968-19821-6-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide some documentation for the idle injection cooling effect in
order to let people to understand the rational of the approach for the
idle injection CPU cooling device.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/thermal/cpu-idle-cooling.txt | 165 +++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 Documentation/thermal/cpu-idle-cooling.txt

diff --git a/Documentation/thermal/cpu-idle-cooling.txt b/Documentation/thermal/cpu-idle-cooling.txt
new file mode 100644
index 0000000..29fc651
--- /dev/null
+++ b/Documentation/thermal/cpu-idle-cooling.txt
@@ -0,0 +1,165 @@
+
+Situation:
+----------
+
+Under certain circumstances, the SoC reaches a temperature exceeding
+the allocated power budget or the maximum temperature limit. The
+former must be mitigated to stabilize the SoC temperature around the
+temperature control using the defined cooling devices, the latter is a
+catastrophic situation where a radical decision must be taken to
+reduce the temperature under the critical threshold, that can impact
+the performances.
+
+Another situation is when the silicon reaches a certain temperature
+which continues to increase even if the dynamic leakage is reduced to
+its minimum by clock gating the component. The runaway phenomena will
+continue with the static leakage and only powering down the component,
+thus dropping the dynamic and static leakage will allow the component
+to cool down. This situation is critical.
+
+Last but not least, the system can ask for a specific power budget but
+because of the OPP density, we can only choose an OPP with a power
+budget lower than the requested one and underuse the CPU, thus losing
+performances. In other words, one OPP under uses the CPU with a power
+lesser than the power budget and the next OPP exceed the power budget,
+an intermediate OPP could have been used if it were present.
+
+Solutions:
+----------
+
+If we can remove the static and the dynamic leakage for a specific
+duration in a controlled period, the SoC temperature will
+decrease. Acting at the idle state duration or the idle cycle
+injection period, we can mitigate the temperature by modulating the
+power budget.
+
+The Operating Performance Point (OPP) density has a great influence on
+the control precision of cpufreq, however different vendors have a
+plethora of OPP density, and some have large power gap between OPPs,
+that will result in loss of performance during thermal control and
+loss of power in other scenes.
+
+At a specific OPP, we can assume injecting idle cycle on all CPUs,
+belonging to the same cluster, with a duration greater than the
+cluster idle state target residency, we drop the static and the
+dynamic leakage for this period (modulo the energy needed to enter
+this state). So the sustainable power with idle cycles has a linear
+relation with the OPP’s sustainable power and can be computed with a
+coefficient similar to:
+
+	    Power(IdleCycle) = Coef x Power(OPP)
+
+Idle Injection:
+---------------
+
+The base concept of the idle injection is to force the CPU to go to an
+idle state for a specified time each control cycle, it provides
+another way to control CPU power and heat in addition to
+cpufreq. Ideally, if all CPUs of a cluster inject idle synchronously,
+this cluster can get into the deepest idle state and achieve minimum
+power consumption, but that will also increase system response latency
+if we inject less than cpuidle latency.
+
+     ^
+     |
+     |
+     |-------       -------       -------
+     |_______|_____|_______|_____|_______|___________
+
+      <----->
+       idle  <---->
+              running
+
+With the fixed idle injection duration, we can give a value which is
+an acceptable performance drop off or latency when we reach a specific
+temperature and we begin to mitigate by varying the Idle injection
+period.
+
+The mitigation begins with a maximum period value which decrease when
+more cooling effect is requested. When the period duration is equal to
+the idle duration, then we are in a situation the platform can’t
+dissipate the heat enough and the mitigation fails. In this case the
+situation is considered critical and there is nothing to do. The idle
+injection duration must be changed by configuration and until we reach
+the cooling effect, otherwise an additionnal cooling device must be
+used or ultimately decrease the SoC performance by dropping the
+highest OPP point of the SoC.
+
+The idle injection duration value must comply with the constraints:
+
+- It is lesser or equal to the latency we tolerate when the mitigation
+  begins. It is platform dependent and will depend on the user
+  experience, reactivity vs performance trade off we want. This value
+  should be specified.
+
+- It is greater than the idle state’s target residency we want to go
+  for thermal mitigation, otherwise we end up consuming more energy.
+
+Minimum period
+--------------
+
+The idle injection duration being fixed, it is obvious the minimum
+period can’t be lesser than that, otherwise we will be scheduling the
+idle injection task right before the idle injection duration is
+complete, so waking up the CPU to put it asleep again.
+
+Maximum period
+--------------
+
+The maximum period is the initial period when the mitigation
+begins. Theoretically when we reach the thermal trip point, we have to
+sustain a specified power for specific temperature but at this time we
+consume:
+
+ Power = Capacitance x Voltage^2 x Frequency x Utilisation
+
+... which is more than the sustainable power (or there is something
+wrong on the system setup). The ‘Capacitance’ and ‘Utilisation’ are a
+fixed value, ‘Voltage’ and the ‘Frequency’ are fixed artificially
+because we don’t want to change the OPP. We can group the
+‘Capacitance’ and the ‘Utilisation’ into a single term which is the
+‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have:
+
+ Pdyn = Cdyn x Voltage^2 x Frequency
+
+The IPA will ask us somehow to reduce our power in order to target the
+sustainable power defined in the device tree. So with the idle
+injection mechanism, we want an average power (Ptarget) resulting on
+an amount of time running at full power on a specific OPP and idle
+another amount of time. That could be put in a equation:
+
+ P(opp)target = ((trunning x (P(opp)running) + (tidle P(opp)idle)) /
+			(trunning + tidle)
+  ...
+
+ tidle = trunning x ((P(opp)running / P(opp)target) - 1)
+
+At this point if we know the running period for the CPU, that gives us
+the idle injection, we need. Alternatively if we have the idle
+injection duration, we can compute the running duration with:
+
+ trunning = tidle / ((P(opp)running / P(opp)target) - 1)
+
+Practically, if the running power is lesses than the targeted power,
+we end up with a negative time value, so obviously the equation usage
+is bound to a power reduction, hence a higher OPP is needed to have
+the running power greater than the targeted power.
+
+However, in this demonstration we ignore three aspects:
+
+ * The static leakage is not defined here, we can introduce it in the
+   equation but assuming it will be zero most of the time as it is
+   difficult to get the values from the SoC vendors
+
+ * The idle state wake up latency (or entry + exit latency) is not
+   taken into account, it must be added in the equation in order to
+   rigorously compute the idle injection
+
+ * The injected idle duration must be greater than the idle state
+   target residency, otherwise we end up consuming more energy and
+   potentially invert the mitigation effect
+
+So the final equation is:
+
+ trunning = (tidle - twakeup ) x
+		(((P(opp)dyn + P(opp)static ) - P(opp)target) / P(opp)target )
-- 
2.7.4
