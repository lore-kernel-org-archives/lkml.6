Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523658287; cv=none;
        d=google.com; s=arc-20160816;
        b=cEUr19Uye+70hkNEHEMGN3cb98i2e1n2+QGPuhSyDxG8yY2hcx1Vb+y/LfP9PUozsg
         VMepsaQxBIzOic2OrFj0GEIOr1SqdTlQchUroSvDxF7/1PVRUsgjcSWIvWwAhmIkBcix
         yjjAKFqs8BjkFHNTgyxsOi3A3drSUMioYgAI3w2ws0Nku+L0YNNpjMvx0EZQ+lxD6GsH
         166hxvhmkn+Ru7J8D2D8YED4tOrAEwg+ECbi0EQhue8l03fKiVKN88NTCqlPNUzGwNHo
         FY7aBElzNDt13SzN+xMDOoN0MuKKeZsZ/o4srRM7uW+3tpFOzV+VMV+nhOKS2O2OjLWX
         sgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=/xV069D5F3+/1hhAuH2OU4twEah/nX1uIBIWRlTshHg=;
        b=tNccsErqGvj9GxGCwQVcWOVyb10VK7ZxPxECm32BFRCT4l/s3A2uAURACyten0PJgL
         Xn8IQ4fIKSgv6xQXnXy56VSTmygianDl5wF8nP7FTJB0MbKWraFN+tQaVVjtH82+J477
         UqA9vKbodLuXwEJkHbXQ2cfWRHCq7gAFXY3WMqOnS9cfbTGz3f4yzJjZsEugZJCZEiuT
         94dSHDgBXNC/+1ggqmgyjnnXtShSuDvah7tvHbu9yMXG/+9dvCrpAUsR463t8c/ZeQd9
         wRWFtM2YDK9ejhmA3nQq1fbqunwl4Idyy83igObhRePZj1HaRtSeTYcWf+maABF6Rvia
         IbzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EjPu/xko;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EjPu/xko;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48bWBn2jdFTUiP+YWiE5h2tj4CqBGPfPFa43ZridKiJD/6g03MfwSNVOnXSyKnRUNwcS9vGOg==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ALSA: usb: add UAC3 BADD profiles support
Date: Sat, 14 Apr 2018 01:24:26 +0300
Message-Id: <1523658266-2259-5-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597671512160670217?=
X-GMAIL-MSGID: =?utf-8?q?1597671512160670217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Recently released USB Audio Class 3.0 specification
contains BADD (Basic Audio Device Definition) document
which describes pre-defined UAC3 configurations.

BADD support is mandatory for UAC3 devices, it should be
implemented as a separate USB device configuration.
As per BADD document, class-specific descriptors
shall not be included in the Device’s Configuration
descriptor ("inferred"), but host can guess them
from BADD profile number, number of endpoints and
their max packed sizes.

This patch adds support of all BADD profiles from the spec

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 sound/usb/card.c       |  14 +++
 sound/usb/clock.c      |   9 +-
 sound/usb/mixer.c      | 313 +++++++++++++++++++++++++++++++++++++++++++++++--
 sound/usb/mixer_maps.c |  65 ++++++++++
 sound/usb/stream.c     |  83 +++++++++++--
 sound/usb/usbaudio.h   |   2 +
 6 files changed, 466 insertions(+), 20 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 4d866bd..47ebc50 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -307,6 +307,20 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 			return -EINVAL;
 		}
 
+		if (protocol == UAC_VERSION_3) {
+			int badd = assoc->bFunctionSubClass;
+
+			if (badd != UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0 &&
+			    (badd < UAC3_FUNCTION_SUBCLASS_GENERIC_IO ||
+			     badd > UAC3_FUNCTION_SUBCLASS_SPEAKERPHONE)) {
+				dev_err(&dev->dev,
+					"Unsupported UAC3 BADD profile\n");
+				return -EINVAL;
+			}
+
+			chip->badd_profile = badd;
+		}
+
 		for (i = 0; i < assoc->bInterfaceCount; i++) {
 			int intf = assoc->bFirstInterface + i;
 
diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 0b030d8..17673f3 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -587,8 +587,15 @@ int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
 	default:
 		return set_sample_rate_v1(chip, iface, alts, fmt, rate);
 
-	case UAC_VERSION_2:
 	case UAC_VERSION_3:
+		if (chip->badd_profile >= UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
+			if (rate != UAC3_BADD_SAMPLING_RATE)
+				return -ENXIO;
+			else
+				return 0;
+		}
+	/* fall through */
+	case UAC_VERSION_2:
 		return set_sample_rate_v2v3(chip, iface, alts, fmt, rate);
 	}
 }
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 301ad61..e5c3b0d 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -112,14 +112,12 @@ enum {
 #include "mixer_maps.c"
 
 static const struct usbmix_name_map *
-find_map(struct mixer_build *state, int unitid, int control)
+find_map(const struct usbmix_name_map *p, int unitid, int control)
 {
-	const struct usbmix_name_map *p = state->map;
-
 	if (!p)
 		return NULL;
 
-	for (p = state->map; p->id; p++) {
+	for (; p->id; p++) {
 		if (p->id == unitid &&
 		    (!control || !p->control || control == p->control))
 			return p;
@@ -1333,6 +1331,76 @@ static struct usb_feature_control_info *get_feature_control_info(int control)
 	return NULL;
 }
 
+static void build_feature_ctl_badd(struct usb_mixer_interface *mixer,
+			      unsigned int ctl_mask, int control, int unitid,
+			      const struct usbmix_name_map *badd_map)
+{
+	struct usb_feature_control_info *ctl_info;
+	unsigned int len = 0;
+	struct snd_kcontrol *kctl;
+	struct usb_mixer_elem_info *cval;
+	const struct usbmix_name_map *map;
+
+	map = find_map(badd_map, unitid, control);
+	if (!map)
+		return;
+
+	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
+	if (!cval)
+		return;
+	snd_usb_mixer_elem_init_std(&cval->head, mixer, unitid);
+	cval->control = control;
+	cval->cmask = ctl_mask;
+
+	ctl_info = get_feature_control_info(control);
+	if (!ctl_info) {
+		kfree(cval);
+		return;
+	}
+	cval->val_type = ctl_info->type;
+
+	if (ctl_mask == 0) {
+		cval->channels = 1;	/* master channel */
+	} else {
+		int i, c = 0;
+
+		for (i = 0; i < 2; i++)
+			if (ctl_mask & (1 << i))
+				c++;
+		cval->channels = c;
+	}
+
+	kctl = snd_ctl_new1(&usb_feature_unit_ctl, cval);
+
+	if (!kctl) {
+		usb_audio_err(mixer->chip, "cannot malloc kcontrol\n");
+		kfree(cval);
+		return;
+	}
+	kctl->private_free = snd_usb_mixer_elem_free;
+	len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
+
+	append_ctl_name(kctl, control == UAC_FU_MUTE ? " Switch" : " Volume");
+
+	/* get min/max values */
+	get_min_max_with_quirks(cval, 0, kctl);
+
+	if (control == UAC_FU_VOLUME) {
+		check_mapped_dB(map, cval);
+		if (cval->dBmin < cval->dBmax || !cval->initialized) {
+			kctl->tlv.c = snd_usb_mixer_vol_tlv;
+			kctl->vd[0].access |=
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+				SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+		}
+	}
+
+	usb_audio_dbg(mixer->chip, "[%d] FU [%s] ch = %d, val = %d/%d/%d\n",
+		      cval->head.id, kctl->id.name, cval->channels,
+		      cval->min, cval->max, cval->res);
+	snd_usb_mixer_add_control(&cval->head, kctl);
+}
+
 static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 			      unsigned int ctl_mask, int control,
 			      struct usb_audio_term *iterm, int unitid,
@@ -1353,7 +1421,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 		return;
 	}
 
-	map = find_map(state, unitid, control);
+	map = find_map(state->map, unitid, control);
 	if (check_ignored_ctl(map))
 		return;
 
@@ -1806,7 +1874,7 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 	struct snd_kcontrol *kctl;
 	const struct usbmix_name_map *map;
 
-	map = find_map(state, unitid, 0);
+	map = find_map(state->map, unitid, 0);
 	if (check_ignored_ctl(map))
 		return;
 
@@ -2105,7 +2173,7 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 
 		if (!(controls[valinfo->control / 8] & (1 << ((valinfo->control % 8) - 1))))
 			continue;
-		map = find_map(state, unitid, valinfo->control);
+		map = find_map(state->map, unitid, valinfo->control);
 		if (check_ignored_ctl(map))
 			continue;
 		cval = kzalloc(sizeof(*cval), GFP_KERNEL);
@@ -2308,7 +2376,7 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	if (desc->bNrInPins == 1) /* only one ? nonsense! */
 		return 0;
 
-	map = find_map(state, unitid, 0);
+	map = find_map(state->map, unitid, 0);
 	if (check_ignored_ctl(map))
 		return 0;
 
@@ -2495,6 +2563,226 @@ static int snd_usb_mixer_dev_free(struct snd_device *device)
 }
 
 /*
+ * create mixer controls for UAC3 BADD profiles
+ *
+ * UAC3 BADD device doesn't contain CS descriptors thus we will guess everything
+ *
+ * BADD device may contain Mixer Unit, which doesn't have any controls, skip it
+ */
+static int snd_usb_mixer_controls_badd(struct usb_mixer_interface *mixer,
+				       int ctrlif)
+{
+	struct usb_device *dev = mixer->chip->dev;
+	struct usb_interface_assoc_descriptor *assoc;
+	int badd_profile = mixer->chip->badd_profile;
+	const struct usbmix_ctl_map *map;
+	int p_chmask = 0, c_chmask = 0, st_chmask = 0;
+	int i;
+
+	assoc = usb_ifnum_to_if(dev, ctrlif)->intf_assoc;
+
+	/* Detect BADD capture/playback channels from AS EP descriptors */
+	for (i = 0; i < assoc->bInterfaceCount; i++) {
+		int intf = assoc->bFirstInterface + i;
+
+		if (intf != ctrlif) {
+			struct usb_interface *iface;
+			struct usb_host_interface *alts;
+			struct usb_interface_descriptor *altsd;
+			unsigned int maxpacksize;
+			char dir_in;
+			int chmask, num;
+
+			iface = usb_ifnum_to_if(dev, intf);
+			num = iface->num_altsetting;
+
+			if (num < 2)
+				return -EINVAL;
+
+			/*
+			 * The number of Channels in an AudioStreaming interface
+			 * and the audio sample bit resolution (16 bits or 24
+			 * bits) can be derived from the wMaxPacketSize field in
+			 * the Standard AS Audio Data Endpoint descriptor in
+			 * Alternate Setting 1
+			 */
+			alts = &iface->altsetting[1];
+			altsd = get_iface_desc(alts);
+
+			if (altsd->bNumEndpoints < 1)
+				return -EINVAL;
+
+			/* check direction */
+			dir_in = (get_endpoint(alts, 0)->bEndpointAddress & USB_DIR_IN);
+			maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+
+			switch (maxpacksize) {
+			default:
+				usb_audio_err(mixer->chip,
+					"incorrect wMaxPacketSize 0x%x for BADD profile\n",
+					maxpacksize);
+				return -EINVAL;
+			case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_16:
+			case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_16:
+			case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_24:
+			case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_24:
+				chmask = 1;
+				break;
+			case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_16:
+			case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_16:
+			case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_24:
+			case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_24:
+				chmask = 3;
+				break;
+			}
+
+			if (dir_in)
+				c_chmask = chmask;
+			else
+				p_chmask = chmask;
+		}
+	}
+
+	usb_audio_dbg(mixer->chip,
+		"UAC3 BADD profile 0x%x: detected c_chmask=%d p_chmask=%d\n",
+		badd_profile, c_chmask, p_chmask);
+
+	/* check the mapping table */
+	for (map = uac3_badd_usbmix_ctl_maps; map->id; map++) {
+		if (map->id == badd_profile) {
+			mixer->ignore_ctl_error = map->ignore_ctl_error;
+			break;
+		}
+	}
+
+	if (!map->id)
+		return -EINVAL;
+
+	switch (badd_profile) {
+	default:
+		return -EINVAL;
+	case UAC3_FUNCTION_SUBCLASS_GENERIC_IO:
+		/*
+		 * BAIF, BAOF or combination of both
+		 * IN: Mono or Stereo cfg, Mono alt possible
+		 * OUT: Mono or Stereo cfg, Mono alt possible
+		 */
+		/* c_chmask := DYNAMIC */
+		/* p_chmask := DYNAMIC */
+		if (!c_chmask && !p_chmask) {
+			usb_audio_err(mixer->chip,
+				"BADD GENERIC_IO profile: no channels?\n");
+			return -EINVAL;
+		}
+		break;
+	case UAC3_FUNCTION_SUBCLASS_HEADPHONE:
+		/* BAOF; Stereo only cfg, Mono alt possible */
+		if (p_chmask != 3)
+			usb_audio_warn(mixer->chip,
+				"BADD HEADPHONE p_chmask mismatch: expected 3 actual %d\n",
+				p_chmask);
+		p_chmask = 3;
+		break;
+	case UAC3_FUNCTION_SUBCLASS_SPEAKER:
+		/* BAOF; Mono or Stereo cfg, Mono alt possible */
+		/* p_chmask := DYNAMIC */
+		if (!p_chmask) {
+			usb_audio_err(mixer->chip,
+				"BADD SPEAKER profile: no playback channels?\n");
+			return -EINVAL;
+		}
+		break;
+	case UAC3_FUNCTION_SUBCLASS_MICROPHONE:
+		/* BAIF; Mono or Stereo cfg, Mono alt possible */
+		/* c_chmask := DYNAMIC */
+		if (!c_chmask) {
+			usb_audio_err(mixer->chip,
+				"BADD MICROPHONE profile: no capture channels?\n");
+			return -EINVAL;
+		}
+		break;
+	case UAC3_FUNCTION_SUBCLASS_HEADSET:
+		/*
+		 * BAIOF
+		 * IN: Mono only
+		 * OUT: Mono or Stereo cfg, Mono alt possible
+		 */
+		if (c_chmask != 1)
+			usb_audio_warn(mixer->chip,
+				"BADD HEADSET c_chmask mismatch: expected 1 actual %d\n",
+				c_chmask);
+		c_chmask = 1;
+		st_chmask = 1;
+		/* p_chmask := DYNAMIC */
+		if (!p_chmask) {
+			usb_audio_err(mixer->chip,
+				"BADD HEADSET profile: no playback channels?\n");
+			return -EINVAL;
+		}
+		break;
+	case UAC3_FUNCTION_SUBCLASS_HEADSET_ADAPTER:
+		/* BAIOF; IN: Mono only; OUT: Stereo only, Mono alt possible */
+		if (c_chmask != 1)
+			usb_audio_warn(mixer->chip,
+				"BADD HEADSET_ADAPTER c_chmask mismatch: expected 1 actual %d\n",
+				c_chmask);
+		if (p_chmask != 3)
+			usb_audio_warn(mixer->chip,
+				"BADD HEADSET_ADAPTER p_chmask mismatch: expected 3 actual %d\n",
+				p_chmask);
+		c_chmask = 1;
+		st_chmask = 1;
+		p_chmask = 3;
+		break;
+	case UAC3_FUNCTION_SUBCLASS_SPEAKERPHONE:
+		/* BAIF + BAOF; IN: Mono only; OUT: Mono only */
+		if (c_chmask != 1)
+			usb_audio_warn(mixer->chip,
+				"BADD SPEAKERPHONE c_chmask mismatch: expected 1 actual %d\n",
+				c_chmask);
+		if (p_chmask != 1)
+			usb_audio_warn(mixer->chip,
+				"BADD SPEAKERPHONE p_chmask mismatch: expected 1 actual %d\n",
+				p_chmask);
+		c_chmask = 1;
+		p_chmask = 1;
+		break;
+	}
+
+	/* Playback */
+	if (p_chmask) {
+		/* Master channel, always writable */
+		build_feature_ctl_badd(mixer, 0, UAC_FU_MUTE,
+				       UAC3_BADD_FU_ID2, map->map);
+		/* Mono/Stereo volume channels, always writable */
+		build_feature_ctl_badd(mixer, p_chmask, UAC_FU_VOLUME,
+				       UAC3_BADD_FU_ID2, map->map);
+	}
+
+	/* Capture */
+	if (c_chmask) {
+		/* Master channel, always writable */
+		build_feature_ctl_badd(mixer, 0, UAC_FU_MUTE,
+				       UAC3_BADD_FU_ID5, map->map);
+		/* Mono/Stereo volume channels, always writable */
+		build_feature_ctl_badd(mixer, c_chmask, UAC_FU_VOLUME,
+				       UAC3_BADD_FU_ID5, map->map);
+	}
+
+	/* Side tone-mixing */
+	if (st_chmask) {
+		/* Master channel, always writable */
+		build_feature_ctl_badd(mixer, 0, UAC_FU_MUTE,
+				       UAC3_BADD_FU_ID7, map->map);
+		/* Mono volume channel, always writable */
+		build_feature_ctl_badd(mixer, 1, UAC_FU_VOLUME,
+				       UAC3_BADD_FU_ID7, map->map);
+	}
+
+	return 0;
+}
+
+/*
  * create mixer controls
  *
  * walk through all UAC_OUTPUT_TERMINAL descriptors to search for mixers
@@ -2838,9 +3126,14 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 		break;
 	}
 
-	if ((err = snd_usb_mixer_controls(mixer)) < 0 ||
-	    (err = snd_usb_mixer_status_create(mixer)) < 0)
+	if (mixer->protocol == UAC_VERSION_3 &&
+			chip->badd_profile >= UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
+		if ((err = snd_usb_mixer_controls_badd(mixer, ctrlif)) < 0)
+			goto _error;
+	} else if ((err = snd_usb_mixer_controls(mixer)) < 0 ||
+			(err = snd_usb_mixer_status_create(mixer)) < 0) {
 		goto _error;
+	}
 
 	snd_usb_mixer_apply_create_quirk(mixer);
 
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 9038b2e..13f03c8 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -482,3 +482,68 @@ struct usbmix_ctl_map {
 	{ 0 } /* terminator */
 };
 
+/*
+ * Control map entries for UAC3 BADD profiles
+ */
+
+static struct usbmix_name_map uac3_badd_generic_io_map[] = {
+	{ UAC3_BADD_FU_ID2, "Generic Out Playback" },
+	{ UAC3_BADD_FU_ID5, "Generic In Capture" },
+	{ 0 }					/* terminator */
+};
+static struct usbmix_name_map uac3_badd_headphone_map[] = {
+	{ UAC3_BADD_FU_ID2, "Headphone Playback" },
+	{ 0 }					/* terminator */
+};
+static struct usbmix_name_map uac3_badd_speaker_map[] = {
+	{ UAC3_BADD_FU_ID2, "Speaker Playback" },
+	{ 0 }					/* terminator */
+};
+static struct usbmix_name_map uac3_badd_microphone_map[] = {
+	{ UAC3_BADD_FU_ID5, "Mic Capture" },
+	{ 0 }					/* terminator */
+};
+/* Covers also 'headset adapter' profile */
+static struct usbmix_name_map uac3_badd_headset_map[] = {
+	{ UAC3_BADD_FU_ID2, "Headset Playback" },
+	{ UAC3_BADD_FU_ID5, "Headset Capture" },
+	{ UAC3_BADD_FU_ID7, "Side Tone Mixing" },
+	{ 0 }					/* terminator */
+};
+static struct usbmix_name_map uac3_badd_speakerphone_map[] = {
+	{ UAC3_BADD_FU_ID2, "Speaker Playback" },
+	{ UAC3_BADD_FU_ID5, "Mic Capture" },
+	{ 0 }					/* terminator */
+};
+
+static struct usbmix_ctl_map uac3_badd_usbmix_ctl_maps[] = {
+	{
+		.id = UAC3_FUNCTION_SUBCLASS_GENERIC_IO,
+		.map = uac3_badd_generic_io_map,
+	},
+	{
+		.id = UAC3_FUNCTION_SUBCLASS_HEADPHONE,
+		.map = uac3_badd_headphone_map,
+	},
+	{
+		.id = UAC3_FUNCTION_SUBCLASS_SPEAKER,
+		.map = uac3_badd_speaker_map,
+	},
+	{
+		.id = UAC3_FUNCTION_SUBCLASS_MICROPHONE,
+		.map = uac3_badd_microphone_map,
+	},
+	{
+		.id = UAC3_FUNCTION_SUBCLASS_HEADSET,
+		.map = uac3_badd_headset_map,
+	},
+	{
+		.id = UAC3_FUNCTION_SUBCLASS_HEADSET_ADAPTER,
+		.map = uac3_badd_headset_map,
+	},
+	{
+		.id = UAC3_FUNCTION_SUBCLASS_SPEAKERPHONE,
+		.map = uac3_badd_speakerphone_map,
+	},
+	{ 0 } /* terminator */
+};
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 586d664..ea5a13e0 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -798,15 +798,67 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 	struct uac3_input_terminal_descriptor *input_term;
 	struct uac3_output_terminal_descriptor *output_term;
 	struct uac3_cluster_header_descriptor *cluster;
-	struct uac3_as_header_descriptor *as;
+	struct uac3_as_header_descriptor *as = NULL;
 	struct uac3_hc_descriptor_header hc_header;
 	struct snd_pcm_chmap_elem *chmap;
+	unsigned char badd_profile;
+	u64 badd_formats  = 0;
 	unsigned int num_channels;
 	struct audioformat *fp;
 	u16 cluster_id, wLength;
 	int clock = 0;
 	int err;
 
+	badd_profile = chip->badd_profile;
+
+	if (badd_profile >= UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
+		unsigned int maxpacksize =
+			le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+
+		switch (maxpacksize) {
+		default:
+			dev_err(&dev->dev,
+				"%u:%d : incorrect wMaxPacketSize for BADD profile\n",
+				iface_no, altno);
+			return NULL;
+		case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_16:
+		case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_16:
+			badd_formats = SNDRV_PCM_FMTBIT_S16_LE;
+			num_channels = 1;
+			break;
+		case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_24:
+		case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_24:
+			badd_formats = SNDRV_PCM_FMTBIT_S24_3LE;
+			num_channels = 1;
+			break;
+		case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_16:
+		case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_16:
+			badd_formats = SNDRV_PCM_FMTBIT_S16_LE;
+			num_channels = 2;
+			break;
+		case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_24:
+		case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_24:
+			badd_formats = SNDRV_PCM_FMTBIT_S24_3LE;
+			num_channels = 2;
+			break;
+		}
+
+		chmap = kzalloc(sizeof(*chmap), GFP_KERNEL);
+		if (!chmap)
+			return ERR_PTR(-ENOMEM);
+
+		if (num_channels == 1) {
+			chmap->map[0] = SNDRV_CHMAP_MONO;
+		} else {
+			chmap->map[0] = SNDRV_CHMAP_FL;
+			chmap->map[1] = SNDRV_CHMAP_FR;
+		}
+
+		chmap->channels = num_channels;
+		clock = UAC3_BADD_CS_ID9;
+		goto found_clock;
+	}
+
 	as = snd_usb_find_csint_desc(alts->extra, alts->extralen,
 				     NULL, UAC_AS_GENERAL);
 	if (!as) {
@@ -922,18 +974,31 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 	if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
 		fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
 				* (fp->maxpacksize & 0x7ff);
-	fp->attributes = parse_uac_endpoint_attributes(chip, alts,
-						       UAC_VERSION_3,
-						       iface_no);
 	fp->clock = clock;
 	fp->chmap = chmap;
 	INIT_LIST_HEAD(&fp->list);
 
-	/* ok, let's parse further... */
-	if (snd_usb_parse_audio_format_v3(chip, fp, as, stream) < 0) {
-		kfree(fp->rate_table);
-		kfree(fp);
-		return NULL;
+	if (badd_profile >= UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
+		fp->attributes = 0; /* No attributes */
+
+		fp->fmt_type = UAC_FORMAT_TYPE_I;
+		fp->formats = badd_formats;
+
+		fp->nr_rates = 0;	/* SNDRV_PCM_RATE_CONTINUOUS */
+		fp->rate_min = UAC3_BADD_SAMPLING_RATE;
+		fp->rate_max = UAC3_BADD_SAMPLING_RATE;
+		fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
+
+	} else {
+		fp->attributes = parse_uac_endpoint_attributes(chip, alts,
+							       UAC_VERSION_3,
+							       iface_no);
+		/* ok, let's parse further... */
+		if (snd_usb_parse_audio_format_v3(chip, fp, as, stream) < 0) {
+			kfree(fp->rate_table);
+			kfree(fp);
+			return NULL;
+		}
 	}
 
 	return fp;
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 4d5c89a..1bb5e2c 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -49,6 +49,8 @@ struct snd_usb_audio {
 	int num_suspended_intf;
 	int sample_rate_read_error;
 
+	int badd_profile;		/* UAC3 BADD profile */
+
 	struct list_head pcm_list;	/* list of pcm streams */
 	struct list_head ep_list;	/* list of audio-related endpoints */
 	int pcm_devs;
-- 
1.9.1
