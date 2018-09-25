Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8463AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6ED2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6ED2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbeIYVGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:06:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52364 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbeIYVGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:06:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2CB3ED1;
        Tue, 25 Sep 2018 07:59:00 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D6D23F5BD;
        Tue, 25 Sep 2018 07:58:58 -0700 (PDT)
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jean Delvare <khali@linux-fr.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <130edd60-d92a-9871-334b-943fe8acffee@arm.com>
Date:   Tue, 25 Sep 2018 15:58:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

Just two minor things below, that I noticed while using fault handlers
for SVA. From my perspective the series is fine otherwise

On 11/05/2018 21:54, Jacob Pan wrote:
> +int iommu_unregister_device_fault_handler(struct device *dev)
> +{
> +       struct iommu_param *param = dev->iommu_param;
> +       int ret = 0;
> +
> +       if (!param)
> +               return -EINVAL;
> +
> +       mutex_lock(&param->lock);

Could we check that param->fault_param isn't NULL here, so that the
driver can call this function unconditionally in a cleanup path?

> +       /* we cannot unregister handler if there are pending faults */
> +       if (!list_empty(&param->fault_param->faults)) {
> +               ret = -EBUSY;
> +               goto unlock;
> +       }
> +
> +       kfree(param->fault_param);
> +       param->fault_param = NULL;
> +       put_device(dev);
> +unlock:
> +       mutex_unlock(&param->lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
> +
> +
> +/**
> + * iommu_report_device_fault() - Report fault event to device
> + * @dev: the device
> + * @evt: fault event data
> + *
> + * Called by IOMMU model specific drivers when fault is detected, typically
> + * in a threaded IRQ handler.
> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_report_device_fault(struct device *dev, struct
> iommu_fault_event *evt)
> +{
> +       int ret = 0;
> +       struct iommu_fault_event *evt_pending;
> +       struct iommu_fault_param *fparam;
> +
> +       /* iommu_param is allocated when device is added to group */
> +       if (!dev->iommu_param | !evt)

Should probably be ||

Thanks,
Jean
