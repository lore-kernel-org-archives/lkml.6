Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtVtd9k+3oYHT3StsQw7RdYhJghUhl7lDK87f/BeJueVFHadHryyFqewiWSZQ7E76FePcjU
ARC-Seal: i=1; a=rsa-sha256; t=1521484142; cv=none;
        d=google.com; s=arc-20160816;
        b=BmG9GiDwWKtlj5BB2C5exeo0844lPiGf9rdT0A4iY8grQ3/S1snetFlNhj+inZe3i1
         95FFtF8szItox+JH0oCq58RRippIb9/x2jNuSP6DrJOVWFZ5L21iEK63rXWR7eiQrt0f
         y+HteIexTdztKxr+JN5uLfcH0AuQXYqt7NaFTLBYwk49viHjJ2a+oN4fzGxYMBeDrVym
         kwEA+FPflg08Jb5kIHf1rvvQPqVc0L0DkIwy+ido3+45+gpmmAl5nH29foiXfBd/Smx2
         tgeK7QukicPvP5TfdRX9lSNPhpVCROJ/S8vy7LcjP/fByG9ENoVO0Cb85k++NWukxYTL
         srnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/QlQ73X4PdHtCuSG6ZEfsDHZLSIp6gT0a7fNnsW/WG0=;
        b=Zags025yDUq2ux7Y0lsN//xmxrprf1OnosjNAaUS0hqxfhvAlort51Zx9skNfE+Q4+
         JMrV8lgk2wOdz+aQgkMmC6zBdrlOLu8sv0V72cGR2kyZ32qzyC1Zq+tseqmsT6kcX5w8
         W+AXCwnht76LAzvIhg4TM3hrXxvZrig0slf/XZvY0z2g8sIbeWautn2HeuH9iMKLNVEf
         h9nAgylHLcVbDEx455NFdFsJ2COnyJ5FWya0/6nomSEoUYc1oKjNdS8AcJYYCkSPZs3G
         0+mWjv/Tc0jLped4VuxV1VmbGpj5ZjRyHrrNoygve3NbBjnF2jzoIKuEtUOl29QL3mhT
         D1GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+4090700a4f13fccaf648@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 222/241] ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()
Date: Mon, 19 Mar 2018 19:08:07 +0100
Message-Id: <20180319180800.357441733@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390642761119786?=
X-GMAIL-MSGID: =?utf-8?q?1595391755843252780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 01c0b4265cc16bc1f43f475c5944c55c10d5768f upstream.

snd_pcm_oss_get_formats() has an obvious use-after-free around
snd_mask_test() calls, as spotted by syzbot.  The passed format_mask
argument is a pointer to the hw_params object that is freed before the
loop.  What a surprise that it has been present since the original
code of decades ago...

Reported-by: syzbot+4090700a4f13fccaf648@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1814,10 +1814,9 @@ static int snd_pcm_oss_get_formats(struc
 		return -ENOMEM;
 	_snd_pcm_hw_params_any(params);
 	err = snd_pcm_hw_refine(substream, params);
-	format_mask = *hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT); 
-	kfree(params);
 	if (err < 0)
-		return err;
+		goto error;
+	format_mask = *hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	for (fmt = 0; fmt < 32; ++fmt) {
 		if (snd_mask_test(&format_mask, fmt)) {
 			int f = snd_pcm_oss_format_to(fmt);
@@ -1825,7 +1824,10 @@ static int snd_pcm_oss_get_formats(struc
 				formats |= f;
 		}
 	}
-	return formats;
+
+ error:
+	kfree(params);
+	return err < 0 ? err : formats;
 }
 
 static int snd_pcm_oss_set_format(struct snd_pcm_oss_file *pcm_oss_file, int format)
