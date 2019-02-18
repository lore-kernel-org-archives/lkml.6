Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3842C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D702184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfBRAtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 19:49:25 -0500
Received: from ozlabs.org ([203.11.71.1]:36451 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfBRAtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 19:49:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442lcd2whwz9s7h;
        Mon, 18 Feb 2019 11:49:21 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        erhard_f@mailbox.org, jack@suse.cz, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due to pgd/pud_present()
In-Reply-To: <20190217215556.GH31125@350D>
References: <20190214062339.7139-1-mpe@ellerman.id.au> <20190216105511.GA31125@350D> <20190216142206.GE14180@gate.crashing.org> <20190217062333.GC31125@350D> <87ef86dd9v.fsf@concordia.ellerman.id.au> <20190217215556.GH31125@350D>
Date:   Mon, 18 Feb 2019 11:49:18 +1100
Message-ID: <87imxhrkdt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <bsingharora@gmail.com> writes:
> On Sun, Feb 17, 2019 at 07:34:20PM +1100, Michael Ellerman wrote:
>> Balbir Singh <bsingharora@gmail.com> writes:
>> > On Sat, Feb 16, 2019 at 08:22:12AM -0600, Segher Boessenkool wrote:
>> >> On Sat, Feb 16, 2019 at 09:55:11PM +1100, Balbir Singh wrote:
>> >> > On Thu, Feb 14, 2019 at 05:23:39PM +1100, Michael Ellerman wrote:
>> >> > > In v4.20 we changed our pgd/pud_present() to check for _PAGE_PRESENT
>> >> > > rather than just checking that the value is non-zero, e.g.:
>> >> > > 
>> >> > >   static inline int pgd_present(pgd_t pgd)
>> >> > >   {
>> >> > >  -       return !pgd_none(pgd);
>> >> > >  +       return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
>> >> > >   }
>> >> > > 
>> >> > > Unfortunately this is broken on big endian, as the result of the
>> >> > > bitwise && is truncated to int, which is always zero because
>> >> 
>> >> (Bitwise "&" of course).
>> >> 
>> >> > Not sure why that should happen, why is the result an int? What
>> >> > causes the casting of pgd_t & be64 to be truncated to an int.
>> >> 
>> >> Yes, it's not obvious as written...  It's simply that the return type of
>> >> pgd_present is int.  So it is truncated _after_ the bitwise and.
>> >>
>> >
>> > Thanks, I am surprised the compiler does not complain about the truncation
>> > of bits. I wonder if we are missing -Wconversion
>> 
>> Good luck with that :)
>> 
>> What I should start doing is building with it enabled and then comparing
>> the output before and after commits to make sure we're not introducing
>> new cases.
>
> Fair enough, my point was that the compiler can help out. I'll see what
> -Wconversion finds on my local build :)

I get about 43MB of warnings here :)

cheers
