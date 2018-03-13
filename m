Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933924AbeCMQUN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:20:13 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47723 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932951AbeCMQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:20:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] drm/i915/pmu: avoid -Wmaybe-uninitialized warning
Date: Tue, 13 Mar 2018 17:19:31 +0100
Message-Id: <20180313161952.552083-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:u65WKnmySMO/FelMrDXo7VnOyCqGV8M3jI0/A5LNAT6pJqaUZE0
 wcUi2Wr0wQ7+FbaU3A5pcUFwLUqjd2464PjfemppuaVVIyhmTwWAAfRbE29D+O1S1KgPCZ/
 Sv1rP1MzDm9vkV5BU+nb/M5YcxKYIPoWlGLHc5U+qTcA9qhKY4BUO7lY+HouW9SAZFZmUgT
 tmZ1YGFWQ2or4DjeM2MHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cCVg6YZBdAQ=:y60Ch4LNUKUSaCE8hl3C4M
 uSPAnz02uWMQoT5WPV2Gt8kugZNS8cG6zSZOl+Sfmmm6sVbFgYZvmXd7ZDK7fWYiwVVdH52n2
 +RVqR+HGwKU4GP1b/VsyfhtwA/wEuqp+HRk+3rX0JAZpYHnGm5aN4wpOnpR9QdHTk/S6ZP/G2
 +/f2o2CDIZDtqoRxt4E54XgbtRXQ86IWaj1Esp80d0sb3yotSbpLM2mneijjLT1VJ+MbAFZfk
 ncFG6Yqa1OUg54FmF2c+WMn/roVbusU2dMNnXlvH9YJO1JNoT1H+eOVOLgLk5qXolWGIvKQv5
 jSWsvYgCRto7dlP9KlfZgW2ad7SECpOVwRdheycFjizU+TViWsldxFYLFUVuL3ZU6iOBvqjhv
 0anlHTzifYQz0nARmDmCAXYt3eAGs1nbfFFQNaO6V5WCjAEYmrhFWm+MUBi/WKOY3+0zFXWFA
 uuVZLRAXKUAQ23YJ3e2mi/hXP8X1hpC89K0T8747ag1gMso/CHJY00vllmDqqBTMHbrA7pdhd
 Eiu0w5T4oNpvcDhvBEkRXikQQFmGe0qAuYUHkJSGrL70GWlnSByMuvJod/iijyzpEUhrQhhfy
 caO6q3xirPN7RHAOgbdfyslQrisZ0v7pOE+FROpVW1gufBIDBSfXgidGwhp79bgrFGQu2yIhe
 cSAiS082pt5Nmrynv7rUy0CZUhI1PgJahVRsaXobp7f+wllA3MXr8oNk/Tv+QfEsAFP18U9Yl
 JSo/FPGVIKlUa7FKKwc+BfNl1e4KJSgwHX/vWg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conditional spinlock confuses gcc into thinking the 'flags' value
might contain uninitialized data:

drivers/gpu/drm/i915/i915_pmu.c: In function '__i915_pmu_event_read':
arch/x86/include/asm/paravirt_types.h:573:3: error: 'flags' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The code is correct, but it's easy to see how the compiler gets confused
here. This avoids the problem by pulling the lock outside of the function
into its only caller.

Fixes: 1fe699e30113 ("drm/i915/pmu: Fix sleep under atomic in RC6 readout")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: removed unused function argument, fixed 'break' statement.
---
 drivers/gpu/drm/i915/i915_pmu.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 4bc7aefa9541..d6b9b6b5fb98 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -412,10 +412,9 @@ static u64 __get_rc6(struct drm_i915_private *i915)
 	return val;
 }
 
-static u64 get_rc6(struct drm_i915_private *i915, bool locked)
+static u64 get_rc6(struct drm_i915_private *i915)
 {
 #if IS_ENABLED(CONFIG_PM)
-	unsigned long flags;
 	u64 val;
 
 	if (intel_runtime_pm_get_if_in_use(i915)) {
@@ -428,18 +427,12 @@ static u64 get_rc6(struct drm_i915_private *i915, bool locked)
 		 * previously.
 		 */
 
-		if (!locked)
-			spin_lock_irqsave(&i915->pmu.lock, flags);
-
 		if (val >= i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur) {
 			i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = 0;
 			i915->pmu.sample[__I915_SAMPLE_RC6].cur = val;
 		} else {
 			val = i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur;
 		}
-
-		if (!locked)
-			spin_unlock_irqrestore(&i915->pmu.lock, flags);
 	} else {
 		struct pci_dev *pdev = i915->drm.pdev;
 		struct device *kdev = &pdev->dev;
@@ -452,9 +445,6 @@ static u64 get_rc6(struct drm_i915_private *i915, bool locked)
 		 * on top of the last known real value, as the approximated RC6
 		 * counter value.
 		 */
-		if (!locked)
-			spin_lock_irqsave(&i915->pmu.lock, flags);
-
 		spin_lock_irqsave(&kdev->power.lock, flags2);
 
 		if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
@@ -470,9 +460,6 @@ static u64 get_rc6(struct drm_i915_private *i915, bool locked)
 		val = jiffies_to_nsecs(val);
 		val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
 		i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
-
-		if (!locked)
-			spin_unlock_irqrestore(&i915->pmu.lock, flags);
 	}
 
 	return val;
@@ -519,7 +506,15 @@ static u64 __i915_pmu_event_read(struct perf_event *event, bool locked)
 			val = count_interrupts(i915);
 			break;
 		case I915_PMU_RC6_RESIDENCY:
-			val = get_rc6(i915, locked);
+			if (!locked) {
+				unsigned long flags;
+
+				spin_lock_irqsave(&i915->pmu.lock, flags);
+				val = get_rc6(i915);
+				spin_unlock_irqrestore(&i915->pmu.lock, flags);
+			} else {
+				val = get_rc6(i915);
+			}
 			break;
 		}
 	}
-- 
2.9.0
