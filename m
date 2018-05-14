Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoOWhSH73E236gqoEp3AxpinmprwGgjzDTJn+iv6mmteaABgcuKMIER5E2z2g6LydoCR6w1
ARC-Seal: i=1; a=rsa-sha256; t=1526280666; cv=none;
        d=google.com; s=arc-20160816;
        b=sgLcyIotBJM7JowOcP1TghNLfRGOfM96zToko3bylREplUKVM3RjpTOJrreyGGt1tW
         O5Qpt0gSzwfSpB3FEhWMQVc8S9SY5/CuI3+BdvfP/uO52abbjquc2YtvwcGM5LHuZ2Ry
         jWZxyRgUqYktHGI53EwEeq5m0kLxtJGuUGNj2AvKRsIwgpYgd3/KXr4/wR/DgdAROBov
         wrKUvWijIFBWN1lx2Ctme6vi1ygcDJ7E1TSt2ZpnzKB0nR9dULnO2jkGHqAKi+fNdAuo
         2y1sOyX1MdyHlYPHYYhW0EM5EQQ2iObNb84eK9TtcX9kVPAiwSyZSs3Vy8zVvr3rJCTn
         i0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Yn/fXH4In//uZIU+AUOD0v7jQv3KMzJ9Xh1QmONrnIc=;
        b=vO4nwRwINKhyXhNzB7NZ5ILhqPh+hr4oV0QA0JhpKX7r3nPiwRGwdWPcEGb7qz6ZAk
         gEQd9rk2QNF8Dm815USi+kY90Xi6TzrhnDBDuVJncP7X2YIb0ojLeqXna6L39TRLeK0E
         0lbl+4NhiA3jfFL87PTI7WlyMaNiHWqKUA2szyQt6lhgnXr31r/IioJvo9B/9bWS2njB
         w7lWRbxAgUe0ENat7azXoXshdF4KxqHZ0q26pbm3mGlBvH6qPjKCGv0MbY0wo99SFk0F
         S+f6Efhvu70nMNHs3D1N2jP9y8FWcfJVZe7Yjiwf8yvcH7w4sPlvPDJ5GSZ5sFh2Z0Ut
         ztQg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jWP2TkSx;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jWP2TkSx;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+1dac3a4f6bc9c1c675d4@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 12/56] ALSA: pcm: Check PCM state at xfern compat ioctl
Date: Mon, 14 May 2018 08:48:17 +0200
Message-Id: <20180514064756.256536571@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421211019570544?=
X-GMAIL-MSGID: =?utf-8?q?1600421275865036610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -426,6 +426,8 @@ static int snd_pcm_ioctl_xfern_compat(st
 		return -ENOTTY;
 	if (substream->stream != dir)
 		return -EINVAL;
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+		return -EBADFD;
 
 	if ((ch = substream->runtime->channels) > 128)
 		return -EINVAL;
