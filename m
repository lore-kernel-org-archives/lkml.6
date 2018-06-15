Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 531DAC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018DF208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018DF208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755787AbeFOGED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:04:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:52949 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755589AbeFOGEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:04:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 23:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="237639901"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.61])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2018 23:03:58 -0700
Date:   Fri, 15 Jun 2018 13:52:46 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v6 17/29] fpga: dfl: fme: add partial reconfiguration sub
 feature support
Message-ID: <20180615055246.GA27304@hao-dev>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <1528798243-2029-18-git-send-email-hao.wu@intel.com>
 <20180614010713.fivl64pirawrnrhc@derp-derp.local>
 <CANk1AXRU9yXhgWu9_CZLLRQfNKedR22ghoPLGeTRUeTX24XtWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRU9yXhgWu9_CZLLRQfNKedR22ghoPLGeTRUeTX24XtWw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 11:33:00AM -0500, Alan Tull wrote:
> On Wed, Jun 13, 2018 at 8:07 PM, Moritz Fischer <mdf@kernel.org> wrote:
> 
> Hellooo,
> 
> This probably could use a comment, please see below.
> 
> > Hi,
> >
> > quick question for Alan inline below.
> >
> 
> >> +static int fme_pr(struct platform_device *pdev, unsigned long arg)
> >> +{
> >> +     struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> >> +     void __user *argp = (void __user *)arg;
> >> +     struct dfl_fpga_fme_port_pr port_pr;
> >> +     struct fpga_image_info *info;
> >> +     struct fpga_region *region;
> >> +     void __iomem *fme_hdr;
> >> +     struct dfl_fme *fme;
> >> +     unsigned long minsz;
> >> +     void *buf = NULL;
> >> +     int ret = 0;
> >> +     u64 v;
> >> +
> >> +     minsz = offsetofend(struct dfl_fpga_fme_port_pr, buffer_address);
> >> +
> >> +     if (copy_from_user(&port_pr, argp, minsz))
> >> +             return -EFAULT;
> >> +
> >> +     if (port_pr.argsz < minsz || port_pr.flags)
> >> +             return -EINVAL;
> >> +
> >> +     if (!IS_ALIGNED(port_pr.buffer_size, 4))
> >> +             return -EINVAL;
> >> +
> >> +     /* get fme header region */
> >> +     fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
> >> +                                            FME_FEATURE_ID_HEADER);
> >> +
> >> +     /* check port id */
> >> +     v = readq(fme_hdr + FME_HDR_CAP);
> >> +     if (port_pr.port_id >= FIELD_GET(FME_CAP_NUM_PORTS, v)) {
> >> +             dev_dbg(&pdev->dev, "port number more than maximum\n");
> >> +             return -EINVAL;
> >> +     }
> >> +
> >> +     if (!access_ok(VERIFY_READ,
> >> +                    (void __user *)(unsigned long)port_pr.buffer_address,
> >> +                    port_pr.buffer_size))
> >> +             return -EFAULT;
> >> +
> >> +     buf = vmalloc(port_pr.buffer_size);
> >> +     if (!buf)
> >> +             return -ENOMEM;
> >> +
> >> +     if (copy_from_user(buf,
> >> +                        (void __user *)(unsigned long)port_pr.buffer_address,
> >> +                        port_pr.buffer_size)) {
> >> +             ret = -EFAULT;
> >> +             goto free_exit;
> >> +     }
> >> +
> >> +     /* prepare fpga_image_info for PR */
> >> +     info = fpga_image_info_alloc(&pdev->dev);
> >> +     if (!info) {
> >> +             ret = -ENOMEM;
> >> +             goto free_exit;
> >> +     }
> >> +
> >> +     info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
> >> +
> >> +     mutex_lock(&pdata->lock);
> >> +     fme = dfl_fpga_pdata_get_private(pdata);
> >> +     /* fme device has been unregistered. */
> >> +     if (!fme) {
> >> +             ret = -EINVAL;
> >> +             goto unlock_exit;
> >> +     }
> >> +
> >> +     region = dfl_fme_region_find(fme, port_pr.port_id);
> >> +     if (!region) {
> >> +             ret = -EINVAL;
> >> +             goto unlock_exit;
> >> +     }
> >> +
> >> +     fpga_image_info_free(region->info);
> >> +
> >> +     info->buf = buf;
> >> +     info->count = port_pr.buffer_size;
> >> +     info->region_id = port_pr.port_id;
> >> +     region->info = info;
> >> +
> >> +     ret = fpga_region_program_fpga(region);
> >> +
> >> +     if (region->get_bridges)
> >> +             fpga_bridges_put(&region->bridge_list);
> >
> > I'm wondering if this should not be done as part of
> > fpga_region_program_fpga() (It's not at the moment).
> >
> > Alan, am I missing something obvious? :)
> 
> It is up to the caller of  fpga_region_program_fpga to put the bridges
> before programming again.  That prevents something other than the
> caller from reprogramming a partial region or messing with the bridges
> until the caller puts the bridges.
> 
> For example, for DT support, applying an overlay calls
> fpga_region_program_fpga() which gets the bridges, disables them, does
> the programming, and reenables the bridges.  Then the bridges are
> held, preventing anything else from disabling the bridges until the
> overlay is removed.  This was important in the DT case since the
> overlay could include child nodes for hardware in the FPGA.   Allowing
> anyone else to play with the bridges while those drivers were
> expecting hardware access could be bad.
> 
> I can't remember for certain, but I think this code has to put the
> bridges here because this patch set allows userspace to reset the PR
> region's logic by disabling/reenabling the bridge to clear things out
> between acceleration runs (which Hao promises is OK to do, it's
> documented elsewhere in the pachset).  It probably could use a comment
> right here to explain why the bridges are put here so future
> generations know not to break this.

Yes, it's correct. I can add some comments here in the next version.

Thanks
Hao

> 
> Alan
> 
> >> +
> >> +     put_device(&region->dev);
> >> +unlock_exit:
> >> +     mutex_unlock(&pdata->lock);
> >> +free_exit:
> >> +     vfree(buf);
> >> +     if (copy_to_user((void __user *)arg, &port_pr, minsz))
> >> +             return -EFAULT;
> >> +
> >> +     return ret;
> >> +}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
