Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753547AbeC1OVX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:21:23 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40003 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbeC1OVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:21:21 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hans de Goede <hdegoede@redhat.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Libin Yang <libin.yang@intel.com>, Lukas Wunner <lukas@wunner.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda_intel: mark PM functions as __maybe_unused
Date: Wed, 28 Mar 2018 16:19:29 +0200
Message-Id: <20180328142020.3275989-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:AA5en+CPEumnR4cgwSMlk5BL3HjrGHLOFueRuZ/A6LHFbZEW9C/
 pbHYndzS9x9NCI83wwiQpSlhz+mZh4uyVAJDAhuI3oK+I9RS0lWwf78BZsH0PrG/hdnZAx3
 deGI+G6Y/vbwiOGgWxRbwTXg8bJlNB5XEynV2rj6SgOeEICdaImvSOl+GqBb/+CwMJ1/Hjs
 jvVEFGrn9rNKYaKzTvv5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5D8wCD9REFk=:qlGfaUfxAPe5gPUjXhdXpP
 uOY43WEzUH9NwV8clQh2Qg59bYZR29pCM6+ZjdjNkZc2myPt+AArEqeaUnqaQa4kJ2hTKyLqM
 V52YS+dOlM2J8r56E1SFVPSL20/tVFjBnVaHPDLLe9SWmaYo/QiihCzEYTBvM/v0s5J3j8i2X
 8mnT+tO23eRm5FUWAoj6c540+vFTlwDiAdlIBmR67+7bH5DgOlF6WsG4gYpnyUKEjQmN66IPI
 cXrTm45lB9dqhYnbQ+KRgjOtiTrSvQchahAXDptrD8BmhHTCAQNuLwsLN5l9C24Pf9X6ZS1wm
 usaCa9kB8OEdOL9y5s/sqnt6R2RAj4SSxrrYGtsjv/8q7zgtxJnaJLJpI3dFVqYqwDbj8yDfv
 u2YKRbf1MNl7AyrKkhgy2DsKHFKV//rW6ehs+E2oIS4VRndioxkAaV2GZCDRn5jVDxETYM9AE
 4DaTkQcbpn25Y9LSzPYcYLqwRHA2/r21yFttnvHV2F7YzO4wuH8Ix+UlbZCIm0n9BB6VYyyZX
 8caXAIHo4vvCAh5DNubSVZJepmyqIF6axWZ4Qc8pbVGpmRSrhFy7x0hUgiOfzGKvSfanutcKk
 EylXhrvHFmpm7zsSzCNiw+AhdQZD6Y4KiznobTnjT2iH6xJ/JOqGV0w2DLmp7ZbxdKCWWL4cp
 3kNChpE1yw9cRlaTMN/RvldJERopf1sfIv11UiYLndYoHucOiLntEMQCyqsUAHDe2haQMpx1q
 8+VCwfZh35gNbcBtOA0SMGIzaF9P6L891iDXvQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two callsites of azx_suspend/azx_resume were removed, leaving these
functions only called from the optional SET_SYSTEM_SLEEP_PM_OPS()
and causing a warning without CONFIG_PM_SLEEP:

sound/pci/hda/hda_intel.c:1029:12: error: 'azx_resume' defined but not used [-Werror=unused-function]
 static int azx_resume(struct device *dev)
            ^~~~~~~~~~
sound/pci/hda/hda_intel.c:994:12: error: 'azx_suspend' defined but not used [-Werror=unused-function]
 static int azx_suspend(struct device *dev)
            ^~~~~~~~~~~

Keeping track of the correct #ifdef checks is hard, so this removes
all the #ifdefs for power management in this file and instead uses
__maybe_unused annotations that let the compiler do the job right
by itself.

Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/hda/hda_intel.c       | 52 +++++++++++++++++------------------------
 sound/pci/hda/hda_intel_trace.h |  2 --
 2 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 087c4d861c6e..01a96972d191 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -198,7 +198,9 @@ static bool power_save_controller = 1;
 module_param(power_save_controller, bool, 0644);
 MODULE_PARM_DESC(power_save_controller, "Reset controller in power save mode.");
 #else
-#define power_save	0
+#define power_save		0
+#define power_save_controller	0
+#define pm_blacklist		0
 #endif /* CONFIG_PM */
 
 static int align_buffer_size = -1;
@@ -941,13 +943,16 @@ static unsigned int azx_get_pos_skl(struct azx *chip, struct azx_dev *azx_dev)
 	return azx_get_pos_posbuf(chip, azx_dev);
 }
 
-#ifdef CONFIG_PM
 static DEFINE_MUTEX(card_list_lock);
 static LIST_HEAD(card_list);
 
 static void azx_add_card_list(struct azx *chip)
 {
 	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
+
+	if (!IS_ENABLED(CONFIG_PM))
+		return;
+
 	mutex_lock(&card_list_lock);
 	list_add(&hda->list, &card_list);
 	mutex_unlock(&card_list_lock);
@@ -956,13 +961,17 @@ static void azx_add_card_list(struct azx *chip)
 static void azx_del_card_list(struct azx *chip)
 {
 	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
+
+	if (!IS_ENABLED(CONFIG_PM))
+		return;
+
 	mutex_lock(&card_list_lock);
 	list_del_init(&hda->list);
 	mutex_unlock(&card_list_lock);
 }
 
 /* trigger power-save check at writing parameter */
-static int param_set_xint(const char *val, const struct kernel_param *kp)
+static int __maybe_unused param_set_xint(const char *val, const struct kernel_param *kp)
 {
 	struct hda_intel *hda;
 	struct azx *chip;
@@ -982,16 +991,11 @@ static int param_set_xint(const char *val, const struct kernel_param *kp)
 	mutex_unlock(&card_list_lock);
 	return 0;
 }
-#else
-#define azx_add_card_list(chip) /* NOP */
-#define azx_del_card_list(chip) /* NOP */
-#endif /* CONFIG_PM */
 
-#if defined(CONFIG_PM_SLEEP) || defined(SUPPORT_VGA_SWITCHEROO)
 /*
  * power management
  */
-static int azx_suspend(struct device *dev)
+static int __maybe_unused azx_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip;
@@ -1026,7 +1030,7 @@ static int azx_suspend(struct device *dev)
 	return 0;
 }
 
-static int azx_resume(struct device *dev)
+static int __maybe_unused azx_resume(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
@@ -1068,13 +1072,11 @@ static int azx_resume(struct device *dev)
 	trace_azx_resume(chip);
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP || SUPPORT_VGA_SWITCHEROO */
 
-#ifdef CONFIG_PM_SLEEP
 /* put codec down to D3 at hibernation for Intel SKL+;
  * otherwise BIOS may still access the codec and screw up the driver
  */
-static int azx_freeze_noirq(struct device *dev)
+static int __maybe_unused azx_freeze_noirq(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
@@ -1086,7 +1088,7 @@ static int azx_freeze_noirq(struct device *dev)
 	return 0;
 }
 
-static int azx_thaw_noirq(struct device *dev)
+static int __maybe_unused azx_thaw_noirq(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
@@ -1097,10 +1099,8 @@ static int azx_thaw_noirq(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
-static int azx_runtime_suspend(struct device *dev)
+static int __maybe_unused azx_runtime_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip;
@@ -1132,7 +1132,7 @@ static int azx_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int azx_runtime_resume(struct device *dev)
+static int __maybe_unused azx_runtime_resume(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip;
@@ -1185,7 +1185,7 @@ static int azx_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int azx_runtime_idle(struct device *dev)
+static int __maybe_unused azx_runtime_idle(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip;
@@ -1215,12 +1215,6 @@ static const struct dev_pm_ops azx_pm = {
 	SET_RUNTIME_PM_OPS(azx_runtime_suspend, azx_runtime_resume, azx_runtime_idle)
 };
 
-#define AZX_PM_OPS	&azx_pm
-#else
-#define AZX_PM_OPS	NULL
-#endif /* CONFIG_PM */
-
-
 static int azx_probe_continue(struct azx *chip);
 
 #ifdef SUPPORT_VGA_SWITCHEROO
@@ -2199,7 +2193,6 @@ static int azx_probe(struct pci_dev *pci,
 	return err;
 }
 
-#ifdef CONFIG_PM
 /* On some boards setting power_save to a non 0 value leads to clicking /
  * popping sounds when ever we enter/leave powersaving mode. Ideally we would
  * figure out how to avoid these sounds, but that is not always feasible.
@@ -2215,7 +2208,6 @@ static struct snd_pci_quirk power_save_blacklist[] = {
 	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
 	{}
 };
-#endif /* CONFIG_PM */
 
 /* number of codec slots for each chipset: 0 = default slots (i.e. 4) */
 static unsigned int azx_max_codecs[AZX_NUM_DRIVERS] = {
@@ -2313,8 +2305,7 @@ static int azx_probe_continue(struct azx *chip)
 	azx_add_card_list(chip);
 
 	val = power_save;
-#ifdef CONFIG_PM
-	if (pm_blacklist) {
+	if (IS_ENABLED(CONFIG_PM) && pm_blacklist) {
 		const struct snd_pci_quirk *q;
 
 		q = snd_pci_quirk_lookup(chip->pci, power_save_blacklist);
@@ -2324,7 +2315,6 @@ static int azx_probe_continue(struct azx *chip)
 			val = 0;
 		}
 	}
-#endif /* CONFIG_PM */
 
 	/*
 	 * The discrete GPU cannot power down unless the HDA controller runtime
@@ -2671,7 +2661,7 @@ static struct pci_driver azx_driver = {
 	.remove = azx_remove,
 	.shutdown = azx_shutdown,
 	.driver = {
-		.pm = AZX_PM_OPS,
+		.pm = &azx_pm,
 	},
 };
 
diff --git a/sound/pci/hda/hda_intel_trace.h b/sound/pci/hda/hda_intel_trace.h
index 73a7adfa192d..2775fa81a500 100644
--- a/sound/pci/hda/hda_intel_trace.h
+++ b/sound/pci/hda/hda_intel_trace.h
@@ -34,7 +34,6 @@ DEFINE_EVENT(hda_pm, azx_resume,
 	TP_ARGS(chip)
 );
 
-#ifdef CONFIG_PM
 DEFINE_EVENT(hda_pm, azx_runtime_suspend,
 	TP_PROTO(struct azx *chip),
 	TP_ARGS(chip)
@@ -44,7 +43,6 @@ DEFINE_EVENT(hda_pm, azx_runtime_resume,
 	TP_PROTO(struct azx *chip),
 	TP_ARGS(chip)
 );
-#endif
 
 #endif /* _TRACE_HDA_INTEL_H */
 
-- 
2.9.0
