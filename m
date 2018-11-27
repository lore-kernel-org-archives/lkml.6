Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C96CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F36C214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F36C214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeK1CD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:03:56 -0500
Received: from mail5.windriver.com ([192.103.53.11]:40998 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbeK1CDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:03:55 -0500
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wARF3p3n029992
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 27 Nov 2018 07:04:02 -0800
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Tue, 27 Nov 2018 07:03:41 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 196372E0841; Tue, 27 Nov 2018 10:03:41 -0500 (EST)
Date:   Tue, 27 Nov 2018 10:03:41 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     kbuild test robot <lkp@intel.com>, <kbuild-all@01.org>,
        <linux-kernel@vger.kernel.org>,
        David Dajun Chen <dchen@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 02/11] mfd: da9055-core: make it explicitly non-modular
Message-ID: <20181127150340.GG14659@windriver.com>
References: <1542861179-8941-3-git-send-email-paul.gortmaker@windriver.com>
 <201811231036.wIjm7GBh%fengguang.wu@intel.com>
 <20181123031456.GD14659@windriver.com>
 <20181123144328.GE14659@windriver.com>
 <20181127130711.GL4272@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181127130711.GL4272@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 02/11] mfd: da9055-core: make it explicitly non-modular] On 27/11/2018 (Tue 13:07) Lee Jones wrote:

> On Fri, 23 Nov 2018, Paul Gortmaker wrote:

[...]

> > My other pending MFD patches have a trivial runtime behavior change;
> > deleting a ".remove" field/function - that will never be used for a
> > non-module case, but in theory could be (pointlessly) triggered by
> > forcing a driver unbind.  (see mainline 98b72b94def9 as an example)
> > Patches like this were left behind for a future send batch.
> 
> What about when .remove() is invoked during shutdown?

It is my understanding that .remove is not invoked during shutdown.

If we step outside of MFD and look at mainline commit 7aa8619a66aea5
("iommu/arm-smmu-v3: Implement shutdown method") -- you can see it adds
a shutdown that is just a wrapper around the remove function.

If shutdown called remove, then this commit would cause the remove
function to get called *twice* on a shutdown.

I also don't see any obvious coupling in drivers/base/platform.c - they
seem independent, but it is possible I've overlooked something?

Thanks,
Paul.

----------
static int platform_drv_remove(struct device *_dev)
{
        struct platform_driver *drv = to_platform_driver(_dev->driver);
        struct platform_device *dev = to_platform_device(_dev);
        int ret = 0;

        if (drv->remove)
                ret = drv->remove(dev);
        dev_pm_domain_detach(_dev, true);

        return ret;
}

static void platform_drv_shutdown(struct device *_dev)
{
        struct platform_driver *drv = to_platform_driver(_dev->driver);
        struct platform_device *dev = to_platform_device(_dev);

        if (drv->shutdown)
                drv->shutdown(dev);
}
----------
