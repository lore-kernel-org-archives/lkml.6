Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx486FlU+p+3ONyc+2N1mIArT7UzPtos/Tv06/Wl0rB2W80PPNcrQXxgNU+w6sRcH69yrtbFY
ARC-Seal: i=1; a=rsa-sha256; t=1524406150; cv=none;
        d=google.com; s=arc-20160816;
        b=xvC1MVHYAAWE2ZDyjsLhcgG7pPR7KJq6LUGMdbG4UdRCoZFeRU+paaD3038Ghu6WM4
         XG4FwswPVkXbTDj3iGotYmaU1GIbC142KoiYy0gqVVb3VKjRckb39jBfpkXd+1xrM9EM
         QZkGvMVhjVx7IY8mkzYKxpCFNqYMlRbNagcSiZhiRH0QdYw+cOFbe8CwKlMkGOTU43KX
         qU/Wr0ZPBskdxZ50DUw8uCLY5kENZ9g3RwJ0OJm1l64hLC865oVJstKCMU25LBu0ra2U
         mn9mvMZZpGCqR75nzf6S11ptQZZUjEZtnwJJh6TYfnXTC90z6ydCkhc+9J6rdk7ptoU8
         SeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RL0KByFdYUyS8Gd/6OT7OaJW30u7ZU0LPn/CCSDgwuw=;
        b=PXDdwn3FUsmEA1WmNxkmvUMWfN9jUJE6Hd5yg5XOXKRgPeX6rvp3ymglfW8N9OkggG
         w1/PN/6ZnMj5Q0IHZzaFb75NioqsGRsuAQFrnnwgEbwEGWoY9fxzXJCplML1IKK8xipg
         58vxljOHt7y/s4YZfv8CGn2gKHcHpPV179DQo370D3l+SR4vKJ9dyOiMZMdQowWEKaZY
         1xcCL6VJgnT391GCayvflsP+QEYJmin5ustkKtzLnn0R+HF6Lm3UTMayfpIdOG0X269G
         97RsKZO0gTwmFSlBwBk4hPmR9+lFENr6K6ypXegTBtTNYFpnToxiR4z76TWeU0Vz7ssJ
         aX3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hui Wang <hui.wang@canonical.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 131/164] ALSA: hda/realtek - set PINCFG_HEADSET_MIC to parse_flags
Date: Sun, 22 Apr 2018 15:53:18 +0200
Message-Id: <20180422135140.747717518@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455328273632207?=
X-GMAIL-MSGID: =?utf-8?q?1598455703525310133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Wang <hui.wang@canonical.com>

commit 3ce0d5aa265bcc0a4b281cb0cabf92491276101b upstream.

Otherwise, the pin will be regarded as microphone, and the jack name
is "Mic Phantom", it is always on in the pulseaudio even nothing is
plugged into the jack. So the UI is confusing to users since the
microphone always shows up in the UI even there is no microphone
plugged.

After adding this flag, the jack name is "Headset Mic Phantom", then
the pulseaudio can handle its detection correctly.

Fixes: f0ba9d699e5c ("ALSA: hda/realtek - Fix Dell headset Mic can't record")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6225,6 +6225,8 @@ static const struct hda_fixup alc269_fix
 			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
 			{ }
 		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
 };
 
