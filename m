Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuacPIVpdsKp3c6mL5AAZ5W6NK6Li5OX4YFxSSEFsc+K9TGvfniIZmtb8d2f0x6r1oXCGLj
ARC-Seal: i=1; a=rsa-sha256; t=1519981200; cv=none;
        d=google.com; s=arc-20160816;
        b=TCviy+DzJ+FpypOMPMJm7ZMmrh/HdpzntcTz6eifmkJnmtbGwGDxFgQn723iiZJZWn
         ctts93UjbWNywBQ8iMjvE2D9QjQ/9bh4a7nUgQdhTouZ5AbPw5lZRWTZv/EtgTxYN9e4
         +yuq3I2EPErGWWRcyQZwjuylOSZ6N4Mr0ppUVDAA0aGayN6TgW8ckHBqRnxb+r0wAdR9
         IzA19xEx9c4XDoquB7gUzNZaDUVAomfn8ZaqPqstfa6zf67zF9tYV/rHtDQfng0TlyDi
         8oKnYmjFArRH26gkvrlQB01feKxCc3UrkFkbBdWHoGXZtOVs5LadzisaaTIho5FvGmIl
         yc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=viLqCBpsRJWWyDGOr94/+XFNa4yo0/W7f/fDmjT04B4=;
        b=TLYjZw8dph4J2oTPrugXKISVdQY3Z/OvOpTeatUli1XUXLu+imbQvtzVnTwoNGoqWj
         sUjbFMuoA0Pd6qnx5oTufPeo1g/ppzSkHNf/FLAwn8iNQN8Wclc8vjpeZOmNI3JDNKFm
         tVLzDI69tnF95RLbx8SWIs89vGss1zpjeNt4zFJTtsIuAjGBDcnecsSemVoXRj0bJtAK
         E4txZ8QeRSyK8/sdiMsVP/wfc4fbcsju030urq5tWqESq5pc+iDGomHASsjkJl3lEoN4
         oTcyRpnyQFlu4+Hn7M+KJnz+BgDSI5M1Mn1aeNb5dmfmkTUt8OYLxdLjOPPwlriODsa/
         MH7w==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 005/115] dmaengine: fsl-edma: disable clks on all error paths
Date: Fri,  2 Mar 2018 09:50:08 +0100
Message-Id: <20180302084504.072174231@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815569196394585?=
X-GMAIL-MSGID: =?utf-8?q?1593815807367072927?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
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
