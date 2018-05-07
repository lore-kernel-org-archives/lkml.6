Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeEGGmH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:42:07 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33476 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEGGmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:42:04 -0400
X-Google-Smtp-Source: AB8JxZrj4ebbO8eUtapNYg+rWJn0WtFCywJOK94+0aVBpXhK4X7u2WEdYi/T0ymk29+36W7MeWawgg==
MIME-Version: 1.0
References: <20180308094807.9443-1-jacob-chen@iotwrt.com> <20180308094807.9443-6-jacob-chen@iotwrt.com>
 <20180503090909.o3dyhukzs2y7em5z@tarshish> <CAAFQd5CvBv4hkE=PSHBJTYa9Lj0SyggxpMBEAYD=if0=T0uzHw@mail.gmail.com>
 <20180507063814.vweb4p3nfgnoc3td@tarshish>
In-Reply-To: <20180507063814.vweb4p3nfgnoc3td@tarshish>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 07 May 2018 06:41:50 +0000
X-Gmail-Original-Message-ID: <CAAFQd5A7gAK4fXH9YVrobR5_QX_5f8xa272R_56v5YUghV6Sxw@mail.gmail.com>
Message-ID: <CAAFQd5A7gAK4fXH9YVrobR5_QX_5f8xa272R_56v5YUghV6Sxw@mail.gmail.com>
Subject: Re: [PATCH v6 05/17] media: rkisp1: add Rockchip ISP1 subdev driver
To: baruch@tkos.co.il
Cc: Jacob Chen <jacob-chen@iotwrt.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?B?6ZKf5Lul5bSH?= <zyc@rock-chips.com>,
        Eddie Cai <eddie.cai.linux@gmail.com>,
        Jeffy <jeffy.chen@rock-chips.com>, devicetree@vger.kernel.org,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen Jacob <jacob2.chen@rock-chips.com>,
        =?UTF-8?B?6ZmI5Z+O?= <cc@rock-chips.com>,
        Allon Huang <allon.huang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 3:38 PM Baruch Siach <baruch@tkos.co.il> wrote:

> Hi Tomasz,

> On Mon, May 07, 2018 at 06:13:27AM +0000, Tomasz Figa wrote:
> > On Thu, May 3, 2018 at 6:09 PM Baruch Siach <baruch@tkos.co.il> wrote:
> > > On Thu, Mar 08, 2018 at 05:47:55PM +0800, Jacob Chen wrote:
> > > > +static int rkisp1_isp_sd_s_power(struct v4l2_subdev *sd, int on)
> > > > +{
> > > > +     struct rkisp1_device *isp_dev = sd_to_isp_dev(sd);
> > > > +     int ret;
> > > > +
> > > > +     v4l2_dbg(1, rkisp1_debug, &isp_dev->v4l2_dev, "s_power: %d\n",
> > on);
> > > > +
> > > > +     if (on) {
> > > > +             ret = pm_runtime_get_sync(isp_dev->dev);
> > > > +             if (ret < 0)
> > > > +                     return ret;
> > > > +
> > > > +             rkisp1_config_clk(isp_dev);
> > > > +     } else {
> > > > +             ret = pm_runtime_put(isp_dev->dev);
> >
> > > I commented this line out to make more than one STREAMON work.
Otherwise,
> > > the second STREAMON hangs. I guess the bug is not this driver.
Probably
> > > something in drivers/soc/rockchip/pm_domains.c. Just noting that in
case
> > > you or someone on Cc would like to investigate it further.
> > >
> > > I tested v4.16-rc4 on the Tinkerboard.
> >
> > Looks like that version doesn't include the IOMMU PM and clock handling
> > rework [1], which should fix a lot of runtime PM issues. FWIW,
linux-next
> > seems to already include it.
> >
> > [1] https://lkml.org/lkml/2018/3/23/44

> Thanks for the reference.

> It looks like the iommu driver part is in Linus' tree already. The DT
part is
> in the v4.18-armsoc/dts32 branch of Heiko's tree. Am I missing anything?

You're right, most of the series made it in time for 4.17. However, the DT
part (precisely, the clocks properties added to IOMMU nodes) is crucial for
the fixes to be effective.


> Anyway, I'll take a look.

Thanks for testing. :) (Forgot to mention in my previous email...)

Best regards,
Tomasz
