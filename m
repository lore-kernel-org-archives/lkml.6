Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELty3F3Yuw/EwbHDsDJ3B72jSzYmiwHTPKzTuAKwe6EmS1yN792ZIayuVHhutieC3nllrzXx
ARC-Seal: i=1; a=rsa-sha256; t=1521483190; cv=none;
        d=google.com; s=arc-20160816;
        b=LgJCxQMRVtRH/fTp9vQL9DlNs3ml8WmttWIXlQpPfp8n4+ZTcPqdRy9mAU/NKXn6iw
         GHA10fqITvyoQ43GRwGoqc7jcTGmB5QfYVKL7kh0/HWdoyrv1iD9mGSza8+edPiGN3DF
         tm+NaeS4DcWrhpt9IdWPdlQssXvOXKTxxM76bqDbpxP5fmmWk2/bi5nWKRl6obazsUv0
         JFK90Tqxoj2rse9qmZCjok0jmWhHkXKp66JYTzedlwfas0mm1PqOnrt3GWLMJSUaKnCL
         QaP3oKVOHwmy0bhcYX2BARF1bE0DoBfSVHAt0nAWBDEYLT9x8mu/+7g+0E38q4vjkN1u
         oaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UR4+WDHq2nDa7ra4ii5A8aiE2yjimS6IC8c41JmUhRU=;
        b=cohEQJJ7RyHIy4Li6rekhXOrMG44TCScxnDQ2CqXmhBGm0Tbwne7TX4/CYVrkJO7ew
         vttirgRLvGWCn6IyoQg/bTiQRzQBLlNoyv3bJcqvBMdsPZUnDHIQURtSNKebnR2f39At
         dPDuNBfa7klh7pkXvfO/rLi5x6nRxEmY2nsOR21WL+SfW/7teKaW0fAFg94L2T5grE9I
         jlDc2yNGDSgXh5W4zX7JuWWvDFxY1T05XMDVCdJILQT6ylyc84kdwZPDWFUZ9cRA8DWM
         ZrkSpqyHtbibIkKnzdNd05FWKVK78pj3JCS64hDiB7x1nZdZKOtH4pwc7GgB2EsdNMwC
         5NWw==
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
Subject: [PATCH 4.4 031/134] ASoC: rcar: ssi: dont set SSICR.CKDV = 000 with SSIWSR.CONT
Date: Mon, 19 Mar 2018 19:05:14 +0100
Message-Id: <20180319171853.784248889@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390758601391123?=
X-GMAIL-MSGID: =?utf-8?q?1595390758601391123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -143,6 +143,15 @@ static int rsnd_ssi_master_clk_start(str
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
 		 * system word is 64fs (= 2 x 32bit)
 		 * see rsnd_ssi_init()
