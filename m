Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbeE3Ldt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:33:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60854 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751653AbeE3LHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:03 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "Erik Veijola" <erik.veijola@gmail.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.551567406@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 106/153] ALSA: usb-audio: Add a quirck for B&W PX
 headphones
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Veijola <erik.veijola@gmail.com>

commit 240a8af929c7c57dcde28682725b29cf8474e8e5 upstream.

The capture interface doesn't work and the playback interface only
supports 48 kHz sampling rate even though it advertises more rates.

Signed-off-by: Erik Veijola <erik.veijola@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/quirks-table.h | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2766,4 +2766,51 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
 	}
 },
 
+{
+	/*
+	 * Bower's & Wilkins PX headphones only support the 48 kHz sample rate
+	 * even though it advertises more. The capture interface doesn't work
+	 * even on windows.
+	 */
+	USB_DEVICE(0x19b5, 0x0021),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
+			},
+			/* Capture */
+			{
+				.ifnum = 1,
+				.type = QUIRK_IGNORE_INTERFACE,
+			},
+			/* Playback */
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S16_LE,
+					.channels = 2,
+					.iface = 2,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_FILL_MAX |
+						UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x03,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
+					.rate_max = 48000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) {
+						48000
+					}
+				}
+			},
+		}
+	}
+},
+
 #undef USB_DEVICE_VENDOR_SPEC
