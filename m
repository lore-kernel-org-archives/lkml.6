Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD71C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A2A20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217742;
	bh=KY+GS1ppiFLyTEF6sHFX7+WQi9e1PKc7O9F1RPBui5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K64biqbPcqSI6Uo7XgbyGwEbiUX/EU/v69RKg0FSFjFn3HS9y0lII3rJ+kSDGpsg1
	 ocLV46SwM+4IeWjGL1VGf7CxsDitEZrh/TlO5FvSC1vITgJtYE2BXB9pnhjULR7ci6
	 Z+mp1a0Rk6nw+B1huXfG6qaJEj29ytAHG5AzDOZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfAKOmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404124AbfAKOmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:42:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FF9E20872;
        Fri, 11 Jan 2019 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217736;
        bh=KY+GS1ppiFLyTEF6sHFX7+WQi9e1PKc7O9F1RPBui5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eDa61KcKlMbgXwGRmABjcfpAVM42prssVbdURbmGWYYxNhbFLWXg7L631v37Sq9Cn
         5EWsV4AiEM54IJnvHwMsTDj/iIHL+TL1UAlvyNAe4WMGqF7XgMl4TNeW7Ki4wugDql
         JVfdB1HVMRN9JkvSDffvNCMJPVhVWS0qQs/4aiZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Hui Peng <benquike@163.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 22/65] ALSA: usb-audio: Always check descriptor sizes in parser code
Date:   Fri, 11 Jan 2019 15:15:08 +0100
Message-Id: <20190111131059.464880650@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 3e96d7280f16e2f787307f695a31296b9e4a1cd7 upstream.

There are a few places where we access the data without checking the
actual object size from the USB audio descriptor.  This may result in
OOB access, as recently reported.

This patch addresses these missing checks.  Most of added codes are
simple bLength checks in the caller side.  For the input and output
terminal parsers, we put the length check in the parser functions.
For the input terminal, a new argument is added to distinguish between
UAC1 and the rest, as they treat different objects.

Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Reported-by: Hui Peng <benquike@163.com>
Tested-by: Hui Peng <benquike@163.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/card.c   |    2 +-
 sound/usb/mixer.c  |    4 ++++
 sound/usb/stream.c |   36 +++++++++++++++++++++++++-----------
 3 files changed, 30 insertions(+), 12 deletions(-)

--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -246,7 +246,7 @@ static int snd_usb_create_streams(struct
 		h1 = snd_usb_find_csint_desc(host_iface->extra,
 							 host_iface->extralen,
 							 NULL, UAC_HEADER);
-		if (!h1) {
+		if (!h1 || h1->bLength < sizeof(*h1)) {
 			dev_err(&dev->dev, "cannot find UAC_HEADER\n");
 			return -EINVAL;
 		}
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2075,11 +2075,15 @@ static int parse_audio_input_terminal(st
 
 	if (state->mixer->protocol == UAC_VERSION_2) {
 		struct uac2_input_terminal_descriptor *d_v2 = raw_desc;
+		if (d_v2->bLength < sizeof(*d_v2))
+			return -EINVAL;
 		control = UAC2_TE_CONNECTOR;
 		term_id = d_v2->bTerminalID;
 		bmctls = le16_to_cpu(d_v2->bmControls);
 	} else if (state->mixer->protocol == UAC_VERSION_3) {
 		struct uac3_input_terminal_descriptor *d_v3 = raw_desc;
+		if (d_v3->bLength < sizeof(*d_v3))
+			return -EINVAL;
 		control = UAC3_TE_INSERTION;
 		term_id = d_v3->bTerminalID;
 		bmctls = le32_to_cpu(d_v3->bmControls);
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -596,12 +596,8 @@ static int parse_uac_endpoint_attributes
 		csep = snd_usb_find_desc(alts->extra, alts->extralen, NULL, USB_DT_CS_ENDPOINT);
 
 	if (!csep || csep->bLength < 7 ||
-	    csep->bDescriptorSubtype != UAC_EP_GENERAL) {
-		usb_audio_warn(chip,
-			       "%u:%d : no or invalid class specific endpoint descriptor\n",
-			       iface_no, altsd->bAlternateSetting);
-		return 0;
-	}
+	    csep->bDescriptorSubtype != UAC_EP_GENERAL)
+		goto error;
 
 	if (protocol == UAC_VERSION_1) {
 		attributes = csep->bmAttributes;
@@ -609,6 +605,8 @@ static int parse_uac_endpoint_attributes
 		struct uac2_iso_endpoint_descriptor *csep2 =
 			(struct uac2_iso_endpoint_descriptor *) csep;
 
+		if (csep2->bLength < sizeof(*csep2))
+			goto error;
 		attributes = csep->bmAttributes & UAC_EP_CS_ATTR_FILL_MAX;
 
 		/* emulate the endpoint attributes of a v1 device */
@@ -618,12 +616,20 @@ static int parse_uac_endpoint_attributes
 		struct uac3_iso_endpoint_descriptor *csep3 =
 			(struct uac3_iso_endpoint_descriptor *) csep;
 
+		if (csep3->bLength < sizeof(*csep3))
+			goto error;
 		/* emulate the endpoint attributes of a v1 device */
 		if (le32_to_cpu(csep3->bmControls) & UAC2_CONTROL_PITCH)
 			attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
 	}
 
 	return attributes;
+
+ error:
+	usb_audio_warn(chip,
+		       "%u:%d : no or invalid class specific endpoint descriptor\n",
+		       iface_no, altsd->bAlternateSetting);
+	return 0;
 }
 
 /* find an input terminal descriptor (either UAC1 or UAC2) with the given
@@ -631,13 +637,17 @@ static int parse_uac_endpoint_attributes
  */
 static void *
 snd_usb_find_input_terminal_descriptor(struct usb_host_interface *ctrl_iface,
-					       int terminal_id)
+				       int terminal_id, bool uac23)
 {
 	struct uac2_input_terminal_descriptor *term = NULL;
+	size_t minlen = uac23 ? sizeof(struct uac2_input_terminal_descriptor) :
+		sizeof(struct uac_input_terminal_descriptor);
 
 	while ((term = snd_usb_find_csint_desc(ctrl_iface->extra,
 					       ctrl_iface->extralen,
 					       term, UAC_INPUT_TERMINAL))) {
+		if (term->bLength < minlen)
+			continue;
 		if (term->bTerminalID == terminal_id)
 			return term;
 	}
@@ -655,7 +665,8 @@ snd_usb_find_output_terminal_descriptor(
 	while ((term = snd_usb_find_csint_desc(ctrl_iface->extra,
 					       ctrl_iface->extralen,
 					       term, UAC_OUTPUT_TERMINAL))) {
-		if (term->bTerminalID == terminal_id)
+		if (term->bLength >= sizeof(*term) &&
+		    term->bTerminalID == terminal_id)
 			return term;
 	}
 
@@ -729,7 +740,8 @@ snd_usb_get_audioformat_uac12(struct snd
 		format = le16_to_cpu(as->wFormatTag); /* remember the format value */
 
 		iterm = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
-							     as->bTerminalLink);
+							       as->bTerminalLink,
+							       false);
 		if (iterm) {
 			num_channels = iterm->bNrChannels;
 			chconfig = le16_to_cpu(iterm->wChannelConfig);
@@ -764,7 +776,8 @@ snd_usb_get_audioformat_uac12(struct snd
 		 * to extract the clock
 		 */
 		input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
-								    as->bTerminalLink);
+								    as->bTerminalLink,
+								    true);
 		if (input_term) {
 			clock = input_term->bCSourceID;
 			if (!chconfig && (num_channels == input_term->bNrChannels))
@@ -998,7 +1011,8 @@ snd_usb_get_audioformat_uac3(struct snd_
 	 * to extract the clock
 	 */
 	input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
-							    as->bTerminalLink);
+							    as->bTerminalLink,
+							    true);
 	if (input_term) {
 		clock = input_term->bCSourceID;
 		goto found_clock;


