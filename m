Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpLaqfE4wKaHtbqzgK0P+4Pwd/YZuoVKrgCrTY7QYT0IQKfQeXmuWze2/mRKb8Uai4Nb+7B
ARC-Seal: i=1; a=rsa-sha256; t=1525116413; cv=none;
        d=google.com; s=arc-20160816;
        b=hw9WN9ytecZAV3KYwN7SlCDjAW1FopExHfeWgaOqOQqKOMLjGRH6X01rnQFVUEKpC/
         j9mWM8UhOMPnRnE3P+dp91T+AF56wRwXx4zoQjMvfqD+1r3Ra0UQ3qovK93eSPJ7tRsp
         obOBrAIE6bLnpdedlpB6va8gYAPGwvdZySMz+jrE0jJM9VcR8AbBl7Y0SnhQAJfGLsKF
         XLWTim24abtqr9LpgP1Y5BFBrfkfrLZi2568ftCft10p5bsz4SFivLd484jBytrWmdyj
         gvkFtt4R0rH5BncVsk0T0mWX7EZCARGs9H/GBPUR7hlL+WcPYozPIOh76XVLc8mScPUi
         uStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=9DHO31b4pT+Zi/d3f2x91r0bX7ORRtDboByZmyXAF1M=;
        b=zIGnfuK57LRN2fHvgVjVFSXSkoPOsRzTmaMZYACo/+JJ9KR87vNKcces8fb/ZEMvgl
         BJ7FZe5X2lqOHVH+ekPtBGsdIbB9ITvIsLUpBJEAqHjocohUkmUdUeRJS3hRC5HshpMC
         LIbe4yPx1x9zoCCvr4NEtyj3vM9k3/zjUG40jKxWEHq5Fn4knSgEg7x3kRn2LPKp1Q6q
         DQlSnDfHJnc0FUcHQosAwvz/qBdTJjQJdLsYDPRseoXXJw987tTNuBX/mYM2bunga365
         GPp3QHgESNWUfpP/0H0qk6kyp4w+tskImYw12Tf2B6dp986zDB+Pv5gAKTCdaR/wY9iU
         qQOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDC022DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 48/61] ASoC: fsl_esai: Fix divisor calculation failure at lower ratio
Date: Mon, 30 Apr 2018 12:24:51 -0700
Message-Id: <20180430183955.410289974@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200287248158187?=
X-GMAIL-MSGID: =?utf-8?q?1599200468795019674?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolin Chen <nicoleotsuka@gmail.com>

commit c656941df9bc80f7ec65b92ca73c42f8b0b62628 upstream.

When the desired ratio is less than 256, the savesub (tolerance)
in the calculation would become 0. This will then fail the loop-
search immediately without reporting any errors.

But if the ratio is smaller enough, there is no need to calculate
the tolerance because PM divisor alone is enough to get the ratio.

So a simple fix could be just to set PM directly instead of going
into the loop-search.

Reported-by: Marek Vasut <marex@denx.de>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Marek Vasut <marex@denx.de>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/fsl/fsl_esai.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -145,6 +145,13 @@ static int fsl_esai_divisor_cal(struct s
 
 	psr = ratio <= 256 * maxfp ? ESAI_xCCR_xPSR_BYPASS : ESAI_xCCR_xPSR_DIV8;
 
+	/* Do not loop-search if PM (1 ~ 256) alone can serve the ratio */
+	if (ratio <= 256) {
+		pm = ratio;
+		fp = 1;
+		goto out;
+	}
+
 	/* Set the max fluctuation -- 0.1% of the max devisor */
 	savesub = (psr ? 1 : 8)  * 256 * maxfp / 1000;
 
