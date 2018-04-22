Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48dUW3k5RO23e+rcsgg3OnXxp3oA/S7O1ju2oXP1vggTLdgYKT5sLzBRzSaY3v9qpAzBjsH
ARC-Seal: i=1; a=rsa-sha256; t=1524406427; cv=none;
        d=google.com; s=arc-20160816;
        b=cocW22HUxEvIZLf3uSoKuWWKX5y8PePhU6W6Q9p5gla1oBvy7GdibFtNqoQ1PEiu3M
         45iGMf2XVPGwqUBB5RQAilIqKaCaYEx+cM4kmoo9kkY3gBNiPf8ceAE+i5IsIe6yA/sB
         76F6n7dVrHfSOTrBH7pBZu8odJzQaSDlErgxZrCkFEo/ym9SWzpGdC4KbX+/p+IPBhvG
         zeQc7wf9Sohu7WTXSsv7dNXVbXIknA82DpLfSXYPwg98ISZ0fjpQ7osO03+/WGGazLAF
         1y5SI422GLJSs904p/eG4fzADBpt0WLdH23aya5Bj/qgzvwe6MuPF4n+9LYLrO0OOp1r
         oEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Zxbk11wdCoC0UCyTYNEFxDkUekoO6+l8UvDxDBeBRUk=;
        b=yNrfvZawL+J5DmiZIeF1f7y53xeDksRcAQoIHhuRw25XwkEkOG+5AkHeib0NcBHazw
         aPdN9N4qF8qw2x8+hPR5k/ABOEc6whzdVyiVRxoWa1SkHvG2Df5L8He3SEwPNSH3n0ac
         yn6uP0wBpK6s9dnyCP7q7eygBTUedMTGFUSyZ29fBsn7LePQ1IphGyegBcvo//7E+WGp
         9J1zbX1dTek5o6l+8Pogx6drU9QEA0KqkIokywPk+l5jIERqv1x0ky0UIaEFvY3G5aZ/
         Jf6UXk3/NJQ5D/2XIssZjny3agdSexI/GFbM02IQbaxDpGmbP2brBFAGhyo+nQDnZdJZ
         YRUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 60/95] ALSA: pcm: Use ERESTARTSYS instead of EINTR in OSS emulation
Date: Sun, 22 Apr 2018 15:53:29 +0200
Message-Id: <20180422135212.878841961@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455655750027723?=
X-GMAIL-MSGID: =?utf-8?q?1598455993807868574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -853,7 +853,7 @@ static int snd_pcm_oss_change_params(str
 		if (!(mutex_trylock(&runtime->oss.params_lock)))
 			return -EAGAIN;
 	} else if (mutex_lock_interruptible(&runtime->oss.params_lock))
-		return -EINTR;
+		return -ERESTARTSYS;
 	sw_params = kzalloc(sizeof(*sw_params), GFP_KERNEL);
 	params = kmalloc(sizeof(*params), GFP_KERNEL);
 	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
