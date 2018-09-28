Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D06C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9512172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9512172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeI1Q46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:56:58 -0400
Received: from foss.arm.com ([217.140.101.70]:46680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbeI1Q46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:56:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 528DD1596;
        Fri, 28 Sep 2018 03:33:51 -0700 (PDT)
Received: from [10.4.13.85] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E384A3F5BD;
        Fri, 28 Sep 2018 03:33:49 -0700 (PDT)
Subject: Re: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
To:     Richard Ruigrok <rruigrok@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
 <44ac1fad-8df4-4738-0f25-8a7a2de8f6df@codeaurora.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <911a666a-9f11-5c23-77a4-658afba02644@arm.com>
Date:   Fri, 28 Sep 2018 11:33:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <44ac1fad-8df4-4738-0f25-8a7a2de8f6df@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 27/09/18 22:10, Richard Ruigrok wrote:
> Hi Marc
> 
> On 9/21/2018 1:59 PM, Marc Zyngier wrote:
>> The GICv3 architecture has the remarkable feature that once LPI tables
>> have been assigned to redistributors and that LPI delivery is enabled,
>> there is no guarantee that LPIs can be turned off (and most
>> implementations do not allow it), nor can it be reprogrammed to use
>> other tables.
>>
>> This is a bit of a problem for kexec, where the secondary kernel
>> completely looses track of the previous allocations. If the secondary
>> kernel doesn't allocate the tables exactly the same way, no LPIs will
>> be delivered by the GIC (which continues to use the old tables), and
>> memory previously allocated for the pending tables will be slowly
>> corrupted, one bit at a time.
>>
>> The workaround for this is based on a series[1] by Ard Biesheuvel,
>> which adds the required infrastructure for memory reservations to be
>> passed from one kernel to another using an EFI table.
>>
>> This infrastructure is then used to register the allocation of GIC
>> tables with EFI, and allow the GIC driver to safely reuse the existing
>> programming if it detects that the tables have been correctly
>> registered. On non-EFI systems, there is not much we can do.
>>
>> This has been tested on a TX2 system both as a host and a guest. I'd
>> welcome additional testing of different HW. For convenience, I've
>> stashed a branch containing the whole thing at [2].
> I tested [2] from the 4.19-rc4 set which included this series and [1].
> Tested kexec on Centriq system with ITS support (46 core).  On-board was a MLX CX5 NIC, verified MSIs are active in /proc/interrupts.
> Prior to this we used a workaround from Shanker to reuse the same tables in the kexec'ed kernel.

Yes, I remember seeing this workaround. Hopefully we're in a better 
place now that we can guarantee that the tables are not reused.

> Let me know if further testing is needed, and thanks for adding this support.

Good to know, thanks for having tested it. I've now put this code into 
-next for some more soaking. Hopefully nothing horrible will happen ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
