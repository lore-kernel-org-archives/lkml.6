Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu6XGTl69n3sctTDQ9CHl3vuHtpnA/bYLAbwY/H2y0Ih/8llHN9c1E9kBUhmED/aGPPV4Jq
ARC-Seal: i=1; a=rsa-sha256; t=1519980973; cv=none;
        d=google.com; s=arc-20160816;
        b=blSPYJK4Fz46qFt8lfbvT8bLT98yjclN+ZEIZc7OSPILvIcOOPFd55D1lpVrQJ/tsN
         giaFSdhBFsBEDmR6vHAu9tYDaxO4U5oumZxFJBd9D+rgxZm5zDVEKFtyliDAe0MLhLpi
         ZzI9K7ZrK3gevrbNDeQHv1G2nocz1AF1eRCaO8L1hg8jBN9AhEgaxuzJ/v3rJuh4tziK
         RkTpxh69nxiBkJvwJ5bT13KZ7suDnPQ0u2VZ+nCZPT0jWdktUQRV6c0JU7lQ6uolK66F
         XZiiyyXcZtRj7jQv9R03zoTb9Op/xDYdUNhby/XKG8b3OkZbDun1Zxv82Ouj78frkQRd
         e1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6jrnm9oqJMzhUNy3KSt2w/lMv/YeebSJJHhTRY3Lgv4=;
        b=MWsy9UnuKtRGCi+VsH5hmqWb7tZk69SuPLQWUf4wWu4Y/sSpt/OYbwkfnIL18Xe4W0
         yAVA9b6UgVSs0DQPwC5I0hmyREVOsZpTEKx4PfP4T0oQrIZUR0wdWItv1tR6Qn5+1dyX
         HL67OjdC6nEgM6kCDuk0Oq9oMRzvJwDV2SLisF3WbxdNxQ4aJO8k4Oy3350y3yLbS7m9
         EbaYMI0VGpM5n+RE6a6ZvM4zvJhs20oSUlFvzI/q2slbPtyNbdfyMknAIciQk3/KM7Ef
         9eHgd5zt94KKpg/YlBVKhMEuxJYeviircFrqAnNBTCEOFDHJszInw4nhHF91N5Is6HcY
         JZzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andreas Platschek <andreas.platschek@opentech.at>,
	Vinod Koul <vinod.koul@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 04/56] dmaengine: fsl-edma: disable clks on all error paths
Date: Fri,  2 Mar 2018 09:50:50 +0100
Message-Id: <20180302084449.866993911@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815569196394585?=
X-GMAIL-MSGID: =?utf-8?q?1593815569196394585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Platschek <andreas.platschek@opentech.at>


[ Upstream commit 2610acf46b9ed528ec2cacd717bc9d354e452b73 ]

Previously enabled clks are only disabled if clk_prepare_enable() fails.
However, there are other error paths were the previously enabled
clocks are not disabled.

To fix the problem, fsl_disable_clocks() now takes the number of clocks
that shall be disabled + unprepared. For existing calls were all clocks
were already successfully prepared + enabled, DMAMUX_NR is passed to
disable + unprepare all clocks.

In error paths were only some clocks were successfully prepared +
enabled the loop counter is passed, in order to disable + unprepare
all successfully prepared + enabled clocks.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Andreas Platschek <andreas.platschek@opentech.at>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/fsl-edma.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -863,11 +863,11 @@ static void fsl_edma_irq_exit(
 	}
 }
 
-static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma)
+static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
 {
 	int i;
 
-	for (i = 0; i < DMAMUX_NR; i++)
+	for (i = 0; i < nr_clocks; i++)
 		clk_disable_unprepare(fsl_edma->muxclk[i]);
 }
 
@@ -904,25 +904,25 @@ static int fsl_edma_probe(struct platfor
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1 + i);
 		fsl_edma->muxbase[i] = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(fsl_edma->muxbase[i]))
+		if (IS_ERR(fsl_edma->muxbase[i])) {
+			/* on error: disable all previously enabled clks */
+			fsl_disable_clocks(fsl_edma, i);
 			return PTR_ERR(fsl_edma->muxbase[i]);
+		}
 
 		sprintf(clkname, "dmamux%d", i);
 		fsl_edma->muxclk[i] = devm_clk_get(&pdev->dev, clkname);
 		if (IS_ERR(fsl_edma->muxclk[i])) {
 			dev_err(&pdev->dev, "Missing DMAMUX block clock.\n");
+			/* on error: disable all previously enabled clks */
+			fsl_disable_clocks(fsl_edma, i);
 			return PTR_ERR(fsl_edma->muxclk[i]);
 		}
 
 		ret = clk_prepare_enable(fsl_edma->muxclk[i]);
-		if (ret) {
-			/* disable only clks which were enabled on error */
-			for (; i >= 0; i--)
-				clk_disable_unprepare(fsl_edma->muxclk[i]);
-
-			dev_err(&pdev->dev, "DMAMUX clk block failed.\n");
-			return ret;
-		}
+		if (ret)
+			/* on error: disable all previously enabled clks */
+			fsl_disable_clocks(fsl_edma, i);
 
 	}
 
@@ -976,7 +976,7 @@ static int fsl_edma_probe(struct platfor
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		fsl_disable_clocks(fsl_edma);
+		fsl_disable_clocks(fsl_edma, DMAMUX_NR);
 		return ret;
 	}
 
@@ -985,7 +985,7 @@ static int fsl_edma_probe(struct platfor
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
-		fsl_disable_clocks(fsl_edma);
+		fsl_disable_clocks(fsl_edma, DMAMUX_NR);
 		return ret;
 	}
 
@@ -1015,7 +1015,7 @@ static int fsl_edma_remove(struct platfo
 	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
-	fsl_disable_clocks(fsl_edma);
+	fsl_disable_clocks(fsl_edma, DMAMUX_NR);
 
 	return 0;
 }
