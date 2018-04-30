Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoUM4mG9p0Ft82rGwrFW/uWmwcYSOwxBUbtsjg8eXeBFpTFKagZJehDGGCekfwrErZUP7vr
ARC-Seal: i=1; a=rsa-sha256; t=1525116390; cv=none;
        d=google.com; s=arc-20160816;
        b=O03YqaaE/tTcJhkXIl6hJkuBehGw4BAVKlq8WG/lGpKLI2UoOu05H5XYzMt/yuwhQ1
         cv34AIwmUiut5tbGsvzuOOKT26tilSGdCWiayk3nbQzspzLbZirGjhTVtG303dGVqiCt
         If9+IjvLjKRFpHSdMSe/1XCJ1qdSXa25UziU7OdyrtgZ7LjXOgakbeVssTAp/U754vd1
         +a3j06mVSBZkxa++MwpyY63MPn5JgfY9Fbndfz8quje3s+2VPt714EU8d0tW66Y4nOh5
         yHl7xsZERBdadGCeOcX9VS4c3vjMwu79eFxqV5edWpXgpPFK4t4UWiHMLB5tgLyT2WOB
         ++/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=H+HkN+NuutGgVGc8smM25+8nMq6Zia27KZSgr1Wc5GE=;
        b=mY2q3YLzNxnVtGJgwwTYwCkc7/4rTJ3N4Kx62i9A/r5xCqBsp4PSPcYwnepG/yf3+J
         vUp0ergEI3lmnue9QOpEB2cRNXSaxLTwGq8N3Vr6xDNIjyY+WMU5qCnysRE1mUKRLve0
         6rjDdyDgpeF2ISfr7aYDF9ApHl8ULQFslZbvqDMqZFeF49S8B6y0bFeIi8og6fU1Hp9z
         XFirKPTvQxUhW1hGjy/RXqVGEHU+MtAjdTu1WEm+jueb5S03dTLxRJZNaocQNINBBbHO
         +SEKL59dTXYbM/PCW4w8v1Puuc6wLt6asNKqYAU3EuMediFCClXep0ptDdZK+W6/baww
         VCyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE4B22DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Henningsson <diwic@ubuntu.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 31/61] ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr
Date: Mon, 30 Apr 2018 12:24:34 -0700
Message-Id: <20180430183954.020728739@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200281194240670?=
X-GMAIL-MSGID: =?utf-8?q?1599200444953308595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2729,6 +2729,7 @@ static int snd_pcm_sync_ptr(struct snd_p
 	sync_ptr.s.status.hw_ptr = status->hw_ptr;
 	sync_ptr.s.status.tstamp = status->tstamp;
 	sync_ptr.s.status.suspended_state = status->suspended_state;
+	sync_ptr.s.status.audio_tstamp = status->audio_tstamp;
 	snd_pcm_stream_unlock_irq(substream);
 	if (copy_to_user(_sync_ptr, &sync_ptr, sizeof(sync_ptr)))
 		return -EFAULT;
