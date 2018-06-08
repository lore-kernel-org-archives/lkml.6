Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ziKuCMHrGlu5fQAAmS7hNA
	; Fri, 08 Jun 2018 20:49:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F0A93605A5; Fri,  8 Jun 2018 20:49:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lp5Y3P4Y"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 698D9607E4;
	Fri,  8 Jun 2018 20:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 698D9607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbeFHUs7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:48:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40454 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbeFHUs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AMvOO8LJp9cY9eQOtY5T1+5LaZ0HKdJDmvEW5xYq9lI=; b=Lp5Y3P4Ypk/ZpkBb1a2du8jdK1
        Wx1PynxKAvr6ABmsQwADnBS7f9/IaYZ5/wwT4jKQ1kEPmAKF4DIe/DPhVYQIx+ijv1Y5XMsg3ZyFe
        ef6aVIofey1l5Ouor3fWOWW50w7iMx3W3/zkJP7YX9v0Q0Z9O93NjJ+Ag7m/RFadtC5cxcsZpOBqj
        lXzkb8EOfBYAdEDVIgVXC6hko9aC4rSUtz77GSPZ5s+S97RMTc/u7id9RijHAawnnFCNxRtBamU/r
        7uFPOQ6i1EOEivh8O4afYolWxDXZx7yB51DnbMRQe45u2aw8mDPxQh28Onc7noyHCyfuHR76ZwKB3
        4fHbwIWA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fROJb-0000aq-Pf; Fri, 08 Jun 2018 20:48:56 +0000
Subject: Re: [PATCH] uapi: Make generic uapi headers compile standalone.
To: Jayant Chowdhary <jchowdhary@google.com>,
        linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, kernel-team@android.com,
        linux-kbuild@vger.kernel.org
References: <20180606231602.231326-1-jchowdhary@google.com>
 <b6b6dd56-c948-54e8-df95-3d170a3c1e7d@infradead.org>
 <fe1d69e1-1a0f-a3ea-e45f-994698d53dbd@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cf1b59ad-994b-f6ac-8e58-2b24ef346c49@infradead.org>
Date: Fri, 8 Jun 2018 13:48:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <fe1d69e1-1a0f-a3ea-e45f-994698d53dbd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 11:36 AM, Jayant Chowdhary wrote:
> Hi Randy,
> 
> On 06/07/2018 05:07 PM, Randy Dunlap wrote:
>> On 06/06/2018 04:16 PM, Jayant Chowdhary wrote:
>>> In order for static analysis tools to analyze each of the uapi headers,
>>> we need to enable them to compile stand-alone. Some uapi headers were
>>> missing dependencies which would not make them compile stand-alone in
>>> user-land. This patch adds those dependencies.
>>
>> Hi,
>>
>> Thanks for getting started on this.  I see that the kbuild robot and I were
>> still not able to do successful builds even after this patch is applied.
>> We were building different targets though.  robot was doing kernel builds
>> and I was doing a large "all-uapi" build.
>>
>> I started on my all-uapi work about 1 week ago but haven't posted anything yet,
>> but it's posted (attached) below.  It's not yet up to kernel quality yet (for a
>> Makefile), and I have made very little progress toward a successful userspace build.
>>
>> If anyone is interested, just put these 3 files in <kernel_tree>/tools/build
>> and then run:
>>
>> make ARCH=$some_arch O=build_dir headers_check
>> so that the headers will be cleaned up and installed in build_dir/usr/.
>>
>> Then run 'make -f all-uapi.mk'
>> and the userspace program with all header files found in build_dir/usr/include
>> will be built -- i.e., attempted (not successfully).
>>
>> (note: chmod +x hdr-fix-lines.pl)
>>
>>
> 
> Thank you for this. This is surely a more formal way of finding out and
> verifying problems w.r.t the uapi headers, being compiled from user-land. I do
> have one concern with this approach though: the make target 'all-uapi.o' depends
> on all-uapi.h, which includes all the uapi headers installed in <build-dir>. So
> this does make sure that when all the uapi headers are included, a user-land
> program will be able to compile fine, without adding any additional
> dependencies. However, this could be masking some cases of dependency exclusion.
> An example can be seen as follows:
> 
> Header dependency chain:
> A.h->B.h, however A.h doesn't actually include B.h
> C.h->B.h, C.h does include B.h
> 
> all-uapi.h
> #include<C.h>
> #include<A.h>
> 
> all-uapi.h will compile fine, since the inclusion of C.h before A.h satisfies
> A.h's dependency on B.h. However, if a user-land program includes just A.h, it
> will not compile without adding B.h. So the target being built successfully
> masked an issue with the uapi header, no?

Yes, good point.

> I guess it might be better to just have a Makefile which produces a target for
> each header in the set produced by 'make headers_install' and compile those,
> with a -I flag as <build-dir>/usr/include ?

Yes, that makes sense.  Should be fairly straightforward to do that.

> Also, do you think it might be better to do this work in phases ? I'm guessing
> we'll be seeing many headers to fix (especially arch specific ones). Fixing
> these separately: first the generic ones, followed by the ones for the arches,
> might be easier ?

Absolutely.  I was planning to just focus on one sub-directory of
usr/include/choose_one (and begin with a smaller one).


thanks,
-- 
~Randy
