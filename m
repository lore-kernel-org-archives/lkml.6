Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D754C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FD12064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FD12064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbeGZQ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:26:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57922 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730105AbeGZQ0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:26:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2240D15B2;
        Thu, 26 Jul 2018 08:09:31 -0700 (PDT)
Received: from [10.4.13.35] (ostrya.emea.arm.com [10.4.13.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C5453F2EA;
        Thu, 26 Jul 2018 08:09:29 -0700 (PDT)
Subject: Re: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
 <5B568D5B.5050606@linux.intel.com>
 <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19127FB9E@SHSMSX101.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19127FF05@SHSMSX101.ccr.corp.intel.com>
 <a530c220-9bf1-05ec-5698-526ccbea127f@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912826AE@SHSMSX101.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191282739@SHSMSX101.ccr.corp.intel.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <68bacab4-7729-59cd-07dc-e8d1f9580ec4@arm.com>
Date:   Thu, 26 Jul 2018 16:09:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191282739@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/18 04:28, Tian, Kevin wrote:
>> hierarchical domain might be the right way to go, but let's do more
>> thinking on any corner cases.
>>
> 
> btw maybe we don't need make it 'hierarchical', as maintaining
> hierarchy usually brings more work. What we require is possibly
> just the capability of having one device bind to multiple 
> iommu_domains. One domain is reserved for parent driver's
> own DMA activities (e.g. serving DMA APIs), while other domains
> are auxiliary and can be tagged with a PASID (or any other identifier
> which IOMMU can use to support multiple domains). Such identifiers 
> may be automatically provisioned when auxiliary domain is attached, 
> i.e. not requiring an explicit request from caller. IMO it's safe to 
> assume that supporting multiple iommu domains anyway implies 
> some finer-grained capability than RID-based in underlying IOMMU.
> Then there is no need of parent/child concept.

Right, we probably don't need a hierarchy. I like this model (it's
actually the one I favor for supporting PASID in virtio-iommu), though
I'm hoping we can avoid changing the logic of iommu_attach/detach, and
instead introduce a new "get_child_domain", "attach_aux_domain" or
simply "clone" op.

Currently the attach_dev() op toggles the domain of a device. For
example a device automatically gets a default domain for kernel DMA,
then VFIO attaches a new domain for assigning to a VM. attach_dev()
disables the default domain and installs fresh page tables. detach_dev()
isn't called, and the SMMU drivers don't even implement it. If we wanted
to reuse attach_dev() for auxiliary domains, we'd need some flag to
differentiate the "add auxiliary domain" operation from the "detach
everything and attach one new domain" one

Thanks,
Jean
