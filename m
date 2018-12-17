Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B690FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F19321836
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbeLQIkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:40:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56543 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726436AbeLQIkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:40:06 -0500
X-UUID: 4fd06850410f45f7ab661e39b664d84b-20181217
X-UUID: 4fd06850410f45f7ab661e39b664d84b-20181217
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 642604067; Mon, 17 Dec 2018 16:39:51 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs03n2.mediatek.inc
 (172.21.101.182) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 17 Dec
 2018 16:39:50 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Dec 2018 16:39:49 +0800
Message-ID: <1545035989.28871.41.camel@mhfsdcap03>
Subject: Re: [PATCH v5 1/2] dmaengine: 8250_mtk_dma: add Mediatek uart DMA
 support
From:   Long Cheng <long.cheng@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        Ryder Lee =?UTF-8?Q?=28=E6=9D=8E=E5=BA=9A=E8=AB=BA=29?= 
        <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>,
        Sean Wang =?UTF-8?Q?=28=E7=8E=8B=E5=BF=97=E4=BA=98=29?= 
        <sean.wang@mediatek.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>
Date:   Mon, 17 Dec 2018 16:39:49 +0800
In-Reply-To: <CAGp9LzpGfVgjL9MMQyh2iZRD9bJiuH0B0GTg_bahaa5ju2wmzw@mail.gmail.com>
References: <1544506645-27979-1-git-send-email-long.cheng@mediatek.com>
         <1544506645-27979-2-git-send-email-long.cheng@mediatek.com>
         <CAGp9LzqB=hzkOHZqa-ZzRLcJujU--7gxYZczXiEj3DiH+FmhbQ@mail.gmail.com>
         <1544700985.28871.26.camel@mhfsdcap03>
         <CAGp9LzpGfVgjL9MMQyh2iZRD9bJiuH0B0GTg_bahaa5ju2wmzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: AFF4BBF1F486043803C46BE477C45F6BD9CBF7E0A7A3C326FF498372E0E2E10A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-14 at 12:09 -0800, Sean Wang wrote:

thanks for your reply.

> On Thu, Dec 13, 2018 at 3:36 AM Long Cheng <long.cheng@mediatek.com> wrote:
> 
> Hope those comments did not get a response that means they're fine with you.
> 
> < ... >
> 
> > > > +struct mtk_dmadev {
> > > > +       struct dma_device ddev;
> > > > +       void __iomem *mem_base[MTK_APDMA_CHANNELS];
> > > > +       spinlock_t lock; /* dma dev lock */
> > > > +       struct tasklet_struct task;
> > >
> > > we can drop tasklet and instead allows descriptors to be handled as
> > > fast as possible.
> > > similar suggestions have been made in the other dmaengine [1] and mtk-hsdma.c
> > >
> >
> > OK, i will remove these, and improve it.
> >
> 
> Thanks, that would be great.
> 
> > > [1] https://lkml.org/lkml/2018/11/11/146
> > >
> > > > +       struct list_head pending;
> > > > +       struct clk *clk;
> > > > +       unsigned int dma_requests;
> > > > +       bool support_33bits;
> > > > +       unsigned int dma_irq[MTK_APDMA_CHANNELS];
> > > > +       struct mtk_chan *ch[MTK_APDMA_CHANNELS];
> > > > +};
> > > > +
> 
> < ... >
> 
> > > > +static struct dma_async_tx_descriptor *mtk_dma_prep_slave_sg
> > > > +       (struct dma_chan *chan, struct scatterlist *sgl,
> > > > +       unsigned int sglen,     enum dma_transfer_direction dir,
> > > > +       unsigned long tx_flags, void *context)
> > > > +{
> > > > +       struct mtk_chan *c = to_mtk_dma_chan(chan);
> > > > +       struct scatterlist *sgent;
> > > > +       struct mtk_dma_desc *d;
> > > > +       struct mtk_dma_sg *sg;
> > > > +       unsigned int size, i, j, en;
> > > > +
> > > > +       en = 1;
> > > > +
> > > > +       if ((dir != DMA_DEV_TO_MEM) &&
> > > > +               (dir != DMA_MEM_TO_DEV)) {
> > > > +               dev_err(chan->device->dev, "bad direction\n");
> > > > +               return NULL;
> > > > +       }
> > > > +
> > > > +       /* Now allocate and setup the descriptor. */
> > > > +       d = kzalloc(sizeof(*d) + sglen * sizeof(d->sg[0]), GFP_ATOMIC);
> > > > +       if (!d)
> > > > +               return NULL;
> > > > +
> > > > +       d->dir = dir;
> > > > +
> > > > +       j = 0;
> > > > +       for_each_sg(sgl, sgent, sglen, i) {
> > > > +               d->sg[j].addr = sg_dma_address(sgent);
> > > > +               d->sg[j].en = en;
> > > > +               d->sg[j].fn = sg_dma_len(sgent) / en;
> > > > +               j++;
> > > > +       }
> > > > +
> > > > +       d->sglen = j;
> > > > +
> > > > +       if (dir == DMA_MEM_TO_DEV) {
> > > > +               for (size = i = 0; i < d->sglen; i++) {
> > > > +                       sg = &d->sg[i];
> > > > +                       size += sg->en * sg->fn;
> > > > +               }
> > > > +               d->len = size;
> > > > +       }
> > > > +
> > >
> > > The driver always only handles data move for the single contiguous
> > > area, but it seems the callback must provide the scatter-gather
> > > function to the dmaegine. otherwise, why is the callback be called
> > > device_prep_slave_sg?
> > >
> >
> > because in 8250 UART native code, call the device_prep_slave_sg. we just
> > use one ring buffer.
> >
> 
> If it really did specifically for UART, you should show the function
> only can handle only one entry in sg for the DMA in a few comments and
> a sanity check for these invalid requests (more one entries in sg).
> Otherwise, the hardware will get a failure and even function doesn't
> complain or warn anything if more one entries in sg requested in.
> Additionally, the code can be simplified much if it's just for the
> specific use case.
> 

ok. i will add some comments. and let the code be simplified.

> > > > +       return vchan_tx_prep(&c->vc, &d->vd, tx_flags);
> > > > +}
> > > > +
> > > > +static void mtk_dma_issue_pending(struct dma_chan *chan)
> > > > +{
> > > > +       struct mtk_chan *c = to_mtk_dma_chan(chan);
> > > > +       struct virt_dma_desc *vd;
> > > > +       struct mtk_dmadev *mtkd;
> > > > +       unsigned long flags;
> > > > +
> > > > +       spin_lock_irqsave(&c->vc.lock, flags);
> > > > +       if (c->cfg.direction == DMA_DEV_TO_MEM) {
> > > > +               mtkd = to_mtk_dma_dev(chan->device);
> > >
> > > mtkd can be dropped as it seems no users
> > >
> 
> < ... >
> 
> > > > +static int mtk_dma_slave_config(struct dma_chan *chan,
> > > > +                               struct dma_slave_config *cfg)
> > > > +{
> > > > +       struct mtk_chan *c = to_mtk_dma_chan(chan);
> > > > +       struct mtk_dmadev *mtkd = to_mtk_dma_dev(c->vc.chan.device);
> > > > +       int ret;
> > > > +
> > > > +       c->cfg = *cfg;
> > > > +
> > > > +       if (cfg->direction == DMA_DEV_TO_MEM) {
> > > > +               unsigned int rx_len = cfg->src_addr_width * 1024;
> > >
> > > it seems you should use cfg->src_port_window_size as the comments explains
> > >
> > > * @src_port_window_size: The length of the register area in words the data need
> > >  * to be accessed on the device side. It is only used for devices which is using
> > >  * an area instead of a single register to receive the data. Typically the DMA
> > >  * loops in this area in order to transfer the data.
> > >  * @dst_port_window_size: same as src_port_window_size but for the destination
> > >  * port.
> > >
> >
> > in 8250 UART native code, will set the parameter. if want to modify
> > this, i think that maybe at next kernel release, we can modify it. i
> > suggest that not modify it at this patch. because it relate of 8250 uart
> > code. thanks.
> >
> 
> You can fix it in the next version and a separate follow-up patch for
> the client driver.
> 
> > > > +
> > > > +               mtk_dma_chan_write(c, VFF_ADDR, cfg->src_addr);
> > > > +               mtk_dma_chan_write(c, VFF_LEN, rx_len);
> > > > +               mtk_dma_chan_write(c, VFF_THRE, VFF_RX_THRE(rx_len));
> > > > +               mtk_dma_chan_write(c,
> > > > +                                  VFF_INT_EN, VFF_RX_INT_EN0_B
> > > > +                                  | VFF_RX_INT_EN1_B);
> > > > +               mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
> > > > +               mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
> > >
> > > I'd prefer to move those channel interrupt enablement to
> > > .device_alloc_chan_resources
> > > and related disablement to .device_free_chan_resources
> > >
> >
> > i think that, first need set the config to HW, and the enable the DMA.
> >
> 
> I've read through the client driver and the dmaengine, I probably know
> how interaction they work and find out there is something you seem
> completely make a wrong.
> 
> You can't do enable DMA with enabling VFF here. That causes a big
> problem, DMA would self decide to move data and not managed and issued
> by the dmaengine framework. For instance in DMA Tx path, because you
> enable the DMA and DMA  buffer (VFF) and UART Tx ring uses the same
> memory area,  DMA would self start to move data once data from
> userland go in Tx ring even without being issued by dmaengine.
> 
> Instead, you should ensure all descriptors are being batched by
> .device_prep_slave_sg and DMA does not start moving data until
> .device_issue_pending done and once descriptors are issued, DMA
> hardware or software have to do it as fast as possible.
> 

the VFF enable just enable the DMA function. DMA can't move data here.
Now, the code get length of the data in '.device_prep_slave_sg'.
And let DMA move data in '.device_issue_pending function'. in here, just
enable the function.

> > > > +
> > > > +               if (!c->requested) {
> > > > +                       c->requested = true;
> > > > +                       ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > > > +                                         mtk_dma_rx_interrupt,
> > > > +                                         IRQF_TRIGGER_NONE,
> > > > +                                         KBUILD_MODNAME, chan);
> > >
> > > ISR registration usually happens as the driver got probe, it can give
> > > the system more flexibility to manage such IRQ affinity on the fly.
> > >
> >
> > i will move the request irq to alloc channel.
> >
> 
> why don't let it done in driver probe?
> 
there are many uart ports, like UART[0-5]. in probe, just get the all
irq of ports. which port is using, who request irq. example, UART1 is
using. we just request irq of uart1. uart0, uart[2-5] don't need request
irq.

> > > > +                       if (ret < 0) {
> > > > +                               dev_err(chan->device->dev, "Can't request rx dma IRQ\n");
> > > > +                               return -EINVAL;
> > > > +                       }
> > > > +               }
> > > > +       } else if (cfg->direction == DMA_MEM_TO_DEV)    {
> > > > +               unsigned int tx_len = cfg->dst_addr_width * 1024;
> > >
> > > Ditto as above, it seems you should use cfg->dst_port_window_size
> > >
> > > > +
> > > > +               mtk_dma_chan_write(c, VFF_ADDR, cfg->dst_addr);
> > > > +               mtk_dma_chan_write(c, VFF_LEN, tx_len);
> > > > +               mtk_dma_chan_write(c, VFF_THRE, VFF_TX_THRE(tx_len));
> > > > +               mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_TX_INT_FLAG_CLR_B);
> > > > +               mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
> > >
> > > ditto, I'd prefer to move those channel interrupt enablement to
> > > .device_alloc_chan_resources and related disablement to
> > > .device_free_chan_resources
> > >
> > > > +
> > > > +               if (!c->requested) {
> > > > +                       c->requested = true;
> > > > +                       ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > > > +                                         mtk_dma_tx_interrupt,
> > > > +                                         IRQF_TRIGGER_NONE,
> > > > +                                         KBUILD_MODNAME, chan);
> > >
> > > ditto, we can request ISR with devm_request_irq in the driver got
> > > probe and trim the c->request member
> > >
> > > > +                       if (ret < 0) {
> > > > +                               dev_err(chan->device->dev, "Can't request tx dma IRQ\n");
> > > > +                               return -EINVAL;
> > > > +                       }
> > > > +               }
> > > > +       }
> > > > +
> > > > +       if (mtkd->support_33bits)
> > > > +               mtk_dma_chan_write(c, VFF_4G_SUPPORT, VFF_4G_SUPPORT_B);
> > > > +
> > > > +       if (mtk_dma_chan_read(c, VFF_EN) != VFF_EN_B) {
> > > > +               dev_err(chan->device->dev,
> > > > +                       "config dma dir[%d] fail\n", cfg->direction);
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int mtk_dma_terminate_all(struct dma_chan *chan)
> > > > +{
> > > > +       struct mtk_chan *c = to_mtk_dma_chan(chan);
> > > > +       unsigned long flags;
> > > > +
> > > > +       spin_lock_irqsave(&c->vc.lock, flags);
> > > > +       list_del_init(&c->node);
> > > > +       mtk_dma_stop(c);
> > > > +       spin_unlock_irqrestore(&c->vc.lock, flags);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int mtk_dma_device_pause(struct dma_chan *chan)
> > > > +{
> > > > +       /* just for check caps pass */
> > > > +       return -EINVAL;
> > >
> > > always return error code seems not the client driver wants us to do.
> > >
> > > maybe if the hardware doesn't support pause, we can make a software
> > > pause, that waits until all active descriptors in hardware done, then
> > > disable interrupt and then stop handling the following vd in the
> > > vchan.
> > >
> > > > +}
> >
> > the code can't run. just for 8250 native code to check the function
> > pointer. in the future, if the function useful, we can realize. thanks.
> >
> 
> Always return an error code looks like it's a faked function just to
> pass the criteria check. It seems not a good idea.
> 

yes, the function is fake. i just review the 8250 uart framework. there
no check the return value of the function. so i can modify it to 'return
0'

> > > > +
> > > > +static int mtk_dma_device_resume(struct dma_chan *chan)
> > > > +{
> > > > +       /* just for check caps pass */
> > > > +       return -EINVAL;
> 
> < ... >
> 
> > > > +static struct platform_driver mtk_dma_driver = {
> > >
> > > mtk_dma is much general and all functions and structures in the driver
> > > should be all consistent.  I'd prefer to have all naming starts with
> > > mtk_uart_apdma.
> > >
> >
> > the function name and parameters' name, i will modify it. but before the
> > 8250_mtk.c and the Doc. are recorded. if modify file name and Kconfig,
> > will bring about the disorder. i suggest that after the patch is
> > recorded, modify this. thanks.
> >
> 
> We can do it in separate patches and in a logical order for the
> changes required across different subsystems.
> 
> > > > +       .probe  = mtk_apdma_probe,
> > >
> > > such  as
> > > mtk_uart_apdma_probe
> > >
> > > > +       .remove = mtk_apdma_remove,
> > >
> > > mtk_uart_apdma_remove
> > >
> > > > +       .driver = {
> > > > +               .name           = KBUILD_MODNAME,
> > > > +               .pm             = &mtk_dma_pm_ops,
> > >
> > > mtk_uart_apdma_pm_ops
> > >
> > > > +               .of_match_table = of_match_ptr(mtk_uart_dma_match),
> > >
> > > mtk_uart_apdma_match
> > >
> > > > +       },
> > > > +};
> > > > +
> > > > +module_platform_driver(mtk_dma_driver);
> > >
> > > mtk_uart_apdma_driver
> > >
> > > > +
> > > > +MODULE_DESCRIPTION("MediaTek UART APDMA Controller Driver");
> > > > +MODULE_AUTHOR("Long Cheng <long.cheng@mediatek.com>");
> > > > +MODULE_LICENSE("GPL v2");
> > > > +
> > > > diff --git a/drivers/dma/mediatek/Kconfig b/drivers/dma/mediatek/Kconfig
> > > > index 27bac0b..d399624 100644
> > > > --- a/drivers/dma/mediatek/Kconfig
> > > > +++ b/drivers/dma/mediatek/Kconfig
> > > > @@ -1,4 +1,15 @@
> > > >
> > > > +config DMA_MTK_UART
> > >
> > > MTK_UART_APDMA to align the other drivers
> > >
> > > > +       tristate "MediaTek SoCs APDMA support for UART"
> > > > +       depends on OF && SERIAL_8250_MT6577
> > > > +       select DMA_ENGINE
> > > > +       select DMA_VIRTUAL_CHANNELS
> > > > +       help
> > > > +         Support for the UART DMA engine found on MediaTek MTK SoCs.
> > > > +         when 8250 mtk uart is enabled, and if you want to using DMA,
> > >
> > > 8250 mtk uart should be changed to SERIAL_8250_MT6577 to be more intuitive
> > >
> > > > +         you can enable the config. the DMA engine just only be used
> > > > +         with MediaTek Socs.
> > >
> > > SoCs
> > >
> > > > +
> > > >  config MTK_HSDMA
> > > >         tristate "MediaTek High-Speed DMA controller support"
> > > >         depends on ARCH_MEDIATEK || COMPILE_TEST
> > > > diff --git a/drivers/dma/mediatek/Makefile b/drivers/dma/mediatek/Makefile
> > > > index 6e778f8..2f2efd9 100644
> > > > --- a/drivers/dma/mediatek/Makefile
> > > > +++ b/drivers/dma/mediatek/Makefile
> > > > @@ -1 +1,2 @@
> > > > +obj-$(CONFIG_DMA_MTK_UART) += 8250_mtk_dma.o
> > >
> > > obj-$(CONFIG_MTK_UART_APDMA) += mtk-uart-apdma.o
> > > to align the other dirvers
> > >
> > > >  obj-$(CONFIG_MTK_HSDMA) += mtk-hsdma.o
> > > > --
> > > > 1.7.9.5
> > > >
> >
> >


