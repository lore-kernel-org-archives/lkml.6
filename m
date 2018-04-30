Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrj4On7t4z9kjmKVr+sx+hBroS2tBYJ2VzIAp1ewKHJqW6/X1xBAAXJ07dxmdxIlt7eE6qe
ARC-Seal: i=1; a=rsa-sha256; t=1525116431; cv=none;
        d=google.com; s=arc-20160816;
        b=iCmuBZDFOSFUxP1zjxLzxnhGp+kVdyhkSx1VPWCaqyU1ypUzqzqMJOdiBv5A4VBHqV
         ZcFg4pYhnbVpq+ooc22i6eQn5gFFsNAwoAfr18/pzjplBMoh+wjn+Blw7OzrBiQNdmCa
         /gH1AJfYdBncMSgxHItTmLEKMtnttNgfKbx98VGJFa/9e7yyrNDODaA0DEA/VpplPyyS
         JICiqUqzNM8dUXhrRaPAJbvpnMgr7J+BdbIJ8FRmLTOcyqXA3MOezOfXy7An6Ob4sux6
         mC+gmsN0klKjuyUI725IAwAG458304cuNigL+ElBQvSzqxd1CCQGzbsaHY0/GfylD5ii
         LR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=BIVwh5kvUw2Ogi1h92Flq1EIulQDrafdypuf64qg3ts=;
        b=ozgC4/lcDMBh4K+BnrLtQAwsO0e+Ym0agTvlDzmXps7v2cIgyT8lGtd/EVNUBiIVPY
         JUvX13fLiMaq4Tomxi/j5NDt+7+uQI9Ln48QPS1BRVeUFgiXm8Qa8NgXzY8QCnQ+OC59
         AQA1Bw+XbrnEXBm3stzqxTnc1JW40DBigjbjPJMlrI7BJjaljsYRaT8fugaRdD9k/eQF
         2yqsDOzEn/60CaE1Wr9LfoQH84g4ihksAwuLOBFHPsVX8ySdiPkksLQQElucKcUMiC+q
         jZEyJAlRr1Lo5hZDKaXqqjle1g9R0vgUpYMKP7QW9K/U17lNkBD6mpIcTNpNwgi+RCoR
         pZkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA4822DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 35/91] ALSA: dice: fix error path to destroy initialized stream data
Date: Mon, 30 Apr 2018 12:24:17 -0700
Message-Id: <20180430184005.997066310@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200440345997459?=
X-GMAIL-MSGID: =?utf-8?q?1599200487654422716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
