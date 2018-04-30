Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrg4T4wJ1nK7/YIamNa9FZVDpz7w2OUA6jg52iEuRPfuTY9vXbyBP+FwAyT6TvJrkixRt9P
ARC-Seal: i=1; a=rsa-sha256; t=1525116436; cv=none;
        d=google.com; s=arc-20160816;
        b=qoT8Nq/klfrNLNRt2oQtchNllt+2xjnqjNIF/Q0XpiVk12mkpFvWwYsqKliLrnjab8
         jaiwNy8XO1nu/8c+78yRWLFmzkEE1+ezl9qCO+YEwA58yoqSwPIv6d3aJAj6DT5iYR04
         WJFF7PRYtSXTwK9QODeDCdMrymhrJ5CrVD2U2R4jk98iFSlc+TvYISXW/88GRwBjVDOt
         OClgrnY2zwdwS1bQ++5Uuo/vAvQnQ370vQTvy95rlYF/h137alFMpUuGPUMLFTPKCGhZ
         KnhSRi8BTnkD32orX/hjA+vpJ2/vki909mB69wAPpCHrw4nRaT/T/50qijA1XLXjL0Ni
         Xc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=l5qtPaofFlDuuaS5GhX6QeMEvgViTsGyv5gx4nwW1EQ=;
        b=me16E4dG4fQszq4OYZn1+7K4Lo9IcM/Kkyu35D8mFNGpUYsFagbK3UhP7SjK6vYTKo
         i9GPgE/+zLs+BzY8Ll9gcG9B+D4vfGVIxQpMrUVu3x2dOEGceyq6SMUrU46+ve7jLzFv
         suBs6OVHP3ZKrvxN29VvRHxExkdhpKL95oEk4ngPYaFrprWWsqwWwl6OeGGqjtVcTmcw
         zy90cqbeY81SzKAw3pS7CMg08nnxx7NUE88D+4DzMP/V0eQNzA8WOpAOWNcdwxwbOPrg
         0MMCxWWcHv5d6ZoDsMVZSa3/4pFnMWFttK99P6IIMzCASyH+dDfVOPYyf2OuSPot/pPd
         3zoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED49B22DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Henningsson <diwic@ubuntu.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 43/91] ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr
Date: Mon, 30 Apr 2018 12:24:25 -0700
Message-Id: <20180430184006.422361938@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200281194240670?=
X-GMAIL-MSGID: =?utf-8?q?1599200492126126234?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Henningsson <diwic@ubuntu.com>

commit f853dcaae2f5bbe021161e421bd1576845bae8f6 upstream.

It looks like a simple mistake that this struct member
was forgotten.

Audio_tstamp isn't used much, and on some archs (such as x86) this
ioctl is not used by default, so that might be the reason why this
has slipped for so long.

Fixes: 4eeaaeaea1ce ("ALSA: core: add hooks for audio timestamps")
Signed-off-by: David Henningsson <diwic@ubuntu.com>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: <stable@vger.kernel.org> # v3.8+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm_native.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2751,6 +2751,7 @@ static int snd_pcm_sync_ptr(struct snd_p
 	sync_ptr.s.status.hw_ptr = status->hw_ptr;
 	sync_ptr.s.status.tstamp = status->tstamp;
 	sync_ptr.s.status.suspended_state = status->suspended_state;
+	sync_ptr.s.status.audio_tstamp = status->audio_tstamp;
 	snd_pcm_stream_unlock_irq(substream);
 	if (copy_to_user(_sync_ptr, &sync_ptr, sizeof(sync_ptr)))
 		return -EFAULT;
