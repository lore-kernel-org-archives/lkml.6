Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9676ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEF62083C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEF62083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbeGQNBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:01:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45842 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731242AbeGQNBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:01:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D61318A;
        Tue, 17 Jul 2018 05:29:12 -0700 (PDT)
Received: from [10.1.211.22] (e110467-lin.cambridge.arm.com [10.1.211.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C6743F5A0;
        Tue, 17 Jul 2018 05:29:10 -0700 (PDT)
Subject: Re: [PATCH] arm64: cpuinfo: Include cleartext implementer and part
 strings
To:     Olof Johansson <olof@lixom.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20180715035342.11371-1-olof@lixom.net>
 <f619f0e9-b8b4-29fb-5ad6-7f5ebc3a4da8@arm.com>
 <CAOesGMjq=d3ZPLTq5qudx+EE+XC2-zSsA1ViheTwM7fnTtJh2Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e7e272e0-a7ad-1a97-a081-acf3bfa42b6f@arm.com>
Date:   Tue, 17 Jul 2018 13:27:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOesGMjq=d3ZPLTq5qudx+EE+XC2-zSsA1ViheTwM7fnTtJh2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/18 15:34, Olof Johansson wrote:
[...]
> There's also a growing expectation of the system to behave more like
> x86, especially when it comes to trivial ways of detecting what kind
> of machine you are running on. On x86 it's been trivial to look at
> /proc/cpuinfo since it is provided by the platform there. Nobody wants
> to change their implementation from having to read a file to exec a
> program, dealing with errors, and parsing its output (sure, easier
> from scripts, but more awkward from real source).

The thing with the "be more like x86" argument is that it never actually 
stands up to scrutiny. What is proposed here (again) is for the kernel 
to decode the raw MIDR description of the *CPU core microarchitecture* 
to a human-readable string. What does the nearest Intel box say about 
its microarchitecture name?

cpu family	: 6
model		: 79

OK, I had to go and look up that that apparently implies "Broadwell", so 
the x86 kernel is in fact no more helpful in that regard than arm64.

Furthermore, telling the user that they have have 4 "Cortex-A53" cores 
vs. 4 "part: 0xd03" cores doesn't actually give them any more meaningful 
information about their *system*, because that example reflects about 
half the low-to-mid-range SoCs on the market today. What the "model 
name" on x86 describes is a specific processor SKU, of which Arm has no 
*architectural* equivalent, for reasons which should hopefully be 
obvious from the fundamental differences in the business models driving 
the respective architectures.

And yet whenever /proc/cpuinfo/ comes up, nobody ever seems to ask for 
some kind of SoC identifier in there; it's always just decoding MIDR 
into a microarchitecture name, which implies that all these people want 
is to see a string for the sake of seeing a string, regardless of how 
meaningful it actually might be (and yes, I do realise that in *some* 
cases a CPU core is essentially unique to a particular SoC, but we have 
to look at the big picture here).

In summary; when a small minority of users are complaining that oranges 
aren't apples, the sensible response is not to start debating whether to 
paint the oranges green or red.

Robin.
