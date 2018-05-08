Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoBNINJHMZIMR3FvHZ9iaBUsUlwCRq55LpxgngBRZapTq/lo8jQ4a/eZWuWFJd6bpYjs4mR
ARC-Seal: i=1; a=rsa-sha256; t=1525767121; cv=none;
        d=google.com; s=arc-20160816;
        b=IGTHu8O4sViXWiSDd1uPIgAMyLAjdU6fguALyQTgLMXd4PO5rl5Re+AG0CqbUjG3bM
         l0pG61jdLAUlOY/b/8iALuPz6IOwQUBcGQX8R8VarU/svR2RWpGLvjdlJ06qpOCQ2LOh
         44a9yMXSzMu6bAcSuqpXKYXZSvIFhAzaCqhVJ9a8WR6EGxLQCOr8t0axieY9G7BG5bS7
         txTYeoUWTZ1aLf5gHt9P4e6DCw4nm3P2n36HSinXoYHdaOrMVg8L6JwE6pn8aLXzwXG9
         +bAMgFTOP2ALkyZFjQCYK19PBCAhZKBYFKK+35N5FonM/Q7bhYv1rI3zw1wjNV7RkSNO
         s+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=TLsEWd9XEvlT5nLYROVq7uRnaTvJwEml7lURuEhS/Kc=;
        b=WbR0BXGYa/36CBHkWA48b6Mbl2Yi0jeK5LOQG+UYKRwmZ85YyGBFGRiNk11iV2apBp
         dS7kZeOK8d2n15LA3FFlqgGTeQZGc0zn9Ct1jPnySO8eBh5T2DqbgNMVozUbqMCA4rfy
         WCnJjywP1AcjdvBqXjsW2ycBnr7uALzU/v8XT40/d0H984tTEilinghWW56sDckDBo+1
         HHkFNj4y+5SfKMJ4Xaw//i8+awAZMBVR/sL6ivNz2Eu+5JK9VDSc5rawz/opSaoZy6LB
         VSsmyc5kYDp6fyzAy7sv08JtfdogIZ6ia33GCHSplyPgZKJGo6+c3fVg8SkxxNRYCbfq
         /mBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=yEu21eWA;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=yEu21eWA;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+1dac3a4f6bc9c1c675d4@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 04/52] ALSA: pcm: Check PCM state at xfern compat ioctl
Date: Tue,  8 May 2018 10:10:02 +0200
Message-Id: <20180508073928.636680894@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882785467298438?=
X-GMAIL-MSGID: =?utf-8?q?1599882785467298438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f13876e2c33a657a71bcbb10f767c0951b165020 upstream.

Since snd_pcm_ioctl_xfern_compat() has no PCM state check, it may go
further and hit the sanity check pcm_sanity_check() when the ioctl is
called right after open.  It may eventually spew a kernel warning, as
triggered by syzbot, depending on kconfig.

The lack of PCM state check there was just an oversight.  Although
it's no real crash, the spurious kernel warning is annoying, so let's
add the proper check.

Reported-by: syzbot+1dac3a4f6bc9c1c675d4@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm_compat.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -423,6 +423,8 @@ static int snd_pcm_ioctl_xfern_compat(st
 		return -ENOTTY;
 	if (substream->stream != dir)
 		return -EINVAL;
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+		return -EBADFD;
 
 	if ((ch = substream->runtime->channels) > 128)
 		return -EINVAL;
