Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525397092; cv=none;
        d=google.com; s=arc-20160816;
        b=ehwXfRBld6cwaCCWqDN68t7VS3TY5FFmVPSslgue9Q3GpXYRvE5T+5afUYZWEotdju
         D/fmoUt3hJvn0FJ4qmn8FgNk68ZCURtA7cCI4MUSyRYR/bAni6Y9/Gqfm0S2isRWNWye
         YnQvpQar0CBuIII8BVoLcMH6F5HqCqMoj+Dn/vU4oxcuzw6uE6srFVtULiXW7zEPsqLL
         PGwEXfQJoT8pUbtKLZZbK+KbxMWCPFMVJ0Lg4b+MVohbrP+czTdPmdtEW/61jBomNr0L
         XJGeT6orvM+NO2OzhEi1t1cwlbxhYvqz4spiiPOHJ0ni5NIN8nejMXQwGvisMlFGSqgY
         SAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=mTDwbCCAgVGuhjKLI1fv8k84Vtt7fiORiHVM5xcC+rU=;
        b=ByT47Bg0AvmNb9MG8oe59XOfGz8HHmIJA4LixUAmllJSpECDgWulH2Gu53K3EJGb2e
         T8sdLqAueeBPZBZF7GEg8WkZdo/iiOSxXBB8AqSZQcJnxXAj20yJLUdjt0rQgym/dJkX
         tFDgTW1nH2szZdKEM8+wa/3V2/mzpRA52EeNZIkcTOd/PrZzAY8yuwVrvtiSewHE4N+g
         Nl1bfTHmo/bawtuYWutraLcDMNTRmaDDVU+1lv+3INktgEzBWrQ4Yhhaj24Ss4AcLq1A
         on8KyxLCgG8Rau3MoN9os+jzQ/9l7SUDk/dVML03qDVTPZtIOQacrmADaRV2lozCaPZZ
         2hAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Px4a+3K5;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Px4a+3K5;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqbXJHz+a0PQXzz/FPguDux/qOic/LNTr3R9mkFWfSvCxyG285+coBPUWbSU7CZ8aVtVw/JGA==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>,
	Andrew Chant <achant@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] ALSA: usb: stream: refactor uac1/2 audio interface parsing
Date: Fri,  4 May 2018 04:23:59 +0300
Message-Id: <1525397044-15080-3-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599494781743474446?=
X-GMAIL-MSGID: =?utf-8?q?1599494781743474446?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Offload snd_usb_parse_audio_interface() function
which became quite long after adding UAC3 spec support.

Move class-specific parts of uac1/2 parsing to separate
function which now produce audioformat structure that
is ready to be fed to snd_usb_add_audio_stream().

This also broke Blue Microphones workaround (which
relies on audioformat decoded from previous altsetting)
into two parts: prepare quirk flag analyzing previous
altsetting then use it with current altsetting.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 sound/usb/stream.c | 333 +++++++++++++++++++++++++++++------------------------
 1 file changed, 185 insertions(+), 148 deletions(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 8ec0a52..3369226 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -656,6 +656,156 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 	return fp;
 }
 
+static struct audioformat *
+snd_usb_get_audioformat_uac12(struct snd_usb_audio *chip,
+			      struct usb_host_interface *alts,
+			      int protocol, int iface_no, int altset_idx,
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
+	fp = audio_format_alloc_init(chip, alts, protocol, iface_no,
+				     altset_idx, altno, num_channels, clock);
+	if (!fp)
+		return ERR_PTR(-ENOMEM);
+
+	fp->attributes = parse_uac_endpoint_attributes(chip, alts, protocol,
+						       iface_no);
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
 
 int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 {
@@ -663,14 +813,13 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 	struct usb_interface *iface;
 	struct usb_host_interface *alts;
 	struct usb_interface_descriptor *altsd;
+	struct uac3_as_header_descriptor *as = NULL;
 	int i, altno, err, stream;
 	u64 format = 0;
 	unsigned int num_channels = 0;
 	struct audioformat *fp = NULL;
 	int num, protocol, clock = 0;
-	struct uac_format_type_i_continuous_descriptor *fmt = NULL;
 	struct snd_pcm_chmap_elem *chmap_v3 = NULL;
-	unsigned int chconfig;
 
 	dev = chip->dev;
 
@@ -719,98 +868,41 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
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
+			int bm_quirk = 0;
 
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
+			/*
+			 * Blue Microphones workaround: The last altsetting is
+			 * identical with the previous one, except for a larger
+			 * packet size, but is actually a mislabeled two-channel
+			 * setting; ignore it.
+			 *
+			 * Part 1: prepare quirk flag
+			 */
+			if (altno == 2 && num == 3 &&
+			    fp && fp->altsetting == 1 && fp->channels == 1 &&
+			    fp->formats == SNDRV_PCM_FMTBIT_S16_LE &&
+			    protocol == UAC_VERSION_1 &&
+			    le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize) ==
+							fp->maxpacksize * 2)
+				bm_quirk = 1;
 
-			dev_err(&dev->dev,
-				"%u:%d : bogus bTerminalLink %d\n",
-				iface_no, altno, as->bTerminalLink);
-			continue;
+			fp = snd_usb_get_audioformat_uac12(chip, alts, protocol,
+							   iface_no, i, altno,
+							   stream, bm_quirk);
+			break;
 		}
-
 		case UAC_VERSION_3: {
 			struct uac3_input_terminal_descriptor *input_term;
 			struct uac3_output_terminal_descriptor *output_term;
-			struct uac3_as_header_descriptor *as;
 			struct uac3_cluster_header_descriptor *cluster;
 			struct uac3_hc_descriptor_header hc_header;
 			u16 cluster_id, wLength;
@@ -923,40 +1015,12 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		}
 
 		if (protocol == UAC_VERSION_1 || protocol == UAC_VERSION_2) {
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
+			if (!fp)
 				continue;
-			}
+			else if (IS_ERR(fp))
+				return PTR_ERR(fp);
 
-			/*
-			 * Blue Microphones workaround: The last altsetting is
-			 * identical with the previous one, except for a larger
-			 * packet size, but is actually a mislabeled two-channel
-			 * setting; ignore it.
-			 */
-			if (fmt->bNrChannels == 1 &&
-			    fmt->bSubframeSize == 2 &&
-			    altno == 2 && num == 3 &&
-			    fp && fp->altsetting == 1 && fp->channels == 1 &&
-			    fp->formats == SNDRV_PCM_FMTBIT_S16_LE &&
-			    protocol == UAC_VERSION_1 &&
-			    le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize) ==
-							fp->maxpacksize * 2)
-				continue;
+			goto skip_uac3;
 		}
 
 		fp = audio_format_alloc_init(chip, alts, protocol, iface_no, i,
@@ -967,45 +1031,18 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		fp->attributes = parse_uac_endpoint_attributes(chip, alts,
 							       protocol,
 							       iface_no);
-
-		/* some quirks for attributes here */
-		snd_usb_audioformat_attributes_quirk(chip, fp, stream);
+		fp->chmap = chmap_v3;
 
 		/* ok, let's parse further... */
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
+		if (snd_usb_parse_audio_format_v3(chip, fp, as,
+							stream) < 0) {
+			kfree(fp->rate_table);
+			kfree(fp);
+			fp = NULL;
+			continue;
 		}
 
-		/* Create chmap */
-		if (fp->channels != num_channels)
-			chconfig = 0;
-
-		if (protocol == UAC_VERSION_3)
-			fp->chmap = chmap_v3;
-		else
-			fp->chmap = convert_chmap(fp->channels, chconfig,
-						  protocol);
-
+skip_uac3:
 		dev_dbg(&dev->dev, "%u:%d: add audio endpoint %#x\n", iface_no, altno, fp->endpoint);
 		err = snd_usb_add_audio_stream(chip, stream, fp);
 		if (err < 0) {
-- 
1.9.1
