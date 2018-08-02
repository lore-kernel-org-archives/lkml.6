Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C15C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AA32151C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AA32151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbeHBOQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:16:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728797AbeHBOQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:16:09 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F128194EAC467;
        Thu,  2 Aug 2018 20:25:06 +0800 (CST)
Received: from [127.0.0.1] (10.57.77.109) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Thu, 2 Aug 2018
 20:24:59 +0800
Subject: Re: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801165644.GA3820@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
 <20180802111000.4649d9ed@alans-desktop>
CC:     Jerome Glisse <jglisse@redhat.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        "Hao Fang" <fanghao11@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        "David S . Miller" <davem@davemloft.net>,
        "\"linux-accelerators@lists.ozlabs.org\\\" " 
        <linux-accelerators@lists.ozlabs.org>
From:   Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <5B62F807.8030407@huawei.com>
Date:   Thu, 2 Aug 2018 20:24:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20180802111000.4649d9ed@alans-desktop>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.77.109]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/8/2 18:10, Alan Cox wrote:
>> One motivation I guess, is that most accelerators lack of a
>> well-abstracted high level APIs similar to GPU side (e.g. OpenCL
>> clearly defines Shared Virtual Memory models). VFIO mdev
>> might be an alternative common interface to enable SVA usages
>> on various accelerators...
> SVA is not IMHO the hard bit from a user level API perspective. The hard
> bit is describing what you have and enumerating the contents of the device
> especially when those can be quite dynamic and in the FPGA case can
> change on the fly.
>
> Right now we've got
> - FPGA manager
> - Google's recently posted ASIC patches
> - WarpDrive
>
> all trying to be bits of the same thing, and really there needs to be a
> single solution that handles all of this stuff properly.
>
> If we are going to have any kind of general purpose accelerator API then
> it has to be able to implement things like
>
> 	'find me an accelerator with function X that is nearest my memory'
> 	'find me accelerator functions X and Y that share HBM'
> 	'find me accelerator functions X and Y than can be chained'
>
> If instead we have three API's depending upon whose accelerator you are
> using and whether it's FPGA or ASIC this is going to be a mess on a grand
> scale.
>
Agree, at the beginning, we try to bring a notion of 'capability' which 
describes 'algorithms, mem access methods .etc ',
but then, we come to realize it is the first thing that we should come 
to a single solution on these things such as
memory/device access, IOMMU .etc.

Thanks,
Zaibo

>
> .
>


