Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpliTxLl9NPb4X+v9SnQZZYa2XSsfDFgb6+UolKdUmZw+VNR+zfUawOaGHgLI/YuPHtRUmP
ARC-Seal: i=1; a=rsa-sha256; t=1525116514; cv=none;
        d=google.com; s=arc-20160816;
        b=o46nubmzM88k0dTN7bFQrEbSdOH9wSblh4JW75oLu2+8FRSAZIUyjgAMV4xlUkhiQB
         WPJVrtGx0BsWe1eE/yhGK9Fhwvq2gETuWBQ6vTPzx3wrDVH8JcAkgBKJ8EG7G9jpHbii
         LN9DqZSmUaqHA6EKtRA1eW5ZW0GQTAx4xXViSvnnuuongcETHbzEho+oaW8/qXi2S3rR
         OHzrmhXMHRj8amip5dSNYZBUp4yrVM+LP4583uaXnG2r+CxEinREK9NKIVojXOxsI034
         uPd08KEeqMlL8IxZNjNJmgH5Bf9NBINtMnlO+sy5M9FEtFjACxui14VWx7V1xbJNYSKd
         atsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=er/w/p5uCtrnsH3DB5O5x0g1bUe4Fwto6jz3eofDIpU=;
        b=QYEAD7WluS8lcbKqMTewnCdCUUA++MNln3BQhLIwsNAq9wnbVELw7nLZVct4ullAap
         +ZtZWgQNQ2xiKHJQ0dZUEXnAEKK3WltH0bT1sC81yu/LH3ENhELYj9+nzbPxAlIY6yDU
         j1Ti4IdA7vvbiUj2mI8tyCCsN3vep3UxDn4yLg+GtyK5CRy6vjzkZElfXDZjTulH3U53
         Z7NOWtwlaMmqgv82CsXL1nzFR3snX7hbK2Txs3E/fz/t3nDcOgjwowZomoAblxnMfeRu
         dUQuaqMXivvJgph35vIlaOoFcy+bPi55rh4AF9fz6bfuiStpkL+Uy3v+qL6Br2oeXk8G
         W4NQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D2B22DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 039/113] ALSA: dice: fix error path to destroy initialized stream data
Date: Mon, 30 Apr 2018 12:24:10 -0700
Message-Id: <20180430184016.697280794@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200440345997459?=
X-GMAIL-MSGID: =?utf-8?q?1599200573875109298?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -435,7 +435,7 @@ int snd_dice_stream_init_duplex(struct s
 		err = init_stream(dice, AMDTP_IN_STREAM, i);
 		if (err < 0) {
 			for (; i >= 0; i--)
-				destroy_stream(dice, AMDTP_OUT_STREAM, i);
+				destroy_stream(dice, AMDTP_IN_STREAM, i);
 			goto end;
 		}
 	}
