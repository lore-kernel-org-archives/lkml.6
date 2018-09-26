Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F90C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBD3214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBD3214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeIZQ0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:26:37 -0400
Received: from foss.arm.com ([217.140.101.70]:42176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeIZQ0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:26:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A9A418A;
        Wed, 26 Sep 2018 03:14:24 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5FF73F5BD;
        Wed, 26 Sep 2018 03:14:21 -0700 (PDT)
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
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
        Lu Baolu <baolu.lu@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
 <130edd60-d92a-9871-334b-943fe8acffee@arm.com>
 <20180925151711.7ea1cf75@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <2842c93a-6252-225f-1595-296fe5bbb778@arm.com>
Date:   Wed, 26 Sep 2018 11:14:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925151711.7ea1cf75@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2018 23:17, Jacob Pan wrote:
> On Tue, 25 Sep 2018 15:58:41 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> Hi Jacob,
>> 
>> Just two minor things below, that I noticed while using fault handlers
>> for SVA. From my perspective the series is fine otherwise
>> 
>> On 11/05/2018 21:54, Jacob Pan wrote:
>> > +int iommu_unregister_device_fault_handler(struct device *dev)
>> > +{
>> > +       struct iommu_param *param = dev->iommu_param;
>> > +       int ret = 0;
>> > +
>> > +       if (!param)
>> > +               return -EINVAL;
>> > +
>> > +       mutex_lock(&param->lock);  
>> 
>> Could we check that param->fault_param isn't NULL here, so that the
>> driver can call this function unconditionally in a cleanup path?
>> 
> sounds good.
> 
>         if (!param || param->fault_param)
>                 return -EINVAL;

That would be too convenient... param needs to be checked before taking
the lock, and fault_param accessed after

Thanks,
Jean
