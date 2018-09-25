Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B1AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5F020896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5F020896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeIZAEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:04:39 -0400
Received: from foss.arm.com ([217.140.101.70]:56216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIZAEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:04:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03F3118A;
        Tue, 25 Sep 2018 10:56:00 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.Emea.Arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA9DC3F5BD;
        Tue, 25 Sep 2018 10:55:57 -0700 (PDT)
Subject: Re: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching group
 helpers
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <20180830040922.30426-9-baolu.lu@linux.intel.com>
 <c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
 <a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
 <04f5dc9d-71b1-37ec-402b-fae5f9e08664@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191300D35@SHSMSX101.ccr.corp.intel.com>
 <c285871d-2ea0-5878-c7ac-ffa4ba8256ee@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191305A74@SHSMSX101.ccr.corp.intel.com>
 <f46bcf5f-002b-4269-a750-c4254c9fc89f@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19130EAD7@SHSMSX101.ccr.corp.intel.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <75517c87-6ffd-2023-a541-3c69ae52ef4b@arm.com>
Date:   Tue, 25 Sep 2018 18:55:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19130EAD7@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2018 00:26, Tian, Kevin wrote:
>> If the core actually calls it, we can implement detach_dev :) The
>> problem is that the core never calls detach_dev when default_domain is
>> present (affects any IOMMU driver that relies on default_domain,
>> including AMD), and even in case 4) the default_domain is present for
>> the parent device
> 
> Then can we change that core logic so detach_dev is invoked in all
> cases? yes there will be some changes in vendor drivers, but I expect
> this change trivial (especially considering the gain in IOMMU API
> simplicity side as described below).

Thinking more about this, there might be a way that doesn't require too
much rewriting of IOMMU drivers. When VFIO calls iommu_detach_group to
detach a vfio-pci device from its domain, it could do detach_dev(dev,
old_domain) followed by attach_dev(dev, default_domain) instead of only
attach_dev(dev, default_domain), so:

__iommu_attach_group(grp, unmanaged_domain)
  ops->attach_dev(dev, unmanaged_domain)
    -> IOMMU driver detaches from default_domain only if the dev isn't
       in auxiliary mode

__iommu_detach_group(grp, unmanaged_domain)
  if (ops->detach_dev)
      ops->detach_dev(dev, unmanaged_domain)
  ops->attach_dev(dev, default_domain)
    -> IOMMU driver ignores this if still attached to default_domain

It's not trivial: since half the IOMMU drivers seem to be using default
domain now, their detach_dev callback might have been dead code for a
while (I can't find a path where it still gets called), so re-enabling
it requires some attention. However, since most of them won't care about
aux domains, maybe we could just remove their detach_dev pointer.

The resulting logic of attach/detach_dev in IOMMU drivers that do use
aux domains still seems unnecessarily convoluted. It could as well be
done with separate attach_aux/detach_aux functions. If you want to keep
it that way though, I think the above could work for us and I'll try to
write an RFC.

Thanks,
Jean
