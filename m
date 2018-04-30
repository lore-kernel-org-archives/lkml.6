Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqQmHVGoxdJ9Bq97y2KmX6iYEahZuynE3dDWnRsv5Mj0qsyklRoPpmoMv2y3PaggL+0DodQ
ARC-Seal: i=1; a=rsa-sha256; t=1525116364; cv=none;
        d=google.com; s=arc-20160816;
        b=QqdGr6sEYt1zk9bvCX2d4sWRZxcu0NkN4HB+eJDzhzyI5yGidZhtAHDYr59yvvlHgL
         WdtFCU9Iv/Y6jJ1e7jcmjsow+RUC6d+3n9XpVleY/ElrDMXxZQ8gD2d383E5Dq+YxeLu
         KVNyu2/gwwzCfGQgZTApsY3zOzYOvh21N/LOquMDX+4ow26xCGY89pj6jRm9sqKmHTJ6
         Fc0jerh+8vk5ZEOaAU9lJYSmnK5U3iSpaJmSpSdGwrkyqXypS1gI6JyO3xajlw90sGHr
         U5TeOS6JcItXN8tm7i/S6JOhV0KOgU0+bw76wULSkdYP1Z8//9NEEQwUok4IWypbnttn
         YziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=NcFMQf4mI/PuzrE/SFWHe7khDP0p+vcS4jV3ykOr60U=;
        b=djSkSZJQ6SVVBb6qYxFQlSr1cLTZjScqmVjV9VoHU9s03jQ3PZs+XWrlxnWFIiTj2f
         /iBM/jaYa/3NBC+bSEgzorLgCMW6s8qn9PuAeRHBwF7EuJrrxTwv5NhP/arFEltCseVi
         0/a4KMcXiGMuRZ+7P3qZc2KcvZ/i3Vb6asKD9rVdoep9oKIIFQ7SbfoUk6yD8eRtLlDy
         IsSvOYKYpGxV+ZSDtjFcN2Vb8ud3Dyeu9juyMEbzU5mhdsWHcTynxg7HrQwfMeiUhfhW
         wpWhgPDQhEtm6a/6fthBLQhQUsbv69mS32wBghDY3CM5EUl+Cs89f9Mk5usifXfY1IoB
         ZoMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A7322DC9
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
Subject: [PATCH 4.4 38/44] ASoC: fsl_esai: Fix divisor calculation failure at lower ratio
Date: Mon, 30 Apr 2018 12:24:49 -0700
Message-Id: <20180430190947.851669215@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200287248158187?=
X-GMAIL-MSGID: =?utf-8?q?1599200416651151490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -143,6 +143,13 @@ static int fsl_esai_divisor_cal(struct s
 
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
 
