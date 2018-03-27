Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49WaMSZ2GNBetHpjrJhI4eJXRvnVQYZukwK0VtCWv4uWus6NyjGsyoeBNP8nzzAjo7OB1Zy
ARC-Seal: i=1; a=rsa-sha256; t=1522168733; cv=none;
        d=google.com; s=arc-20160816;
        b=kIWzQP815FuMXttPFjg1/YR83cQ7U5tcmMv2elk1mf4BIjJIbPx3qizA0z3xTKH5gv
         yt2kRCl+9O8eRDy5z7rY6DfDHFQsjXW79Yo16LOWZ+zR42JGTNdXrRMV1M3Jjoliv7vS
         xIxXTlpTogTuag9hM19JsOtIXysjFB8wrSqSGlJYanQxj6++HoDg6QM8f+XfYCtgWr7y
         tMHQhSe6ofOlbIX/VkIE8O1YEjtv3WHg2JoUutnyCdOAy6qMsg4u2eQZHwik5v37hUr1
         5gTMI9dKNiwwWqv+LRvm4oKf9GoA/Gjryz5C2Ldfqi+4vMGp6rnmPzSXSlCevepYGtFU
         4/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Pff6IhsjKSa+QxyvnvWHe/uj5bL9yjnnYDXg7597yIY=;
        b=ZAzB47poCbU9q/guhPBCnuT1Rv+raaHh5c2E+YlrcmD0xhIdsviLfa8S2iFYDuSCAA
         pvSM58NcdmnpcZY82U3CN0yhe2XOgOlom2cmfNlgVQBVYVSUCzBSoLCM34IklHXJMIbX
         laOK4muPQfMWju8JpM41yjlHccEI8pkKgFSRLAfWJCTxAcUCBCQE+0qYvhHPsgvNZURF
         NZ3WNa2biZT1v0DQYUMcbVA9LriJvZIwgYR8jToNhalfwViR1DVV16swic9kVfMJNksF
         4LOYgOzHWnEl2NBRNT3fBpwUjXZm6A/AoIoIs3oaoaTQ28OhRGzTb8JdJ328ow/ufKW1
         KvDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 013/105] ALSA: hda/realtek - Fix speaker no sound after system resume
Date: Tue, 27 Mar 2018 18:26:53 +0200
Message-Id: <20180327162758.401789965@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109294346792824?=
X-GMAIL-MSGID: =?utf-8?q?1596109602598585740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit 88d42b2b45d7208cc872c2c9dec0b1ae6c6008d7 upstream.

It will have a chance speaker no sound after system resume.
To toggle NID 0x53 index 0x2 bit 15 will solve this issue.
This usage will also suitable with ALC256.

Fixes: 4a219ef8f370 ("ALSA: hda/realtek - Add ALC256 HP depop function")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3130,6 +3130,8 @@ static void alc256_init(struct hda_codec
 
 	alc_update_coef_idx(codec, 0x46, 3 << 12, 0);
 	alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x4); /* Hight power */
+	alc_update_coefex_idx(codec, 0x53, 0x02, 0x8000, 1 << 15); /* Clear bit */
+	alc_update_coefex_idx(codec, 0x53, 0x02, 0x8000, 0 << 15);
 }
 
 static void alc256_shutup(struct hda_codec *codec)
@@ -7032,6 +7034,8 @@ static int patch_alc269(struct hda_codec
 		break;
 	case 0x10ec0257:
 		spec->codec_variant = ALC269_TYPE_ALC257;
+		spec->shutup = alc256_shutup;
+		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0;
 		break;
 	case 0x10ec0215:
