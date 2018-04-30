Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpJFtqIvf5PcuGMJlgw9/sPBbKtVujHimCM9OJjM14XfT0nOxLLuCT9N1obq4cQf1g8JgcK
ARC-Seal: i=1; a=rsa-sha256; t=1525116516; cv=none;
        d=google.com; s=arc-20160816;
        b=y9DcM6Z43JgizUU6cUOrygeeQaBC9O9aQuOHsCASYN37Z5YsQ/XxtuIH08eNI8sn53
         3bkUirU77hVDJIomIqVsyKAIbZMidm6NaZzlwbqpa5Y2XXVd45Bb7FWQm8cFpzEg8WZt
         SWLHJNHIENMkGwM7YOkQmdCi8A4KRli+pEtsp446E1iRKZpCfZ72fjRPM9A5gY0zWDKF
         pA5n6Y1CIcUGLkiKxMZK8EerjBwpoVScVLuufd3DvuAf1vS9MIRFhKZBQSsKPUoesfMk
         zahsgCotvEelTOM/Oa5RZxhSFftIqbB3hCz0TXXwT0PcsLqUx27o1Y2iCnbY69RoWDo5
         uXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Dv6RS00eLbCVpOGQDotoLD1NiiJ9D77SHf3J+qS0LXI=;
        b=NKBEA4yCYp/vwCskrnjH96GD0133AsF4TZOLNuK0vCjptUIW75sW3MLvk7ex6VXV3/
         KG1PW2WxKD+SgU1uKyPLT+hyC3P45quP4Ix1GFlfWUrjfbOP89rsaQodVrzOfahToZn+
         y5HkbQ8AstyyOVlPdVBDn+RdERgMhHPUv9UNVX7QFGe6p5Ko6S5OnWixz2Fc2YWUgC9C
         14UpC2zOq7Z/5dQeUa+KLHNvkQLI5TErFTax5+IHqKxAdi5iVtLIKDbk/riiLYNEj33N
         n0fwqkzU87GjbAtI2oJoZfq2jHJGDoQBE8I2k57o3bXS3PSFpdCpvJRFcJZzrCHGIG8t
         +NRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3026022DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 043/113] ALSA: hdspm: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:14 -0700
Message-Id: <20180430184016.875135579@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200425501203379?=
X-GMAIL-MSGID: =?utf-8?q?1599200576538036721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 
