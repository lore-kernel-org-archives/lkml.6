Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpuKE3+EzCbTKmCHEBA3kTJb0spG+bOOXWO4g+pjq7tOLwMAwUzgQ6mC5Pc9FFsejJPHf0N
ARC-Seal: i=1; a=rsa-sha256; t=1525116434; cv=none;
        d=google.com; s=arc-20160816;
        b=rD6JGbERR4u13+gafzRMKUERg8ZVCPkLqqGKF96HHocvPl9Ogcc8vReJ9jAR/qStgZ
         GJ/kan2omJOo6wK1sP4m2AHWjz/YqgWpiWAKmXnIEhA1EA+tXY71gWyDAsV1oAXYAAd3
         sPF7zN9VBqgb+VAdBZTSVEzErEoY31DhvQ/lYHHZs/aeXovY75JSTPZGYq1B+Th8yNJT
         ma6hDd3PjI0PTWghzSkjnH3A5Qj2SnXB/5qouIydiKhHRdkvx6boxcQ2BbSszV5XDQP0
         2qvyhpLFB0qziT4Yo7G0qiP0VrR+mDHO9p2agxFjzp5ffvVvsR5uC5FS6r+dI7BEgApJ
         Up2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=MzfCqD0VH5FV1UgibykHL4DWPb5KFKhtgWjA9sYxKWM=;
        b=xZrG1PmwZvB1YFdozzlpCmGHYLOKBKJChg2nH80LuJqol1vItPZ4xFjLee+m2KGlCh
         nfPPmeyIt4XsCbVESp/ssnj7GUqyo9DZi/eBGecKF7Z8qvBILyprd4kix5XtxXYfnG6u
         4zgxalFCSzH00hyBQsCN3bIbS2rsx/Xf814u6dw3saDc7QPokjBy1LYZw4AqO/83f7oA
         OGgj5kp07IaKwQ4IjFF4wKAdOmUiu2Cknz8cpmWaMYJs8Hb8mLQmKT+tohzeSwlS+zTn
         PEZCadq08Fd82Vb8aUxcuOBaAlGcLI0tQ3GNfd3VGGBuiJJ/n6U7OeMHob8QmfKf/rvX
         7eBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7767622DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 39/91] ALSA: hdspm: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:21 -0700
Message-Id: <20180430184006.201800944@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200425501203379?=
X-GMAIL-MSGID: =?utf-8?q?1599200489914436580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5698,40 +5699,43 @@ static int snd_hdspm_channel_info(struct
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
 
