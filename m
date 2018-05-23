Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932586AbeEWK4U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:56:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50081 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932312AbeEWK4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:56:16 -0400
Date: Wed, 23 May 2018 12:56:12 +0200
From: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
To: Robin Gong <yibin.gong@nxp.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "vinod.koul@intel.com" <vinod.koul@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v1] dma: imx-sdma: add virt-dma support
Message-ID: <20180523105612.u4wbezh7fzkv4wfh@pengutronix.de>
References: <1521735499-29138-1-git-send-email-yibin.gong@nxp.com>
 <20180522100948.6xsq3unhyyyd7zz3@pengutronix.de>
 <1527099973.3990.37.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1527099973.3990.37.camel@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:40:05 up 152 days, 18:58, 97 users,  load average: 0.10, 0.10,
 0.13
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 10:26:23AM +0000, Robin Gong wrote:
> > 
> > > 
> > > +	u32				bd_size_sum;
> > This variable is never used for anything.
> Yes, it's not for significative use but debug to see how many current
> bds used.

I am not convinced this is useful. The variable could easily be added back
by someone who debugs this driver. The code has to be changed anyway to
make use of this variable.


> > > @@ -632,7 +635,7 @@ static int sdma_run_channel0(struct sdma_engine
> > > *sdma)
> > >  static int sdma_load_script(struct sdma_engine *sdma, void *buf,
> > > int size,
> > >  		u32 address)
> > >  {
> > > -	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
> > > +	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
> > This change seems to be an orthogonal change. Please make this a
> > separate patch.
> It's something related with virtual dma support, because in virtual
> dma framework, all bds should be allocated dynamically if they used.
> but bd0 is a specail case since it's must and basic for load sdma
> firmware and context for other channels. So here alloc 'bd0' for other
> channels.

Well, it's somewhat related to virtual dma support, but that's not my
point. My point is that this patch is quite big and thus hard to review.
If we find ways to make it smaller and to split it up in multiple
patches then we should do so, because it makes it easier to review and
in case you break something here we raise the chance that a "git bisect"
lands on a smaller patch which is easier to understand.

Please try and make that a separate change. I haven't really looked into
it and it may not be possible due to reasons I haven't seen, but please
at least give it a try.

> > 
> > > 
> > > +
> > > +	if (sdmac->desc)
> > > +		sdmac->desc = NULL;
> > The test is unnecesary.
> This 'NULL' is meaningful in case that dma done interrupt come after
> terminate as you know sdma will actually stop after current transfer
> done.

The setting of the variable to NULL is ok, but the test is useless.

	if (sdmac->desc)
		sdmac->desc = NULL;

is equivalent to:

	sdmac->desc = NULL;


Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
