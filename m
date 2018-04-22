Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48vETtGwvjub+BXVxJ6aiWpqAg6uaaGNPe6vwp9EyKgY8qcZvcVpTQ+Cc48AHI9uX4e3f1Q
ARC-Seal: i=1; a=rsa-sha256; t=1524406888; cv=none;
        d=google.com; s=arc-20160816;
        b=YF529jJUdER9TTbivQ7DGL85TmQvHSsHT0SsDZG8H1mt27BrY/uGSoh+C9LsxHOtdp
         /bLoxlldS21eZ/aH0j8a5NpopOST/ba5iEjt4AHjs76Db0rGghc3XBkGSsO4l0qRdS2C
         2ZDOmC+Wnawg46+kANlB4rd6JsUYymbIdQl9yWYYh0/vncqXXnkSRr9o+ymdPm2uLD+n
         dkqV7fnYJER3QH5v5TZM0RQOejxe0z2r3ZLiieFaeR3I/mgNf00a+8lBVTWnc3EHlI+Y
         egfADliT5IVdAUJQzRTLzIZJ0wffU9Yjn+wbDh5RDKI48H0T7H/HGCBDS2jzX0hE6cQt
         CCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VTNpfZFxHRo6BwAqFQycFgty9PIh4a6sgS9ByZxod+0=;
        b=hn2Vgn+SeB9cQcJvFyXpYjAen32ot1Gk+SjcTWNEDI1eeGHUQ+oLLy7M2udXC2BQ2U
         zW9yvbk+GnwIvHFNSF8ykdWFyUXpovwJWGg4iPN15WpWQS5uqvjfhIxONNieetOD0GuP
         u83HrdwDP4Pa1ItNzB5iAtuWW4Ss6L8dnMMl1E450Cyn0QZwAsoSRMPjoVBi/Wr951mU
         f3Q+jm2LNytNo4Mnom3C8NA/JAJdgrvWi/ZghrDaHD47i9a97Gx4FOjvvXOy8HmW3QH6
         6fQhA6aYLnq/koO/U1cgNYz9X++tP9GtGYwJyjWq/DOLxH2nSCZPcFAH0aNyQUmXD5In
         dfmg==
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
Subject: [PATCH 3.18 41/52] ALSA: rawmidi: Fix missing input substream checks in compat ioctls
Date: Sun, 22 Apr 2018 15:54:14 +0200
Message-Id: <20180422135317.278063464@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455298881914693?=
X-GMAIL-MSGID: =?utf-8?q?1598456478305660322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -113,16 +117,18 @@ static int snd_rawmidi_ioctl_status_x32(
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
