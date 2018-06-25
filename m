Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBC4C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15D82609E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MPNdxLGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15D82609E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965120AbeFYUEJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:04:09 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:57968 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965002AbeFYUEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:04:05 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CA4DE10C05A9;
        Mon, 25 Jun 2018 13:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529957044; bh=dg8ydnLOmdAGZadZYl/ZH4BA9RAN63c+rFfj1xJ5BzE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=MPNdxLGuWYf5wIr/ySiOPHeBoLJdbRoEs99g4UQKvbJxgbOM4/JIa2iR/6VyL5Cg5
         psFlLgW0PfI6Sdn+tB/aPNqCTYcqe7V4EWPY4kiZmWIHQPeIAOd+sKY0qrQnaNPe8U
         Us4DNHYFWEQTh34i8TrOI3zj6GU6X8CfInh8m66eW7Q850xZOkxw4Rw1MkWuhIauwi
         0hhqAWbpEG7eg0oIxN0riKt8mHCQPsjvy04vj+u+Pd5sIW0Xe6ayBGsLNbTkz8dw5g
         PTaYyWVyNO2uC3MvtwxV18qjRfJ2XE7HfrkTjE/PjPSJiJ9bKWnmbtF79ukcsGc2pq
         YrgwCoA9dFTEA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id B24F63FE3;
        Mon, 25 Jun 2018 13:04:04 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 25 Jun 2018 13:04:04 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 26 Jun 2018 01:34:01 +0530
Received: from [10.10.161.98] (10.10.161.98) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 26 Jun 2018 01:34:01 +0530
Subject: Re: [PATCH v2] ARC: Improve cmpxchg syscall implementation
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20180619142205.20493-1-abrodkin@synopsys.com>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 i91ThhqBJlyU6MVUa6vZNv8E
Message-ID: <bc488b10-cd54-2ef8-46d6-d6c8dc20f799@synopsys.com>
Date:   Mon, 25 Jun 2018 13:03:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619142205.20493-1-abrodkin@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.10.161.98]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 07:22 AM, Alexey Brodkin wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> arc_usr_cmpxchg syscall is supposed to be used on platforms
> that lack support of Load-Locked/Store-Conditional instructions
> in hardware. And in that case we mimic missing hardware features
> with help of kernel's sycall that "atomically" checks current
> value in memory and then if it matches caller expectation new
> value is written to that same location.
>
> What's important in the description above:
>  - Check-and-exchange must be "atomical" which means
>    preemption must be disabled during entire "transaction"
>  - Data accessed is from user-space, i.e. we're dealing
>    with virtual addresses
>
> And in current implementation we have a couple of problems:
>
> 1. We do disable preemprion around __get_user() & __put_user()
>    but that in its turn disables page fault handler.
>    That means if a pointer to user's data has no mapping in
>    the TLB we won't be able to access required data.
>    Instead software "exception handling" code from __get_user_fn()
>    will return -EFAULT.
>
> 2. What's worse if we're dealing with data from not yet allocated
>    page (think of pre-copy-on-write state) we'll successfully
>    read data but on write we'll silently return to user-space
>    with correct result (which we really read just before). That leads
>    to very strange problems in user-space app further down the line
>    because new value was never written to the destination.
>
> 3. Regardless of what went wrong we'll return from syscall
>    and user-space application will continue to execute.
>    Even if user's pointer was completely bogus.
>    In case of hardware LL/SC that app would have been killed
>    by the kernel.
>
> With that change we attempt to imrove on all 3 items above:
>
> 1. We still disable preemption around write of user's data but
>    if we happen to fail with write we're enabling preemption
>    and try to fix-up page fault so that we have a correct permission
>    for writing user's data. Then re-try again in "atomic" context.
>
> 2. If real page fault fails or even access_ok() returns false
>    we send SIGSEGV to the user-space process so if something goes
>    seriously wrong we'll know about it much earlier.
>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-arch@vger.kernel.org
> ---
>
> Changes v1 -> v2:
>
>  * Peter's almost clean-room reimplmentation with less paranoid checks
>    and direct invocation of fixup_user_fault() for in-place update of
>    write permissions.
>

I don't like the changelog - it is way too verbose and doesn't say the exact
problem we are trying to solve. How about something like below ?

----->

    ARC: Improve cmpxchg syscall implementation
   
    This is used in configs lacking hardware atomics to emulate atomic r-m-w
    for user space, implemented by disabling preemption in kernel.
   
    However there are issues in current implementation:
   
    1. Process not terminated if invalid user pointer passed:
       i.e. __get_user() failed.
   
    2. The reason for this patch was __put_user() failure not being handled,
       for COW break scenario. The zero page is initially wired up and
       read by __get_user() succeeds. However a write by __put_user()
       doesn't complete the page fault handling due to the page fault
       disabling from preempt disable. And what's worse is we silently return
       the stale zero value from __get_user() to user space. So the fix
       handles the specific case by re-enabling preemption and explicitly
       fixing up the fault and retrying the whole sequence over.

OK ?

-Vineet
