Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59A0C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA0F208E8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA0F208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeGKGfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:35:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:58802 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeGKGfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:35:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 23:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,337,1526367600"; 
   d="scan'208";a="70391505"
Received: from blu2-desk2.ccr.corp.intel.com (HELO [10.0.2.15]) ([10.239.13.1])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2018 23:32:48 -0700
Subject: Re: [PATCH v4 1/9] iommu/vt-d: Global PASID name space
To:     Peter Xu <peterx@redhat.com>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
 <1531113778-28238-2-git-send-email-baolu.lu@linux.intel.com>
 <20180711024843.GC2359@xz-mi>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5B45A48C.7040300@linux.intel.com>
Date:   Wed, 11 Jul 2018 14:32:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180711024843.GC2359@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for looking into my patches.

On 07/11/2018 10:48 AM, Peter Xu wrote:
> On Mon, Jul 09, 2018 at 01:22:50PM +0800, Lu Baolu wrote:
>
> [...]
>
>> +#ifndef __INTEL_PASID_H
>> +#define __INTEL_PASID_H
>> +
>> +#define PASID_MIN			0x1
>> +#define PASID_MAX			0x20000
> Could I ask whether there's a reason to explicitly use 0x20000 for the
> max value?  Asked since I saw that the example in the spec gave 20
> bits for PASID (please refer to spec ver 3.0 section 3.4.3 figure
> 3-8).  Also I believe that's what I was told by Kevin.
>
> I saw that the old per-iommu max value is set to 0x20000, though I'm
> not sure whether that's still needed since if we're going to have
> two-level pasid table then AFAIU we don't need physically continuous
> memory any more (though I saw that we don't yet have two-level pasid
> table implemented):
>
> 	/* Eventually I'm promised we will get a multi-level PASID table
> 	 * and it won't have to be physically contiguous. Until then,
> 	 * limit the size because 8MiB contiguous allocations can be hard
> 	 * to come by. The limit of 0x20000, which is 1MiB for each of
> 	 * the PASID and PASID-state tables, is somewhat arbitrary. */
> 	if (iommu->pasid_max > 0x20000)
> 		iommu->pasid_max = 0x20000;

You are right.

With the scalable mode defined in vt-d v3.0, wecould use the full 20 bit
pasid. Previous max pasid was intended to save contiguous physical memory.

Best regards,
Lu Baolu
