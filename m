Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137C5C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 22:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15AB20842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 22:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15AB20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbeG1XlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:41:08 -0400
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:52830 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731091AbeG1XlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:41:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 23B85837F243;
        Sat, 28 Jul 2018 22:13:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: earth27_8eef74c478451
X-Filterd-Recvd-Size: 10488
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 28 Jul 2018 22:13:02 +0000 (UTC)
Message-ID: <27780ceb2056b871d746803a2ac23464396f3026.camel@perches.com>
Subject: [TRIVIAL RFC PATCH] Kconfigs - reduce use of "depends on EXPERT"
From:   Joe Perches <joe@perches.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Buesch <m@bues.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Date:   Sat, 28 Jul 2018 15:13:00 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most uses of EXPERT are in the form

	bool "something" if EXPERT

but some are

	depends on EXPERT

The difference is the the 'depends on' use makes it
easier to select the CONFIG_EXPERT option.

$ git grep "if EXPERT" -- "*/Kconfig*" | wc -l
155
$ git grep "depends on.*EXPERT" -- "*/Kconfig*" | wc -l
26

Some of the 'depends on' uses with EXPERT are more menus
or complex logic with || and can not easily be modified,
but it's perhaps reasonable to modify the simpler ones
to the "if EXPERT" form.
---
 arch/x86/Kconfig.debug                     |  3 +--
 drivers/char/Kconfig                       |  4 ++--
 drivers/gpu/drm/i915/Kconfig.debug         |  3 +--
 drivers/gpu/drm/msm/Kconfig                |  4 ++--
 drivers/net/wireless/intel/iwlwifi/Kconfig |  4 ++--
 drivers/ssb/Kconfig                        |  4 ++--
 drivers/video/fbdev/Kconfig                |  4 ++--
 init/Kconfig                               | 10 ++++------
 kernel/power/Kconfig                       |  7 +++----
 net/wireless/Kconfig                       |  3 +--
 security/Kconfig                           |  3 +--
 11 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index c6dd1d980081..f175c00c3786 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -393,8 +393,7 @@ config UNWINDER_FRAME_POINTER
 	  reliable stack trace (CONFIG_HAVE_RELIABLE_STACKTRACE).
 
 config UNWINDER_GUESS
-	bool "Guess unwinder"
-	depends on EXPERT
+	bool "Guess unwinder" if EXPERT
 	depends on !STACKDEPOT
 	---help---
 	  This option enables the "guess" unwinder for unwinding kernel stack
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index ce277ee0a28a..c1c231a32521 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -52,8 +52,8 @@ source "drivers/tty/serial/Kconfig"
 source "drivers/tty/serdev/Kconfig"
 
 config TTY_PRINTK
-	tristate "TTY driver to output user messages via printk"
-	depends on EXPERT && TTY
+	tristate "TTY driver to output user messages via printk" if EXPERT
+	depends on TTY
 	default n
 	---help---
 	  If you say Y here, the support for writing user messages (i.e.
diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index 459f8f88a34c..cbf61c0d3917 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -1,8 +1,7 @@
 config DRM_I915_WERROR
-        bool "Force GCC to throw an error instead of a warning when compiling"
+        bool "Force GCC to throw an error instead of a warning when compiling" if EXPERT
         # As this may inadvertently break the build, only allow the user
         # to shoot oneself in the foot iff they aim really hard
-        depends on EXPERT
         # We use the dependency on !COMPILE_TEST to not be enabled in
         # allmodconfig or allyesconfig configurations
         depends on !COMPILE_TEST
diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 843a9d40c05e..4fe57693005f 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -30,8 +30,8 @@ config DRM_MSM_REGISTER_LOGGING
 	  logging can be switched on via msm.reglog=y module param.
 
 config DRM_MSM_GPU_SUDO
-	bool "Enable SUDO flag on submits"
-	depends on DRM_MSM && EXPERT
+	bool "Enable SUDO flag on submits" if EXPERT
+	depends on DRM_MSM
 	default n
 	help
 	  Enable userspace that has CAP_SYS_RAWIO to submit GPU commands
diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index e5a2fc738ac3..d82d0bdd837e 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -89,8 +89,8 @@ config IWLWIFI_BCAST_FILTERING
 	  expect incoming broadcasts for their normal operations.
 
 config IWLWIFI_PCIE_RTPM
-       bool "Enable runtime power management mode for PCIe devices"
-       depends on IWLMVM && PM && EXPERT
+       bool "Enable runtime power management mode for PCIe devices" if EXPERT
+       depends on IWLMVM && PM
        help
          Say Y here to enable runtime power management for PCIe
          devices.  If enabled, the device will go into low power mode
diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
index c574dd210500..e6036784c260 100644
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -90,8 +90,8 @@ config SSB_HOST_SOC
 	  If unsure, say N
 
 config SSB_SILENT
-	bool "No SSB kernel messages"
-	depends on SSB && EXPERT
+	bool "No SSB kernel messages" if EXPERT
+	depends on SSB
 	help
 	  This option turns off all Sonics Silicon Backplane printks.
 	  Note that you won't be able to identify problems, once
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 591a13a59787..371c6c6ac414 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1076,8 +1076,8 @@ config FB_CARILLO_RANCH
 	  This driver supports the LE80578 (Carillo Ranch) board
 
 config FB_INTEL
-	tristate "Intel 830M/845G/852GM/855GM/865G/915G/945G/945GM/965G/965GM support"
-	depends on FB && PCI && X86 && AGP_INTEL && EXPERT
+	tristate "Intel 830M/845G/852GM/855GM/865G/915G/945G/945GM/965G/965GM support" if EXPERT
+	depends on FB && PCI && X86 && AGP_INTEL
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/init/Kconfig b/init/Kconfig
index 3f44cae1f88c..fe17a3261a8f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1086,9 +1086,8 @@ config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	  is used to distinguish them from label names / C identifiers.
 
 config LD_DEAD_CODE_DATA_ELIMINATION
-	bool "Dead code and data elimination (EXPERIMENTAL)"
+	bool "Dead code and data elimination (EXPERIMENTAL)" if EXPERT
 	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
-	depends on EXPERT
 	help
 	  Enable this if you want to do dead code and data elimination with
 	  the linker by compiling with -ffunction-sections -fdata-sections,
@@ -1626,8 +1625,7 @@ config SLUB
 	   a slab allocator.
 
 config SLOB
-	depends on EXPERT
-	bool "SLOB (Simple Allocator)"
+	bool "SLOB (Simple Allocator)" if EXPERT
 	help
 	   SLOB replaces the stock allocator with a drastically simpler
 	   allocator. SLOB is generally more space efficient but
@@ -1679,8 +1677,8 @@ config SLUB_CPU_PARTIAL
 	  Typically one would choose no for a realtime system.
 
 config MMAP_ALLOW_UNINITIALIZED
-	bool "Allow mmapped anonymous memory to be uninitialized"
-	depends on EXPERT && !MMU
+	bool "Allow mmapped anonymous memory to be uninitialized" if EXPERT
+	depends on !MMU
 	default n
 	help
 	  Normally, and according to the Linux spec, anonymous memory obtained
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index e880ca22c5a5..d684fcdeaa89 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -19,9 +19,8 @@ config SUSPEND_FREEZER
 	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
 
 config SUSPEND_SKIP_SYNC
-	bool "Skip kernel's sys_sync() on suspend to RAM/standby"
+	bool "Skip kernel's sys_sync() on suspend to RAM/standby" if EXPERT
 	depends on SUSPEND
-	depends on EXPERT
 	help
 	  Skip the kernel sys_sync() before freezing user processes.
 	  Some systems prefer not to pay this cost on every invocation
@@ -185,8 +184,8 @@ config PM_SLEEP_DEBUG
 	depends on PM_DEBUG && PM_SLEEP
 
 config DPM_WATCHDOG
-	bool "Device suspend/resume watchdog"
-	depends on PM_DEBUG && PSTORE && EXPERT
+	bool "Device suspend/resume watchdog" if EXPERT
+	depends on PM_DEBUG && PSTORE
 	---help---
 	  Sets up a watchdog timer to capture drivers that are
 	  locked up attempting to suspend/resume a device.
diff --git a/net/wireless/Kconfig b/net/wireless/Kconfig
index 41722046b937..50bcd75cc881 100644
--- a/net/wireless/Kconfig
+++ b/net/wireless/Kconfig
@@ -67,8 +67,7 @@ config CFG80211_DEVELOPER_WARNINGS
 
 
 config CFG80211_CERTIFICATION_ONUS
-	bool "cfg80211 certification onus"
-	depends on EXPERT
+	bool "cfg80211 certification onus" if EXPERT
 	default n
 	---help---
 	  You should disable this option unless you are both capable
diff --git a/security/Kconfig b/security/Kconfig
index afa91c6f06bb..b017771a3012 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -179,9 +179,8 @@ config HARDENED_USERCOPY_FALLBACK
 	  this setting.
 
 config HARDENED_USERCOPY_PAGESPAN
-	bool "Refuse to copy allocations that span multiple pages"
+	bool "Refuse to copy allocations that span multiple pages" if EXPERT
 	depends on HARDENED_USERCOPY
-	depends on EXPERT
 	help
 	  When a multi-page allocation is done without __GFP_COMP,
 	  hardened usercopy will reject attempts to copy it. There are,

