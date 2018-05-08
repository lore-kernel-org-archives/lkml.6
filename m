Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoPsc6QHFMqQQH09/etvW3sj/zZw+L6+cjx0ElqIefTHkCUlg5ffnRTfMSeTzZyY9znBacz
ARC-Seal: i=1; a=rsa-sha256; t=1525767437; cv=none;
        d=google.com; s=arc-20160816;
        b=cjwU1zaUAtdrNn52Sq33O/VcXMCjcEyPaXMnDcHXfInxeW/LgeLJWdR2pW/9p94POF
         FVMs2IyxIYz2307PP1DJ4kxk1rEi7hDJ+6fRLzzsfrGi4sXk+XksF/SbSMLsMt2q9raL
         LtlFjRZYwU7bbGyU4nUFL+tloq21188z65pByyrYDiVs6yD0KuSUL/nXGEY26ol2F2kf
         aalYIKmmHsugqeZdkBw9QB7SNS9NsPALCAdq6LeNUsODRL3g6FNj36+ckBUGePqv4kK6
         kYR0Dd8ma+IB8MfxDiftHEi0eak++6lEbNXapsUAHs02cinxwdjNy4Lm6rQm5LMWDU6U
         oH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Zjwwj6VeQEtds1NSWxGHj0zVW7Rs3vRylDlSgZqbWGA=;
        b=hkmy1CkmKbPeshhrPtHapufg6o52I9yNKY98SQHQv985AUwMzChg15xX6X3ILEgwTs
         himLxaM69w8iRCpFJ9HXyo0r/vvSoNRdqYpaSrBBLCURPyYtSJyzLR2N/ZF/iU2oeuC2
         SI+AdDVE8L4InGxKeMEhktn0tIRsMJXXzTcKUCwWE/HDs8LDcqA9g7LJnFRmIDinrbWH
         j8IwoJkgH66N5QNvzR7U5wzwfdY+TGuqgHqjhLYcf0qyXQDF98TXakVDGl109pW3nDod
         CZ4+jso5UjqmhDl2bJmhaAa+FoEPYUYgpqt2maajSYwpSz7mMafbVyHCU37RjCOIcdeU
         JTMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LZxTXhb3;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LZxTXhb3;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+1dac3a4f6bc9c1c675d4@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 08/32] ALSA: pcm: Check PCM state at xfern compat ioctl
Date: Tue,  8 May 2018 10:10:48 +0200
Message-Id: <20180508074010.126160355@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882785467298438?=
X-GMAIL-MSGID: =?utf-8?q?1599883116740918377?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
