Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523658281; cv=none;
        d=google.com; s=arc-20160816;
        b=xSCT5XRq0gWRUvyssggpykDWwhEfulYQbGB2WnkQ0YZ5QZTW6ntcNqs8gBUQ2AALVf
         AJL780q2HuF2R1mPvFzcIOQco55JaVRBk9L2MVWzMsun28IsxcFVpyPczWjRGWrGFWG8
         WSeZO4QU+yj+isJzEEnlAlRtMOOstMODspK7eC+71tH2HFKe3K+R0ORcQxRu6O9uRL/G
         XG8GUb/f/WzZYfjoI/g9Y9YkU3xIjE8E0scxrNKoMYiRdBdxO3tfGATL4OV4lMFq1FyU
         2ojkdmgZN7zam78BLMTsnuTy+aSsNoSf/YbMBQoePysjd9yTv/dwJCRpRxmRLD0T3W14
         r2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=YJRLFP1XCCMVEAz/VMRMR+yNrijKaZ0TMiOKsF9k2tc=;
        b=riRwpGYb3ujfAzmfAMt2D3pPWrpfaxoNZtRjO+za63aFFkQSS1ePSdrnuGNfZGIBq+
         3lQU4YGLzOVK+5vmcq7Vamrg/kO/CmvEwOn84qNhoGD5zs5J4ZnN2e6qPks1UKSUioYF
         czFsChA1B+4zRB4nKNTovzwWEzHbp2d0JruXMe7HKQch9Fijh1dEhN9Y1VjS1M38HKyg
         CZHJrKHXJm5SZaeFBAEZj3JzaAqbedG94CAT43q5IKpw8wPlyeD1zZPItgegmScKdFFt
         B89VkYuTzR1pzDs+iKFc823hmm1sZwSGqs9RuQ5tNaDJXoT2bWr0w/EbRg0xmcULjb3+
         F+lQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=parwscKz;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=parwscKz;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+JmLtP0XxYUATrKHaxvqaSTDsKYd2y0IvD1cle6TQMt7OfRNCYHyRHvzxO079Z1ddRl97tPQ==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ALSA: usb: stream: refactor audio interface parsing
Date: Sat, 14 Apr 2018 01:24:23 +0300
Message-Id: <1523658266-2259-2-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597671506346289659?=
X-GMAIL-MSGID: =?utf-8?q?1597671506346289659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Offload snd_usb_parse_audio_interface() function which
became quite long after adding UAC3 spec support.

Move class-specific parts to separate functions
which now produce audioformat structure that is
ready to be fed to snd_usb_add_audio_stream().

This also broke Blue Microphones workaround (which
relies on audioformat decoded from previous altsetting)
into two parts: prepare quirk flag analyzing previous
altsetting then use it with current altsetting.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 sound/usb/stream.c | 613 +++++++++++++++++++++++++++++------------------------
 1 file changed, 334 insertions(+), 279 deletions(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 6a8f584..586d664 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -626,6 +626,319 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 	return NULL;
 }
 
+static struct audioformat *
+snd_usb_get_audioformat_uac12(struct snd_usb_audio *chip,
+			      struct usb_host_interface *alts,
+			      int protocol, int iface_no,
+			      int altno, int stream, int bm_quirk)
+{
+	struct usb_device *dev = chip->dev;
+	struct uac_format_type_i_continuous_descriptor *fmt;
+	unsigned int num_channels = 0, chconfig = 0;
+	struct audioformat *fp;
+	int clock = 0;
+	u64 format;
+
+	/* get audio formats */
+	if (protocol == UAC_VERSION_1) {
+		struct uac1_as_header_descriptor *as =
+			snd_usb_find_csint_desc(alts->extra, alts->extralen,
+						NULL, UAC_AS_GENERAL);
+		struct uac_input_terminal_descriptor *iterm;
+
+		if (!as) {
+			dev_err(&dev->dev,
+				"%u:%d : UAC_AS_GENERAL descriptor not found\n",
+				iface_no, altno);
+			return NULL;
+		}
+
+		if (as->bLength < sizeof(*as)) {
+			dev_err(&dev->dev,
+				"%u:%d : invalid UAC_AS_GENERAL desc\n",
+				iface_no, altno);
+			return NULL;
+		}
+
+		format = le16_to_cpu(as->wFormatTag); /* remember the format value */
+
+		iterm = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
+							     as->bTerminalLink);
+		if (iterm) {
+			num_channels = iterm->bNrChannels;
+			chconfig = le16_to_cpu(iterm->wChannelConfig);
+		}
+	} else { /* UAC_VERSION_2 */
+		struct uac2_input_terminal_descriptor *input_term;
+		struct uac2_output_terminal_descriptor *output_term;
+		struct uac2_as_header_descriptor *as =
+			snd_usb_find_csint_desc(alts->extra, alts->extralen,
+						NULL, UAC_AS_GENERAL);
+
+		if (!as) {
+			dev_err(&dev->dev,
+				"%u:%d : UAC_AS_GENERAL descriptor not found\n",
+				iface_no, altno);
+			return NULL;
+		}
+
+		if (as->bLength < sizeof(*as)) {
+			dev_err(&dev->dev,
+				"%u:%d : invalid UAC_AS_GENERAL desc\n",
+				iface_no, altno);
+			return NULL;
+		}
+
+		num_channels = as->bNrChannels;
+		format = le32_to_cpu(as->bmFormats);
+		chconfig = le32_to_cpu(as->bmChannelConfig);
+
+		/*
+		 * lookup the terminal associated to this interface
+		 * to extract the clock
+		 */
+		input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
+								    as->bTerminalLink);
+		if (input_term) {
+			clock = input_term->bCSourceID;
+			if (!chconfig && (num_channels == input_term->bNrChannels))
+				chconfig = le32_to_cpu(input_term->bmChannelConfig);
+			goto found_clock;
+		}
+
+		output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
+								      as->bTerminalLink);
+		if (output_term) {
+			clock = output_term->bCSourceID;
+			goto found_clock;
+		}
+
+		dev_err(&dev->dev,
+			"%u:%d : bogus bTerminalLink %d\n",
+			iface_no, altno, as->bTerminalLink);
+		return NULL;
+	}
+
+found_clock:
+	/* get format type */
+	fmt = snd_usb_find_csint_desc(alts->extra, alts->extralen,
+				      NULL, UAC_FORMAT_TYPE);
+	if (!fmt) {
+		dev_err(&dev->dev,
+			"%u:%d : no UAC_FORMAT_TYPE desc\n",
+			iface_no, altno);
+		return NULL;
+	}
+	if (((protocol == UAC_VERSION_1) && (fmt->bLength < 8))
+			|| ((protocol == UAC_VERSION_2) &&
+					(fmt->bLength < 6))) {
+		dev_err(&dev->dev,
+			"%u:%d : invalid UAC_FORMAT_TYPE desc\n",
+			iface_no, altno);
+		return NULL;
+	}
+
+	/*
+	 * Blue Microphones workaround: The last altsetting is
+	 * identical with the previous one, except for a larger
+	 * packet size, but is actually a mislabeled two-channel
+	 * setting; ignore it.
+	 *
+	 * Part 2: analyze quirk flag and format
+	 */
+	if (bm_quirk && fmt->bNrChannels == 1 && fmt->bSubframeSize == 2)
+		return NULL;
+
+	fp = kzalloc(sizeof(*fp), GFP_KERNEL);
+	if (!fp)
+		return ERR_PTR(-ENOMEM);
+
+	fp->iface = iface_no;
+	fp->altsetting = altno;
+	fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
+	fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
+	fp->datainterval = snd_usb_parse_datainterval(chip, alts);
+	fp->protocol = protocol;
+	fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+	fp->channels = num_channels;
+	if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
+		fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
+				* (fp->maxpacksize & 0x7ff);
+	fp->attributes = parse_uac_endpoint_attributes(chip, alts,
+						       protocol, iface_no);
+	fp->clock = clock;
+	INIT_LIST_HEAD(&fp->list);
+
+	/* some quirks for attributes here */
+	snd_usb_audioformat_attributes_quirk(chip, fp, stream);
+
+	/* ok, let's parse further... */
+	if (snd_usb_parse_audio_format(chip, fp, format,
+					fmt, stream) < 0) {
+		kfree(fp->rate_table);
+		kfree(fp);
+		return NULL;
+	}
+
+	/* Create chmap */
+	if (fp->channels != num_channels)
+		chconfig = 0;
+
+	fp->chmap = convert_chmap(fp->channels, chconfig, protocol);
+
+	return fp;
+}
+
+static struct audioformat *
+snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
+			     struct usb_host_interface *alts,
+			     int iface_no, int altno, int stream)
+{
+	struct usb_device *dev = chip->dev;
+	struct uac3_input_terminal_descriptor *input_term;
+	struct uac3_output_terminal_descriptor *output_term;
+	struct uac3_cluster_header_descriptor *cluster;
+	struct uac3_as_header_descriptor *as;
+	struct uac3_hc_descriptor_header hc_header;
+	struct snd_pcm_chmap_elem *chmap;
+	unsigned int num_channels;
+	struct audioformat *fp;
+	u16 cluster_id, wLength;
+	int clock = 0;
+	int err;
+
+	as = snd_usb_find_csint_desc(alts->extra, alts->extralen,
+				     NULL, UAC_AS_GENERAL);
+	if (!as) {
+		dev_err(&dev->dev,
+			"%u:%d : UAC_AS_GENERAL descriptor not found\n",
+			iface_no, altno);
+		return NULL;
+	}
+
+	if (as->bLength < sizeof(*as)) {
+		dev_err(&dev->dev,
+			"%u:%d : invalid UAC_AS_GENERAL desc\n",
+			iface_no, altno);
+		return NULL;
+	}
+
+	cluster_id = le16_to_cpu(as->wClusterDescrID);
+	if (!cluster_id) {
+		dev_err(&dev->dev,
+			"%u:%d : no cluster descriptor\n",
+			iface_no, altno);
+		return NULL;
+	}
+
+	/*
+	 * Get number of channels and channel map through
+	 * High Capability Cluster Descriptor
+	 *
+	 * First step: get High Capability header and
+	 * read size of Cluster Descriptor
+	 */
+	err = snd_usb_ctl_msg(chip->dev,
+			usb_rcvctrlpipe(chip->dev, 0),
+			UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
+			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+			cluster_id,
+			snd_usb_ctrl_intf(chip),
+			&hc_header, sizeof(hc_header));
+	if (err < 0)
+		return ERR_PTR(err);
+	else if (err != sizeof(hc_header)) {
+		dev_err(&dev->dev,
+			"%u:%d : can't get High Capability descriptor\n",
+			iface_no, altno);
+		return ERR_PTR(-EIO);
+	}
+
+	/*
+	 * Second step: allocate needed amount of memory
+	 * and request Cluster Descriptor
+	 */
+	wLength = le16_to_cpu(hc_header.wLength);
+	cluster = kzalloc(wLength, GFP_KERNEL);
+	if (!cluster)
+		return ERR_PTR(-ENOMEM);
+	err = snd_usb_ctl_msg(chip->dev,
+			usb_rcvctrlpipe(chip->dev, 0),
+			UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
+			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+			cluster_id,
+			snd_usb_ctrl_intf(chip),
+			cluster, wLength);
+	if (err < 0) {
+		kfree(cluster);
+		return ERR_PTR(err);
+	} else if (err != wLength) {
+		dev_err(&dev->dev,
+			"%u:%d : can't get Cluster Descriptor\n",
+			iface_no, altno);
+		kfree(cluster);
+		return ERR_PTR(-EIO);
+	}
+
+	num_channels = cluster->bNrChannels;
+	chmap = convert_chmap_v3(cluster);
+	kfree(cluster);
+
+	/*
+	 * lookup the terminal associated to this interface
+	 * to extract the clock
+	 */
+	input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
+							    as->bTerminalLink);
+	if (input_term) {
+		clock = input_term->bCSourceID;
+		goto found_clock;
+	}
+
+	output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
+							     as->bTerminalLink);
+	if (output_term) {
+		clock = output_term->bCSourceID;
+		goto found_clock;
+	}
+
+	dev_err(&dev->dev, "%u:%d : bogus bTerminalLink %d\n",
+			iface_no, altno, as->bTerminalLink);
+	return NULL;
+
+found_clock:
+	fp = kzalloc(sizeof(*fp), GFP_KERNEL);
+	if (!fp)
+		return ERR_PTR(-ENOMEM);
+
+	fp->iface = iface_no;
+	fp->altsetting = altno;
+	fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
+	fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
+	fp->datainterval = snd_usb_parse_datainterval(chip, alts);
+	fp->protocol = UAC_VERSION_3;
+	fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+	fp->channels = num_channels;
+	if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
+		fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
+				* (fp->maxpacksize & 0x7ff);
+	fp->attributes = parse_uac_endpoint_attributes(chip, alts,
+						       UAC_VERSION_3,
+						       iface_no);
+	fp->clock = clock;
+	fp->chmap = chmap;
+	INIT_LIST_HEAD(&fp->list);
+
+	/* ok, let's parse further... */
+	if (snd_usb_parse_audio_format_v3(chip, fp, as, stream) < 0) {
+		kfree(fp->rate_table);
+		kfree(fp);
+		return NULL;
+	}
+
+	return fp;
+}
+
 int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 {
 	struct usb_device *dev;
@@ -633,13 +946,8 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 	struct usb_host_interface *alts;
 	struct usb_interface_descriptor *altsd;
 	int i, altno, err, stream;
-	u64 format = 0;
-	unsigned int num_channels = 0;
 	struct audioformat *fp = NULL;
-	int num, protocol, clock = 0;
-	struct uac_format_type_i_continuous_descriptor *fmt = NULL;
-	struct snd_pcm_chmap_elem *chmap_v3 = NULL;
-	unsigned int chconfig;
+	int num, protocol;
 
 	dev = chip->dev;
 
@@ -688,303 +996,50 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		    protocol <= 2)
 			protocol = UAC_VERSION_1;
 
-		chconfig = 0;
-		/* get audio formats */
 		switch (protocol) {
 		default:
 			dev_dbg(&dev->dev, "%u:%d: unknown interface protocol %#02x, assuming v1\n",
 				iface_no, altno, protocol);
 			protocol = UAC_VERSION_1;
 			/* fall through */
-
-		case UAC_VERSION_1: {
-			struct uac1_as_header_descriptor *as =
-				snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
-			struct uac_input_terminal_descriptor *iterm;
-
-			if (!as) {
-				dev_err(&dev->dev,
-					"%u:%d : UAC_AS_GENERAL descriptor not found\n",
-					iface_no, altno);
-				continue;
-			}
-
-			if (as->bLength < sizeof(*as)) {
-				dev_err(&dev->dev,
-					"%u:%d : invalid UAC_AS_GENERAL desc\n",
-					iface_no, altno);
-				continue;
-			}
-
-			format = le16_to_cpu(as->wFormatTag); /* remember the format value */
-
-			iterm = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
-								       as->bTerminalLink);
-			if (iterm) {
-				num_channels = iterm->bNrChannels;
-				chconfig = le16_to_cpu(iterm->wChannelConfig);
-			}
-
-			break;
-		}
-
+		case UAC_VERSION_1:
+			/* fall through */
 		case UAC_VERSION_2: {
-			struct uac2_input_terminal_descriptor *input_term;
-			struct uac2_output_terminal_descriptor *output_term;
-			struct uac2_as_header_descriptor *as =
-				snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
-
-			if (!as) {
-				dev_err(&dev->dev,
-					"%u:%d : UAC_AS_GENERAL descriptor not found\n",
-					iface_no, altno);
-				continue;
-			}
-
-			if (as->bLength < sizeof(*as)) {
-				dev_err(&dev->dev,
-					"%u:%d : invalid UAC_AS_GENERAL desc\n",
-					iface_no, altno);
-				continue;
-			}
-
-			num_channels = as->bNrChannels;
-			format = le32_to_cpu(as->bmFormats);
-			chconfig = le32_to_cpu(as->bmChannelConfig);
-
-			/* lookup the terminal associated to this interface
-			 * to extract the clock */
-			input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
-									    as->bTerminalLink);
-			if (input_term) {
-				clock = input_term->bCSourceID;
-				if (!chconfig && (num_channels == input_term->bNrChannels))
-					chconfig = le32_to_cpu(input_term->bmChannelConfig);
-				break;
-			}
-
-			output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
-									      as->bTerminalLink);
-			if (output_term) {
-				clock = output_term->bCSourceID;
-				break;
-			}
-
-			dev_err(&dev->dev,
-				"%u:%d : bogus bTerminalLink %d\n",
-				iface_no, altno, as->bTerminalLink);
-			continue;
-		}
-
-		case UAC_VERSION_3: {
-			struct uac3_input_terminal_descriptor *input_term;
-			struct uac3_output_terminal_descriptor *output_term;
-			struct uac3_as_header_descriptor *as;
-			struct uac3_cluster_header_descriptor *cluster;
-			struct uac3_hc_descriptor_header hc_header;
-			u16 cluster_id, wLength;
-
-			as = snd_usb_find_csint_desc(alts->extra,
-							alts->extralen,
-							NULL, UAC_AS_GENERAL);
-
-			if (!as) {
-				dev_err(&dev->dev,
-					"%u:%d : UAC_AS_GENERAL descriptor not found\n",
-					iface_no, altno);
-				continue;
-			}
-
-			if (as->bLength < sizeof(*as)) {
-				dev_err(&dev->dev,
-					"%u:%d : invalid UAC_AS_GENERAL desc\n",
-					iface_no, altno);
-				continue;
-			}
-
-			cluster_id = le16_to_cpu(as->wClusterDescrID);
-			if (!cluster_id) {
-				dev_err(&dev->dev,
-					"%u:%d : no cluster descriptor\n",
-					iface_no, altno);
-				continue;
-			}
-
-			/*
-			 * Get number of channels and channel map through
-			 * High Capability Cluster Descriptor
-			 *
-			 * First step: get High Capability header and
-			 * read size of Cluster Descriptor
-			 */
-			err = snd_usb_ctl_msg(chip->dev,
-					usb_rcvctrlpipe(chip->dev, 0),
-					UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
-					USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
-					cluster_id,
-					snd_usb_ctrl_intf(chip),
-					&hc_header, sizeof(hc_header));
-			if (err < 0)
-				return err;
-			else if (err != sizeof(hc_header)) {
-				dev_err(&dev->dev,
-					"%u:%d : can't get High Capability descriptor\n",
-					iface_no, altno);
-				return -EIO;
-			}
-
-			/*
-			 * Second step: allocate needed amount of memory
-			 * and request Cluster Descriptor
-			 */
-			wLength = le16_to_cpu(hc_header.wLength);
-			cluster = kzalloc(wLength, GFP_KERNEL);
-			if (!cluster)
-				return -ENOMEM;
-			err = snd_usb_ctl_msg(chip->dev,
-					usb_rcvctrlpipe(chip->dev, 0),
-					UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
-					USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
-					cluster_id,
-					snd_usb_ctrl_intf(chip),
-					cluster, wLength);
-			if (err < 0) {
-				kfree(cluster);
-				return err;
-			} else if (err != wLength) {
-				dev_err(&dev->dev,
-					"%u:%d : can't get Cluster Descriptor\n",
-					iface_no, altno);
-				kfree(cluster);
-				return -EIO;
-			}
-
-			num_channels = cluster->bNrChannels;
-			chmap_v3 = convert_chmap_v3(cluster);
-
-			kfree(cluster);
-
-			format = le64_to_cpu(as->bmFormats);
-
-			/* lookup the terminal associated to this interface
-			 * to extract the clock */
-			input_term = snd_usb_find_input_terminal_descriptor(
-							chip->ctrl_intf,
-							as->bTerminalLink);
-
-			if (input_term) {
-				clock = input_term->bCSourceID;
-				break;
-			}
-
-			output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
-									      as->bTerminalLink);
-			if (output_term) {
-				clock = output_term->bCSourceID;
-				break;
-			}
-
-			dev_err(&dev->dev,
-				"%u:%d : bogus bTerminalLink %d\n",
-				iface_no, altno, as->bTerminalLink);
-			continue;
-		}
-		}
-
-		if (protocol == UAC_VERSION_1 || protocol == UAC_VERSION_2) {
-			/* get format type */
-			fmt = snd_usb_find_csint_desc(alts->extra,
-						      alts->extralen,
-						      NULL, UAC_FORMAT_TYPE);
-			if (!fmt) {
-				dev_err(&dev->dev,
-					"%u:%d : no UAC_FORMAT_TYPE desc\n",
-					iface_no, altno);
-				continue;
-			}
-			if (((protocol == UAC_VERSION_1) && (fmt->bLength < 8))
-					|| ((protocol == UAC_VERSION_2) &&
-							(fmt->bLength < 6))) {
-				dev_err(&dev->dev,
-					"%u:%d : invalid UAC_FORMAT_TYPE desc\n",
-					iface_no, altno);
-				continue;
-			}
+			int bm_quirk = 0;
 
 			/*
 			 * Blue Microphones workaround: The last altsetting is
 			 * identical with the previous one, except for a larger
 			 * packet size, but is actually a mislabeled two-channel
 			 * setting; ignore it.
+			 *
+			 * Part 1: prepare quirk flag
 			 */
-			if (fmt->bNrChannels == 1 &&
-			    fmt->bSubframeSize == 2 &&
-			    altno == 2 && num == 3 &&
+			if (altno == 2 && num == 3 &&
 			    fp && fp->altsetting == 1 && fp->channels == 1 &&
 			    fp->formats == SNDRV_PCM_FMTBIT_S16_LE &&
 			    protocol == UAC_VERSION_1 &&
 			    le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize) ==
 							fp->maxpacksize * 2)
-				continue;
+				bm_quirk = 1;
+
+			fp = snd_usb_get_audioformat_uac12(chip, alts, protocol,
+							   iface_no, altno,
+							   stream, bm_quirk);
+			break;
+		}
+		case UAC_VERSION_3:
+			fp = snd_usb_get_audioformat_uac3(chip, alts,
+						iface_no, altno, stream);
+			break;
 		}
 
-		fp = kzalloc(sizeof(*fp), GFP_KERNEL);
 		if (!fp)
-			return -ENOMEM;
+			continue;
+		else if (IS_ERR(fp))
+			return PTR_ERR(fp);
 
-		fp->iface = iface_no;
-		fp->altsetting = altno;
 		fp->altset_idx = i;
-		fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
-		fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
-		fp->datainterval = snd_usb_parse_datainterval(chip, alts);
-		fp->protocol = protocol;
-		fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
-		fp->channels = num_channels;
-		if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
-			fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
-					* (fp->maxpacksize & 0x7ff);
-		fp->attributes = parse_uac_endpoint_attributes(chip, alts, protocol, iface_no);
-		fp->clock = clock;
-		INIT_LIST_HEAD(&fp->list);
-
-		/* some quirks for attributes here */
-		snd_usb_audioformat_attributes_quirk(chip, fp, stream);
-
-		/* ok, let's parse further... */
-		if (protocol == UAC_VERSION_1 || protocol == UAC_VERSION_2) {
-			if (snd_usb_parse_audio_format(chip, fp, format,
-							fmt, stream) < 0) {
-				kfree(fp->rate_table);
-				kfree(fp);
-				fp = NULL;
-				continue;
-			}
-		} else {
-			struct uac3_as_header_descriptor *as;
-
-			as = snd_usb_find_csint_desc(alts->extra,
-						     alts->extralen,
-						     NULL, UAC_AS_GENERAL);
-
-			if (snd_usb_parse_audio_format_v3(chip, fp, as,
-								stream) < 0) {
-				kfree(fp->rate_table);
-				kfree(fp);
-				fp = NULL;
-				continue;
-			}
-		}
-
-		/* Create chmap */
-		if (fp->channels != num_channels)
-			chconfig = 0;
-
-		if (protocol == UAC_VERSION_3)
-			fp->chmap = chmap_v3;
-		else
-			fp->chmap = convert_chmap(fp->channels, chconfig,
-						  protocol);
 
 		dev_dbg(&dev->dev, "%u:%d: add audio endpoint %#x\n", iface_no, altno, fp->endpoint);
 		err = snd_usb_add_audio_stream(chip, stream, fp);
-- 
1.9.1
