Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965690AbeEXI5S (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:57:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45248 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965639AbeEXI5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:57:15 -0400
Date: Thu, 24 May 2018 10:56:14 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Stefan Agner <stefan@agner.ch>
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
Message-ID: <20180524105614.3c51736c@bbrezillon>
In-Reply-To: <2d8107f0e6568512d691e9ea25a1e4e5@agner.ch>
References: <cover.1526990589.git.stefan@agner.ch>
        <86fdf19ec92b732709732fb60199f16488b4b727.1526990589.git.stefan@agner.ch>
        <20180523161810.0ed9fe80@bbrezillon>
        <2d8107f0e6568512d691e9ea25a1e4e5@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018 10:46:27 +0200
Stefan Agner <stefan@agner.ch> wrote:

> Hi Boris,
> 
> Thanks for the initial review! One small question below:
> 
> On 23.05.2018 16:18, Boris Brezillon wrote:
> > Hi Stefan,
> > 
> > On Tue, 22 May 2018 14:07:06 +0200
> > Stefan Agner <stefan@agner.ch> wrote:  
> >> +
> >> +struct tegra_nand {
> >> +	void __iomem *regs;
> >> +	struct clk *clk;
> >> +	struct gpio_desc *wp_gpio;
> >> +
> >> +	struct nand_chip chip;
> >> +	struct device *dev;
> >> +
> >> +	struct completion command_complete;
> >> +	struct completion dma_complete;
> >> +	bool last_read_error;
> >> +
> >> +	dma_addr_t data_dma;
> >> +	void *data_buf;
> >> +	dma_addr_t oob_dma;
> >> +	void *oob_buf;
> >> +
> >> +	int cur_chip;
> >> +};  
> > 
> > This struct should be split in 2 structures: one representing the NAND
> > controller and one representing the NAND chip:
> > 
> > struct tegra_nand_controller {
> > 	struct nand_hw_control base;
> > 	void __iomem *regs;
> > 	struct clk *clk;
> > 	struct device *dev;
> > 	struct completion command_complete;
> > 	struct completion dma_complete;
> > 	bool last_read_error;
> > 	int cur_chip;
> > };
> > 
> > struct tegra_nand {
> > 	struct nand_chip base;
> > 	dma_addr_t data_dma;
> > 	void *data_buf;
> > 	dma_addr_t oob_dma;
> > 	void *oob_buf;
> > };  
> 
> Is there a particular reason why you would leave DMA buffers in the chip
> structure? It seems that is more a controller thing...

The size of those buffers is likely to be device dependent, so if you
have several NANDs connected to the controller, you'll either have to
have one buffer at the controller level which is max(all-chip-buf-size)
or a buffer per device.

Also, do you really need these buffers? The core already provide some
which are suitable for DMA (chip->oob_poi and chip->data_buf).

> 
> If I move them, then struct tegra_nand would be basically empty. Can I
> just use struct nand_chip and have no driver specific chip abstraction?

Sure.
