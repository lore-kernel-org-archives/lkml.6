Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EFFC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778FA21A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gotplt.org header.i=@gotplt.org header.b="cGH7EUrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778FA21A03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbeHFN2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:28:09 -0400
Received: from sub5.mail.dreamhost.com ([208.113.200.129]:43506 "EHLO
        homiemail-a52.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbeHFN2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:28:09 -0400
Received: from homiemail-a52.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a52.g.dreamhost.com (Postfix) with ESMTP id A4A806004114;
        Mon,  6 Aug 2018 04:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=gotplt.org; h=subject:to
        :cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=gotplt.org; bh=LLV/Og
        JNdFfTphNDzrkqiL8SjW8=; b=cGH7EUrlrSsjD7VwFEjcqV8vBiMF6wpB1/khQk
        7NWJ6D1ccqLq75aanF3KgDYuFYGvl4gnm6elAdn7l5NFtu50ZQGrRxdHRlmdLusH
        7bHxjDGo0H35TlB+I7VqX+Yt/wMa1uPL047KZgx49ySUZjUe0KdLMfhrPBlw3lzu
        bc4BM=
Received: from [192.168.0.48] (unknown [202.189.238.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by homiemail-a52.g.dreamhost.com (Postfix) with ESMTPSA id A1F4E600410B;
        Mon,  6 Aug 2018 04:19:28 -0700 (PDT)
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Andrew Pinski <pinskia@gmail.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
 <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
 <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com>
 <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_y6La77sWOSROrwfRy65jrFVYVvRZt+ewNheYhdhHCkQ@mail.gmail.com>
 <alpine.LRH.2.02.1808060626060.2986@file01.intranet.prod.int.rdu2.redhat.com>
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
Message-ID: <df77857e-1674-38ea-2337-366182afb41e@gotplt.org>
Date:   Mon, 6 Aug 2018 16:49:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1808060626060.2986@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 04:01 PM, Mikulas Patocka wrote:
> I think there are three possible solutions:
> 
> 1. provide an alternative memcpy implementation that doesn't do unaligned
> accesses and recompile the graphics software with -mstrict-align

Given that there's already a tunable glibc.cpu.cached_memopt for powerpc 
that (as Tulio clarified elsewhere) essentially does the same thing for 
cache-inhibited memory, it wouldn't be too much of an overhead to put in 
another ifunc implementation that gets chosen only when one sets this 
tunable.  In fact, we could reuse the C string routines for this to 
avoid adding yet another assembly implementation to have to support. 
That way we can minimally fix the issue at hand without regressing 
existing uses.

You can then set the glibc.cpu.cached_memopt tunable in the default 
environment for your board[1] or for applications that need it (e.g. 
whenever DISPLAY is exported or something like that).

The only difference from Power would be that cpu.noncached==0 for Power 
by default whereas for aarch64 it will be the other way around.  It 
shouldn't be too hard to enhance the framework to set platform-specific 
defaults.

Siddhesh

[1] Or if you're feeling particularly generous, help us implement 
systemwide tunables since you have an actual use case for it :)
