Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuPWhFX6M6tpglkHkg5WK1aK+LGXj9btQieg22b8ffQm0r0vAeiRRgfmPgnwa05ejtXUXdZ
ARC-Seal: i=1; a=rsa-sha256; t=1521484273; cv=none;
        d=google.com; s=arc-20160816;
        b=R+80/9wmg/b01mjxDpaLxuFwR68gMlSywAxHSHJtC7oaBC7ZQMC+yEhentGegJZrP4
         n4pS2OYwpz29qQrCwmQZeWWbjlStORT6X0y5tq0yiIlE3Kp11efl5fdIeMD9wAhxkjfj
         jjuvPzRF9RvxSoYWxo1PPnOCxehPzu5uEIKfUJZi4Qx+EauF0tFnty7UKesG4DP7QXvL
         XW+2MB+0B+q96BGVUXlrUhVM8EiKdKK7DOj8anXpoCLnGsNAca6uF/2musP5REWgmV1j
         6JegGCxL49GMds20j6XPKMFV+5lJb5g4bneGAlooDIo7B1lp17XBcXF7ylUQ+DJ5Qc1Y
         pimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u9kVfrKrfhC7XhFBmFz6BqhwRRYW8JKqQdk6DV79q6c=;
        b=opd6Ys8Rte/XdvDP6ryCbuJc0zFSH4msSBQw8r1pJmMVk1n0wqWA0visNImEmrJwkG
         +sRGUoo9z+sKlH4L+2iI7o1MiyGYxZ/svkL3UUc2HzNILIKbUY3RWR4mr3DVx8Ew8zxK
         TRT76Vqbq/v/otDvCV2bHd4867S2VLwwwc5aK1nuW8zrmX8AubWlxI+amooqiM705Y3k
         +gldJ0BDnrYQ0gqkqSVgRbQZr+sVEGxRy3DB5dMOR12LGRmcIeGI6/y0y3Xyb5sHQ4i4
         0eDPpxop6TkQz2PkPjUoBtALeun4Zcf6nGgw8jvCN3LEEgKnylboFGsiEW8DB8MH7MRF
         VV8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+4090700a4f13fccaf648@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 11/52] ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()
Date: Mon, 19 Mar 2018 19:08:09 +0100
Message-Id: <20180319180735.741994907@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390642761119786?=
X-GMAIL-MSGID: =?utf-8?q?1595391894039173500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 01c0b4265cc16bc1f43f475c5944c55c10d5768f upstream.

snd_pcm_oss_get_formats() has an obvious use-after-free around
snd_mask_test() calls, as spotted by syzbot.  The passed format_mask
argument is a pointer to the hw_params object that is freed before the
loop.  What a surprise that it has been present since the original
code of decades ago...

Reported-by: syzbot+4090700a4f13fccaf648@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1762,10 +1762,9 @@ static int snd_pcm_oss_get_formats(struc
 		return -ENOMEM;
 	_snd_pcm_hw_params_any(params);
 	err = snd_pcm_hw_refine(substream, params);
-	format_mask = hw_param_mask_c(params, SNDRV_PCM_HW_PARAM_FORMAT);
-	kfree(params);
 	if (err < 0)
-		return err;
+		goto error;
+	format_mask = hw_param_mask_c(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	for (fmt = 0; fmt < 32; ++fmt) {
 		if (snd_mask_test(format_mask, fmt)) {
 			int f = snd_pcm_oss_format_to(fmt);
@@ -1773,7 +1772,10 @@ static int snd_pcm_oss_get_formats(struc
 				formats |= f;
 		}
 	}
-	return formats;
+
+ error:
+	kfree(params);
+	return err < 0 ? err : formats;
 }
 
 static int snd_pcm_oss_set_format(struct snd_pcm_oss_file *pcm_oss_file, int format)
