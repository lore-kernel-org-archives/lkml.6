Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9934C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8F620645
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8F620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503909AbeKWWlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:41:31 -0500
Received: from foss.arm.com ([217.140.101.70]:42964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387885AbeKWWlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:41:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F5B33620;
        Fri, 23 Nov 2018 03:57:34 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7E163F5A0;
        Fri, 23 Nov 2018 03:57:32 -0800 (PST)
Subject: Re: Sleeping in user_access section
To:     Russell King - ARM Linux <linux@armlinux.org.uk>, hpa@zytor.com
Cc:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>
References: <3e881ee6-0ff6-b8b6-0633-3d4a7743411d@arm.com>
 <5B3B6AF9-9D8C-4577-905E-D407A5E7D0E3@zytor.com>
 <20181123105034.GQ30658@n2100.armlinux.org.uk>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <44297716-74aa-1f14-67be-3594b5244b74@arm.com>
Date:   Fri, 23 Nov 2018 11:57:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181123105034.GQ30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/18 10:50, Russell King - ARM Linux wrote:
> On Fri, Nov 23, 2018 at 01:57:12AM -0800, hpa@zytor.com wrote:
>> You should never call a sleeping function from a user_access section.
>> It is intended for very limited regions.
> 
> So, what happens if the "unsafe" user access causes a page fault that
> ends up sleeping?
> 

Thanks for pointing that out.

On the arm64 side, PAN state is saved in spsr and (if PAN feature is 
enabled in SCTLR) PAN bit gets set (disabling the user accesses). For 
software PAN we follow the same behaviour on exception entry. So upon 
exception we implicitly exit user_access mode and then re-enter it when 
returning from the exception.

On x86, the EFLAGS.AC bit is also saved upon exception and I think it is 
cleared upon exception entry so there is implicit exit from the 
user_access mode when taking exception/interrupt.

This however is just how those two architectures happen to behave and 
doesn't seem to be specified as part of the user_access API...

Which is why I'd like to clarify the semantics of user_access region wrt 
sleeping functions.

Thanks,

-- 
Julien Thierry
