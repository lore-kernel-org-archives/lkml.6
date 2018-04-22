Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49eUMb3pUKm156ptE2PiAZF0JaonsOmuh+XxYkk18HA9/FFZp4dwBLpY1cD9mdO398tGBUp
ARC-Seal: i=1; a=rsa-sha256; t=1524405792; cv=none;
        d=google.com; s=arc-20160816;
        b=rmKd8le9mu/drrkFCVXQyJf0/fLwXAJpHbfvJm7qTAWmB2Mn9s27MpJarhbFVLj4Lm
         a4Mhs0S9DBJZ2rz423Svu/hMv4+2RBIa3hLPvZv2Yq9b4hikmLITsdlxk8q3cGEIs7gi
         9/Bu4OIFYQw+QAhT+zvOrvU3pTkR8sOcEmZ8YoVSOFZoqm9fbVfSOK/HpSq+rEuO90xY
         /ZptKJauERvuFlv1rmNGuR56gDfnvjl+VAyiqWVVXULzpf6WSf6JU++iXG5ME+7qvJh4
         0DtREO3j1mmgJd8QeujI/F+Nz6x//xa+6tBgkG7wN2fGZZckdZjGLbAeQ2/HETPjJtfg
         tAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Og3HTHEEzbJ/NaB7/jvMS8/g5lWV4Wxrkyz3A2OkU+o=;
        b=jwJMKJ2uiZI0QxGm9J+OsDK2tyf0hLkXtJXBFItJwYY4WKUnlQq6FDAKEUu24u+t3V
         Cc2PFjjgLUEH1Hee+8c1XypHBUVq5pRUFTGm5BsLpkXfJrkxGTzEsp0anAWxrHLgRX3M
         JH9NT01S26QrBlRsE6f/IM3sAEVITWgkp+eJfp8GGeACkz4Te71+7v2kT61Y7arYkZN9
         kwG0nhUg8WteA/zbYsrYee8eZu2QEdo5k1bWE19+zLwQ2IR/hDOMlOOvRtM76Nvb8WeC
         +Vx2fHA5KyDer76Rh07sC9/XEByPnmw5XeoaAyC/ypXb1Y/obyU49R8TWnSnyE4m/n9R
         qVew==
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
Subject: [PATCH 4.16 161/196] ALSA: hda/realtek - set PINCFG_HEADSET_MIC to parse_flags
Date: Sun, 22 Apr 2018 15:53:01 +0200
Message-Id: <20180422135112.555650407@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455328273632207?=
X-GMAIL-MSGID: =?utf-8?q?1598455328273632207?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6370,6 +6370,8 @@ static const struct hda_fixup alc269_fix
 			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
 			{ }
 		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
 };
 
