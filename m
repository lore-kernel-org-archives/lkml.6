Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AIpwx4/Rqfitby5QwrVTFIu376JPgTmOZj1SHlc45SwqtGkpTcnHKy8XLF2h4mYuuZjENFF+Mu/6
ARC-Seal: i=1; a=rsa-sha256; t=1524243819; cv=none;
        d=google.com; s=arc-20160816;
        b=qipbitoz2BkuUThGK4sUEh3QHZe2knYOl3StJFy93LKk0ljkU+8f/RXFM2Bl2n7GB9
         mXh406zBC33hI01IdWl5Z7j4ib5KrXsy2WbrrFi2F98HzkJJxAsw8xl9HCbribJNRuH1
         6v4wt2/9ToCXiSbuLQMDzHZnoFoZ+m6eluM97aic+eHgN5LpQk/TLvU7kUA7y9lhvCSV
         VedeaBokGsBGs69Gb7nxgJ9yc47z8X8S4gP9r95pKf63d/B/HbI81C6fkzvq5Wk73RLk
         EmCYMGntcY+6ulqJtnxf8DHX/LfdJ3aJ0O1urUVHjzwdeey8q0IrsFCBzAssza0Kgb3t
         9CBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=9HgxRl6q1ZDJTjBVW2OSCHkLGPA30NnNW+KWsy25ulU=;
        b=MZWlKjYZExxCpM5d81y9GmFVUTsf6N5NGhhWFq/WKmJw1aXlRNCVGpMxNPAE/m3u84
         SLdBsHYtZGe0yh0crKGdOjJT3es0WQYc5R9xwiSw4Mu5AXiW6x6DrP95x4ZfKNHFkTOK
         lO2pbq8hPbc9/syf8r3ZECuFJh2ZFTJKxPOVjv8iAHvZdomgpYZKEWSydoL0mW9nvXM5
         dlhnxDXWDURrZwS0ospxCBWPMWrJBT7MJNlz4trzo3Hn/1lfiqmB9FZzvWytmEwrxvCc
         /qxt2oLBVd8hHZ9d3xDqhKyI7yB5JF48vhQkUzIJCjnJskN0bzZiCQ7Sq8SCeWASycqF
         IljA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 1/4] ALSA: usb-audio: UAC3. Add support for mixer unit.
Date: Fri, 20 Apr 2018 18:03:24 +0100
Message-Id: <20180420170327.31569-2-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285487518505397?=
X-GMAIL-MSGID: =?utf-8?q?1598285487518505397?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This adds support for the MIXER UNIT in UAC3. All the information
is obtained from the (HIGH CAPABILITY) Cluster's header. We don't
read the rest of the logical cluster to obtain the channel config
as that wont make any difference in the current mixer behaviour.

The name of the mixer unit is not yet requested as there is not
support for the UAC3 Class Specific String requests.

Tested in an UAC3 device working as a HEADSET with a basic mixer
unit (same as the one in the BADD spec) with no controls.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 include/uapi/linux/usb/audio.h | 13 +++++++--
 sound/usb/mixer.c              | 64 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
index 3a78e7145689..f9be472cd025 100644
--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -285,9 +285,16 @@ static inline __u8 uac_mixer_unit_iChannelNames(struct uac_mixer_unit_descriptor
 static inline __u8 *uac_mixer_unit_bmControls(struct uac_mixer_unit_descriptor *desc,
 					      int protocol)
 {
-	return (protocol == UAC_VERSION_1) ?
-		&desc->baSourceID[desc->bNrInPins + 4] :
-		&desc->baSourceID[desc->bNrInPins + 6];
+	switch (protocol) {
+	case UAC_VERSION_1:
+		return &desc->baSourceID[desc->bNrInPins + 4];
+	case UAC_VERSION_2:
+		return &desc->baSourceID[desc->bNrInPins + 6];
+	case UAC_VERSION_3:
+		return &desc->baSourceID[desc->bNrInPins + 2];
+	default:
+		return NULL;
+	}
 }
 
 static inline __u8 uac_mixer_unit_iMixer(struct uac_mixer_unit_descriptor *desc)
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 301ad61ed426..738ca37e6d6e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -719,6 +719,35 @@ static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm
 }
 
 /*
+ * Get logical cluster information for UAC3 devices.
+ */
+static int get_cluster_channels_v3(struct mixer_build *state, unsigned int cluster_id)
+{
+	struct uac3_cluster_header_descriptor c_header;
+	int err;
+
+	err = snd_usb_ctl_msg(state->chip->dev,
+			usb_rcvctrlpipe(state->chip->dev, 0),
+			UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
+			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+			cluster_id,
+			snd_usb_ctrl_intf(state->chip),
+			&c_header, sizeof(c_header));
+	if (err < 0)
+		goto error;
+	else if (err != sizeof(c_header)) {
+		err = -EIO;
+		goto error;
+	}
+
+	return c_header.bNrChannels;
+
+error:
+	usb_audio_err(state->chip, "cannot request logical cluster ID: %d (err: %d)\n", cluster_id, err);
+	return err;
+}
+
+/*
  * parse the source unit recursively until it reaches to a terminal
  * or a branched unit.
  */
@@ -865,6 +894,19 @@ static int check_input_term(struct mixer_build *state, int id,
 				term->name = le16_to_cpu(d->wClockSourceStr);
 				return 0;
 			}
+			case UAC3_MIXER_UNIT: {
+				struct uac_mixer_unit_descriptor *d = p1;
+				unsigned int cluster_id = le16_to_cpu(d->baSourceID[d->bNrInPins]);
+
+				err = get_cluster_channels_v3(state, cluster_id);
+				if (err < 0)
+					return err;
+
+				term->channels = err;
+				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+
+				return 0;
+			}
 			default:
 				return -ENODEV;
 			}
@@ -1801,7 +1843,7 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 				 struct usb_audio_term *iterm)
 {
 	struct usb_mixer_elem_info *cval;
-	unsigned int num_outs = uac_mixer_unit_bNrChannels(desc);
+	unsigned int num_outs;
 	unsigned int i, len;
 	struct snd_kcontrol *kctl;
 	const struct usbmix_name_map *map;
@@ -1814,6 +1856,14 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 	if (!cval)
 		return;
 
+	if (state->mixer->protocol == UAC_VERSION_3) {
+		num_outs = get_cluster_channels_v3(state,
+				le16_to_cpu(desc->baSourceID[desc->bNrInPins]));
+		if (num_outs < 0)
+			return;
+	} else /* UAC_VERSION_1/2 */
+		num_outs = uac_mixer_unit_bNrChannels(desc);
+
 	snd_usb_mixer_elem_init_std(&cval->head, state->mixer, unitid);
 	cval->control = in_ch + 1; /* based on 1 */
 	cval->val_type = USB_MIXER_S16;
@@ -1878,8 +1928,16 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
 	int input_pins, num_ins, num_outs;
 	int pin, ich, err;
 
-	if (desc->bLength < 11 || !(input_pins = desc->bNrInPins) ||
-	    !(num_outs = uac_mixer_unit_bNrChannels(desc))) {
+	if (state->mixer->protocol == UAC_VERSION_3) {
+		err = get_cluster_channels_v3(state,
+				le16_to_cpu(desc->baSourceID[desc->bNrInPins]));
+		if (err < 0)
+			return err;
+		num_outs = err;
+	} else /* UAC_VERSION_1/2 */
+		num_outs = uac_mixer_unit_bNrChannels(desc);
+
+	if (desc->bLength < 11 || !(input_pins = desc->bNrInPins) || !num_outs) {
 		usb_audio_err(state->chip,
 			      "invalid MIXER UNIT descriptor %d\n",
 			      unitid);
-- 
2.11.0
