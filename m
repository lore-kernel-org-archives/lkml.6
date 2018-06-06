Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD275606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeFFMod (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:44:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:1034 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752579AbeFFMoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:44:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="64775783"
Date: Wed, 6 Jun 2018 20:33:26 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Subject: Re: [PATCH v5 09/28] fpga: dfl: add feature device infrastructure
Message-ID: <20180606123326.GC7681@hao-dev>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
 <1525229431-3087-10-git-send-email-hao.wu@intel.com>
 <CANk1AXRyqn_Y26HZiYkFQUoWUVzc89F-znVNWQXGAk+arNB6XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRyqn_Y26HZiYkFQUoWUVzc89F-znVNWQXGAk+arNB6XA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 04:14:43PM -0500, Alan Tull wrote:
> On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> Some minor things, otherwise looks fine.
> 
> > From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> >
> > This patch abstracts the common operations of the sub features, and defines
> > the feature_ops data structure, including init, uinit and ioctl function
> > pointers. And this patch adds some common helper functions for FME and AFU
> > drivers, e.g dfl_feature_dev_use_begin/end which are used to ensure
> > exclusive usage of the feature device file.
> >
> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > Signed-off-by: Kang Luwei <luwei.kang@intel.com>
> > Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
> > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
> 
> > ---
> > v2: rebased
> > v3: use const for feature_ops.
> >     replace pci related function.
> > v4: rebase and add more comments in code.
> > v5: remove useless WARN_ON().
> >     reorder declarations in functions per suggestion from Moritz.
> >     add "dfl_" prefix to functions and data structure.
> > ---
> >  drivers/fpga/dfl.c | 57 +++++++++++++++++++++++++++++++++++++
> >  drivers/fpga/dfl.h | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 138 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 1e06efb..c4c47d6 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -74,6 +74,63 @@ static enum dfl_id_type feature_dev_id_type(struct platform_device *pdev)
> >         return DFL_ID_MAX;
> >  }
> >
> > +void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
> > +{
> > +       struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > +       struct dfl_feature *feature;
> > +
> > +       dfl_fpga_dev_for_each_feature(pdata, feature)
> > +               if (feature->ops) {
> > +                       feature->ops->uinit(pdev, feature);
> > +                       feature->ops = NULL;
> > +               }
> > +}
> > +EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit);
> 
> Please add kernel-doc for functions that are exported to recommend and
> guide their usage.

Sorry, I missed uinit and init functions. will add them in v6.

> 
> > +
> > +static int dfl_feature_instance_init(struct platform_device *pdev,
> > +                                    struct dfl_feature_platform_data *pdata,
> > +                                    struct dfl_feature *feature,
> > +                                    struct dfl_feature_driver *drv)
> > +{
> > +       int ret;
> > +
> > +       ret = drv->ops->init(pdev, feature);
> > +       if (ret)
> > +               return ret;
> > +
> > +       feature->ops = drv->ops;
> > +
> > +       return ret;
> > +}
> > +
> > +int dfl_fpga_dev_feature_init(struct platform_device *pdev,
> > +                             struct dfl_feature_driver *feature_drvs)
> > +{
> > +       struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > +       struct dfl_feature_driver *drv = feature_drvs;
> > +       struct dfl_feature *feature;
> > +       int ret;
> > +
> > +       while (drv->ops) {
> > +               dfl_fpga_dev_for_each_feature(pdata, feature) {
> > +                       /* match feature and drv using id */
> > +                       if (feature->id == drv->id) {
> > +                               ret = dfl_feature_instance_init(pdev, pdata,
> > +                                                               feature, drv);
> > +                               if (ret)
> > +                                       goto exit;
> > +                       }
> > +               }
> > +               drv++;
> > +       }
> > +
> > +       return 0;
> > +exit:
> > +       dfl_fpga_dev_feature_uinit(pdev);
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_init);
> > +
> >  struct dfl_chardev_info {
> >         const char *name;
> >         dev_t devt;
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 2b6aaef..27f7a74 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -132,6 +132,17 @@
> >  #define PORT_CTRL_SFTRST_ACK   BIT_ULL(4)              /* HW ack for reset */
> >
> >  /**
> > + * struct dfl_feature_driver - sub feature's driver
> > + *
> > + * @id: sub feature id.
> > + * @ops: ops of this sub feature.
> > + */
> > +struct dfl_feature_driver {
> > +       u64 id;
> > +       const struct dfl_feature_ops *ops;
> > +};
> > +
> > +/**
> >   * struct dfl_feature - sub feature of the feature devices
> >   *
> >   * @id: sub feature id.
> > @@ -139,13 +150,17 @@
> >   *                 this index is used to find its mmio resource from the
> >   *                 feature dev (platform device)'s reources.
> >   * @ioaddr: mapped mmio resource address.
> > + * @ops: ops of this sub feature.
> >   */
> >  struct dfl_feature {
> >         u64 id;
> >         int resource_index;
> >         void __iomem *ioaddr;
> > +       const struct dfl_feature_ops *ops;
> >  };
> >
> > +#define DEV_STATUS_IN_USE      0
> > +
> >  /**
> >   * struct dfl_feature_platform_data - platform data for feature devices
> >   *
> > @@ -156,6 +171,8 @@ struct dfl_feature {
> >   * @dfl_cdev: ptr to container device.
> >   * @disable_count: count for port disable.
> >   * @num: number for sub features.
> > + * @dev_status: dev status (e.g DEV_STATUS_IN_USE).
> > + * @private: ptr to feature dev private data.
> >   * @features: sub features of this feature dev.
> >   */
> >  struct dfl_feature_platform_data {
> > @@ -165,11 +182,49 @@ struct dfl_feature_platform_data {
> >         struct platform_device *dev;
> >         struct dfl_fpga_cdev *dfl_cdev;
> >         unsigned int disable_count;
> > -
> > +       unsigned long dev_status;
> > +       void *private;
> >         int num;
> >         struct dfl_feature features[0];
> >  };
> >
> > +static inline
> > +int dfl_feature_dev_use_begin(struct dfl_feature_platform_data *pdata)
> > +{
> > +       /* Test and set IN_USE flags to ensure file is exclusively used */
> > +       if (test_and_set_bit_lock(DEV_STATUS_IN_USE, &pdata->dev_status))
> > +               return -EBUSY;
> > +
> > +       return 0;
> > +}
> > +
> > +static inline
> > +void dfl_feature_dev_use_end(struct dfl_feature_platform_data *pdata)
> > +{
> > +       clear_bit_unlock(DEV_STATUS_IN_USE, &pdata->dev_status);
> > +}
> > +
> > +static inline
> > +void dfl_fpga_pdata_set_private(struct dfl_feature_platform_data *pdata,
> > +                               void *private)
> > +{
> > +       pdata->private = private;
> > +}
> > +
> > +static inline
> > +void *dfl_fpga_pdata_get_private(struct dfl_feature_platform_data *pdata)
> > +{
> > +       return pdata->private;
> > +}
> > +
> > +struct dfl_feature_ops {
> > +       int (*init)(struct platform_device *pdev, struct dfl_feature *feature);
> > +       void (*uinit)(struct platform_device *pdev,
> > +                     struct dfl_feature *feature);
> > +       long (*ioctl)(struct platform_device *pdev, struct dfl_feature *feature,
> > +                     unsigned int cmd, unsigned long arg);
> > +};
> > +
> >  #define DFL_FPGA_FEATURE_DEV_FME               "dfl-fme"
> >  #define DFL_FPGA_FEATURE_DEV_PORT              "dfl-port"
> 
> Please move these to the same place as other things that will need to
> be added to as feature devices are added as noted in the other reviews
> today.

as these two strings are used as platform device name, so I think we need to
keep them in the dfl.h file, because platform driver could reuse the same.
But I will add detailed comments to guide others to put name string for new
feature device (platform device) in the dfl.h file together with above ones.

Thanks a lot for the review.
Hao
