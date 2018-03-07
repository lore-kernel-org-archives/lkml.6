Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuENHr96Q7Xw2AdZ53zajuzDx6Vyqixt4296NQvYiRXCmJkzJNYidy2pUsr5BC3cXxlWRnx
ARC-Seal: i=1; a=rsa-sha256; t=1520451920; cv=none;
        d=google.com; s=arc-20160816;
        b=p+jkgw75LgqnQTu4DVKk4iKyeT/Nu7x3VqJIPyTaeojjKg6CYOMIXmWDNx/qhLSdoc
         EHs96h1YCHS3AojdL5mJ7i42UgbTkYU5caAy9z5YjkxEJXUgE4HAaAWxTlq7f1yrAEzE
         8SJN/wdr0HI8lU0+sh0T1v8nR86KTqZAHtP31/00+zUF5Ey/Mv8x3hAwwd3Tmjvu8WMw
         8m4IeDFWpC2JKrdVGMlffftDOT8EzQvyVEc/6kMuG1AdwEmys3q1CfVyI5SdriLUNmTd
         t6iJn0jZro/kdxrdWWUu0Br7SF2l7H6XtShCIpo7Si9WJ/OQ4MKoVOrJSsjK2ehlKMr3
         THCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u9uhnggtGACh2qOcRDwgLE6w0K/szulS2M1aOgD7E1U=;
        b=DE13duEUd/ACXXFKWVbuv7yBtQVUbnSiJ6cmmtXoB18jrgMcC15qwj5sRuDeCK3Bif
         53Wgo1MhF6H9V5iLslt5Ijztdya6Q6ArN6dhvEOpqqrr6KiXlrHqH+fVMee0KqRUsel2
         Pjsfo2e5YIQmYTvc0PudNudUS6+OChgGD2IdXsxo1LAsA27eYqYAiL57+mMGYAgE+V28
         +cdYLT+cOqH/Nemv5po7CP22KMJI6Nh33K8+E6aLnlD0q0RBzUhq+pF9mQYUcKmnE7wu
         DDwAwlR45LXRXu8hISBECPTrGm/B5IBCcZznQhFeUp5fbJh0wtPaf+mU698TqXJ74TME
         qCBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 013/110] ALSA: hda: Add a power_save blacklist
Date: Wed,  7 Mar 2018 11:37:56 -0800
Message-Id: <20180307191041.443023164@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309056556553398?=
X-GMAIL-MSGID: =?utf-8?q?1594309393885317000?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 1ba8f9d308174e647b864c36209b4d7934d99888 upstream.

On some boards setting power_save to a non 0 value leads to clicking /
popping sounds when ever we enter/leave powersaving mode. Ideally we would
figure out how to avoid these sounds, but that is not always feasible.

This commit adds a blacklist for devices where powersaving is known to
cause problems and disables it on these devices.

Note I tried to put this blacklist in userspace first:
https://github.com/systemd/systemd/pull/8128

But the systemd maintainers rightfully pointed out that it would be
impossible to then later remove entries once we actually find a way to
make power-saving work on listed boards without issues. Having this list
in the kernel will allow removal of the blacklist entry in the same commit
which fixes the clicks / plops.

The blacklist only applies to the default power_save module-option value,
if a user explicitly sets the module-option then the blacklist is not
used.

[ added an ifdef CONFIG_PM for the build error -- tiwai]

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1525104
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=198611
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |   38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -181,7 +181,7 @@ static const struct kernel_param_ops par
 };
 #define param_check_xint param_check_int
 
-static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
+static int power_save = -1;
 module_param(power_save, xint, 0644);
 MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
 		 "(in second, 0 = disable).");
@@ -2186,6 +2186,24 @@ out_free:
 	return err;
 }
 
+#ifdef CONFIG_PM
+/* On some boards setting power_save to a non 0 value leads to clicking /
+ * popping sounds when ever we enter/leave powersaving mode. Ideally we would
+ * figure out how to avoid these sounds, but that is not always feasible.
+ * So we keep a list of devices where we disable powersaving as its known
+ * to causes problems on these devices.
+ */
+static struct snd_pci_quirk power_save_blacklist[] = {
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
+	SND_PCI_QUIRK(0x1849, 0x0c0c, "Asrock B85M-ITX", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
+	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
+	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
+	{}
+};
+#endif /* CONFIG_PM */
+
 /* number of codec slots for each chipset: 0 = default slots (i.e. 4) */
 static unsigned int azx_max_codecs[AZX_NUM_DRIVERS] = {
 	[AZX_DRIVER_NVIDIA] = 8,
@@ -2198,6 +2216,7 @@ static int azx_probe_continue(struct azx
 	struct hdac_bus *bus = azx_bus(chip);
 	struct pci_dev *pci = chip->pci;
 	int dev = chip->dev_index;
+	int val;
 	int err;
 
 	hda->probe_continued = 1;
@@ -2278,7 +2297,22 @@ static int azx_probe_continue(struct azx
 
 	chip->running = 1;
 	azx_add_card_list(chip);
-	snd_hda_set_power_save(&chip->bus, power_save * 1000);
+
+	val = power_save;
+#ifdef CONFIG_PM
+	if (val == -1) {
+		const struct snd_pci_quirk *q;
+
+		val = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
+		q = snd_pci_quirk_lookup(chip->pci, power_save_blacklist);
+		if (q && val) {
+			dev_info(chip->card->dev, "device %04x:%04x is on the power_save blacklist, forcing power_save to 0\n",
+				 q->subvendor, q->subdevice);
+			val = 0;
+		}
+	}
+#endif /* CONFIG_PM */
+	snd_hda_set_power_save(&chip->bus, val * 1000);
 	if (azx_has_pm_runtime(chip) || hda->use_vga_switcheroo)
 		pm_runtime_put_autosuspend(&pci->dev);
 
