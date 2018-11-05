Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246DDC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E571920854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E571920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbeKEVeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:34:06 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42402 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbeKEVeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:34:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F44B80D;
        Mon,  5 Nov 2018 04:14:39 -0800 (PST)
Received: from [10.1.215.12] (unknown [10.1.215.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE36E3F5BD;
        Mon,  5 Nov 2018 04:14:37 -0800 (PST)
Subject: Re: [PATCH 0/7] arm64: capabilities: Optimize checking and enabling
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <0ea1330a-685c-b7b3-1424-1cc521a672e8@arm.com>
Date:   Mon, 5 Nov 2018 12:14:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 05/11/18 11:55, Suzuki K Poulose wrote:
> We maintain two separate tables (i.e, arm64_features and arm64_errata) of
> struct arm64_cpu_capabilities which decide the capabilities of the system.
> We iterate over the two tables for detecting/verifying/enabling the capabilities.
> e.g, this_cpu_has_cap() needs to iterate over the two tables one by one to
> find the "capability" structure corresponding to the cap number and then
> check it on the CPU.
> 
> Also, we enable all the non-boot scoped capabilities after all the SMP cpus
> are brought up by the kernel, using stop_machine() for each available
> capability. We could batch all the "enabling" activity to a single
> stop_machine() callback. But that implies you need a way to map
> a given capability number to the corresponding capability entry
> to finish the operation quickly.
> 
> So we need a quicker way to access the entry for a given capability.
> We have two choices :
> 
>  1) Unify both the tables to a static/dynamic sorted entry based on
>     the capability number. This has the following drawbacks :
>      a) The entries must be unique. i.e, no duplicate entries for a
>         capability.
>      b) Looses the separation of "features" vs. "errata" classification
>      c) Statically sorting the list is error prone. Runtime sorting the
>         array means more time for booting.
> 
>  2) Keep an array of pointers to the capability sorted at boot time
>     based on the capability.
>      a) As for (1), the entries must be unique for a capability.
> 
> This series implements (2) and uses the new list for optimizing the
> operations on the entries. As a prepatory step, we remove the
> duplicate entries for the same capabilities (Patch 1-3).
> 

Thanks a lot for getting it sorted out! In case it'd help:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>

Cheers
Vladimir

> 
> Suzuki K Poulose (7):
>   arm64: capabilities: Merge entries for ARM64_WORKAROUND_CLEAN_CACHE
>   arm64: capabilities: Merge duplicate Cavium erratum entries
>   arm64: capabilities: Merge duplicate entries for Qualcomm erratum 1003
>   arm64: capabilities: Speed up capability lookup
>   arm64: capabilities: Optimize this_cpu_has_cap
>   arm64: capabilities: Use linear array for detection and verification
>   arm64: capabilities: Batch cpu_enable callbacks
> 
>  arch/arm64/include/asm/cpufeature.h |   3 +
>  arch/arm64/include/asm/cputype.h    |   2 +
>  arch/arm64/kernel/cpu_errata.c      |  94 ++++++++++----------
>  arch/arm64/kernel/cpufeature.c      | 165 ++++++++++++++++++++----------------
>  4 files changed, 145 insertions(+), 119 deletions(-)
> 

