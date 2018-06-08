Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RXtpDkjLGVs2FQAAmS7hNA
	; Fri, 08 Jun 2018 00:22:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 72E5B6074D; Fri,  8 Jun 2018 00:22:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E66E9601D2;
	Fri,  8 Jun 2018 00:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E66E9601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeFHAWO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:22:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:60267 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752300AbeFHAWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:22:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 17:22:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,488,1520924400";
   d="scan'208";a="235370015"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.61])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jun 2018 17:22:09 -0700
Date: Fri, 8 Jun 2018 08:11:08 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v5 07/28] fpga: dfl: add chardev support for feature
 devices
Message-ID: <20180608001108.GA20571@hao-dev>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
 <1525229431-3087-8-git-send-email-hao.wu@intel.com>
 <CANk1AXRQx=QtwmSKuWiGprMcfjNnUWcBHNy-hTfP+JaQZsJLLA@mail.gmail.com>
 <20180606122457.GB7681@hao-dev>
 <CANk1AXTmpa1P55qCwZhyn=CGoa3v_hJ-KFCQsy7kMTBpULc6hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXTmpa1P55qCwZhyn=CGoa3v_hJ-KFCQsy7kMTBpULc6hQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 01:03:18PM -0500, Alan Tull wrote:
> On Wed, Jun 6, 2018 at 7:24 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> One more...
> 
> >> > +static dev_t dfl_get_devt(enum dfl_fpga_devt_type type, int id)
> >> > +{
> >> > +       WARN_ON(type >= DFL_FPGA_DEVT_MAX);
> >> > +
> >> > +       return MKDEV(MAJOR(dfl_chrdevs[type].devt), id);
> >> > +}
> >> > +
> >> > +/**
> >> > + * dfl_fpga_register_dev_ops - register cdev ops for feature dev
> >> > + *
> >> > + * @pdev: feature dev.
> >> > + * @fops: file operations for feature dev's cdev.
> >> > + * @owner: owning module/driver.
> >> > + *
> >> > + * Return: 0 on success, negative error code otherwise.
> >> > + */
> >> > +int dfl_fpga_register_dev_ops(struct platform_device *pdev,
> >> > +                             const struct file_operations *fops,
> >> > +                             struct module *owner)
> >> > +{
> >> > +       struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> >> > +
> >> > +       cdev_init(&pdata->cdev, fops);
> >> > +       pdata->cdev.owner = owner;
> >> > +
> >> > +       /*
> >> > +        * set parent to the feature device so that its refcount is
> >> > +        * decreased after the last refcount of cdev is gone, that
> >> > +        * makes sure the feature device is valid during device
> >> > +        * file's life-cycle.
> >> > +        */
> >> > +       pdata->cdev.kobj.parent = &pdev->dev.kobj;
> >> > +
> >> > +       return cdev_add(&pdata->cdev, pdev->dev.devt, 1);
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(dfl_fpga_register_dev_ops);
> >> > +
> >> > +/**
> >> > + * dfl_fpga_unregister_dev_ops - unregister cdev ops for feature dev
> >> > + * @pdev: feature dev.
> >> > + */
> >> > +void dfl_fpga_unregister_dev_ops(struct platform_device *pdev)
> >> > +{
> >> > +       struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> >> > +
> >> > +       cdev_del(&pdata->cdev);
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(dfl_fpga_unregister_dev_ops);
> 
> How about dfl_fpga_dev_ops_register/unregister?

Sure, will fix this in the v6. Thanks.

Hao

> 
> Thanks,
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
