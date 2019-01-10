Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1B8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E94420675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfAJIY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:24:56 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:53157 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727262AbfAJIYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:24:55 -0500
X-UUID: b48ebcbf60974a43ad01e0954853a00a-20190110
X-UUID: b48ebcbf60974a43ad01e0954853a00a-20190110
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 650511360; Thu, 10 Jan 2019 16:24:47 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 16:24:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 10 Jan 2019 16:24:45 +0800
Message-ID: <1547108685.3831.21.camel@mhfsdcap03>
Subject: Re: [PATCH v9 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
From:   Long Cheng <long.cheng@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>,
        Long Cheng <long.cheng@mediatek.com>
Date:   Thu, 10 Jan 2019 16:24:45 +0800
In-Reply-To: <CANMq1KB=yuEJxUdi8M9deDhAv24WZ-4h+26cFq7AzBi8uyd88Q@mail.gmail.com>
References: <1546395178-8880-1-git-send-email-long.cheng@mediatek.com>
         <1546395178-8880-2-git-send-email-long.cheng@mediatek.com>
         <CANMq1KB=yuEJxUdi8M9deDhAv24WZ-4h+26cFq7AzBi8uyd88Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-03 at 09:39 +0800, Nicolas Boichat wrote:
> On Wed, Jan 2, 2019 at 10:13 AM Long Cheng <long.cheng@mediatek.com> wrote:
> >

.....

> > +/* interrupt trigger level for tx */
> > +#define VFF_TX_THRE(n)         ((n) * 7 / 8)
> > +/* interrupt trigger level for rx */
> > +#define VFF_RX_THRE(n)         ((n) * 3 / 4)
> > +
> > +#define VFF_RING_SIZE  0xffffU
> 
> Well, the size is actually 0x10000. Maybe call this VFF_RING_SIZE_MASK?
> 

the max length is 0xffff.  the bit 16 is wrap bit. our buffer is ring
buffer. So not mask.

> > +/* invert this bit when wrap ring head again*/
> > +#define VFF_RING_WRAP  0x10000U
> > +
> > +       writel(val, c->base + reg);
> > +}
> > +

......

> > +static void mtk_uart_apdma_start_tx(struct mtk_chan *c)
> > +{
> > +       unsigned int len, send, left, wpt, d_wpt, tmp;
> > +       int ret;
> > +
> > +       left = mtk_uart_apdma_read(c, VFF_LEFT_SIZE);
> > +       if (!left) {
> > +               mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> > +               return;
> > +       }
> > +
> > +       /* Wait 1sec for flush,  can't sleep*/
> 
> nit: one space after ',', period after 'sleep', space before '*'.
> 
> > +       ret = readx_poll_timeout(readl, c->base + VFF_FLUSH, tmp,
> > +                       tmp != VFF_FLUSH_B, 0, 1000000);
> > +       if (ret)
> > +               dev_warn(c->vc.chan.device->dev, "tx: fail, debug=0x%x\n",
> > +                       mtk_uart_apdma_read(c, VFF_DEBUG_STATUS));
> 
> Why do we need to wait for flush now? The previous implementation did
> not require this...
> 

because our HW buffer is cyclic. at one tx, if the size of data is
bigger, data maybe cover. So must wait flush finish. confirm the data is
right. like 128 bytes size, small length can't reproduce the issue.

> > +
> > +       send = min_t(unsigned int, left, c->desc->avail_len);
> > +       wpt = mtk_uart_apdma_read(c, VFF_WPT);
> > +       len = mtk_uart_apdma_read(c, VFF_LEN);
> > +
> > +       d_wpt = wpt + send;
> > +       if ((d_wpt & VFF_RING_SIZE) >= len) {
> 
> I don't get why you need to add "& VFF_RING_SIZE". If wpt + send >
> VFF_RING_SIZE, don't you need to toggle VFF_RING_WRAP too?

the longest actual length is VFF_RING_SIZE. one cyclic, will set bit[16]
to ~bit[16]. the bit[0 ~ 15] is actual address. So need get rid of
bit[16]

> 
> > +               d_wpt = d_wpt - len;
> > +               d_wpt = d_wpt ^ VFF_RING_WRAP;
> > +       }
> > +       mtk_uart_apdma_write(c, VFF_WPT, d_wpt);
> > +
> > +       c->desc->avail_len -= send;
> > +
> > +       mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> > +       if (mtk_uart_apdma_read(c, VFF_FLUSH) == 0U)
> > +               mtk_uart_apdma_write(c, VFF_FLUSH, VFF_FLUSH_B);
> > +}
> 
> (thanks for the rest of the changes, this looks much more readable)
> 
> > +
......

> > +
> > +static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
> > +{
> > +       /* just for check caps pass */
> > +       return 0;
> > +}
> 
> This is still not right... Hopefully somebody more familiar with the
> DMA subsystem can weigh in, but maybe it's enough to wait for the
> current transfer to be flushed and temporarily disable interrupts?
> e.g. call mtk_uart_apdma_terminate_all above?
> 

i had review the 8250 UART framework. just check the function pointer,
not use. and our HW can't support the feature. So i just keep it at
first version.

> > +
> > +static int mtk_uart_apdma_device_resume(struct dma_chan *chan)
> > +{
> > +       /* just for check caps pass */
> > +       return 0;
> > +}
> 
> Drop this one since you don't really need it.
> 

ok, i will remove it.

> > +
> > +static void mtk_uart_apdma_free(struct mtk_uart_apdmadev *mtkd)
> > +{
> > +       while (list_empty(&mtkd->ddev.channels) == 0) {
> 
> !list_empty(
> 
> > +               struct mtk_chan *c = list_first_entry(&mtkd->ddev.channels,
> > +                       struct mtk_chan, vc.chan.device_node);
> > +
> > +               list_del(&c->vc.chan.device_node);
> > +               tasklet_kill(&c->vc.task);
> > +       }
> > +}
> > +
> > +static const struct of_device_id mtk_uart_apdma_match[] = {
> > +       { .compatible = "mediatek,mt6577-uart-dma", },
> > +       { /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, mtk_uart_apdma_match);
> > +
> > +static int mtk_uart_apdma_probe(struct platform_device *pdev)
> > +{
> > +       struct mtk_uart_apdmadev *mtkd;
> > +       struct resource *res;
> > +       struct mtk_chan *c;
> > +       unsigned int i;
> > +       int rc;
> > +
> > +       mtkd = devm_kzalloc(&pdev->dev, sizeof(*mtkd), GFP_KERNEL);
> > +       if (!mtkd)
> > +               return -ENOMEM;
> > +
> > +       mtkd->clk = devm_clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(mtkd->clk)) {
> > +               dev_err(&pdev->dev, "No clock specified\n");
> > +               rc = PTR_ERR(mtkd->clk);
> > +               return rc;
> > +       }
> > +
> > +       if (of_property_read_bool(pdev->dev.of_node, "dma-33bits"))
> > +               mtkd->support_33bits = true;
> 
> I don't think this should be a device tree property. Typically we'd
> have multiple compatible strings for (slightly) different HW blocks,
> and enable 33bits only on HW that have support.
> 
> See how it's done in drivers/i2c/busses/i2c-mt65xx.c, for example.
> 

in MediaTek, not all IC can support 33bit. So i want to configure by DT.
So don't need to modify code in New IC.

> > +
> > +       rc = dma_set_mask_and_coherent(&pdev->dev,
> > +                               DMA_BIT_MASK(32 | mtkd->support_33bits));
> 
> I'd feel a little more confortable if you used a variable instead:
> 
> int dma_bits = 32;
> 
> if (support_33bits)
>    dma_bits = 33;
> 
> ..., DMA_BIT_MASK(dma_bits));
> 

OK, i can modify it. thanks.

> > +       if (rc)
> > +               return rc;
> > +
> > +       dma_cap_set(DMA_SLAVE, mtkd->ddev.cap_mask);
> > +       mtkd->ddev.device_alloc_chan_resources =
> > +                               mtk_uart_apdma_alloc_chan_resources;
> > +       mtkd->ddev.device_free_chan_resources =
> > +                               mtk_uart_apdma_free_chan_resources;
> > +       mtkd->ddev.device_tx_status = mtk_uart_apdma_tx_status;
> > +       mtkd->ddev.device_issue_pending = mtk_uart_apdma_issue_pending;
> > +       mtkd->ddev.device_prep_slave_sg = mtk_uart_apdma_prep_slave_sg;
> > +       mtkd->ddev.device_config = mtk_uart_apdma_slave_config;
> > +       mtkd->ddev.device_pause = mtk_uart_apdma_device_pause;
> > +       mtkd->ddev.device_resume = mtk_uart_apdma_device_resume;
> > +       mtkd->ddev.device_terminate_all = mtk_uart_apdma_terminate_all;
> > +       mtkd->ddev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> > +       mtkd->ddev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> > +       mtkd->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> > +       mtkd->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> > +       mtkd->ddev.dev = &pdev->dev;
> > +       INIT_LIST_HEAD(&mtkd->ddev.channels);
> > +
> > +       for (i = 0; i < MTK_UART_APDMA_CHANNELS; i++) {
> > +               c = devm_kzalloc(mtkd->ddev.dev, sizeof(*c), GFP_KERNEL);
> > +               if (!c) {
> > +                       rc = -ENODEV;
> > +                       goto err_no_dma;
> > +               }
> > +
> > +               res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> > +               if (!res) {
> > +                       rc = -ENODEV;
> > +                       goto err_no_dma;
> > +               }
> > +
> > +               c->base = devm_ioremap_resource(&pdev->dev, res);
> > +               if (IS_ERR(c->base)) {
> > +                       rc = PTR_ERR(c->base);
> > +                       goto err_no_dma;
> > +               }
> > +               c->requested = false;
> > +               c->vc.desc_free = mtk_uart_apdma_desc_free;
> > +               vchan_init(&c->vc, &mtkd->ddev);
> > +
> > +               mtkd->dma_irq[i] = platform_get_irq(pdev, i);
> > +               if ((int)mtkd->dma_irq[i] < 0) {
> > +                       dev_err(&pdev->dev, "failed to get IRQ[%d]\n", i);
> > +                       rc = -EINVAL;
> > +                       goto err_no_dma;
> > +               }
> > +       }
> > +
> > +       pm_runtime_enable(&pdev->dev);
> > +       pm_runtime_set_active(&pdev->dev);
> > +
> > +       rc = dma_async_device_register(&mtkd->ddev);
> > +       if (rc)
> > +               goto rpm_disable;
> > +
> > +       platform_set_drvdata(pdev, mtkd);
> > +
> > +       if (pdev->dev.of_node) {
> > +               /* Device-tree DMA controller registration */
> > +               rc = of_dma_controller_register(pdev->dev.of_node,
> > +                                               of_dma_xlate_by_chan_id,
> > +                                               mtkd);
> > +               if (rc)
> > +                       goto dma_remove;
> > +       }
> > +
> > +       return rc;
> > +
> > +dma_remove:
> > +       dma_async_device_unregister(&mtkd->ddev);
> > +rpm_disable:
> > +       pm_runtime_disable(&pdev->dev);
> > +err_no_dma:
> > +       mtk_uart_apdma_free(mtkd);
> > +       return rc;
> > +}
> > +

......


