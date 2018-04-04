Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeDDMa0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:30:26 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:44488 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeDDMaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:30:24 -0400
Date: Wed, 4 Apr 2018 14:30:21 +0200
From: Ladislav Michl <ladis@linux-mips.org>
To: Colin Ian King <colin.king@canonical.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
Message-ID: <20180404123021.GA21058@lenoch>
References: <20180330154420.6903-1-colin.king@canonical.com>
 <20180403134540.GA29017@lenoch>
 <20180404102425.cwj7vzvrvi2obcoi@mwanda>
 <9b1399de-3834-cd22-2bca-42a1048e0901@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b1399de-3834-cd22-2bca-42a1048e0901@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 11:41:23AM +0100, Colin Ian King wrote:
> On 04/04/18 11:24, Dan Carpenter wrote:
> > On Tue, Apr 03, 2018 at 03:45:40PM +0200, Ladislav Michl wrote:
> >> On Fri, Mar 30, 2018 at 04:44:20PM +0100, Colin King wrote:
> >>> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> Hello Colin,
> >>
> >>> Trivial fix to spelling mistake in pr_debug message text
> >>
> >> would you mind making this patch a bit less non-trivial and
> >> change pr_debug to dev_dbg dropping Atmel_ssc_dai prefix?
> >>
> >> Thank you.
> >>
> > 
> > Trivial patches should just be trivial instead of evolving into a thread
> > that lasts for days.
> 
> Yep, this feels like this scenario for sure.

And this scenario happens because I wanted to avoid all that work preparing
trivial patch. In the other words, this thread could be few mails shorter
if anyone else took a chance ;-)

[...]

> > space character?  And I think about it for 10 minutes and then delete my
> > patch because it's too much hassle to deal with for something small.

...leading into many small glitches never polished...

> Same here. Hence stuff never gets fixed.

For sure, hassle with sending a patch and crediting everyone who contributed
properly is order of magnitude more time consuming than preparing patch itself.

So here's my last contribution to this painful thread. If you do not like it,
it's your turn :)

(and it'll be needed as Mark does not like patches being sended this way,
oh well, whoever sent original patch should first figure out why driver
outputs debug message just after warning one - so the simplest fix would
be just deleting that line)

-- >8 -- 

From: Joe Perches <joe@perches.com>
Subject: [PATCH] ASoC: atmel_ssc_dai: Replace pr_debug with dev_dbg

Use dev_dbg for debug output, remove registration error message
as every user of atmel_ssc_set_audio prints its own error.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
[Colin Ian King: fix spelling mistake: "Stoping" -> "Stopping"]
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/atmel/atmel_ssc_dai.c | 42 +++++++++++++--------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index a1e2c5682dcd..45c4730e9939 100644
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
@@ -818,9 +816,9 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		ret = request_irq(ssc_p->ssc->irq, atmel_ssc_interrupt, 0,
 				ssc_p->name, ssc_p);
 		if (ret < 0) {
-			printk(KERN_WARNING
-					"atmel_ssc_dai: request_irq failure\n");
-			pr_debug("Atmel_ssc_dai: Stoping clock\n");
+			dev_warn(dai->dev,
+				 "unable to request irq (%d), stopping clock\n",
+				 ret);
 			clk_disable(ssc_p->ssc->clk);
 			return ret;
 		}
@@ -839,7 +837,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	ssc_writel(ssc_p->ssc->regs, TCMR, tcmr);
 	ssc_writel(ssc_p->ssc->regs, TFMR, tfmr);
 
-	pr_debug("atmel_ssc_dai,hw_params: SSC initialized\n");
+	dev_dbg(dai->dev, "SSC initialized\n");
 	return 0;
 }
 
@@ -862,9 +860,9 @@ static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
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
 
@@ -1050,21 +1048,15 @@ static void asoc_ssc_exit(struct device *dev)
 int atmel_ssc_set_audio(int ssc_id)
 {
 	struct ssc_device *ssc;
-	int ret;
 
 	/* If we can grab the SSC briefly to parent the DAI device off it */
 	ssc = ssc_request(ssc_id);
-	if (IS_ERR(ssc)) {
-		pr_err("Unable to parent ASoC SSC DAI on SSC: %ld\n",
-			PTR_ERR(ssc));
+	if (IS_ERR(ssc))
 		return PTR_ERR(ssc);
-	} else {
-		ssc_info[ssc_id].ssc = ssc;
-	}
 
-	ret = asoc_ssc_init(&ssc->pdev->dev);
+	ssc_info[ssc_id].ssc = ssc;
 
-	return ret;
+	return asoc_ssc_init(&ssc->pdev->dev);
 }
 EXPORT_SYMBOL_GPL(atmel_ssc_set_audio);
 
-- 
2.17.0
