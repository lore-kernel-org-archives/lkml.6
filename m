Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42962C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BAD20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BAD20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeIZEZ2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:25:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:17319 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725736AbeIZEZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 00:25:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 15:15:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="75898342"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 25 Sep 2018 15:15:46 -0700
Date:   Tue, 25 Sep 2018 15:17:11 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jean Delvare <khali@linux-fr.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
Message-ID: <20180925151711.7ea1cf75@jacob-builder>
In-Reply-To: <130edd60-d92a-9871-334b-943fe8acffee@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
        <130edd60-d92a-9871-334b-943fe8acffee@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 15:58:41 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Hi Jacob,
> 
> Just two minor things below, that I noticed while using fault handlers
> for SVA. From my perspective the series is fine otherwise
> 
> On 11/05/2018 21:54, Jacob Pan wrote:
> > +int iommu_unregister_device_fault_handler(struct device *dev)
> > +{
> > +       struct iommu_param *param = dev->iommu_param;
> > +       int ret = 0;
> > +
> > +       if (!param)
> > +               return -EINVAL;
> > +
> > +       mutex_lock(&param->lock);  
> 
> Could we check that param->fault_param isn't NULL here, so that the
> driver can call this function unconditionally in a cleanup path?
> 
sounds good.

	if (!param || param->fault_param)
		return -EINVAL;

> > +       /* we cannot unregister handler if there are pending faults
> > */
> > +       if (!list_empty(&param->fault_param->faults)) {
> > +               ret = -EBUSY;
> > +               goto unlock;
> > +       }
> > +
> > +       kfree(param->fault_param);
> > +       param->fault_param = NULL;
> > +       put_device(dev);
> > +unlock:
> > +       mutex_unlock(&param->lock);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
> > +
> > +
> > +/**
> > + * iommu_report_device_fault() - Report fault event to device
> > + * @dev: the device
> > + * @evt: fault event data
> > + *
> > + * Called by IOMMU model specific drivers when fault is detected,
> > typically
> > + * in a threaded IRQ handler.
> > + *
> > + * Return 0 on success, or an error.
> > + */
> > +int iommu_report_device_fault(struct device *dev, struct
> > iommu_fault_event *evt)
> > +{
> > +       int ret = 0;
> > +       struct iommu_fault_event *evt_pending;
> > +       struct iommu_fault_param *fparam;
> > +
> > +       /* iommu_param is allocated when device is added to group */
> > +       if (!dev->iommu_param | !evt)  
> 
> Should probably be ||
> 
your are right, thanks!
