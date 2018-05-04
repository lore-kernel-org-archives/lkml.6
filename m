Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525397094; cv=none;
        d=google.com; s=arc-20160816;
        b=j8HvUS6wW0dLqSw+eiPHEm0aCHtpUTypD71VpUVLLqXUNJ91cbJYaI8J0ZRaVXFkK2
         bkGgLsajxqSip1h8XL6xeSc+Mv03FskRr7X+1xnemYvuUWixMLC+swLEo3Xuo/n6C0T3
         mvCXdZ6k7qdrF8oFYr7QMTWxtnemMZTwtYhKI3L5iZPN5Wyg1zvBA0GJZdHsa4qUj/h4
         CZbuUUPk1htKnxP3cHOAVtBlcL474GRojJMp4cketk6oeLrFmAAmNRSi8sBBZPi0H/nU
         ADgl0+S0CX1KO7SeIo7z4SaIR5AroJvJZPKH31OxDk35lfrH+Euq2Ejg3cDrINi1ekdw
         CyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Brmc9jH2qrqVJEuvXXiZBJOteg8YSQtvLE6IJtkc8A8=;
        b=w3z8C7AmyPQP5eowO/wAUzJgjzyQxbonn0ejihNh4AU7q4Fa1STiRV0YLWCPSBMU24
         kxmKCRYRoE1rpX9SxVRkieU8ImlMLPwDNpdexi388meEF0WsfA/ZTJWyNp2idIlphYKE
         lAkPtHpUtHPipySmd92lWWYvFUDaiH0ua3wEvdXcjyQgyZoAlt9927MaTmRToZ3MUYUo
         saayVkSaJIvJi+J5y77seAqp3dFSJXYc0w+PXY7c4fE3XPX/3QD3Ej1oV1fWyRjBPdwg
         Y1aP4l/aIG2MYxm+K6m2gbE822h2rkf3BWvoMrgSQPqWeMtlSv5vhoJ/yvOE2PMXqDGh
         +CgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=grgArWhN;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=grgArWhN;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrp2cpfqI+FGlM6EB28Rmch5+Jtk+9mcQ7ft2nLf27pW2wVur5Ga24rJpM6QqdeaVSsFuMjRA==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>,
	Andrew Chant <achant@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] ALSA: usb: stream: refactor uac3 audio interface parsing
Date: Fri,  4 May 2018 04:24:00 +0300
Message-Id: <1525397044-15080-4-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599494783943065333?=
X-GMAIL-MSGID: =?utf-8?q?1599494783943065333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Offload snd_usb_parse_audio_interface() function
which became quite long after adding UAC3 spec support.

Move class-specific parts of uac3 parsing to separate
function which now produce audioformat structure that
is ready to be fed to snd_usb_add_audio_stream().

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 sound/usb/stream.c | 289 +++++++++++++++++++++++++++--------------------------
 1 file changed, 146 insertions(+), 143 deletions(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 3369226..764be07 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -807,19 +807,154 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 	return fp;
 }
 
+static struct audioformat *
+snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
+			     struct usb_host_interface *alts,
+			     int iface_no, int altset_idx,
+			     int altno, int stream)
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
+	fp = audio_format_alloc_init(chip, alts, UAC_VERSION_3, iface_no,
+				     altset_idx, altno, num_channels, clock);
+	if (!fp)
+		return ERR_PTR(-ENOMEM);
+
+	fp->attributes = parse_uac_endpoint_attributes(chip, alts,
+						       UAC_VERSION_3,
+						       iface_no);
+	fp->chmap = chmap;
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
 	struct usb_interface *iface;
 	struct usb_host_interface *alts;
 	struct usb_interface_descriptor *altsd;
-	struct uac3_as_header_descriptor *as = NULL;
 	int i, altno, err, stream;
-	u64 format = 0;
-	unsigned int num_channels = 0;
 	struct audioformat *fp = NULL;
-	int num, protocol, clock = 0;
-	struct snd_pcm_chmap_elem *chmap_v3 = NULL;
+	int num, protocol;
 
 	dev = chip->dev;
 
@@ -900,149 +1035,17 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 							   stream, bm_quirk);
 			break;
 		}
-		case UAC_VERSION_3: {
-			struct uac3_input_terminal_descriptor *input_term;
-			struct uac3_output_terminal_descriptor *output_term;
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
-			if (!fp)
-				continue;
-			else if (IS_ERR(fp))
-				return PTR_ERR(fp);
-
-			goto skip_uac3;
+		case UAC_VERSION_3:
+			fp = snd_usb_get_audioformat_uac3(chip, alts,
+						iface_no, i, altno, stream);
+			break;
 		}
 
-		fp = audio_format_alloc_init(chip, alts, protocol, iface_no, i,
-					     altno, num_channels, clock);
 		if (!fp)
-			return -ENOMEM;
-
-		fp->attributes = parse_uac_endpoint_attributes(chip, alts,
-							       protocol,
-							       iface_no);
-		fp->chmap = chmap_v3;
-
-		/* ok, let's parse further... */
-		if (snd_usb_parse_audio_format_v3(chip, fp, as,
-							stream) < 0) {
-			kfree(fp->rate_table);
-			kfree(fp);
-			fp = NULL;
 			continue;
-		}
+		else if (IS_ERR(fp))
+			return PTR_ERR(fp);
 
-skip_uac3:
 		dev_dbg(&dev->dev, "%u:%d: add audio endpoint %#x\n", iface_no, altno, fp->endpoint);
 		err = snd_usb_add_audio_stream(chip, stream, fp);
 		if (err < 0) {
-- 
1.9.1
