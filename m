Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935339AbeBMO1x (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:27:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933612AbeBMO1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:27:52 -0500
Date: Tue, 13 Feb 2018 16:27:46 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau
        <marcandre.lureau@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergio Lopez Pascual <slp@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Somlo, Gabriel" <somlo@cmu.edu>, xiaolong.ye@intel.com
Subject: Re: [PATCH v13 3/4] fw_cfg: write vmcoreinfo details
Message-ID: <20180213162038-mutt-send-email-mst@kernel.org>
References: <20180207013525.1634-1-marcandre.lureau@redhat.com>
 <20180207013525.1634-4-marcandre.lureau@redhat.com>
 <20180212053104-mutt-send-email-mst@kernel.org>
 <CAMxuvawozzWQ98WkduM=nWQJMMmagSQuHPZMhOYbGZEG5a2aaQ@mail.gmail.com>
 <20180212160849-mutt-send-email-mst@kernel.org>
 <CAMxuvayUh=N3Lc6+ut8Ct5scVyS5dVRP_qDmpX7pCYf60hnQRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMxuvayUh=N3Lc6+ut8Ct5scVyS5dVRP_qDmpX7pCYf60hnQRA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 03:14:03PM +0100, Marc-Andre Lureau wrote:
> Hi
> 
> On Mon, Feb 12, 2018 at 10:00 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Mon, Feb 12, 2018 at 11:04:49AM +0100, Marc-Andre Lureau wrote:
> >> >> +}
> >> >> +
> >> >> +/* qemu fw_cfg device is sync today, but spec says it may become async */
> >> >> +static void fw_cfg_wait_for_control(struct fw_cfg_dma *d)
> >> >> +{
> >> >> +     do {
> >> >> +             u32 ctrl = be32_to_cpu(READ_ONCE(d->control));
> >> >> +
> >> >> +             if ((ctrl & ~FW_CFG_DMA_CTL_ERROR) == 0)
> >> >> +                     return;
> >> >> +
> >> >> +             usleep_range(50, 100);
> >> >> +     } while (true);
> >> >
> >> > And you need an smp rmb here.
> >
> > I'd just do rmb() in fact.
> >
> >> Could you explain? thanks
> >
> > See Documentation/memory-barriers.txt
> > You know that control is valid, but following read of
> > the structure could be reordered. So you need that barrier there.
> > Same for write: wmb.
> 
> Is this ok?
> @@ -103,10 +104,14 @@ static ssize_t fw_cfg_dma_transfer(void
> *address, u32 length, u32 control)
>         dma = virt_to_phys(d);
> 
>         iowrite32be((u64)dma >> 32, fw_cfg_reg_dma);
> +       /* force memory to sync before notifying device via MMIO */
> +       wmb();
>         iowrite32be(dma, fw_cfg_reg_dma + 4);
> 
>         fw_cfg_wait_for_control(d);
> 
> +       /* do not reorder the read to d->control */
> +       rmb();
>         if (be32_to_cpu(READ_ONCE(d->control)) & FW_CFG_DMA_CTL_ERROR) {
>                 ret = -EIO;
>         }

I think you need an rmb after the read of d->control.


> >
> >
> >> >
> >> >> +}
> >> >> +
> >> >> +static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 control)
> >> >> +{
> >> >> +     phys_addr_t dma;
> >> >> +     struct fw_cfg_dma *d = NULL;
> >> >> +     ssize_t ret = length;
> >> >> +
> >> >> +     d = kmalloc(sizeof(*d), GFP_KERNEL);
> >> >> +     if (!d) {
> >> >> +             ret = -ENOMEM;
> >> >> +             goto end;
> >> >> +     }
> >> >> +
> >> >> +     *d = (struct fw_cfg_dma) {
> >> >> +             .address = address ? cpu_to_be64(virt_to_phys(address)) : 0,
> >> >> +             .length = cpu_to_be32(length),
> >> >> +             .control = cpu_to_be32(control)
> >> >> +     };
> >> >> +
> >> >> +     dma = virt_to_phys(d);
> >> >
> >> > Pls add docs on why this DMA bypasses the DMA API.
> >>
> >> Peter said in his patch: "fw_cfg device does not need IOMMU
> >> protection, so use physical addresses
> >> always.  That's how QEMU implements fw_cfg.  Otherwise we'll see call
> >> traces during boot."
> >>
> >> Is that enough justification?
> >
> > what are the reasons for the traces exactly though?
> > some kind of explanation should go into comments, and
> > I think it should be a bit more detailed than just "it doesn't
> > work otherwise".
> >
> 
> I can use Peter help here. My understanding is because the qemu fw-cfg
> device doesn't go through iommu when doing DMA op. Whether it should
> or could, I can't answer.
> 
> thanks
