Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935929AbeEXW42 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:56:28 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:44252 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935647AbeEXW4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:56:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Fri, 25 May 2018 00:56:23 +0200
From: Stefan Agner <stefan@agner.ch>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [RESEND PATCH 2/5] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <20180524144134.41a71063@bbrezillon>
References: <cover.1526990589.git.stefan@agner.ch>
 <86fdf19ec92b732709732fb60199f16488b4b727.1526990589.git.stefan@agner.ch>
 <20180523161810.0ed9fe80@bbrezillon>
 <2d8107f0e6568512d691e9ea25a1e4e5@agner.ch>
 <20180524105614.3c51736c@bbrezillon>
 <7b3cc3991fb054130fd54c6fdfec5097@agner.ch>
 <20180524142356.0fc68797@bbrezillon> <20180524144134.41a71063@bbrezillon>
Message-ID: <78b7b43b4284e73cd6a3255e4e5075ed@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[25];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.2018 14:41, Boris Brezillon wrote:
> On Thu, 24 May 2018 14:23:56 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
>> On Thu, 24 May 2018 13:09:53 +0200
>> Stefan Agner <stefan@agner.ch> wrote:
>>
>> > On 24.05.2018 10:56, Boris Brezillon wrote:
>> > > On Thu, 24 May 2018 10:46:27 +0200
>> > > Stefan Agner <stefan@agner.ch> wrote:
>> > >
>> > >> Hi Boris,
>> > >>
>> > >> Thanks for the initial review! One small question below:
>> > >>
>> > >> On 23.05.2018 16:18, Boris Brezillon wrote:
>> > >> > Hi Stefan,
>> > >> >
>> > >> > On Tue, 22 May 2018 14:07:06 +0200
>> > >> > Stefan Agner <stefan@agner.ch> wrote:
>> > >> >> +
>> > >> >> +struct tegra_nand {
>> > >> >> +	void __iomem *regs;
>> > >> >> +	struct clk *clk;
>> > >> >> +	struct gpio_desc *wp_gpio;
>> > >> >> +
>> > >> >> +	struct nand_chip chip;
>> > >> >> +	struct device *dev;
>> > >> >> +
>> > >> >> +	struct completion command_complete;
>> > >> >> +	struct completion dma_complete;
>> > >> >> +	bool last_read_error;
>> > >> >> +
>> > >> >> +	dma_addr_t data_dma;
>> > >> >> +	void *data_buf;
>> > >> >> +	dma_addr_t oob_dma;
>> > >> >> +	void *oob_buf;
>> > >> >> +
>> > >> >> +	int cur_chip;
>> > >> >> +};
>> > >> >
>> > >> > This struct should be split in 2 structures: one representing the NAND
>> > >> > controller and one representing the NAND chip:
>> > >> >
>> > >> > struct tegra_nand_controller {
>> > >> > 	struct nand_hw_control base;
>> > >> > 	void __iomem *regs;
>> > >> > 	struct clk *clk;
>> > >> > 	struct device *dev;
>> > >> > 	struct completion command_complete;
>> > >> > 	struct completion dma_complete;
>> > >> > 	bool last_read_error;
>> > >> > 	int cur_chip;
>> > >> > };
>> > >> >
>> > >> > struct tegra_nand {
>> > >> > 	struct nand_chip base;
>> > >> > 	dma_addr_t data_dma;
>> > >> > 	void *data_buf;
>> > >> > 	dma_addr_t oob_dma;
>> > >> > 	void *oob_buf;
>> > >> > };
>> > >>
>> > >> Is there a particular reason why you would leave DMA buffers in the chip
>> > >> structure? It seems that is more a controller thing...
>> > >
>> > > The size of those buffers is likely to be device dependent, so if you
>> > > have several NANDs connected to the controller, you'll either have to
>> > > have one buffer at the controller level which is max(all-chip-buf-size)
>> > > or a buffer per device.
>> > >
>> > > Also, do you really need these buffers? The core already provide some
>> > > which are suitable for DMA (chip->oob_poi and chip->data_buf).
>> > >
>> >
>> > Good question, I am not sure, that was existing code.
>> >
>> > Are you sure data_buf it is DMA capable?
>> >
>> > nand_scan_tail allocates with kmalloc:
>> >
>> > chip->data_buf = kmalloc(mtd->writesize + mtd->oobsize, GFP_KERNEL);
>>
>> Yes, kmalloc() allocates DMA-able buffers, so those are DMA-safe.
> 
> Hm, that's not exactly true. It depends on the dma_mask attached to the
> device.

It seems to work (tm).

I am not sure how to deal with the OOB buffer. I now use the given
pointer also for oob (offset writesize). I think mtk_nand does the same
thing.

dma_len = mtd->writesize + (oob_required ? mtd->oobsize : 0);        
dma_addr = dma_map_single(ctrl->dev, buf, dma_len, DMA_FROM_DEVICE);

...

Is there a test which allows to test my (read|write)_page implementation
with oob_required set?

--
Stefan
