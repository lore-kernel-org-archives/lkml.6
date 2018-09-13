Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF34C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207C720882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207C720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeIMPCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:02:53 -0400
Received: from foss.arm.com ([217.140.101.70]:44962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMPCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:02:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82BE080D;
        Thu, 13 Sep 2018 02:54:09 -0700 (PDT)
Received: from [10.4.13.23] (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EBAE3F575;
        Thu, 13 Sep 2018 02:54:08 -0700 (PDT)
Subject: Re: [stable PATCH 1/2] arm64: Fix mismatched cache line size
 detection
To:     Greg KH <greg@kroah.com>
Cc:     stable@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com
References: <1536052210-11625-1-git-send-email-suzuki.poulose@arm.com>
 <20180912193816.GF21563@kroah.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <4b8db4d5-20d7-5597-7977-b8df1072ecc7@arm.com>
Date:   Thu, 13 Sep 2018 10:54:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912193816.GF21563@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 12/09/18 20:38, Greg KH wrote:
> On Tue, Sep 04, 2018 at 10:10:09AM +0100, Suzuki K Poulose wrote:
>> commit 4c4a39dd5fe2d13e2d2fa5fceb8ef95d19fc389a upstream
>>
>> If there is a mismatch in the I/D min line size, we must
>> always use the system wide safe value both in applications
>> and in the kernel, while performing cache operations. However,
>> we have been checking more bits than just the min line sizes,
>> which triggers false negatives. We may need to trap the user
>> accesses in such cases, but not necessarily patch the kernel.
>>
>> This patch fixes the check to do the right thing as advertised.
>> A new capability will be added to check mismatches in other
>> fields and ensure we trap the CTR accesses.
>>
>> Fixes: be68a8aaf925 ("arm64: cpufeature: Fix CTR_EL0 field definitions")
>> Cc: <stable@vger.kernel.org> # v4.9
> 
> Why 4.9?  be68a8aaf925 only showed up in 4.16 and was backported only to
> 4.14-stable.  Not to 4.9-stable from what I can tell.

Now when you asked this, I realise that the Fixes tags were not sufficient.

Actually this series fixes a bit more than the commit: be68a8aaf925 ("arm64: cpufeature:
Fix CTR_EL0 field definitions"). I think these patches should have :

Fixes: commit 116c81f427ff6c5 ("arm64: Work around systems with mismatched cache line sizes")

and

Enable trapping on mismatched bits in CTR for IDC/DIC, which were
added to v8.3 onwards.

Essentially these patches makes sure that we trap accesses to
CTR_EL0 when some of the fields are mismatched across CPUs, so
that the CPUs get a consistent view of the cache properties
throughout the system. It also makes sure that we put out
correct information about why we trap accesses to the CTR_EL0
accesses from the userspace.

Hope this helps. The same applies for the next patch.


Suzuki
