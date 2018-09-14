Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D553C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C07820861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C07820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeINIAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 04:00:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:30601 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbeINIAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 04:00:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 19:47:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,371,1531810800"; 
   d="scan'208";a="69874531"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2018 19:47:46 -0700
Cc:     baolu.lu@linux.intel.com,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "tiwei.bie@intel.com" <tiwei.bie@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.y.sun@intel.com" <yi.y.sun@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
 <aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
 <3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4b24f0c6-5985-efbc-f842-8bde239dfc2a@linux.intel.com>
Date:   Fri, 14 Sep 2018 10:46:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/13/2018 01:54 AM, Jean-Philippe Brucker wrote:
> On 12/09/2018 03:42, Lu Baolu wrote:
>> Hi,
>>
>> On 09/11/2018 12:22 AM, Jean-Philippe Brucker wrote:
>>> Hi,
>>>
>>> On 30/08/2018 05:09, Lu Baolu wrote:
>>>> Below APIs are introduced in the IOMMU glue for device drivers to use
>>>> the finer granularity translation.
>>>>
>>>> * iommu_capable(IOMMU_CAP_AUX_DOMAIN)
>>>>     - Represents the ability for supporting multiple domains per device
>>>>       (a.k.a. finer granularity translations) of the IOMMU hardware.
>>> iommu_capable() cannot represent hardware capabilities, we need
>>> something else for systems with multiple IOMMUs that have different
>>> caps. How about iommu_domain_get_attr on the device's domain instead?
>> Domain is not a good choice for per iommu cap query. A domain might be
>> attached to devices belonging to different iommu's.
>>
>> How about an API with device structure as parameter? A device always
>> belongs to a specific iommu. This API is supposed to be used the
>> device driver.
> Ah right, domain attributes won't work. Your suggestion seems more
> suitable, but maybe users can simply try to enable auxiliary domains
> first, and conclude that the IOMMU doesn't support it if it returns an error
> 

Some driver might want to check whether hardware supports AUX_DOMAIN
during the driver probe stage, but doesn't want to enable AUX_DOMAIN
at that time. One reasonable use case is driver check AUX_DOMAIN cap
during driver probe and expose different sysfs nodes according to
whether AUX_DOMAIN is support or not, then AUX_DOMAIN is enabled or 
disabled during run time through a sysfs node. With this consideration,
we still need a API to check cap.

How about

* iommu_check_aux_domain(struct device *dev)
    - Check whether the iommu driver supports multiple domains on @dev.

Best regards,
Lu Baolu



