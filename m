Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtQhPRgN2BAQbyIpz6T96kJRLxuHXK0sBGxLY6HOqyzsd7T7izKwmRXiY4WBuKkc+yOEQoy
ARC-Seal: i=1; a=rsa-sha256; t=1521484164; cv=none;
        d=google.com; s=arc-20160816;
        b=tbvJzGmbbz27U7o1oEOyB6lpMSF0shmRo4RoxP1WufsaWWXqa0gWkp3ZeE/Atgu2fX
         jYTM7Wuw89JxtJg1+2zHoC9pWCCThAIwVR2Y8TVaw4LMI4fNvZqejUR8lrK/YRSDIZf/
         A+NBSgNKHnFe/6OPK8gwWv3sfaoexzxNOAYWCI75ATByj1DN2SzjWiKcXSczqyHaBxkn
         80mnsWpEfKdEG5CfOplYwtvyGtORtfuq50Ds1DTJ5uezNjMBGHAwM5caq4X2vmepp5n5
         ESbecljANMcy0R3yCONDE8lSTZ5ofX58s89WBV0azO9PacncIHHLbZJhPagr+C7LOgX6
         wN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vBgXIMR00nQh3ewO4hOlwShre67GA2/2meRv/5uGsC0=;
        b=FjiuwsGEfhS68vnK4uNL9cRZ8N2jnwJ7ra5tmckprjOGx1zjqspTAGonR3N2GZzL/H
         XwyVDajOhXWa4kM7SA3mOaZ+XLvckz/M5hNeBfhTRXawGgTh2wGr/SIj9Q4lOvBJG/cD
         fMVH4urkh82aSjmfiDEO4qgNITm5yLYFkSM2Bj24Gaf1XAIFi3YHUPkGTCCBuDr1i6Kd
         BKdelGmVnyoLKPqmdnygBb8y9Y/aeJXW8ZnKO3gfh99un8AgR4MNmR8Y1ijuvPCQbpGd
         CEdSpRyckPvyMnzYaQwRnuIj3pYaf+7ErEm/Pwu367oJbCBGZqNVYETFfHev05wZcv02
         4ESw==
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
Subject: [PATCH 4.14 14/41] ALSA: hda - Revert power_save option default value
Date: Mon, 19 Mar 2018 19:08:14 +0100
Message-Id: <20180319180733.158794628@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391067718842348?=
X-GMAIL-MSGID: =?utf-8?q?1595391779470136198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -181,11 +181,15 @@ static const struct kernel_param_ops par
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
@@ -2300,10 +2304,9 @@ static int azx_probe_continue(struct azx
 
 	val = power_save;
 #ifdef CONFIG_PM
-	if (val == -1) {
+	if (pm_blacklist) {
 		const struct snd_pci_quirk *q;
 
-		val = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
 		q = snd_pci_quirk_lookup(chip->pci, power_save_blacklist);
 		if (q && val) {
 			dev_info(chip->card->dev, "device %04x:%04x is on the power_save blacklist, forcing power_save to 0\n",
