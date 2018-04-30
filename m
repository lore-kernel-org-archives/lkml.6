Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpldU3GBIfJH8rJoN65R+Yuv3UAPiSAHMpcYYSjysB0BrCq80dH2apVWqhKl/WSIiclWBkM
ARC-Seal: i=1; a=rsa-sha256; t=1525116386; cv=none;
        d=google.com; s=arc-20160816;
        b=ntSNsCvpzoJn9YokK2XvsZl15f/gafIVCMLSr/JX3VsiEA4W0qOLm/B57nWiNj3CIP
         Gqs8xKA7BWHHPnV1nBH/0IRqdGkMh/PqSZHMBpFjkpKQgnu0TIJTaQDOd07G4jM83UEg
         Fn5DCKnS/6cyXB3IolJZPOz9A/TDaokijtBjIXhqZNzsCjGR7TAZeiGlxUR1XUQdEEnC
         7lz8WmrpLP1pizDfpInF5kIsnlqsPwT/vuicBzjFvRL0FvdW8Gup2d1B4L8cE8xJbT5r
         0/4wpUSs8M85tRbrv/cELgd5JnmUfiaXfhR3b/4BGDjMABzAOaQfmIAiioGzOCxvOaKK
         Hlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=9RejAdIbHinWIJRcrhgXnNcLo9uNpWwl+u7liFRxaxU=;
        b=YBBGXabp5GfwVwhGzRpyJkROKvmz99kDnu9Vin3hDIed4yRkTptt0cGIFBy3YVTope
         qZeLL/LQOC8MJFIMHgB7oLHGHwedgBjqyw2nCgnnzFLAAw5oj8k3D9GGvwhp3d5LwTFt
         K8QGs6QM1bLwFBak2twBlXSKxrMOIrtvZv3ROUN2WuQjT2Xdy8gDzSGpcPzG0hZL8Ndg
         1z5ZQxnMAYk3lF11BOQzTLj/tEzCrA/oKt94DT5SqtC8JC6+9qad4yIKCe+gFR6rQ11p
         1tLq9Pi2JluwpEjFAlAnnxvqzZykMAR+RWbfJBqom+6XLDah7/UVl8g04hVruU7tkfgE
         RXXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1DB22DC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 25/61] ALSA: dice: fix error path to destroy initialized stream data
Date: Mon, 30 Apr 2018 12:24:28 -0700
Message-Id: <20180430183953.482836014@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200440345997459?=
X-GMAIL-MSGID: =?utf-8?q?1599200440345997459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 0f925660a7bc49b269c163249a5d06da3a0c7b0a upstream.

In error path of snd_dice_stream_init_duplex(), stream data for incoming
packet can be left to be initialized.

This commit fixes it.

Fixes: 436b5abe2224 ('ALSA: dice: handle whole available isochronous streams')
Cc: <stable@vger.kernel.org> # v4.6+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/dice/dice-stream.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -425,7 +425,7 @@ int snd_dice_stream_init_duplex(struct s
 		err = init_stream(dice, AMDTP_IN_STREAM, i);
 		if (err < 0) {
 			for (; i >= 0; i--)
-				destroy_stream(dice, AMDTP_OUT_STREAM, i);
+				destroy_stream(dice, AMDTP_IN_STREAM, i);
 			goto end;
 		}
 	}
