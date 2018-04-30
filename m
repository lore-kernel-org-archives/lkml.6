Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqLcFiTdPZSAdAyPO18QVLoxFfCoeSIr6KWcLQpZ3gv5E8kLCFUZPX6KTJFlDJ7QVJyXbMn
ARC-Seal: i=1; a=rsa-sha256; t=1525116470; cv=none;
        d=google.com; s=arc-20160816;
        b=D6jcX0gptFoL89LufkjWdRCc6L0vyv65O/d3KMBcHZnVon24QHMtm9LLoRxrk2v6xe
         nuCwaDP99UYLSY2DG13EtVb4rIelwA6FEHDNAfP1NUS+UUJasSAbEWbDZB/GACWD9Vh2
         KcbVZv41y4IYcWI7FggsULbmdamR1LA16BnR8is/bPx4xZR672+36LfVxQ80SRNB0B5r
         m1LcOFsSuGmrFKnQhgnq62kp+/10QllDLq8aQDLNmcE+T2iUFTk5zxDWEspzhjpLBIJg
         30jEiPLhGf3Fm5EPBjQGw6iSJFslDKw7gXiAYMi0t4NMzz+hhQenX44/KJNsR33K4hGD
         YJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=0gqd+6616BGB2J3m+034bIvVxQsljnizYF31bXEE4q8=;
        b=fqr7Asad8xjS4zvOfRBI4s/ajKdSSJpHsrzsX9e11Wz0yB2ywNsbaaxxPzvJ5MlMZ4
         vLEVqXeML/uuLVYezrMjOs8/H0vD5YkX+c7paLWS8pYB4xKroKcCZQ+ik0wScTP9vl8z
         Vu76TF+7LJh8+kqx4QOxydJZulITomQyfjXLUg3xuribzpQfXg8/L3JNvlARr8O/NsvW
         f4GvabhpO6viUlXxAA7WUWd/gbtEa2n2xyorsWYPzMNXROCFAt7qjj3vC4VF2AdINqA6
         QjrgjTVENMxiof87PZF/VqyYzQg//AjS+hllBaf2tMc2ryy+Z8Sy8ZCBldES8uRCBHyr
         knNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E75222DCC
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
Subject: [PATCH 4.14 72/91] ASoC: fsl_esai: Fix divisor calculation failure at lower ratio
Date: Mon, 30 Apr 2018 12:24:54 -0700
Message-Id: <20180430184008.011918885@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200287248158187?=
X-GMAIL-MSGID: =?utf-8?q?1599200528982252324?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -144,6 +144,13 @@ static int fsl_esai_divisor_cal(struct s
 
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
 
