Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Cl9aSsyib3oz88NQLVsxQSYDIO4vrjJ91FbT+K2F44eG4LBnJmlFqKOqW0mSnIUnJVVz9
ARC-Seal: i=1; a=rsa-sha256; t=1519218623; cv=none;
        d=google.com; s=arc-20160816;
        b=qdhJ/clykB85lcEcrkdD+cjpVySUtsyFSSWya4NdDFBt7JFD05wJGzLXlxPb0kTPw0
         tqoBUOk89wJiVogx87ynwIp68rFOeYJUJQt6/96TOlzwxFgfHEhuJThr1E9E3sa3LoFo
         U+TXmmMLf4ttxWR66/2ydp6ol0ZWLYTAVUaMkYFLckTsKIV965AnZ4T49wzGlGRvYplD
         OP+C+aDl0PBUVcuISzPKvlicAAdV9uffsfqdwW1t0wyszpDOY8Rq/CKfq4aScwDIdQ3I
         gogm/Uo5zGnuYuG+KW7zi9s4E73lUcmmwnuBPh5kgVRaLKz5apwWde6M+QzKi/BjnvzO
         ZF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6irKT1RvFfu1QbFDOWTCNkgGkMHbjAh4sCvymFdmxTM=;
        b=roqLubiX4i/QxHBksrd8JQIi4hPnNCHXrUpVG9N1SF5mbHP/TKNs0Kip9o3kvp3Wqi
         OXaXZzGoImM4tY6as939NH2J2pGj42O3d/kQcMCW98hF38VuB3j/qA9mf8U09Dhe9oNB
         prRNVNZfhJIYpUa4ku+w5Nf4uepjgy/NWEO1f3E9QOks4CH93nmR4PuStSwoAFyhfqQS
         7CCBCEVL9vcXIWHejkenRG+k2yMN/o5pPmslVR5HGMoVshy90QpCtTDP0hjUPN+fRNEm
         WSmIKIvumj5lHDozu6xXscD0RLKKbvYZbk50IoP0UQXbdpjxE29ZxnMKvgD12vTklg3M
         We/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.15 103/163] Revert "mmc: meson-gx: include tx phase in the tuning process"
Date: Wed, 21 Feb 2018 13:48:52 +0100
Message-Id: <20180221124535.974823585@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015686210679851?=
X-GMAIL-MSGID: =?utf-8?q?1593016187592694420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

commit fe0e58048f005fdce315eb4d185e5c160be4ac01 upstream.

This reverts commit 0a44697627d17a66d7dc98f17aeca07ca79c5c20.

This commit was initially intended to fix problems with hs200 and hs400
on some boards, mainly the odroid-c2. The OC2 (Rev 0.2) I have performs
well in this modes, so I could not confirm these issues.

We've had several reports about the issues being still present on (some)
OC2, so apparently, this change does not do what it was supposed to do.
Maybe the eMMC signal quality is on the edge on the board. This may
explain the variability we see in term of stability, but this is just a
guess. Lowering the max_frequency to 100Mhz seems to do trick for those
affected by the issue

Worse, the commit created new issues (CRC errors and hangs) on other
boards, such as the kvim 1 and 2, the p200 or the libretech-cc.

According to amlogic, the Tx phase should not be tuned and left in its
default configuration, so it is best to just revert the commit.

Fixes: 0a44697627d1 ("mmc: meson-gx: include tx phase in the tuning process")
Cc: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/meson-gx-mmc.c |   19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -716,22 +716,6 @@ static int meson_mmc_clk_phase_tuning(st
 static int meson_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct meson_host *host = mmc_priv(mmc);
-	int ret;
-
-	/*
-	 * If this is the initial tuning, try to get a sane Rx starting
-	 * phase before doing the actual tuning.
-	 */
-	if (!mmc->doing_retune) {
-		ret = meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
-
-		if (ret)
-			return ret;
-	}
-
-	ret = meson_mmc_clk_phase_tuning(mmc, opcode, host->tx_clk);
-	if (ret)
-		return ret;
 
 	return meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
 }
@@ -762,9 +746,8 @@ static void meson_mmc_set_ios(struct mmc
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 
-		/* Reset phases */
+		/* Reset rx phase */
 		clk_set_phase(host->rx_clk, 0);
-		clk_set_phase(host->tx_clk, 270);
 
 		break;
 
