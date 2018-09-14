Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E74AECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EF121480
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19EF121480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeINTzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34508 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbeINTzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F95880D;
        Fri, 14 Sep 2018 07:40:31 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46BBF3F575;
        Fri, 14 Sep 2018 07:40:29 -0700 (PDT)
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
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
 <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
 <aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
 <3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191300D06@SHSMSX101.ccr.corp.intel.com>
 <03d496b0-84c2-b3ca-5be5-d4540c6d8ec7@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191302ECE@SHSMSX101.ccr.corp.intel.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <64e4726e-929f-0e76-6dcc-45a750bde7e9@arm.com>
Date:   Fri, 14 Sep 2018 15:40:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191302ECE@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> This example only needs to modify first-level translation, and works
>> with SMMUv3. The kernel here could be the host, in which case
>> second-level translation is disabled in the SMMU, or it could be the
>> guest, in which case second-level mappings are created by QEMU and
>> first-level translation is managed by assigning PASID tables to the guest.
> 
> the former yes applies to aux domain concept. The latter doesn't -
> you have only one second-level per device. whole PASID table managed
> by guest means you assign the whole device to guest, which is not the
> concept of aux domain here.

Right, in the latter case, the host uses a "normal" domain to assign the
whole PCI function to the guest. But the guest can still use auxiliary
domains like in my example, to sub-assign the PCI function to different
guest userspace applications.

>> So (2) would use iommu_sva_bind_device(), but (1) needs something else.
>> Aren't auxiliary domains suitable for (1)? Why limit auxiliary domain to
>> second-level or nested translation? It seems silly to use a different
>> API for first-level, since the flow in userspace and VFIO is the same as
>> your second-level case as far as MAP_DMA ioctl goes. The difference is
>> that in your case the auxiliary domain supports an additional operation
>> which binds first-level page tables. An auxiliary domain that only
>> supports first-level wouldn't support this operation, but it can still
>> implement iommu_map/unmap/etc.
> 
> Thanks for correcting me on this. You are right that aux domain shouldn't
> impose such limitation on 2nd or nested only. We define aux domain
> as a normal domain (aux takes effect only when attaching to a device),
> thus it should support all capabilities possible on a normal domain.
> 
> btw I'm not sure whether you look at my comment to patch 8/10. I
> explained the rationale why aux domain doesn't interfere with existing
> default domain usage, and in a quick thinking above example might
> not make difference. but need your confirm here. :-)

Yes sorry, I didn't have time to answer, will do it now

Thanks,
Jean
