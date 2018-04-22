Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49VDcC7t5t+sS27HihhVjJW1KcthPMYGFCIaoBcx6l2dnYUzRDd3UUpqGeteHUAT49TBTOR
ARC-Seal: i=1; a=rsa-sha256; t=1524406104; cv=none;
        d=google.com; s=arc-20160816;
        b=kHHFh1xNi/2u2wo/wsud9xVdlRog3g9830KDouRgvlrjpZ7yiavPFN/D1+NIlUsHup
         dKiVWAuGhVPJzJc50uZ5h2OCVmdRucjzf/ZhxZbHIHegl7TcemRmDG2ruFhORXfTC4Rk
         +yp5lSC70yZ4/FqVBYKABLxajQvgQ3fkMLzrYF6/N3qZdoI7GndwMAhzysKMUz+D3nK2
         kGnpHeJ4XBn0D5kicYlfkhyc8jwxVQPIuk579MSUuZz10RJBbeM06C+3IoHS5kekd4xl
         J7+zxqAsfzWPGlvRYs0zlc2Vyeu2VwmwO1X5RGjfkUf3b1Vy7BHI6+jSSl6iqzOK+H1V
         3Fzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5f/azEYTAc9NoZzJ4k+oxkxcFTbXQnFyeaGNihhzUbg=;
        b=IBuSWz2Eln1CTughRvGrP2P26U1lmNqbtAq2Vc5BqN/2GxaghfhQM0XY3GWf88Xtjl
         LqzGYCHOnQKfpoL2egZugggSgbW2ah+vO41bg7jfk5ZVq8Y7ORF6ZdNylhKqsKLjwEF+
         J8rUcYR7aW/EsimfGF0UDB/U4oJEco1E/5nLOjyzakiqAUKFwCCIcsON9QmIBtCevLBW
         c3D6MHXqSATEHqIa+Wyssm/vIOLdv+2XgV/gxpG6MF+ILK6xvl4dpsNuQBlFVs3Zj2gA
         TdfVbJKzaRTQiISBph/eVDQnsVPtD+k6Hi3l60ggPNcQQz9P7l2w1HA6HrdUQRFrnFuU
         dawQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 115/164] ALSA: pcm: Use ERESTARTSYS instead of EINTR in OSS emulation
Date: Sun, 22 Apr 2018 15:53:02 +0200
Message-Id: <20180422135140.117507614@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455655750027723?=
X-GMAIL-MSGID: =?utf-8?q?1598455655750027723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit c64ed5dd9feba193c76eb460b451225ac2a0d87b upstream.

Fix the last standing EINTR in the whole subsystem.  Use more correct
ERESTARTSYS for pending signals.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -842,7 +842,7 @@ static int snd_pcm_oss_change_params(str
 		if (!(mutex_trylock(&runtime->oss.params_lock)))
 			return -EAGAIN;
 	} else if (mutex_lock_interruptible(&runtime->oss.params_lock))
-		return -EINTR;
+		return -ERESTARTSYS;
 	sw_params = kzalloc(sizeof(*sw_params), GFP_KERNEL);
 	params = kmalloc(sizeof(*params), GFP_KERNEL);
 	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
