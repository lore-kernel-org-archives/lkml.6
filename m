Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqbSls/3QfIBkteZ9ibVKl0XyILNX/1vUftW6o8Pukw2TKUZF9S6TVcESJMOrI7AfzodQcg
ARC-Seal: i=1; a=rsa-sha256; t=1525116374; cv=none;
        d=google.com; s=arc-20160816;
        b=We2mSXoV9WO+JZxXPEUPwjB9wI+SdGa+38IFMMp2OPOBUvaxQU2G/Ivw+EuKaPTxHn
         FeMIXoeRh10I1HjJmeBfV7rfvw7lc7CBjckpSN97shCaREm17RzqLAzEGnvdcUs02dGX
         2yPBUkTzmKu3W8DMFI+UUJP8yLZiHm19mlbO41LyicEqpbX4FHxOoY0JXWBAiSnBuyOU
         TZCRc34kcQ8MChRoa92+xJV4sfA3FeuCCCRSkKc3RLejRVIztMIA5o/vYOJ+3Gg3ue6A
         hzgLQH4e0DOxiB100u+9pX1mJ1Ho9wHJ3haAJgQPohAwJWnigQYe4SMHug4lZWNqlRlJ
         qMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=GjwC6NtVxYE+5HRoSeaOZs5MuiNV4Zptyv1Orlv4Bkg=;
        b=HJvyLP82JmM4/QG9RT2CG5J3UIt2Ch1vwg59enCIbNS+ja6pH3NU2NONiOFasWIzpT
         gtu2aAuBpp+OsHf263ezVWRopaOKfy/Nz+ypTP6/9RSWbHoAfyelPFyj2p22/xsypGhq
         U/JV9U+PpiKy5Qq3MRDdOjqXWoiC44nzhoja6JPeEGCYFWvBjhLy18QNw8l+B3B1p9DL
         OC/I/tyPF1LMzpVdkRkSAJpoPVGsFJbTlfoxKJIpicFTqOmh/hFWh93lYwJiZ+EKPYeA
         cdc+kj2gY2+SWysc+RXzTLJTTBKjQ8KKQfG72F40iCYmQJOB/eilGh3LQ2ih+yTeJSZ2
         8Epg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA9622DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Henningsson <diwic@ubuntu.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 25/44] ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr
Date: Mon, 30 Apr 2018 12:24:36 -0700
Message-Id: <20180430190947.346166658@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200281194240670?=
X-GMAIL-MSGID: =?utf-8?q?1599200427297764229?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2727,6 +2727,7 @@ static int snd_pcm_sync_ptr(struct snd_p
 	sync_ptr.s.status.hw_ptr = status->hw_ptr;
 	sync_ptr.s.status.tstamp = status->tstamp;
 	sync_ptr.s.status.suspended_state = status->suspended_state;
+	sync_ptr.s.status.audio_tstamp = status->audio_tstamp;
 	snd_pcm_stream_unlock_irq(substream);
 	if (copy_to_user(_sync_ptr, &sync_ptr, sizeof(sync_ptr)))
 		return -EFAULT;
