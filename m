Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933573AbeCMMJE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:09:04 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42593 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933497AbeCMMJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:09:02 -0400
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
Subject: [PATCH] drm/i915/pmu: avoid -Wmaybe-uninitialized warning
Date: Tue, 13 Mar 2018 13:08:29 +0100
Message-Id: <20180313120848.2658626-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:1C9NSNSxaU5N/FWz8jy8lnk6fXnxY6XUaKse+PTo0KLES56ylvw
 p+AqT5dDoee9LaW5p6Ge64fMdihWff1Z9yB2iWSVuLq7LCmtr5yMTeaIRIFF8vxOdWhkKhw
 K4vAzfdq5/uyF+tnauv5ajaiRDDL7tJcWRyzMR7dOoWAbR7iu3fZ7LT+bjsXWNqJqBWn0AE
 vI7AxxElhk+vo8ieoD/VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ax2aEcaHqPA=:C5PvGOiPe8pAJh266/fS19
 3EKLEEJ31orGyHP2V0BPS42o66jZek0SLoYIjPVqVlP2hEidQzc1hgPa8KFFq1aKvSSil347W
 mUGAgLzNp2E485VTpxBv8zaSmrNS2kdIggms8JYbeXaX9T8Mrgg1xDU2BOjJgA1XYH0iGK3JG
 pAmhvxVnL50HadG8/Rm3hPxN4RLP1/tp11pLDofkHC9a5HBFS9a2gsF9QfIEDG+2ABt47aiGq
 /zqQTZoB3jUNt6QDueUerFUFfcV9jhr7aFWHPU4AM18P/NLUHPRINDF3cpdHAg31Hc2Xp+Ujh
 kM1H0UjnNcnXToJPSzXPNFV0zqY4VZmdo7gSgaBg054GbFJ05fBryZMukQRFIMF4tn+JoHPD+
 g/DLki/v99o8RX+iiVh7HuiXTnx6FttobUIWqJLch8o+Sjv/o9C/11cEE4wLrZsdxw+iKRsTc
 JDNq1Jlk466lQ7U+5tmAg9j6Jzi1Mc/Xd1bGlL4+zQE+Ljo64ZkYkUYfSfHxgbeA9g5QINv0i
 3z0VdBzE02AQW5gpxCABYTpxgpzlZn+Kes6gmRejZ57dt4q79W8ULpJsAl2YpfOGzADWzelk6
 M1D2+3HyKnRWOY2H/dzwm5MDI9vB9iKkrntICw5ozFT1TTIqf6XdnF7KiV068HQ+fdc9tX25g
 TypPDNbeaeLZIK7duXxvliVfMg9XV6vG31ERv7+/xr1QhyELkXQhG3ENHw8+zeAMlg3sYZb/8
 l9h4DsIIbshLsIdSGk/NU94tPLsmTr9eKr2p4g==
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
 drivers/gpu/drm/i915/i915_pmu.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 4bc7aefa9541..2c8c705d1f18 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -415,7 +415,6 @@ static u64 __get_rc6(struct drm_i915_private *i915)
 static u64 get_rc6(struct drm_i915_private *i915, bool locked)
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
@@ -519,8 +506,16 @@ static u64 __i915_pmu_event_read(struct perf_event *event, bool locked)
 			val = count_interrupts(i915);
 			break;
 		case I915_PMU_RC6_RESIDENCY:
-			val = get_rc6(i915, locked);
-			break;
+			if (!locked) {
+				unsigned long flags;
+
+				spin_lock_irqsave(&i915->pmu.lock, flags);
+				val = get_rc6(i915, locked);
+				spin_unlock_irqrestore(&i915->pmu.lock, flags);
+				break;
+			} else {
+				val = get_rc6(i915, locked);
+			}
 		}
 	}
 
-- 
2.9.0
