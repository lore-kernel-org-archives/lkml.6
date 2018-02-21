Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2251ruI9fJk2wQRMoBq5kxXg50Q4eTUEQq1YCXA6lQ34TJwCLatvxZukP9EXMepL9A78QnYA
ARC-Seal: i=1; a=rsa-sha256; t=1519218145; cv=none;
        d=google.com; s=arc-20160816;
        b=TLRh0vTaHV7Td2H8gfyfTKHGBVUGPHJTtR6TGjlSE1NkpCHZHxyGqldqyr+m1ToEvQ
         D3dcEiDZ6FqIMRkRLuWSVRhdmi9fMmSJCxcbN3y+4UbPUWf2YTqC3yZBTNTOVymTq70p
         AReXC51JNke9e6Si5rZPcazvx02cbTmkl1nlJ2/yZ+zOZi9jevZuXHdYadNZgjG/0eg3
         znfNHuMOsyIc/kWyu0Ki4CgfgHxlOH7wMI2WtENayA7p34A2JxSRuiXKM0FOw9/KWwOm
         NNiUEcHZsdpUcRpuiaLYYvlwsaVDxh5/7B3kgvlGt6CbiQtJaDwdXWrWxiJODjXRn/BX
         UK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pM8E0E9HtNkwpKzyesgp/+UyBk0zqgZE6enbO5uHy5w=;
        b=sLuaY4BWqdNG3gAI3io8/TqeN98TqvwPMzj/FKVB60vGNoCibLr9MyaAgeJlTV8yMr
         227krsFt3FCiWZriwcH6b5ucJj+HgPPMGL0enflFPIA1M6oZsVFfhAGtBV2Jk8Aq0NCm
         DT+rfUCguklnu4w0fM7j6hkTdAW+hB0nyuPuVfR4ng8FKzGrGKSJiHVctnvk98MKFqhc
         AcjBAaKM/CmXlJQO1b+6bG2QQ6+O1yf9VxeBKDrdy8++fvxNebeuVoF//Je7fsLzAe7C
         KDFKsfGieo6g27ctAxU5cZoH0kNBubvdfC5fQ6fqmxhcQJmkqYgjnQycjUCVcyaJKFHK
         qbVA==
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
Subject: [PATCH 4.14 102/167] Revert "mmc: meson-gx: include tx phase in the tuning process"
Date: Wed, 21 Feb 2018 13:48:33 +0100
Message-Id: <20180221124529.945115035@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015686210679851?=
X-GMAIL-MSGID: =?utf-8?q?1593015686210679851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
