Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AB8JxZoEGvrlHYwz4L7z9BjPuy1c3zGjJvylbNzurDK4mfKgHu7Ja7/IQF5GleUBE/R+46y35wQe
ARC-Seal: i=1; a=rsa-sha256; t=1524848823; cv=none;
        d=google.com; s=arc-20160816;
        b=07X+0jbMpJRNbJaKoceqeeKkfmdBNdvriWFMjx0M12QZtPz+dL8XqpWXorYzeyFiNu
         vMUZPqqUxhuzuKO//jmY6cNwUMLNbA94725bvoAkiNeZZk2fgA/M/iJvk+WEDrPUxSoB
         0UhgHW3kM6uU4w6QfCz8Elldls3IW20lGgvkT7hY7usxM3bjIXbPxR5tIXIFVQ28ipKF
         B1g1/ffWoRMrV/jrZ4Nsnvm9Nzte3sxTw2lqnWpPQu0uwZ99mCKKRSxbatGoRllk56sW
         1mUlIA6YNYgw3xKRcB2h7D4AKhn964dH0gxaJXq+b5/I438FEprn98EKdAE2eZ2lCsoz
         jWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=TQkbhXqR9i6b7OZoiAXwhcltNnqI49yJQhiZWnRq/GE=;
        b=Jr3MW+faHMyGN/+DyXHGlgFxP/o8RGBOiSGh5dVjmTx61pAeZGRP2IOrSnFODqKJ48
         G+U3GwcgHIBIzMuRoybFyyMuWr8u6XCm8nriji0BN7/EXdNlmWnTOFxQmaf2/0RM6Zkf
         xVrO+HNly7DFCrCpcSZBn1hSxMpXr1tOVRHVmHsrJw0JC1UYFqdkqKobAI46HdSYkgxc
         c9hcrhmx9VMWhBJ3LVWvHFGkjwG0rdrITcqXEYWXepfXGohzCyQ8gq0DF9VFFs3o3GGT
         P5PFhsXh+P1H6LKvH0Q+FL2yKSos+C6qrCuBaCx/K2Rn6Q4UobdD55RnrifLPqaqw5DV
         oxfQ==
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
	ruslan.bilovol@gmail.com,
	Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v3 1/4] ALSA: usb-audio: UAC3. Add support for mixer unit.
Date: Fri, 27 Apr 2018 18:06:49 +0100
Message-Id: <20180427170649.27334-1-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180424172445.31928-2-jorge.sanjuan@codethink.co.uk>
References: <20180424172445.31928-2-jorge.sanjuan@codethink.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285487518505397?=
X-GMAIL-MSGID: =?utf-8?q?1598919879561069746?=
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
 include/uapi/linux/usb/audio.h | 19 +++++++--
 sound/usb/mixer.c              | 88 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 97 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
index 3a78e7145689..13d98e6e0db1 100644
--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -285,9 +285,22 @@ static inline __u8 uac_mixer_unit_iChannelNames(struct uac_mixer_unit_descriptor
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
+}
+
+static inline __u16 uac3_mixer_unit_wClusterDescrID(struct uac_mixer_unit_descriptor *desc)
+{
+	return (desc->baSourceID[desc->bNrInPins + 1] << 8) |
+		desc->baSourceID[desc->bNrInPins];
 }
 
 static inline __u8 uac_mixer_unit_iMixer(struct uac_mixer_unit_descriptor *desc)
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 301ad61ed426..3503f4840ec3 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -719,6 +719,66 @@ static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm
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
+	if (err != sizeof(c_header)) {
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
+ * Get number of channels for a Mixer Unit.
+ */
+static int uac_mixer_unit_get_channels(struct mixer_build *state,
+				       struct uac_mixer_unit_descriptor *desc)
+{
+	int mu_channels;
+
+	if (desc->bLength < 11)
+		return -EINVAL;
+	if (!desc->bNrInPins)
+		return -EINVAL;
+
+	switch (state->mixer->protocol) {
+	case UAC_VERSION_1:
+	case UAC_VERSION_2:
+	default:
+		mu_channels = uac_mixer_unit_bNrChannels(desc);
+		break;
+	case UAC_VERSION_3:
+		mu_channels = get_cluster_channels_v3(state,
+				uac3_mixer_unit_wClusterDescrID(desc));
+		break;
+	}
+
+	if (!mu_channels)
+		return -EINVAL;
+
+	return mu_channels;
+}
+
+/*
  * parse the source unit recursively until it reaches to a terminal
  * or a branched unit.
  */
@@ -865,6 +925,18 @@ static int check_input_term(struct mixer_build *state, int id,
 				term->name = le16_to_cpu(d->wClockSourceStr);
 				return 0;
 			}
+			case UAC3_MIXER_UNIT: {
+				struct uac_mixer_unit_descriptor *d = p1;
+
+				err = uac_mixer_unit_get_channels(state, d);
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
@@ -1797,11 +1869,10 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
  */
 static void build_mixer_unit_ctl(struct mixer_build *state,
 				 struct uac_mixer_unit_descriptor *desc,
-				 int in_pin, int in_ch, int unitid,
-				 struct usb_audio_term *iterm)
+				 int in_pin, int in_ch, int num_outs,
+				 int unitid, struct usb_audio_term *iterm)
 {
 	struct usb_mixer_elem_info *cval;
-	unsigned int num_outs = uac_mixer_unit_bNrChannels(desc);
 	unsigned int i, len;
 	struct snd_kcontrol *kctl;
 	const struct usbmix_name_map *map;
@@ -1878,14 +1949,17 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
 	int input_pins, num_ins, num_outs;
 	int pin, ich, err;
 
-	if (desc->bLength < 11 || !(input_pins = desc->bNrInPins) ||
-	    !(num_outs = uac_mixer_unit_bNrChannels(desc))) {
+	err = uac_mixer_unit_get_channels(state, desc);
+	if (err < 0) {
 		usb_audio_err(state->chip,
 			      "invalid MIXER UNIT descriptor %d\n",
 			      unitid);
-		return -EINVAL;
+		return err;
 	}
 
+	num_outs = err;
+	input_pins = desc->bNrInPins;
+
 	num_ins = 0;
 	ich = 0;
 	for (pin = 0; pin < input_pins; pin++) {
@@ -1912,7 +1986,7 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
 				}
 			}
 			if (ich_has_controls)
-				build_mixer_unit_ctl(state, desc, pin, ich,
+				build_mixer_unit_ctl(state, desc, pin, ich, num_outs,
 						     unitid, &iterm);
 		}
 	}
-- 
2.11.0
