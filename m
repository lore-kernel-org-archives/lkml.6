Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225UUjFTAhntS7/rKhfDu+tZwsXxGZFNKUq16lP5uBaamP0Wrp/6IJuKPMnup0/al1yrO8Y+
ARC-Seal: i=1; a=rsa-sha256; t=1517591654; cv=none;
        d=google.com; s=arc-20160816;
        b=a/1M8dKAxh/Le+8p3mCFYhzTduywzecedRusl3SfqwRK67kp1+e8PIpBe+XxVBPTih
         ji4kAOewyL7rtUldTdXq8NE7Uv3KgFz0Xt8i/vuF/XdIu5blZTyHozWcHDNg/Z/hXaLF
         kBaKoeu6bpYg1pe9ezF1krPseXqUHgO+ADJN3Yo13sEDVm+nlsG9NOu1l1cHnihKYUBM
         UUIXaLagjT1F7NlZhpMKVIXhIW8YPTrVWeGwsWgIVsWY09BIEUQfWPZ4xlCxJWJO+If7
         80hDsfp8cwpoDQkgYXLd3wZiIQWk58ks2mcmnMOfIKhkPGGmmDR047CDYYoZYAI56he1
         Km4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SQFKErIa/lBDoyAQ9uYPQAR6r+TlOWv9qdJMs6eAaio=;
        b=YO4xsvc2JSbG+srlxDvo3Pay1BVdFNuiltC407FmY0YP1Iub3ooPkKj1Kz1h1Jfp9U
         t6awbsmJYeAvA5+0l5FT4vFKeBE0mYBFaHTXQ42mc56g0Fo3I4IqIed3vhXMyjocUaVG
         c/1xRk7PNphssfxW6mPK7w5tlY5FjTrfU9d+9YrcbPQSCUJYB+Uz8F9B2TpB5M8/HBa0
         44RV36kvguPgaXYxn7F+Ad0ENtwJGi6a+E0789gVGE8ugrMkv3G39PgWrAVMAsTQURbi
         UPczIDgurPHNZDaoTO4pNkmS8uItgg+Xx8XEuzPil5FLtVakOpL0/WBzWzqfcxJ6s+f+
         Oupw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Agner <stefan@agner.ch>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 150/156] spi: imx: do not access registers while clocks disabled
Date: Fri,  2 Feb 2018 17:58:51 +0100
Message-Id: <20180202140847.143336945@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309464774805195?=
X-GMAIL-MSGID: =?utf-8?q?1591310186179427673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

commit d593574aff0ab846136190b1729c151c736727ec upstream.

Since clocks are disabled except during message transfer clocks
are also disabled when spi_imx_remove gets called. Accessing
registers leads to a freeeze at least on a i.MX 6ULL. Enable
clocks before disabling accessing the MXC_CSPICTRL register.

Fixes: 9e556dcc55774 ("spi: spi-imx: only enable the clocks when we start to transfer a message")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-imx.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1496,12 +1496,23 @@ static int spi_imx_remove(struct platfor
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+	int ret;
 
 	spi_bitbang_stop(&spi_imx->bitbang);
 
+	ret = clk_enable(spi_imx->clk_per);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(spi_imx->clk_ipg);
+	if (ret) {
+		clk_disable(spi_imx->clk_per);
+		return ret;
+	}
+
 	writel(0, spi_imx->base + MXC_CSPICTRL);
-	clk_unprepare(spi_imx->clk_ipg);
-	clk_unprepare(spi_imx->clk_per);
+	clk_disable_unprepare(spi_imx->clk_ipg);
+	clk_disable_unprepare(spi_imx->clk_per);
 	spi_imx_sdma_exit(spi_imx);
 	spi_master_put(master);
 
