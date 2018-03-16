Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuv4zpPx5Dn8ZcetmvFCPWPPMQ5B6YCkBp0wHYlmXJLVgbLDMwxxHhgz+Ques2Xgn68j34o
ARC-Seal: i=1; a=rsa-sha256; t=1521214818; cv=none;
        d=google.com; s=arc-20160816;
        b=bvkfInQsMb95UVTpsilRrXH0c73sjZQSgVWvQREPvLECgqEdbeNpsmdJL1NPydbMZ+
         D/m3EohfqG4OnG4CEv1z3K4vga4KbvLscDYm5YRM8tX0ao+nk5wVObgx65REUssl4QYz
         MWyVjsOZ2B6uRn/kFIFk5dZLMt0PgOmmzAD0OV+rINYxDQBTKhluh9pnAnBJbTzTGICz
         U2Urs2AgJExJ/oK70fxZleuSMrh4pV6nWG//YD+VkjqRMMe4XTx6ODi/eBBGwKSoj3VU
         SCnBK5ekW8LWXyl+Knga9cEmcL03JbfLsvfJFPNLczJOPLj16FkVVJu61ijCZnvdgK2b
         QrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QHaTIE4Em53HfsHXhokMN0CTxnGd/7KAyWGru1lRelA=;
        b=A5khPHeEwhhHX04E42I/81HkSnmDmIrQw6V2+SHDbftJtPnwj2/E+Sst73lkp7VelH
         N3ToABmr+fSGm7qh8JISxVZsUGNN1BZ3KKTIQmjgHg3+aucpbirhms/0YCZUmuR7rrpA
         DYSw7igsCmF5OIQXvL8NPsK3Kb929WhHOyLed8DbaB07N/2UofOIFObuS036vjezN6dz
         Bn6UqAc1z4E8i1FOK6/rIwNBeDwGVF6t4HrEcen0yV4AKucFqZ0mu3nugbdt8E7cvHTn
         6390IDgs+gbIeouaYscZ/aCl9KfjEiDTB91pBjANOvp37gKuyJH6G9POPZWLtOGx3mUB
         XWdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Trent Piepho <tpiepho@impinj.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 029/128] spi: imx: Fix failure path leak on GPIO request error correctly
Date: Fri, 16 Mar 2018 16:22:50 +0100
Message-Id: <20180316152337.986897158@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109350214699969?=
X-GMAIL-MSGID: =?utf-8?q?1595109350214699969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trent Piepho <tpiepho@impinj.com>


[ Upstream commit 8197f489f4c4398391746a377c10501076b05168 ]

In commit 974488e4ce1e ("spi: imx: Fix failure path leak on GPIO request
error"), spi_bitbang_start() was moved later in the probe sequence.  But
this doesn't work, as spi_bitbang_start() has to be called before
requesting GPIOs because the GPIO data in the spi master is populated when
the master is registed, and that doesn't happen until spi_bitbang_start()
is called.  The default only works if one uses one CS.

So add a failure path call to spi_bitbang_stop() to fix the leak.

CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <kernel@pengutronix.de>
CC: Fabio Estevam <fabio.estevam@nxp.com>
CC: Mark Brown <broonie@kernel.org>
CC: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-imx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 40390d31a93b..6f57592a7f95 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1622,6 +1622,11 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->devtype_data->intctrl(spi_imx, 0);
 
 	master->dev.of_node = pdev->dev.of_node;
+	ret = spi_bitbang_start(&spi_imx->bitbang);
+	if (ret) {
+		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
+		goto out_clk_put;
+	}
 
 	/* Request GPIO CS lines, if any */
 	if (!spi_imx->slave_mode && master->cs_gpios) {
@@ -1640,12 +1645,6 @@ static int spi_imx_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = spi_bitbang_start(&spi_imx->bitbang);
-	if (ret) {
-		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
-		goto out_clk_put;
-	}
-
 	dev_info(&pdev->dev, "probed\n");
 
 	clk_disable(spi_imx->clk_ipg);
-- 
2.16.2
