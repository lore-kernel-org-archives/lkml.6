Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C520C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E264520892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E264520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLFRmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:42:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57196 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeLFRmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:42:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9453A80D;
        Thu,  6 Dec 2018 09:42:19 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BBC93F5AF;
        Thu,  6 Dec 2018 09:42:18 -0800 (PST)
Subject: Re: [PATCH 2/5] iommu/of: Use device_iommu_mapped()
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
References: <20181204172504.19708-1-joro@8bytes.org>
 <20181204172504.19708-3-joro@8bytes.org>
 <44c82503-bc36-e8de-6932-7c4fd2b597f8@arm.com>
 <20181206153512.GG16835@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <42cb32df-5358-f00d-12f5-eb3135ec680a@arm.com>
Date:   Thu, 6 Dec 2018 17:42:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206153512.GG16835@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 15:35, Joerg Roedel wrote:
> Hi Robin,
> 
> On Wed, Dec 05, 2018 at 05:17:54PM +0000, Robin Murphy wrote:
>> FWIW, this check (and its ACPI equivalent in patch #3) is specifically
>> asking "has .add_device() already been called?", rather than the more
>> general "is this device managed by an IOMMU?" (to which the exact answer at
>> this point is "yes, provided we return successfully from here").
>>
>> I have no objection to the change as-is - especially if that usage is within
>> the intended scope of this API - I just wanted to call it out in case you're
>> also planning to introduce something else which would be even more
>> appropriate for that.
> 
> Yes, the purpose of the device_iommu_mapped() functions is to check
> whether the device has been initialized by the IOMMU driver that handles
> it, if any.
> 
> So it answers the question: Can I use the device in an IOMMU-API call?

OK, another way to consider the usage here would be "is the device ready 
to use in IOMMU API calls (or do I need to call add_device to finish 
setting it up)?", so it does in fact seem like a perfect fit, great!

> And it is more readable than the dev->iommu_group checks everywhere :)

For sure - although I am now wondering whether "mapped" is perhaps a 
little ambiguous in the naming, since the answer to "can I use the API" 
is yes even when the device may currently be attached to an 
identity/passthrough domain or blocked completely, neither of which 
involve any "mapping". Maybe simply "device_has_iommu()" would convey 
the intent better?

Robin.
