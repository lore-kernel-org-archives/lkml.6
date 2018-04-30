Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqteqbQuGavbsgwNVn2xB3rP/LpJNJliszqlSuDxcvrg5EbNBCZgPm9+yyWwVUcrbnd+pR0
ARC-Seal: i=1; a=rsa-sha256; t=1525116372; cv=none;
        d=google.com; s=arc-20160816;
        b=AVHd5maF3+oA+KppJdbrsGTebDM9A+gyyBTUflVYvlm+HvuGzX8n7wDpuWxp2eBI4E
         yqOBwMQD89AaWmp5QwaPMPLsWD8a85J2kRgBTl96gxT0YUXVkmyY47g5jRlm4nNCpvpX
         rChFAqtofBSW1E0FnvQLhU8/eDhe5s6Xl5a4ds1LU8dK5qB48usQsmkLAvUsFBdvjKAs
         LbnzAwvPIvVAiDl7usCNA2FCciJ7TXGhTI/WxcXRDXChSo7swfihglyNsUAtVIXuKkIi
         BpUuh8YtsO+1n6vHn/i4IImwSayKHJpXSj19gpfARb8fKEgyTROu6e4wwPGmzQ9xy8pt
         3vdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=JhQkm/ZuSSXgHWGxvOFcmdrjW0kfS0EKQVb7mDDjwDE=;
        b=ACiyixkfiyzt9l6h7AMJ6CiQtKOJ0eHREcMcii8x8hfPpd2lyf4M2v0z5CRZ4O6HEt
         JjvTIRSHgBgaEvPYyzqTbdECm+PiZr6Ea9bmDN0VFbBI46TP5k8r5WfW//ZYbhejjvO7
         bjL6ZuiEH48JGoZFHHMl3KC9JeurbQSlfO/rRpUMLWzsUcszdGvIIwmGTt9BugaotDlZ
         QK9cMZ2j8bFx+wAQ1fmGlEm0cJxhdgOc/k3/x0hSAMgBfsNJBulIEC5EQgBDf/KMESjH
         8iHwQGdBssSNFgh1dbBNDXZTGmH7oSOcfm2u8esyq3QxH2IcAGi2M00ifIETyppNbN3h
         j13Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF1322DC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 22/44] ALSA: hdspm: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:33 -0700
Message-Id: <20180430190947.226606164@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200425501203379?=
X-GMAIL-MSGID: =?utf-8?q?1599200425501203379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 10513142a7114d251670361ad40cba2c61403406 upstream.

As recently Smatch suggested, a couple of places in HDSP MADI driver
may expand the array directly from the user-space value with
speculation:
  sound/pci/rme9652/hdspm.c:5717 snd_hdspm_channel_info() warn: potential spectre issue 'hdspm->channel_map_out' (local cap)
  sound/pci/rme9652/hdspm.c:5734 snd_hdspm_channel_info() warn: potential spectre issue 'hdspm->channel_map_in' (local cap)

This patch puts array_index_nospec() for hardening against them.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/rme9652/hdspm.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -137,6 +137,7 @@
 #include <linux/pci.h>
 #include <linux/math64.h>
 #include <linux/io.h>
+#include <linux/nospec.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -5692,40 +5693,43 @@ static int snd_hdspm_channel_info(struct
 		struct snd_pcm_channel_info *info)
 {
 	struct hdspm *hdspm = snd_pcm_substream_chip(substream);
+	unsigned int channel = info->channel;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (snd_BUG_ON(info->channel >= hdspm->max_channels_out)) {
+		if (snd_BUG_ON(channel >= hdspm->max_channels_out)) {
 			dev_info(hdspm->card->dev,
 				 "snd_hdspm_channel_info: output channel out of range (%d)\n",
-				 info->channel);
+				 channel);
 			return -EINVAL;
 		}
 
-		if (hdspm->channel_map_out[info->channel] < 0) {
+		channel = array_index_nospec(channel, hdspm->max_channels_out);
+		if (hdspm->channel_map_out[channel] < 0) {
 			dev_info(hdspm->card->dev,
 				 "snd_hdspm_channel_info: output channel %d mapped out\n",
-				 info->channel);
+				 channel);
 			return -EINVAL;
 		}
 
-		info->offset = hdspm->channel_map_out[info->channel] *
+		info->offset = hdspm->channel_map_out[channel] *
 			HDSPM_CHANNEL_BUFFER_BYTES;
 	} else {
-		if (snd_BUG_ON(info->channel >= hdspm->max_channels_in)) {
+		if (snd_BUG_ON(channel >= hdspm->max_channels_in)) {
 			dev_info(hdspm->card->dev,
 				 "snd_hdspm_channel_info: input channel out of range (%d)\n",
-				 info->channel);
+				 channel);
 			return -EINVAL;
 		}
 
-		if (hdspm->channel_map_in[info->channel] < 0) {
+		channel = array_index_nospec(channel, hdspm->max_channels_in);
+		if (hdspm->channel_map_in[channel] < 0) {
 			dev_info(hdspm->card->dev,
 				 "snd_hdspm_channel_info: input channel %d mapped out\n",
-				 info->channel);
+				 channel);
 			return -EINVAL;
 		}
 
-		info->offset = hdspm->channel_map_in[info->channel] *
+		info->offset = hdspm->channel_map_in[channel] *
 			HDSPM_CHANNEL_BUFFER_BYTES;
 	}
 
