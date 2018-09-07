Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE06C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E21820652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E21820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIGWiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:38:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35396 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbeIGWiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:38:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED43318A;
        Fri,  7 Sep 2018 10:56:01 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.Emea.Arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2C013F5BC;
        Fri,  7 Sep 2018 10:55:58 -0700 (PDT)
Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
To:     Jerome Glisse <jglisse@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>
Cc:     Kenneth Lee <nek.in.cn@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, kvm@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Hao Fang <fanghao11@huawei.com>, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, iommu@lists.linux-foundation.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-accelerators@lists.ozlabs.org
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
 <20180904150019.GA4024@redhat.com> <20180904101509.62314b67@t450s.home>
 <20180906094532.GG230707@Turing-Arch-b> <20180906133133.GA3830@redhat.com>
 <20180907040138.GI230707@Turing-Arch-b> <20180907165303.GA3519@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <404f0944-d514-b450-f743-89ae798ac694@arm.com>
Date:   Fri, 7 Sep 2018 18:55:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180907165303.GA3519@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 17:53, Jerome Glisse wrote:
> So there is no reasons to do that under VFIO. Especialy as in your example
> it is not a real user space device driver, the userspace portion only knows
> about writting command into command buffer AFAICT.
> 
> VFIO is for real userspace driver where interrupt, configurations, ... ie
> all the driver is handled in userspace. This means that the userspace have
> to be trusted as it could program the device to do DMA to anywhere (if
> IOMMU is disabled at boot which is still the default configuration in the
> kernel).

If the IOMMU is disabled (not exactly a kernel default by the way, I
think most IOMMU drivers enable it by default), your userspace driver
can't bypass DMA isolation by accident. It just won't be allowed to
access the device. VFIO requires an IOMMU unless the admin forces the
NOIOMMU mode with the "enable_unsafe_noiommu_mode" module parameter, and
the userspace explicitly asks for it with VFIO_NOIOMMU_IOMMU, which
taints the kernel. Not for production. A normal userspace driver that
uses VFIO can only do DMA to its own memory.

Thanks,
Jean
