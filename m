Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuAVHCA276kb6NPFWZteUDUk8PaKu0s2ZLJanOqv2xIBMe7oa4vmj9oA6iwGys8TMQG0Kgv
ARC-Seal: i=1; a=rsa-sha256; t=1521484144; cv=none;
        d=google.com; s=arc-20160816;
        b=ZgvIGezhZbIqSq+Wd5P6AHpTC6B7OvYSHj7XA1SF44xhRq42rg+rSd/JfP1CRdySQ0
         cM3AjHqDauSAXm7DOfDAkOgPa/70XkvRBd4acRV6uP1YI3sg4MHVnfRNEWfcJubI4oYI
         KxoSvqXQQAEFcT7r1LpLfpuuopFjNMkrEhMizxs9tCA0nX+Tfkz0DS5KNPKMpUTtWDlD
         XZtOSI1YKBhdFOmABgtMb3j3TQZpEabaXK34T+G9eqS+jHVP3hjFM0/OytURwYlUS1UG
         46YM2HdSeIsMkXEfGdLUaUJ0ew/w70ghV5IJ/paEJhGqFA3fAHS5f/ZNMiAS7xhBFaUP
         PIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gr7KW0rFQg3Jlwoj+Ye2B0e4+ZcjpTf2sHbpfQOMcVk=;
        b=BNjb+TB2FWMojcwWU4FxsJhaFqakIxsiG6FZRUUWHB5s2iHGlj0kdzgZUNlQTT8zbw
         YkS1CYlsxtBpjyvlcLX+FTJY4qvIursnN+cc8bgAIwmvWjdDac96yh1D8izV0gbAZOn5
         oOcGoNmc8bgB3De8rN2FFgBOIMfflKywFo0XsHgrDtCFrPVb850Ptz+prtIyK+h7acex
         5EmTOpTQwLRV+y8AfcAY+cgV/jsW536xJm0i3ozg4FJctzH+KHsq6Pg6MrRaQ2wBdD3G
         tHG2SnD9y6XYFhLIpEb+x8zh1rcBlGHVeyyOmBoE9Tv8uM3c9jtXHCPTitStfn9SsVyX
         WEdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 223/241] ALSA: hda - Revert power_save option default value
Date: Mon, 19 Mar 2018 19:08:08 +0100
Message-Id: <20180319180800.405889647@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391067718842348?=
X-GMAIL-MSGID: =?utf-8?q?1595391758824169571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 40088dc4e1ead7df31728c73f5b51d71da18831d upstream.

With the commit 1ba8f9d30817 ("ALSA: hda: Add a power_save
blacklist"), we changed the default value of power_save option to -1
for processing the power-save blacklist.
Unfortunately, this seems breaking user-space applications that
actually read the power_save parameter value via sysfs and judge /
adjust the power-saving status.  They see the value -1 as if the
power-save is turned off, although the actual value is taken from
CONFIG_SND_HDA_POWER_SAVE_DEFAULT and it can be a positive.

So, overall, passing -1 there was no good idea.  Let's partially
revert it -- at least for power_save option default value is restored
again to CONFIG_SND_HDA_POWER_SAVE_DEFAULT.  Meanwhile, in this patch,
we keep the blacklist behavior and make is adjustable via the new
option, pm_blacklist.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199073
Fixes: 1ba8f9d30817 ("ALSA: hda: Add a power_save blacklist")
Acked-by: Hans de Goede <hdegoede@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -180,11 +180,15 @@ static const struct kernel_param_ops par
 };
 #define param_check_xint param_check_int
 
-static int power_save = -1;
+static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
 module_param(power_save, xint, 0644);
 MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
 		 "(in second, 0 = disable).");
 
+static bool pm_blacklist = true;
+module_param(pm_blacklist, bool, 0644);
+MODULE_PARM_DESC(pm_blacklist, "Enable power-management blacklist");
+
 /* reset the HD-audio controller in power save mode.
  * this may give more power-saving, but will take longer time to
  * wake up.
@@ -2153,10 +2157,9 @@ static int azx_probe_continue(struct azx
 
 	val = power_save;
 #ifdef CONFIG_PM
-	if (val == -1) {
+	if (pm_blacklist) {
 		const struct snd_pci_quirk *q;
 
-		val = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
 		q = snd_pci_quirk_lookup(chip->pci, power_save_blacklist);
 		if (q && val) {
 			dev_info(chip->card->dev, "device %04x:%04x is on the power_save blacklist, forcing power_save to 0\n",
