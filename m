Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeDCPuD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:50:03 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:59966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751323AbeDCPuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:50:01 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:69:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1535:1544:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2899:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3870:3872:3873:4250:4321:4605:5007:6119:7576:8828:10004:10848:11026:11232:11473:11658:11914:12043:12296:12555:12683:12740:12760:12895:12986:13095:13255:13439:14180:14181:14659:14721:21080:21433:21451:21627:30029:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: spade90_57156a35c6141
X-Filterd-Recvd-Size: 5260
Message-ID: <1522770597.11653.49.camel@perches.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
From: Joe Perches <joe@perches.com>
To: Ladislav Michl <ladis@linux-mips.org>,
        Colin King <colin.king@canonical.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Apr 2018 08:49:57 -0700
In-Reply-To: <20180403134540.GA29017@lenoch>
References: <20180330154420.6903-1-colin.king@canonical.com>
         <20180403134540.GA29017@lenoch>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-03 at 15:45 +0200, Ladislav Michl wrote:
> On Fri, Mar 30, 2018 at 04:44:20PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> 
> Hello Colin,
> 
> > Trivial fix to spelling mistake in pr_debug message text
> 
> would you mind making this patch a bit less non-trivial and
> change pr_debug to dev_dbg dropping Atmel_ssc_dai prefix?

Presumably, then all the pr_<foo> calls should be changed.
Something like:
---
 sound/soc/atmel/atmel_ssc_dai.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index a1e2c5682dcd..594228156b2d 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -291,11 +291,10 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 	int dir, dir_mask;
 	int ret;
 
-	pr_debug("atmel_ssc_startup: SSC_SR=0x%x\n",
-		ssc_readl(ssc_p->ssc->regs, SR));
+	dev_dbg(dai->dev, "SSC_SR=0x%x\n", ssc_readl(ssc_p->ssc->regs, SR));
 
 	/* Enable PMC peripheral clock for this SSC */
-	pr_debug("atmel_ssc_dai: Starting clock\n");
+	dev_dbg(dai->dev, "Starting clock\n");
 	clk_enable(ssc_p->ssc->clk);
 	ssc_p->mck_rate = clk_get_rate(ssc_p->ssc->clk);
 
@@ -385,7 +384,7 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 	spin_unlock_irq(&ssc_p->lock);
 
 	/* Shutdown the SSC clock. */
-	pr_debug("atmel_ssc_dai: Stopping clock\n");
+	dev_dbg(dai->dev, "Stopping clock\n");
 	clk_disable(ssc_p->ssc->clk);
 }
 
@@ -794,13 +793,12 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		break;
 
 	default:
-		printk(KERN_WARNING "atmel_ssc_dai: unsupported DAI format 0x%x\n",
-			ssc_p->daifmt);
+		dev_warn(dai->dev, "unsupported DAI format 0x%x\n",
+			 ssc_p->daifmt);
 		return -EINVAL;
 	}
-	pr_debug("atmel_ssc_hw_params: "
-			"RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n",
-			rcmr, rfmr, tcmr, tfmr);
+	dev_dbg(dai->dev, "RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n",
+		rcmr, rfmr, tcmr, tfmr);
 
 	if (!ssc_p->initialized) {
 		if (!ssc_p->ssc->pdata->use_dma) {
@@ -818,9 +816,8 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		ret = request_irq(ssc_p->ssc->irq, atmel_ssc_interrupt, 0,
 				ssc_p->name, ssc_p);
 		if (ret < 0) {
-			printk(KERN_WARNING
-					"atmel_ssc_dai: request_irq failure\n");
-			pr_debug("Atmel_ssc_dai: Stoping clock\n");
+			dev_warn(dai->dev, "request_irq failure\n");
+			dev_dbg(dai->dev, "Stopping clock\n");
 			clk_disable(ssc_p->ssc->clk);
 			return ret;
 		}
@@ -839,7 +836,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	ssc_writel(ssc_p->ssc->regs, TCMR, tcmr);
 	ssc_writel(ssc_p->ssc->regs, TFMR, tfmr);
 
-	pr_debug("atmel_ssc_dai,hw_params: SSC initialized\n");
+	dev_dbg(dai->dev, "SSC initialized\n");
 	return 0;
 }
 
@@ -862,9 +859,9 @@ static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
 	ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_disable);
 	ssc_writel(ssc_p->ssc->regs, IDR, dma_params->mask->ssc_error);
 
-	pr_debug("%s enabled SSC_SR=0x%08x\n",
-			dir ? "receive" : "transmit",
-			ssc_readl(ssc_p->ssc->regs, SR));
+	dev_dbg(dai->dev, "%s enabled SSC_SR=0x%08x\n",
+		dir ? "receive" : "transmit",
+		ssc_readl(ssc_p->ssc->regs, SR));
 	return 0;
 }
 
@@ -1050,21 +1047,18 @@ static void asoc_ssc_exit(struct device *dev)
 int atmel_ssc_set_audio(int ssc_id)
 {
 	struct ssc_device *ssc;
-	int ret;
 
 	/* If we can grab the SSC briefly to parent the DAI device off it */
 	ssc = ssc_request(ssc_id);
 	if (IS_ERR(ssc)) {
 		pr_err("Unable to parent ASoC SSC DAI on SSC: %ld\n",
-			PTR_ERR(ssc));
+		       PTR_ERR(ssc));
 		return PTR_ERR(ssc);
-	} else {
-		ssc_info[ssc_id].ssc = ssc;
 	}
 
-	ret = asoc_ssc_init(&ssc->pdev->dev);
+	ssc_info[ssc_id].ssc = ssc;
 
-	return ret;
+	return asoc_ssc_init(&ssc->pdev->dev);
 }
 EXPORT_SYMBOL_GPL(atmel_ssc_set_audio);
 
