Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224IBk51QE/apqrQePdCAgPFTmixTR5OKN1NAozeFg09efwxPA6yfk+YTEAhVSLC53J2vtOy
ARC-Seal: i=1; a=rsa-sha256; t=1517591827; cv=none;
        d=google.com; s=arc-20160816;
        b=X5Dn4WIpTjKHoMDMYUz0noHFRucWzmx9pB8F2vTkY6GM4d7xbYP/hrrINEPj5N2sHS
         d5WB7eJF/G0reqKx0Axyt1tGlSu6LNSoWzgAVZ5lLR9tMZ4t06EAW2BlLT+7IHAMQCUZ
         NOeAP8wrlql12p8tErWcDXy8fFB7Zz2iXzWTq82HRU1pLiNIz2jN2N207gw5vO7i/jeU
         yW+QpgwU/1zNx9x5NJWvtpcoahfgi/9+CjQVxLPcEvY5qfUKqMjUWGZNxpXN+ypuqJA3
         KjpPvn6rk9l5VwHnfwpmPej6yijB+aFD7ICrfsgJBu5e/5Afj5jjwIdDJUGHSpUPXvzp
         HTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pZB2uSLs++JSmkph55mNKLkwflIW9JLzU4BCAB7vn1k=;
        b=rh7QitM5Osixu68w/f8q7Ha2N0z5F6oRR1CJ45nZKfqNpyxHRFQl/AiFNK0jyWqtIV
         PV1aDQ6G0izWv59iVKmt7RDLTpIckKCv9i21Zm0FMzGYhu6miOv6rXVECeIVTPkCrwok
         z0r+yG2AL7OE69cgj4b7BAzKFdxthVLw3OUSULqBzv9Gt63ynhZLHuHo9WSX27hx6wLe
         1Ny84YaTL0drcdaxMSREce+dai7724xntMLzI5mIRmDCkTthAOt/BA4CWv2ZSrUUXMmC
         I3t/4hvhMxIZRAgbRcJm2PBB8cjAge4XJcfkrdeMpYOyKYGEaLoU2xfzgUtFF3fNVBRE
         7EzQ==
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
Subject: [PATCH 4.15 49/55] spi: imx: do not access registers while clocks disabled
Date: Fri,  2 Feb 2018 17:59:07 +0100
Message-Id: <20180202140830.828629367@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309464774805195?=
X-GMAIL-MSGID: =?utf-8?q?1591310367588558493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1668,12 +1668,23 @@ static int spi_imx_remove(struct platfor
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
 
