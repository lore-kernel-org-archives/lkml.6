Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AIpwx482wmSsbBfKtoT/P0E0psh2TMxhURsvei8XJrkzrF074JekJm8xCdOaeP41kvKrhf06kxjm
ARC-Seal: i=1; a=rsa-sha256; t=1524243822; cv=none;
        d=google.com; s=arc-20160816;
        b=VAOUfu4Wpjhllo91ZDrS1e3EsAgf3eEEFIBqBE1t1mu4LcFrbv4sg35v3Ey61xltoj
         QUpMKcDdfvpqVA2gNzl6DQyM7cyB9nmsLGg6Z9/OLoT2Mg1R4EGVMxR13bQXxKwV1m6Q
         d8MtLVHsmHrwcz2NpgffmVnnH9kquBS1KTOx9ADdgyQoT8Q+kqOvYS4ObSJ53p2RDlmV
         uFPuegMr/UTce08n8MDjczyt2TgNq3bGnjWqZqhrOYPkVj3rhNx8ELCad68pL3hpbQ1W
         2eOR/tVd+cYR9+j7DEVshjoIo52B/4lXpurzmP3KscHx/Ve+Tuip0+YLTLG6XJMIZ8ED
         FEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=M8ltwmzU7W4bOyD/848e5Xh1jmtBWvGw8DLJWkVZy2M=;
        b=aw40qQn0bwgrImQDmLYiO3dnvr/i1NUig8Kjp0OBz9vMEcCD7xr5E7f6Sh2Q7XxrxA
         g5Rl6666I8ENowPT7QRYtK6iuXptBXpZoOB7pSVnH1FyCxLmJUsp6UnttewRTpQwWPwz
         A6/yt8AXhceE6hNphEAmN41f/ezwhGZFLs9/Yx/RsQ9Ty9UXkxonXLkYT8s9UkJ0s8mo
         13o5gkiPIqShpedg6zCKyvP2eDuIeZoxRxgWXOSbuL3QjTZW3RvJVfulAbD1N5ecwz3+
         348mIORAKA6n2hsfJaMbB1GGretYtjsCBi7B4h5378b56UQf+o98r5Ep1Z35weWM3UIH
         xO3w==
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
Subject: [PATCH 4/4] ALSA: usb-audio: UAC3 Add support for connector insertion.
Date: Fri, 20 Apr 2018 18:03:27 +0100
Message-Id: <20180420170327.31569-5-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285490123572261?=
X-GMAIL-MSGID: =?utf-8?q?1598285490123572261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This adds support for the UAC3 insertion controls. The status
is reported as a boolean value in the same way it used to do
for UAC2. Hence, the presence of any connector in the response
will make the control saying the jack is connected.

The UAC2 support for this control has been moved to a dedicated
control for connectors as both UAC2 and UAC3 follow a specific
Control Request Parameter Block for this control. This parameter
block for UAC3 could not be read in the same simplistic
manner as in UAC2.

This implementation is not requesting additional information
from the HIGH CAPABILITY Connectors descriptor.

Tested with an UAC3 device with UAC2 as legacy configuration.
The connector status can be read with `amixer` and the interrupt
is also caught with `alsactl monitor`.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 include/linux/usb/audio-v2.h |   7 +++
 include/linux/usb/audio-v3.h |  14 ++++++
 sound/usb/mixer.c            | 111 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 117 insertions(+), 15 deletions(-)

diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
index aaafecf073ff..a96ed2ce3254 100644
--- a/include/linux/usb/audio-v2.h
+++ b/include/linux/usb/audio-v2.h
@@ -189,6 +189,13 @@ struct uac2_iso_endpoint_descriptor {
 #define UAC2_CONTROL_DATA_OVERRUN	(3 << 2)
 #define UAC2_CONTROL_DATA_UNDERRUN	(3 << 4)
 
+/* 5.2.5.4.2 Connector Control Parameter Block */
+struct uac2_connectors_ctl_blk {
+	__u8 bNrChannels;
+	__le32 bmChannelConfig;
+	__u8 iChannelNames;
+} __attribute__((packed));
+
 /* 6.1 Interrupt Data Message */
 
 #define UAC2_INTERRUPT_DATA_MSG_VENDOR	(1 << 0)
diff --git a/include/linux/usb/audio-v3.h b/include/linux/usb/audio-v3.h
index a8959aaba0ae..6cedb6d499ba 100644
--- a/include/linux/usb/audio-v3.h
+++ b/include/linux/usb/audio-v3.h
@@ -221,6 +221,12 @@ struct uac3_iso_endpoint_descriptor {
 	__le16 wLockDelay;
 } __attribute__((packed));
 
+/* 5.2.1.6.1 INSERTION CONTROL PARAMETER BLOCK */
+struct uac3_insertion_ctl_blk {
+	__u8 bSize;
+	__u8 bmConInserted[1];
+} __attribute__ ((packed));
+
 /* 6.1 INTERRUPT DATA MESSAGE */
 struct uac3_interrupt_data_msg {
 	__u8 bInfo;
@@ -392,4 +398,12 @@ struct uac3_interrupt_data_msg {
 #define UAC3_AC_ACTIVE_INTERFACE_CONTROL	0x01
 #define UAC3_AC_POWER_DOMAIN_CONTROL		0x02
 
+/* A.23.5 TERMINAL CONTROL SELECTORS */
+#define UAC3_TE_UNDEFINED			0x00
+#define UAC3_TE_INSERTION			0x01
+#define UAC3_TE_OVERLOAD			0x02
+#define UAC3_TE_UNDERFLOW			0x03
+#define UAC3_TE_OVERFLOW			0x04
+#define UAC3_TE_LATENCY 			0x05
+
 #endif /* __LINUX_USB_AUDIO_V3_H */
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 738ca37e6d6e..4ddc5d4e1139 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1292,6 +1292,51 @@ static int mixer_ctl_master_bool_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+/* get the connectors status and report it as boolean type */
+static int mixer_ctl_connector_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct snd_usb_audio *chip = cval->head.mixer->chip;
+	int idx = 0, validx, ret, val;
+
+	validx = cval->control << 8 | 0;
+
+	ret = snd_usb_lock_shutdown(chip) ? -EIO : 0;
+	if (ret)
+		goto error;
+
+	idx = snd_usb_ctrl_intf(chip) | (cval->head.id << 8);
+	if (cval->head.mixer->protocol == UAC_VERSION_2) {
+		struct uac2_connectors_ctl_blk uac2_conn;
+
+		ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), UAC2_CS_CUR,
+				      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+				      validx, idx, &uac2_conn, sizeof(uac2_conn));
+		val = !!uac2_conn.bNrChannels;
+	} else { /* UAC_VERSION_3 */
+		struct uac3_insertion_ctl_blk uac3_conn;
+
+		ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), UAC2_CS_CUR,
+				      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+				      validx, idx, &uac3_conn, sizeof(uac3_conn));
+		val = !!uac3_conn.bmConInserted[0];
+	}
+
+	snd_usb_unlock_shutdown(chip);
+
+	if (ret < 0) {
+error:
+		usb_audio_err(chip,
+			"cannot get connectors status: req = %#x, wValue = %#x, wIndex = %#x, type = %d\n",
+			UAC_GET_CUR, validx, idx, cval->val_type);
+		return ret;
+	}
+
+	ucontrol->value.integer.value[0] = val;
+	return 0;
+}
+
 static struct snd_kcontrol_new usb_feature_unit_ctl = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "", /* will be filled later manually */
@@ -1322,6 +1367,15 @@ static struct snd_kcontrol_new usb_bool_master_control_ctl_ro = {
 	.put = NULL,
 };
 
+static struct snd_kcontrol_new usb_connector_ctl_ro = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.name = "", /* will be filled later manually */
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+	.info = snd_ctl_boolean_mono_info,
+	.get = mixer_ctl_connector_get,
+	.put = NULL,
+};
+
 /*
  * This symbol is exported in order to allow the mixer quirks to
  * hook up to the standard feature unit control mechanism
@@ -1568,17 +1622,25 @@ static void build_connector_control(struct mixer_build *state,
 		return;
 	snd_usb_mixer_elem_init_std(&cval->head, state->mixer, term->id);
 	/*
-	 * The first byte from reading the UAC2_TE_CONNECTOR control returns the
-	 * number of channels connected.  This boolean ctl will simply report
-	 * if any channels are connected or not.
-	 * (Audio20_final.pdf Table 5-10: Connector Control CUR Parameter Block)
+	 * UAC2: The first byte from reading the UAC2_TE_CONNECTOR control returns the
+	 * number of channels connected.
+	 *
+	 * UAC3: The first byte specifies size of bitmap for the inserted controls. The
+	 * following byte(s) specifies which connectors are inserted.
+	 *
+	 * This boolean ctl will simply report if any channels are connected
+	 * or not.
 	 */
-	cval->control = UAC2_TE_CONNECTOR;
+	if (state->mixer->protocol == UAC_VERSION_2)
+		cval->control = UAC2_TE_CONNECTOR;
+	else /* UAC_VERSION_3 */
+		cval->control = UAC3_TE_INSERTION;
+
 	cval->val_type = USB_MIXER_BOOLEAN;
 	cval->channels = 1; /* report true if any channel is connected */
 	cval->min = 0;
 	cval->max = 1;
-	kctl = snd_ctl_new1(&usb_bool_master_control_ctl_ro, cval);
+	kctl = snd_ctl_new1(&usb_connector_ctl_ro, cval);
 	if (!kctl) {
 		usb_audio_err(state->chip, "cannot malloc kcontrol\n");
 		kfree(cval);
@@ -1904,16 +1966,29 @@ static int parse_audio_input_terminal(struct mixer_build *state, int unitid,
 				      void *raw_desc)
 {
 	struct usb_audio_term iterm;
-	struct uac2_input_terminal_descriptor *d = raw_desc;
+	unsigned int control, bmctls, term_id;
 
-	check_input_term(state, d->bTerminalID, &iterm);
 	if (state->mixer->protocol == UAC_VERSION_2) {
-		/* Check for jack detection. */
-		if (uac_v2v3_control_is_readable(d->bmControls,
-						 UAC2_TE_CONNECTOR)) {
-			build_connector_control(state, &iterm, true);
-		}
-	}
+		struct uac2_input_terminal_descriptor *d_v2 = raw_desc;
+		control = UAC2_TE_CONNECTOR;
+		term_id = d_v2->bTerminalID;
+		bmctls = d_v2->bmControls;
+	}
+	else if (state->mixer->protocol == UAC_VERSION_3) {
+		struct uac3_input_terminal_descriptor *d_v3 = raw_desc;
+		control = UAC3_TE_INSERTION;
+		term_id = d_v3->bTerminalID;
+		bmctls = d_v3->bmControls;
+	}
+	else /* UAC1. No Insertion control */
+		return 0;
+
+	check_input_term(state, term_id, &iterm);
+
+	/* Check for jack detection. */
+	if (uac_v2v3_control_is_readable(bmctls, control))
+		build_connector_control(state, &iterm, true);
+
 	return 0;
 }
 
@@ -2507,7 +2582,7 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 	} else { /* UAC_VERSION_3 */
 		switch (p1[2]) {
 		case UAC_INPUT_TERMINAL:
-			return 0; /* NOP */
+			return parse_audio_input_terminal(state, unitid, p1);
 		case UAC3_MIXER_UNIT:
 			return parse_audio_mixer_unit(state, unitid, p1);
 		case UAC3_CLOCK_SOURCE:
@@ -2645,6 +2720,12 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 			err = parse_audio_unit(&state, desc->bCSourceID);
 			if (err < 0 && err != -EINVAL)
 				return err;
+
+			if (uac_v2v3_control_is_readable(desc->bmControls,
+							 UAC3_TE_INSERTION)) {
+				build_connector_control(&state, &state.oterm,
+							false);
+			}
 		}
 	}
 
-- 
2.11.0
