Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226U+3f0vVtGeEH5Gn3DhZWOj3wa5W6E+jJRsXIpDz0Xn+L8pWlYwqNMIvHP9xdo3spuc5em
ARC-Seal: i=1; a=rsa-sha256; t=1517855215; cv=none;
        d=google.com; s=arc-20160816;
        b=weAjQPDw2cx2pZ2Dzte/4xTHnIl0aF0EQDtL6QZ0AV5Zt2/w15xVSo3b2tAkazTWYe
         7p00Xt5KTL490WiSTLMhfNdHT1JuYWa/BwcHCVLW3iY5v3td7du+SjMoEe1bFvdLfVKm
         h6MtLJGUngmY17zl/S2eTAbR7Dvp165RS6bfXM0asRxZb1GiUl9NXMu+ni2sVWgpja1j
         PQXIrN9IotHZznX7XBZtZ2GWUl/7sTLaH58PXUfGw7x5kaAPpXBsjc+f5PUMtY2hCJOH
         W2K51tzVBSZKF2wjF9bFrNQrbaTbagJz7YRcklOFBOnmbuQC/s+IizW2OFBoT5Ifh2IR
         9LPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gUUQCxLBQHbL4gfEKSRjT4Oc1s5M3lebQJMvnOWBNTk=;
        b=mjoc4BRI3GbRl12PSZLkdD4tKQT9xpdMnkcbxCP5a2se36+82+cd/afp0nlsUfQ9pq
         kgPWN8Jsd9E8JZ7ufgon9N8sJFewCvcXjJ4iEZnehSpLvLE9jNaOU/4k9UQIAnEunVdQ
         nonfzvkNbQGMCQLdO6L8NcHo+foQONJoeQdlDELvQYh0/AHivsd3sW3fvHp8d7gSqW1o
         nM9Bv+NddQWAXkViApdBfP9rVeE9rxSXC8sDvrAfvOWJrONDR+/d784TPhTHf85PfHyk
         v6CyXfBo9o0Si5XxYkUH9mm24+DoAiOXPCGqLFnv3qbSgQJ6zvKrrS32HBOTE2f8gTa5
         cVTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Agner <stefan@agner.ch>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 3.18 35/36] spi: imx: do not access registers while clocks disabled
Date: Mon,  5 Feb 2018 10:24:03 -0800
Message-Id: <20180205182353.218567254@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586550983169827?=
X-GMAIL-MSGID: =?utf-8?q?1591586550983169827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1220,12 +1220,23 @@ static int spi_imx_remove(struct platfor
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
 
