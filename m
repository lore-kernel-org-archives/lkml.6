Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt7dnlbUz2YsK/cL2KWlckno8vM8+NoxhOc1iIJU0hq0f1q2vdYIB+cjWz0WnL0CCG6uzvH
ARC-Seal: i=1; a=rsa-sha256; t=1521483658; cv=none;
        d=google.com; s=arc-20160816;
        b=pfN3DFK1Wprp8YGtUsk3AAU2bwuEgN+PF7rAJ6lQqrHrj0FGN4S4A8TGoypEYl90nu
         mCwBaRp9PIU4a2AV2mfVNpCgaCbjzF9WajzmTXDfT78wUNNdYL5SJYI6sYGCpOI0rA+l
         f1nXupBAEYJ0VrHGfYvZpC3ixM5+ZEAwpQhu2ULOjU2VT6GsUXk74qjQ/iRiJPAufayG
         pzc/RUq7fQUgm1Xi5TUpioTmamE5fmj88WXrO4SbhekWhr6sFBIjedoXs33g3yfhJcT3
         lXUzbbdGTGiwdHCwrd5P2u0xCrOTuZastM/dD70cha8NO3VFlP8sTHLkGdT5rjvvp2K6
         mJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E4EoITbpP2yqEk04Y3fSvS+Nz1ZMivSRv0XpsKsljWA=;
        b=b0kENFVXNQJT9Nzaf7MNy45Ze+km/UXuiB7ZZXvrSD4vaFbZ3Edkudv4Cee/FUy6wz
         yoJA/9mFH/RoI15uiwKht+BWRkBT+FznQnpzLzTegGsxk0UaqIaH15JuNsW2w9Ag1w5p
         6j9oeL5KPLustEVBuSCpzsS+o/bUy/Fmy6Q9Rmxm5QIww2kPATc5J4UppATb2Mqw3RA3
         R3M52IWsSs02k5lZPWZbmALFZ38UqSCSNy0Lcem4cZo7L5T4KVMGq2LyMArO28yWfkKZ
         ltsxEa24PCXEX6mn36a0s1ZwrhjqQbae6Ui/9LF5mDrJJx1fv4KHBi5s5dGP5XWnB6YB
         +lug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 062/241] ASoC: rcar: ssi: dont set SSICR.CKDV = 000 with SSIWSR.CONT
Date: Mon, 19 Mar 2018 19:05:27 +0100
Message-Id: <20180319180753.770928793@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390758601391123?=
X-GMAIL-MSGID: =?utf-8?q?1595391249336984270?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


[ Upstream commit 6b8530cc056efd4a11b034ca5b1e9f7e9563f553 ]

R-Car Datasheet is indicating "SSICR.CKDV = 000 is invalid when
SSIWSR.WS_MODE = 1 or SSIWSR.CONT = 1".
Current driver will set CONT, thus, we shouldn't use CKDV = 000.
This patch fixup it.

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sh/rcar/ssi.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -233,6 +233,15 @@ static int rsnd_ssi_master_clk_start(str
 	for (j = 0; j < ARRAY_SIZE(ssi_clk_mul_table); j++) {
 
 		/*
+		 * It will set SSIWSR.CONT here, but SSICR.CKDV = 000
+		 * with it is not allowed. (SSIWSR.WS_MODE with
+		 * SSICR.CKDV = 000 is not allowed either).
+		 * Skip it. See SSICR.CKDV
+		 */
+		if (j == 0)
+			continue;
+
+		/*
 		 * this driver is assuming that
 		 * system word is 32bit x chan
 		 * see rsnd_ssi_init()
