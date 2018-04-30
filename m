Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpV+KtKjL3VYR4VlXj7Q8m1o/cx/PU2Laiai5eeg23n4tRcKYQFUk5KqlnKJMdm9//2JyUE
ARC-Seal: i=1; a=rsa-sha256; t=1525116235; cv=none;
        d=google.com; s=arc-20160816;
        b=DxWI7Aiwg02+mTMIF8Ey+O4qRool0/ZyUS9l8QbxDoXwSKFpBuOa4DkNZk2W/+horv
         prteyMwU3QVkjdKmEA3zJ+bXcnYlKFFKhZQad8Oesa0c/gQ+m8GucFxYoePXEU1m1DGV
         mR2QVhddV6VnYzDo2xHlZvsQkZ9jQRqJ1RBqAp0FJ1uCFgbAPEOro7bq3KWuq2hT3CdP
         cVm6EOcmhoWh5U+mL+9i596V/vqO5Q3t+m6J8Szvom5SO+nn+RAs2mGNGMoxgZLGDa+m
         HkLe1ccKQO6AcL6sWoghtZ51cB0OfFDR2GjI1RoXnkV3j/h02mD1PtMTp/96IOL/tVU0
         N94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=YLaF6vD3+XYBwhr156+JfUCzE4W+TqXwCdmPfMGdJ9I=;
        b=NgVOZrlxv4Z+ssGzphZikqExK1OlLmJmVqYeGMCV9l7AifIKAZqVUKQ2uwCYKW1phc
         vRhm03VJfb54SDhwWFHiC6Ljbb9CEw5lycc7nWMRye2V3BGt3oZs2TK6j8aoGcC57mLB
         zHFiuhRW6s2vkq54y/3hIT7nAYyIO2Jw3Rc2myQnPjJ3t0jl7tPOYkFuemtViEw+5KWe
         4aCmR17Kr4SrceiLL/B6kHYfErchINrHlbrDT5etrpkKn7VROxSIP1l7w7Gyz6XRYrb0
         ot3QpBYGU7SqGmntwLRDqyZPsQO2BMUTwc0QDYUQsF24n8GqtOLO7WtTpMWdC6NXPwyT
         bEcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4B922DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Henningsson <diwic@ubuntu.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 16/25] ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr
Date: Mon, 30 Apr 2018 12:23:23 -0700
Message-Id: <20180430183911.479036414@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200281194240670?=
X-GMAIL-MSGID: =?utf-8?q?1599200281194240670?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2695,6 +2695,7 @@ static int snd_pcm_sync_ptr(struct snd_p
 	sync_ptr.s.status.hw_ptr = status->hw_ptr;
 	sync_ptr.s.status.tstamp = status->tstamp;
 	sync_ptr.s.status.suspended_state = status->suspended_state;
+	sync_ptr.s.status.audio_tstamp = status->audio_tstamp;
 	snd_pcm_stream_unlock_irq(substream);
 	if (copy_to_user(_sync_ptr, &sync_ptr, sizeof(sync_ptr)))
 		return -EFAULT;
