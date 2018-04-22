Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+2vpsI3WRsifb96JI9iwF+D88/iJixLiZwHRP/iNYxFV5WlegbVf8EGF5CFY818OjHt5dn
ARC-Seal: i=1; a=rsa-sha256; t=1524405764; cv=none;
        d=google.com; s=arc-20160816;
        b=xt/WFhYETcC0jwJMC63aqJwsRGmV7woisLiF0wc0MtwiMvcnUI8U7K2BksyL1fHzUR
         bVdkcgPj1KDDZc2UzBlUsunzowDUQFlGMp/g+5hF1geQymwgAOjyydZ2q6/0N01tOt9/
         DiJSH0qpZALDocsP2fnH33u6WFpDwLSAqIr/fH6p4CY/lPn0ED3nE1AUNv5/bVBPGkdm
         QKk6IBK9OmQEKQ1f5YidRCEws+anzkr8wA3ym6vLc8GpiyMnXXZEmv3x3rxsIYYgLZI7
         LuYoJ9WUaIjc5LHAOsSgYyyx3vUm6LWKBH6px9yipTDLvBUdBLP0Kn2ygp6/UbwcxjR8
         Jryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=siAf5KS0T4fwZs+5oru9ZTawofAvK8vL/TiLqMDkFFk=;
        b=lHOFmiEBDr8eRKoTuQeEicF8W+iRKhE5h4TqRHqGV5fpr3dva0vlqMsDzmpqgM+JZR
         Yfk+nk3Ug/dD06aZxOEPDSZK1XqOywMx5B6OUiMFIpQyDDh5Zbob5xByPQS+1X8/sZGb
         HlfVjYP41h4rrHOfoWErOYgkA8qYl6LXjhNaNikvhMuKWgBy498ENeiMjoSEPK42yrbr
         uqohmKS6VUyWqzDcqdGk7/gW7Ev2IeMYGp7IUQJf7ePOQWcJ+GNKjQNg5lgcj8yGWIQX
         hCZU71CBtokmPeXrobQCDrrjRdl9OdJ6oq9jFA7AEY36kDdd2q1BbE9Sm9K5eqSuhXdK
         M+rg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+f7a0348affc3b67bc617@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 159/196] ALSA: rawmidi: Fix missing input substream checks in compat ioctls
Date: Sun, 22 Apr 2018 15:52:59 +0200
Message-Id: <20180422135112.444371628@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455298881914693?=
X-GMAIL-MSGID: =?utf-8?q?1598455298881914693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 8a56ef4f3ffba9ebf4967b61ef600b0a7ba10f11 upstream.

Some rawmidi compat ioctls lack of the input substream checks
(although they do check only for rfile->output).  This many eventually
lead to an Oops as NULL substream is passed to the rawmidi core
functions.

Fix it by adding the proper checks before each function call.

The bug was spotted by syzkaller.

Reported-by: syzbot+f7a0348affc3b67bc617@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/rawmidi_compat.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/sound/core/rawmidi_compat.c
+++ b/sound/core/rawmidi_compat.c
@@ -36,8 +36,6 @@ static int snd_rawmidi_ioctl_params_comp
 	struct snd_rawmidi_params params;
 	unsigned int val;
 
-	if (rfile->output == NULL)
-		return -EINVAL;
 	if (get_user(params.stream, &src->stream) ||
 	    get_user(params.buffer_size, &src->buffer_size) ||
 	    get_user(params.avail_min, &src->avail_min) ||
@@ -46,8 +44,12 @@ static int snd_rawmidi_ioctl_params_comp
 	params.no_active_sensing = val;
 	switch (params.stream) {
 	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (!rfile->output)
+			return -EINVAL;
 		return snd_rawmidi_output_params(rfile->output, &params);
 	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (!rfile->input)
+			return -EINVAL;
 		return snd_rawmidi_input_params(rfile->input, &params);
 	}
 	return -EINVAL;
@@ -67,16 +69,18 @@ static int snd_rawmidi_ioctl_status_comp
 	int err;
 	struct snd_rawmidi_status status;
 
-	if (rfile->output == NULL)
-		return -EINVAL;
 	if (get_user(status.stream, &src->stream))
 		return -EFAULT;
 
 	switch (status.stream) {
 	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (!rfile->output)
+			return -EINVAL;
 		err = snd_rawmidi_output_status(rfile->output, &status);
 		break;
 	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (!rfile->input)
+			return -EINVAL;
 		err = snd_rawmidi_input_status(rfile->input, &status);
 		break;
 	default:
@@ -112,16 +116,18 @@ static int snd_rawmidi_ioctl_status_x32(
 	int err;
 	struct snd_rawmidi_status status;
 
-	if (rfile->output == NULL)
-		return -EINVAL;
 	if (get_user(status.stream, &src->stream))
 		return -EFAULT;
 
 	switch (status.stream) {
 	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (!rfile->output)
+			return -EINVAL;
 		err = snd_rawmidi_output_status(rfile->output, &status);
 		break;
 	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (!rfile->input)
+			return -EINVAL;
 		err = snd_rawmidi_input_status(rfile->input, &status);
 		break;
 	default:
