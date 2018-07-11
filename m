Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD676C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916E020878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916E020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbeGKMmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:42:14 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56059 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387500AbeGKMmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:42:12 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fdENe-00042U-Gz; Wed, 11 Jul 2018 13:38:02 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ALSA: usb-audio: Add support for Processing Units in UAC3
Date:   Wed, 11 Jul 2018 13:37:53 +0100
Message-Id: <20180711123755.27182-4-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
References: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Processig Units defined in
the UAC3 spec. The main difference with the previous specs
is the lack of on/off switches in the controls for these
units and the addiction of the new Multi Function Processing
Unit.

The current version of the UAC3 spec doesn't define any
useful controls for the new Multi Function Processing Unit
so no control will get created once this unit is parsed.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 include/linux/usb/audio-v3.h   | 15 +++++++++++++
 include/uapi/linux/usb/audio.h | 49 ++++++++++++++++++++++++++++++++--------
 sound/usb/mixer.c              | 51 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 104 insertions(+), 11 deletions(-)

diff --git a/include/linux/usb/audio-v3.h b/include/linux/usb/audio-v3.h
index a710e28b5215..334bfa6dfb47 100644
--- a/include/linux/usb/audio-v3.h
+++ b/include/linux/usb/audio-v3.h
@@ -387,6 +387,12 @@ struct uac3_interrupt_data_msg {
 #define UAC3_CONNECTORS			0x0f
 #define UAC3_POWER_DOMAIN		0x10
 
+/* A.20 PROCESSING UNIT PROCESS TYPES */
+#define UAC3_PROCESS_UNDEFINED		0x00
+#define UAC3_PROCESS_UP_DOWNMIX		0x01
+#define UAC3_PROCESS_STEREO_EXTENDER	0x02
+#define UAC3_PROCESS_MULTI_FUNCTION	0x03
+
 /* A.22 AUDIO CLASS-SPECIFIC REQUEST CODES */
 /* see audio-v2.h for the rest, which is identical to v2 */
 #define UAC3_CS_REQ_INTEN			0x04
@@ -406,6 +412,15 @@ struct uac3_interrupt_data_msg {
 #define UAC3_TE_OVERFLOW			0x04
 #define UAC3_TE_LATENCY 			0x05
 
+/* A.23.10 PROCESSING UNITS CONTROL SELECTROS */
+
+/* Up/Down Mixer */
+#define UAC3_UD_MODE_SELECT			0x01
+
+/* Stereo Extender */
+#define UAC3_EXT_WIDTH_CONTROL			0x01
+
+
 /* BADD predefined Unit/Terminal values */
 #define UAC3_BADD_IT_ID1	1  /* Input Terminal ID1: bTerminalID = 1 */
 #define UAC3_BADD_FU_ID2	2  /* Feature Unit ID2: bUnitID = 2 */
diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
index 74e520fb944f..ddc5396800aa 100644
--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -390,33 +390,64 @@ static inline __u8 uac_processing_unit_iChannelNames(struct uac_processing_unit_
 static inline __u8 uac_processing_unit_bControlSize(struct uac_processing_unit_descriptor *desc,
 						    int protocol)
 {
-	return (protocol == UAC_VERSION_1) ?
-		desc->baSourceID[desc->bNrInPins + 4] :
-		2; /* in UAC2, this value is constant */
+	switch (protocol) {
+	case UAC_VERSION_1:
+		return desc->baSourceID[desc->bNrInPins + 4];
+	case UAC_VERSION_2:
+		return 2; /* in UAC2, this value is constant */
+	case UAC_VERSION_3:
+		return 4; /* in UAC3, this value is constant */
+	default:
+		return 1;
+	}
 }
 
 static inline __u8 *uac_processing_unit_bmControls(struct uac_processing_unit_descriptor *desc,
 						   int protocol)
 {
-	return (protocol == UAC_VERSION_1) ?
-		&desc->baSourceID[desc->bNrInPins + 5] :
-		&desc->baSourceID[desc->bNrInPins + 6];
+	switch (protocol) {
+	case UAC_VERSION_1:
+		return &desc->baSourceID[desc->bNrInPins + 5];
+	case UAC_VERSION_2:
+		return &desc->baSourceID[desc->bNrInPins + 6];
+	case UAC_VERSION_3:
+		return &desc->baSourceID[desc->bNrInPins + 2];
+	default:
+		return NULL;
+	}
 }
 
 static inline __u8 uac_processing_unit_iProcessing(struct uac_processing_unit_descriptor *desc,
 						   int protocol)
 {
 	__u8 control_size = uac_processing_unit_bControlSize(desc, protocol);
-	return *(uac_processing_unit_bmControls(desc, protocol)
-			+ control_size);
+
+	switch (protocol) {
+	case UAC_VERSION_1:
+	case UAC_VERSION_2:
+	default:
+		return *(uac_processing_unit_bmControls(desc, protocol)
+			 + control_size);
+	case UAC_VERSION_3:
+		return 0; /* UAC3 does not have this field */
+	}
 }
 
 static inline __u8 *uac_processing_unit_specific(struct uac_processing_unit_descriptor *desc,
 						 int protocol)
 {
 	__u8 control_size = uac_processing_unit_bControlSize(desc, protocol);
-	return uac_processing_unit_bmControls(desc, protocol)
+
+	switch (protocol) {
+	case UAC_VERSION_1:
+	case UAC_VERSION_2:
+	default:
+		return uac_processing_unit_bmControls(desc, protocol)
 			+ control_size + 1;
+	case UAC_VERSION_3:
+		return uac_processing_unit_bmControls(desc, protocol)
+			+ control_size;
+	}
 }
 
 /* 4.5.2 Class-Specific AS Interface Descriptor */
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index bfb3484096a6..39fde49e8749 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -953,6 +953,23 @@ static int check_input_term(struct mixer_build *state, int id,
 
 				return 0;
 			}
+			case UAC3_PROCESSING_UNIT: {
+				struct uac_processing_unit_descriptor *d = p1;
+
+				if (!d->bNrInPins)
+					return -EINVAL;
+
+				/* call recursively to retrieve the channel info */
+				err = check_input_term(state, d->baSourceID[0], term);
+				if (err < 0)
+					return err;
+
+				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+				term->id = id;
+				term->name = 0; /* TODO: UAC3 Class-specific strings */
+
+				return 0;
+			}
 			default:
 				return -ENODEV;
 			}
@@ -2180,6 +2197,11 @@ struct procunit_info {
 	struct procunit_value_info *values;
 };
 
+static struct procunit_value_info undefined_proc_info[] = {
+	{ 0x00, "Control Undefined", 0 },
+	{ 0 }
+};
+
 static struct procunit_value_info updown_proc_info[] = {
 	{ UAC_UD_ENABLE, "Switch", USB_MIXER_BOOLEAN },
 	{ UAC_UD_MODE_SELECT, "Mode Select", USB_MIXER_U8, 1 },
@@ -2228,6 +2250,23 @@ static struct procunit_info procunits[] = {
 	{ UAC_PROCESS_DYN_RANGE_COMP, "DCR", dcr_proc_info },
 	{ 0 },
 };
+
+static struct procunit_value_info uac3_updown_proc_info[] = {
+	{ UAC3_UD_MODE_SELECT, "Mode Select", USB_MIXER_U8, 1 },
+	{ 0 }
+};
+static struct procunit_value_info uac3_stereo_ext_proc_info[] = {
+	{ UAC3_EXT_WIDTH_CONTROL, "Width Control", USB_MIXER_U8 },
+	{ 0 }
+};
+
+static struct procunit_info uac3_procunits[] = {
+	{ UAC3_PROCESS_UP_DOWNMIX, "Up Down", uac3_updown_proc_info },
+	{ UAC3_PROCESS_STEREO_EXTENDER, "3D Stereo Extender", uac3_stereo_ext_proc_info },
+	{ UAC3_PROCESS_MULTI_FUNCTION, "Multi-Function", undefined_proc_info },
+	{ 0 },
+};
+
 /*
  * predefined data for extension units
  */
@@ -2388,8 +2427,16 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 static int parse_audio_processing_unit(struct mixer_build *state, int unitid,
 				       void *raw_desc)
 {
-	return build_audio_procunit(state, unitid, raw_desc,
-				    procunits, "Processing Unit");
+	switch (state->mixer->protocol) {
+	case UAC_VERSION_1:
+	case UAC_VERSION_2:
+	default:
+		return build_audio_procunit(state, unitid, raw_desc,
+				procunits, "Processing Unit");
+	case UAC_VERSION_3:
+		return build_audio_procunit(state, unitid, raw_desc,
+				uac3_procunits, "Processing Unit");
+	}
 }
 
 static int parse_audio_extension_unit(struct mixer_build *state, int unitid,
-- 
2.11.0

