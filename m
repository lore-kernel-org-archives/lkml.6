Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D972C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A19208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A19208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbeKTEaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:30:08 -0500
Received: from foss.arm.com ([217.140.101.70]:36948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730227AbeKTEaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:30:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F3EC1596;
        Mon, 19 Nov 2018 10:05:32 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D0003F5B7;
        Mon, 19 Nov 2018 10:05:31 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: Resend: How to handle the SMMU RAS Error in the kernel
To:     gengdongjiu <gengdj.1984@gmail.com>
Cc:     robin.murphy@arm.com,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        xuqiang36@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gengdongjiu <gengdongjiu@huawei.com>
References: <CAMj-D2DY_1eZUsbnqurx8j3q04Y8JKiM2CtPv+NTsswydo0TJQ@mail.gmail.com>
Message-ID: <c8a1d0e7-338b-05e1-2d52-f13223515f49@arm.com>
Date:   Mon, 19 Nov 2018 18:05:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAMj-D2DY_1eZUsbnqurx8j3q04Y8JKiM2CtPv+NTsswydo0TJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gengdongjiu,

On 17/11/2018 15:41, gengdongjiu wrote:
> In the current kernel, it only handles three kinds of error, which is
> memory error, PCIE device and ARM process. But now the SMMU already
> support the RAS, how to handle the SMMU RAS error in the kernel?

What errors are being detected here?

I don't know much about the SMMU, but I think we should start with a list of
errors that we want to handle.


Is this a v8.2 fault handling interrupt from the SMMU taken to EL3?
Or a cpu-access that was returned as external-abort? or a device access that was
told external-abort?

What do we intend to do with this error information? Does the DMA layer have
error handling we can hook this into?

Is this just another interface for memory-errors? (e.g the SMMU provides a
device/address pair and the kernel works out the physical page to run
memory_failure() on)


> I check the UEFI_SPEC_2.7, the ACPI's CPER have the IOMMU type, but it
> seems the IOMMU type only are specific to AMD’s IOMMU specification,

... and Intel VT-d. It looks like UEFI generalises all these as types of 'DMAr'.


> not have the ARM’s IOMMU section type, can we reuse this IOMMU section
> type for the ARM SMMU?

The architecture specific records for AMD? No. Even if the information was the
same, the presence of this record tells you its an AMD IOMMU, which its not.

The generic error section? Maybe.

Assuming the 'fault reason' list in Table 285 is sufficient to cover our list or
errors, we can use the 'DMAr Generic Errors' section, (N.2.11.1), to describe
the generic bits of the error ... but SMMU doesn't have an 'Architecture Type',
so we at least need to get one allocated.

We will probably need an architecture specific 'DMAr Error Section'.


I think adding the UEFI bits is probably the 'easy' bit. We should start with a
list of errors, and the error handling code. This way we know what we need to
add to the spec.



Thanks,

James
