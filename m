Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227xk0AFATb7zT201Kd/Dcmr2QCtsbb7LrVMYJPiWyEtNxBKw2+q/3bq8W5mBgJ60NPcBe3g
ARC-Seal: i=1; a=rsa-sha256; t=1519218316; cv=none;
        d=google.com; s=arc-20160816;
        b=R6/UzVi5GCFXpNaiqDbBF1iBKNRLNE1LjPaDJXQ7/XEHn8NNA2j0e8B+4CjwZPdJAT
         SVsEbPDqF9Yz2hkU6f+tFOmuFYQwZiuBpKeq0KO6xM1R91Cf8FPajJSN2pyUVBbfsTPK
         4g0R9yELSfIB+/cxUs675uV2RgESYPjww7mpKRNqbB9zkktZQfhJDaeaX25Auhi2JG13
         ioiGDYGEcaCnTNIjnJL78mlS4AcdZg4G2/ioUVfdeuqTJdXYKFXcsK3/hTiZ5F45NDqw
         GoESWRvOW0oCGysWBQX97pZGJ8MNqIrby63v0YgQcUJ3MXY4dPNl4naSbKBqh+m8vDDX
         UsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lUtaF07w3xk4d/BTRd5bcUSENwGO92ja21MaPDF3GKw=;
        b=dtkq+Hv+Y2gNMnikA3wM1T9qfIy+Beh30Alp+Epd0RbgVF9zb5tgowU1ryZcYp8nir
         3s4ulxMC2fUaLipddxhIxStf8TdUGmYp3mSLqJW+X55ZjvlVHP3hPPWMRxuPC+A5JZYN
         WOhoOSZmeaqsCrbkzb4LSGgcHRw3NzllFV84/WXvJLa3UxAhQe6pp2mjyy/G+c+AP3o0
         WfAo+UiXgGFofWLhUAFl1IGlYBPnkxk3lJned7YOoeOS9PBMeM8mysjpKjobTMJmA7/K
         VEoUFib/T3F2zdN51tjjBBvCfsAgfcRYkuLJw5LTtNuw8lDUFUlgqjCAyrslSYV7eb0R
         6QoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 4.14 163/167] mmc: sdhci-of-esdhc: disable SD clock for clock value 0
Date: Wed, 21 Feb 2018 13:49:34 +0100
Message-Id: <20180221124533.760885592@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015864888711224?=
X-GMAIL-MSGID: =?utf-8?q?1593015864888711224?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yangbo lu <yangbo.lu@nxp.com>

commit dd3f6983b4a468efca9e8caa0e2b4aa20946d801 upstream.

SD clock should be disabled for clock value 0. It's not
right to just return. This may cause failure of signal
voltage switching.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-of-esdhc.c |   58 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -458,6 +458,33 @@ static unsigned int esdhc_of_get_min_clo
 	return clock / 256 / 16;
 }
 
+static void esdhc_clock_enable(struct sdhci_host *host, bool enable)
+{
+	u32 val;
+	ktime_t timeout;
+
+	val = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
+
+	if (enable)
+		val |= ESDHC_CLOCK_SDCLKEN;
+	else
+		val &= ~ESDHC_CLOCK_SDCLKEN;
+
+	sdhci_writel(host, val, ESDHC_SYSTEM_CONTROL);
+
+	/* Wait max 20 ms */
+	timeout = ktime_add_ms(ktime_get(), 20);
+	val = ESDHC_CLOCK_STABLE;
+	while (!(sdhci_readl(host, ESDHC_PRSSTAT) & val)) {
+		if (ktime_after(ktime_get(), timeout)) {
+			pr_err("%s: Internal clock never stabilised.\n",
+				mmc_hostname(host->mmc));
+			break;
+		}
+		udelay(10);
+	}
+}
+
 static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -469,8 +496,10 @@ static void esdhc_of_set_clock(struct sd
 
 	host->mmc->actual_clock = 0;
 
-	if (clock == 0)
+	if (clock == 0) {
+		esdhc_clock_enable(host, false);
 		return;
+	}
 
 	/* Workaround to start pre_div at 2 for VNN < VENDOR_V_23 */
 	if (esdhc->vendor_ver < VENDOR_V_23)
@@ -558,33 +587,6 @@ static void esdhc_pltfm_set_bus_width(st
 	sdhci_writel(host, ctrl, ESDHC_PROCTL);
 }
 
-static void esdhc_clock_enable(struct sdhci_host *host, bool enable)
-{
-	u32 val;
-	ktime_t timeout;
-
-	val = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
-
-	if (enable)
-		val |= ESDHC_CLOCK_SDCLKEN;
-	else
-		val &= ~ESDHC_CLOCK_SDCLKEN;
-
-	sdhci_writel(host, val, ESDHC_SYSTEM_CONTROL);
-
-	/* Wait max 20 ms */
-	timeout = ktime_add_ms(ktime_get(), 20);
-	val = ESDHC_CLOCK_STABLE;
-	while (!(sdhci_readl(host, ESDHC_PRSSTAT) & val)) {
-		if (ktime_after(ktime_get(), timeout)) {
-			pr_err("%s: Internal clock never stabilised.\n",
-				mmc_hostname(host->mmc));
-			break;
-		}
-		udelay(10);
-	}
-}
-
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
 	sdhci_reset(host, mask);
