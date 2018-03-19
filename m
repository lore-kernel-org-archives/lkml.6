Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsMuNO1/C2Wl8iif7660T5WZfyxPX+ijqDsWmdgcxjZBowEJOH5vobo9eULVz02MBSE1IT2
ARC-Seal: i=1; a=rsa-sha256; t=1521483393; cv=none;
        d=google.com; s=arc-20160816;
        b=xN+r/fEyJAwZD0f37HsE00VbdVilNqkoub00Dq4N7nqTqZrvbGHOxon0RTqzGaWuop
         aVV0oHqe+gBYrGIzTZwhYYdWLr5C1P8JVas/VbEwMam5ts3049ShpFXhFuq9BEHjSgIf
         zfu8kEcfyBOnepgbCn4ygUp0oQSEghR8znjQ9S6b1aUnVYplM9MKQNPOC0BZDAw8/hgp
         fY9zYqVkI1PsIIytinL1ovT5K0fRhgHT/kpeeqlWg4SIK/CzDHMNd23VsBS50gZ+S3ah
         n3vgU0D8Bay8l0R2ReIVrwSpp0JqKjuC0p2R7kCQHT9vmJSMLA1edCguCVYVq606Xnz2
         VVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rbc6sIjCFau6Mm+1jr5gCQOdqo/i3DTNgFL6nIWXd94=;
        b=Z1pGFb/hff1x6lq0cyTDYk61dz/qNdtJgySC+4Hf0tHGMtrd60iiyVQfoz4bmGJVpZ
         SjFrknUV3jmPWVkA94SWwdPTYyKWLSNsWVp+X1dNFqgfKh9N/lsvafCVjJUvPuLVY45V
         ZZ/2Rcb6YUR4znSAuAWT/Vn58gGmip/p/yDlvzni4+r/2RLOxzYVhFDq44cYMXdjhdjz
         Lqn7Oya9yTzSqRudt76V8pH80iYPsp6XkFukfXiTTMO+jLbcw5P8VgfpISxMKGwhgPFc
         CpByBi1M0z/L7H7hTChY9fNzVFJVYEB1000BabZusVaTCTz+yBYmmfTsBCRee7hrkPqD
         JJ4g==
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
Subject: [PATCH 4.4 106/134] ASoC: nuc900: Fix a loop timeout test
Date: Mon, 19 Mar 2018 19:06:29 +0100
Message-Id: <20180319171904.555299725@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390634104093891?=
X-GMAIL-MSGID: =?utf-8?q?1595390970751880418?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
