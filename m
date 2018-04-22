Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/YL6tq0G5N88EW90l8lAti/RwvwMML6KFCMELb6ZOhkRPpUCrOOgxHgT96JA4kDJqcAgCb
ARC-Seal: i=1; a=rsa-sha256; t=1524406689; cv=none;
        d=google.com; s=arc-20160816;
        b=IQPT+ZQHh1fRsaZqHKzY80CFPvwEBRVcckhdJFyHrGqXpFSc5OKVT2ghYAZDKt2iSP
         Uf6dbdp2jfre397G+zZb4jnhlbU1+PaWlw1+k5Q8zqYRc8PZpAyZtx+RqDXKp/9pDjUV
         3iW48XScD7AN4FPXMtANCT2s/Zkp+h37vjXgU/XSXFqgLrsZVbXGYrxanJ6E/3UKU4NR
         pC17aT0eCgMOsUybYGNyjucwxbd/Skj7GBScAG2CyEaVRdv5kp09lS9CXbkXU5zFrhqt
         HCAWK93Jp+1Y/SpDwjh6Kl4VbitHI+9nMI0xn1lH3B6TLFRUHNa8rlfvOmdKYj19EVmY
         al6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HVj9acYjh5BMs0TaVUhz1OcJ1IihgpdlglPRNET40nQ=;
        b=GHdUAZqWiljYATL0busd/Mvh90d6weyesnL5g9dJRR5rPfc+gcX6kEzwyXlknsGCy8
         n/2uHA392TI5v4AGevS2GXJKqIUN5psogB5RX7I50eoC8hQH2N364yWK1JRRs0Ldflab
         uy3GkAiS+MIS5gvJP0fe2BwbadCiGVlFWFvG/CJFtdbggtw6uOPLfhbq91RTlSBOfyj+
         qUWNLUthVCFEH2fnUfp1JhCyorfkFgTXpWvQtlG+DouhCluFoipOhkjKW9z0X6m62S7d
         D1idYTCHD6KEDfJSkVl95HHGpN6h/BhwsBu5rJrYgh7Wjqz0iDs59OVQeB6FEc9SFYI7
         tS4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 66/97] ALSA: pcm: Use ERESTARTSYS instead of EINTR in OSS emulation
Date: Sun, 22 Apr 2018 15:53:44 +0200
Message-Id: <20180422135308.904437764@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455655750027723?=
X-GMAIL-MSGID: =?utf-8?q?1598456268714475824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -852,7 +852,7 @@ static int snd_pcm_oss_change_params(str
 		if (!(mutex_trylock(&runtime->oss.params_lock)))
 			return -EAGAIN;
 	} else if (mutex_lock_interruptible(&runtime->oss.params_lock))
-		return -EINTR;
+		return -ERESTARTSYS;
 	sw_params = kzalloc(sizeof(*sw_params), GFP_KERNEL);
 	params = kmalloc(sizeof(*params), GFP_KERNEL);
 	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
