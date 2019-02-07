Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F21C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F33206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfBGT0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:26:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:36472 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbfBGT0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:26:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68F3DAF29;
        Thu,  7 Feb 2019 19:26:04 +0000 (UTC)
Date:   Thu, 7 Feb 2019 11:25:55 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] MIPS/c-r4k: do no use mmap_sem for gup_fast()
Message-ID: <20190207192555.n3qtle4yqmfb2tpo@linux-r8p5>
Mail-Followup-To: Paul Burton <paul.burton@mips.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
References: <20190207053740.26915-1-dave@stgolabs.net>
 <20190207053740.26915-3-dave@stgolabs.net>
 <20190207190007.jz4rz6e6qxwazxm7@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190207190007.jz4rz6e6qxwazxm7@pburton-laptop>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Feb 2019, Paul Burton wrote:

>Hi Davidlohr,
>
>On Wed, Feb 06, 2019 at 09:37:40PM -0800, Davidlohr Bueso wrote:
>> It is well known that because the mm can internally
>> call the regular gup_unlocked if the lockless approach
>> fails and take the sem there, the caller must not hold
>> the mmap_sem already.
>>
>> Fixes: e523f289fe4d (MIPS: c-r4k: Fix sigtramp SMP call to use kmap)
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: Paul Burton <paul.burton@mips.com>
>> Cc: James Hogan <jhogan@kernel.org>
>> Cc: linux-mips@vger.kernel.org
>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>
>Thanks - this looks good, but:
>
> 1) The problem it fixes was introduced in v4.8.
>
> 2) Commit adcc81f148d7 ("MIPS: math-emu: Write-protect delay slot
>    emulation pages") actually left flush_cache_sigtramp unused, and has
>    been backported to stable kernels also as far as v4.8.
>
>Therefore this will just fix code that never gets called, and I'll go
>delete the whole thing instead.

Even better.

Thanks,
Davidlohr
