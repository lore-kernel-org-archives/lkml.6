Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsQ1DveNNP+pjfoWIHvyQTqw+3IrKhAWcqPCPOd5xRepqHiqKVtDs+6CASwk+rvKhtpt5NN
ARC-Seal: i=1; a=rsa-sha256; t=1521483072; cv=none;
        d=google.com; s=arc-20160816;
        b=yJlr8+kWt/HQ+HSYktqsUtX1VKitnEsNPeKGzQxve/QxevN5I+obOO2xoteeMR3sTW
         LJ97oNskeSFv0W0SbvIZ+TKG9brLvEv4sA23IjzZUcqiOzNU2cRuBBdb9tfaRVxA5pZF
         PAHBKg7QDy4K4A7iKr0ym1ME9JN8tENAwDrIEl0/29AM4sCYNCiP+gIWkSZ2xAe0aZnl
         7L6O/+SQ9HSuMMO0XC+N3LOamEU3O9FQDLPMYX5R97wapsYXu2zfYYTldY9vvtDZYeXV
         JDqL5lv8h/7MqDAnv7/ftPsmyHREGFxsOIsgwI1LcNCu6DC8n4DsnjDxDANI0c65UMho
         IF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aMKC3J9Po1jvO85ghfYd3yCgBVDh+bYpvu3j9C0O2A0=;
        b=lqF003oTp4yC2hkueXJ13NBXsGuH3AoIarCYKkW5rfZmn7n1kISAYowl64ArxyN7yl
         YDNm3j8ZusTU4znGOi6Gnk8YrtVnwSkzw7McsMBFtYpqlccDgZv+ebvaGyHYgcn3RzhD
         /4nALkO202Se53DiLHPZW7tpv3AemALzTzoLEu14yy6vATeNi+2nFGMGaw+FaVSlBdu1
         T/MH00IDDtpdTxIznRY9HYSGVP46HBeh2Bpo7CJ5lZY1pFbTwZcz2LcdZGhADoI6N/pD
         DwN4uVfv1M603RjcNcvfKK9h+lTvgR3KeXrfGFZKBlCOyiawwt8CKvTCyLhzc3fXv5BE
         LZyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 57/68] ASoC: nuc900: Fix a loop timeout test
Date: Mon, 19 Mar 2018 19:06:35 +0100
Message-Id: <20180319171835.863002127@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390634104093891?=
X-GMAIL-MSGID: =?utf-8?q?1595390634104093891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 65a12b3aafed5fc59f4ce41b22b752b1729e6701 ]

We should be finishing the loop with timeout set to zero but because
this is a post-op we finish with timeout == -1.

Fixes: 1082e2703a2d ("ASoC: NUC900/audio: add nuc900 audio driver support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/nuc900/nuc900-ac97.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -67,7 +67,7 @@ static unsigned short nuc900_ac97_read(s
 
 	/* polling the AC_R_FINISH */
 	while (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_R_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
 
 	if (!timeout) {
@@ -121,7 +121,7 @@ static void nuc900_ac97_write(struct snd
 
 	/* polling the AC_W_FINISH */
 	while ((AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_W_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
 
 	if (!timeout)
