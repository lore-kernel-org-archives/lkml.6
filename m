Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpU1mWKXdDwlXQSgDKd/5PDSoRZl+VDjmSFHnT5LjshpfeA5Bh9NB88jFRcpHVb04qLOksW
ARC-Seal: i=1; a=rsa-sha256; t=1525767334; cv=none;
        d=google.com; s=arc-20160816;
        b=k5+mgFGg6Mu9JbaqNL3xaD233ORV+R7b0o72kFdVGF0pZgJRmPsEHOEJiQeBr5/P0v
         5Wg9f9ZSo+A76eBr+1lsHC3fuNaHDdkkwfVJBOE4dkSfsfXYeAte8eOYP5JYnGhNSaMf
         lmnLy8ACG9d3BRgtqSwclUwLmsdAgb+3qFw9UEXUsbKtVrIieUPOPX0ptPjy/jhaRRSC
         oOcG89yQswMY14oi4J6Tw4vS1w1KJ6jl5NCeske8YTad6H/Tj4ir2x0E79Ww1Lqmk/2O
         uBGLFU+yi8tfKYx/isjd1gSo9oWIyZR01c50YGCkrWJewDgIoWtmcI9NGO+lP4YDjo3g
         v+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=eAtIBYa7fJbEaGpsc+j1idH0ejqamcgytDn/NBdTYdA=;
        b=AMl8SuXgDIpOK6aqacOQSxa4RR2C/gXqqKwGu0iYjOZ3qGeSpC2DznHO773fF76fDu
         S9rRLGDM9MdwJEPW4Lxzt0VE3S2QBITHXEWdsdrC/2GMAR3Uggk2OchREB/Jjc9exmoQ
         sEUf5dhCCOmuc5OVaRJwFFvdKCG8qk+jY1CnIEiSvL0El9IAah21hJyalyC4E7F5rgdu
         HWT32bLXV++YJJV5sG1+XCJQbjqCUnyWrQYIF2nm+IfmulyDYiTLmq743YNbwsBqZp6e
         6C+6trAC9qpbIfxofLl3UHeZFQiFSmuPdvEdpqBIz1mhJsstWPMoL4uT8c4cCPUYk4A2
         3HMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=G4oTOCOM;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=G4oTOCOM;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+1dac3a4f6bc9c1c675d4@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 08/43] ALSA: pcm: Check PCM state at xfern compat ioctl
Date: Tue,  8 May 2018 10:10:27 +0200
Message-Id: <20180508074005.316611650@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882785467298438?=
X-GMAIL-MSGID: =?utf-8?q?1599883008422709501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f13876e2c33a657a71bcbb10f767c0951b165020 upstream.

Since snd_pcm_ioctl_xfern_compat() has no PCM state check, it may go
further and hit the sanity check pcm_sanity_check() when the ioctl is
called right after open.  It may eventually spew a kernel warning, as
triggered by syzbot, depending on kconfig.

The lack of PCM state check there was just an oversight.  Although
it's no real crash, the spurious kernel warning is annoying, so let's
add the proper check.

Reported-by: syzbot+1dac3a4f6bc9c1c675d4@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm_compat.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -423,6 +423,8 @@ static int snd_pcm_ioctl_xfern_compat(st
 		return -ENOTTY;
 	if (substream->stream != dir)
 		return -EINVAL;
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+		return -EBADFD;
 
 	if ((ch = substream->runtime->channels) > 128)
 		return -EINVAL;
