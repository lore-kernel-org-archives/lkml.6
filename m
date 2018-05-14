Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqJpte8tPoeFttG2nW4cs0hxAShrrPOFqrn3F/2svWaT7oVWBLZw6fhx5vrDCZKLqPK6nyJ
ARC-Seal: i=1; a=rsa-sha256; t=1526280604; cv=none;
        d=google.com; s=arc-20160816;
        b=IONCSAXyPjXF3j6HbozTtGki65QtCee79EGL+h2YVliVXwnynhBCDmSjAQxdWpOGeT
         P42jjudOWPaHJbhuCvEsTayR5god4VTQgpw76O3lO4UsHFsAf41Ar4rU1UD99ikXKIQi
         oJ8tIsoDAqRc9Ufk393Bn+Ck759uQOlIBd3Xz4isiYAg9mfxX6BPPQbkQBCThYI1emIf
         VK0W0dSGzFOyuNjexB1p1XVbm73VET9Mk4Tiyr11fPEEaNhDTn4c9tPirwzDxPAywJRz
         N3LDhoyYyqlMyxm7Ziai1sTQsmlNXnHwVR1o0aJvF0h7rEpMPj/5WP67lfTyj6B+UhSH
         J89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=3aJCnW+IloPaJ6Xt17iWJXr9SjtYrE2lWjuFkkeNPq8=;
        b=YO+jK8RMnf0qEX38ir9YyGcQtx+c1sS6HLZtZrlVeOFr/NRYHqUH8Cwx/j+C2ntajE
         WfZF9pI+lVUtuk2GPq+tliO1v4w3BXVHGgPv+WJEPKkDnh/Vtbbb4YW7cJ13gPUFu7TT
         Pabn+0nvpy/boxjFN3AsiSw4e0rhGtvHu89fw2ADKDRKAHWWbh5nV97vskHojFMHZMwh
         sU1BXXDu4UMM5NDUpQDbKuNR9wCvR3NkWTl3J0mjTR5nqfSMGhROcaw0eYOhfuIrT5Qn
         ni3//G6++ip71sCqMuv1Ffs1h2J+2b9DsdTHsVLxqHJevapDo7g8bcelC02zNDixLLmA
         XU2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vEdIMXES;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vEdIMXES;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+1dac3a4f6bc9c1c675d4@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 04/23] ALSA: pcm: Check PCM state at xfern compat ioctl
Date: Mon, 14 May 2018 08:48:33 +0200
Message-Id: <20180514064704.234842443@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421211019570544?=
X-GMAIL-MSGID: =?utf-8?q?1600421211019570544?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -333,6 +333,8 @@ static int snd_pcm_ioctl_xfern_compat(st
 		return -ENOTTY;
 	if (substream->stream != dir)
 		return -EINVAL;
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+		return -EBADFD;
 
 	if ((ch = substream->runtime->channels) > 128)
 		return -EINVAL;
