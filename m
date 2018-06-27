Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A95C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B67B25A52
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnZaD8tY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B67B25A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965835AbeF0SW0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:22:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965251AbeF0SWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:22:24 -0400
Received: from localhost (unknown [5.29.173.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C6CB25A52;
        Wed, 27 Jun 2018 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530123744;
        bh=tf1+l1+Pjc2YnpOhYKf8kixKjZcph9LF/BjczvBOVTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CnZaD8tYdbtvidxR5IPh59emH+WOTgDMWf5lSD8nyHr740vmUGlhtpp/BdKVQMJDj
         WVPOypP7USu6DRb0ZChYgRWkEKbyjysAUhKhxQXVIVXpaV+aIyfjyTOTJseWbSq71n
         BIPDY1aGEJA23rW598jM8YQCkuiZ2QOlcCS/xqwA=
Date:   Wed, 27 Jun 2018 21:22:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Doug Ledford <dledford@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Hadar Hen Zion <hadarh@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Michael J Ruhl <michael.j.ruhl@intel.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Raed Salem <raeds@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 08/12] overflow.h: Add arithmetic shift helper
Message-ID: <20180627182220.GV30877@mtr-leonro.mtl.com>
References: <20180624082353.16138-1-leon@kernel.org>
 <20180624082353.16138-9-leon@kernel.org>
 <CAKwiHFhgsyWYD+q+JFb2HJEphnjiiOp=o4Airv3MW031q2jx8w@mail.gmail.com>
 <20180625171157.GE5356@mellanox.com>
 <CAKwiHFiRYbyiJqDYCgKXKZYRr0KjCt8q9AwKwfqoCA1sT2KFyQ@mail.gmail.com>
 <20180626175435.GQ5356@mellanox.com>
 <CAKwiHFgchr+6HYOZ4e4e1vzL9cFabe6eonNNM8NTWZypazcuKA@mail.gmail.com>
 <20180627181012.GM20754@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627181012.GM20754@mellanox.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 12:10:12PM -0600, Jason Gunthorpe wrote:
> On Wed, Jun 27, 2018 at 11:36:03AM +0200, Rasmus Villemoes wrote:
> >    OK. The requirement of everything having the same type for the
> >    check_*_overflow when gccs builtins are not available was mostly a
> >    consequence of my inability to implement completely type-generic
> >    versions (but also to enforce some sanity, so people don't do
> >    check_add_overflow( s8, size_t, int*)). There's no gcc builtin for
> >    shift, but if it's relatively simple to one allowing a and *d to have
> >    different types, then why not. It's of course particularly convenient
> >    to allow a bare "1" (i.e. int) as a while having *d have some random
> >    type.
>
> Yes
>
> >    Wouldn't check_shift_overflow(-1, 4, &someint) just put -16 in someint
> >    and report no overflow? That's what I'd expect, if negative values are
> >    to be supported at all.
>
> I would say that is not a desired outcome, bitshift is defined on
> bits, if the caller wanted something defined as signed multiply they
> should use multiply.
>
> IMHO, nobody writes 'a << b' expecting sign preservation..
>
> >    Well, the types you can check at compile-time, the values not, so you
> >    still have to define the result, i.e. contents of *d, for negative
> >    values (even if we decide that "overflow" should always be signalled in
> >    that case).
>
> Why do a need to define a 'result' beyond whatever the not-undefined
> behavior shift expression produces?
>
> >      What about more like this?
> >                check_shift_overflow(a, s, d) ({
> >                    // Shift is always performed on the machine's largest
> >      unsigned
> >                    u64 _a = a;
> >                    typeof(s) _s = s;
> >                    typeof(d) _d = d;
> >                    // Make s safe against UB
> >                    unsigned int _to_shift = _s >= 0 && _s < 8*sizeof(*d) : _s ? 0;
> >                    *_d = (_a << _to_shift);
> >                     // s is malformed
> >                    (_to_shift != _s ||
> >                     // d is a signed type and became negative
> >                     *_d < 0 ||
> >                     // a is a signed type and was negative
> >                     _a < 0 ||
> >                     // Not invertable means a was truncated during
> >      shifting
> >                     (*_d >> _to_shift) != a))
> >                })
> >      I'm not seeing a UB with this?
> >
> >    Something like that might work, but you're not there yet. In
> >    particular, your test for whether a is negative is thwarted by using
> >    u64 for _a and testing _a < 0...
>
> Oops, yes that was intended to be 'a', and of course we need to
> capture it..
>
> Leon? Seems like agreement, Can you work with this version?

Yes, sure, I waited for an agreement.

>
> #include <stdint.h>
> #include <stdbool.h>
> #include <assert.h>
>
> #define u64 uint64_t
>
> /*
>  * Compute *d = (a << s)
>  *
>  * Returns true if '*d' cannot hold the result or 'a << s' doesn't make sense.
>  * - 'a << s' causes bits to be lost when stored in d
>  * - 's' is garbage (eg negative) or so large that a << s is guarenteed to be 0
>  * - 'a' is negative
>  * - 'a << s' sets the sign bit, if any, in '*d'
>  * *d is not defined if false is returned.
>  */
> #define check_shift_overflow(a, s, d)                                          \
> 	({                                                                     \
> 		typeof(a) _a = a;                                              \
> 		typeof(s) _s = s;                                              \
> 		typeof(d) _d = d;                                              \
> 		u64 _a_full = _a;                                              \
> 		unsigned int _to_shift =                                       \
> 			_s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;               \
>                                                                                \
> 		*_d = (_a_full << _to_shift);                                  \
>                                                                                \
> 		(_to_shift != _s || *_d < 0 || _a < 0 ||                       \
> 		 (*_d >> _to_shift) != a);                                     \
> 	})
>
> int main(int argc, const char *argv[])
> {
> 	int32_t s32;
> 	uint32_t u32;
>
> 	assert(check_shift_overflow(1, 0, &s32) == false && s32 == (1 << 0));
> 	assert(check_shift_overflow(1, 1, &s32) == false && s32 == (1 << 1));
> 	assert(check_shift_overflow(1, 30, &s32) == false && s32 == (1 << 30));
> 	assert(check_shift_overflow(1, 31, &s32) == true);
> 	assert(check_shift_overflow(1, 32, &s32) == true);
> 	assert(check_shift_overflow(-1, 1, &s32) == true);
> 	assert(check_shift_overflow(-1, 0, &s32) == true);
>
> 	assert(check_shift_overflow(1, 0, &u32) == false && u32 == (1 << 0));
> 	assert(check_shift_overflow(1, 1, &u32) == false && u32 == (1 << 1));
> 	assert(check_shift_overflow(1, 30, &u32) == false && u32 == (1 << 30));
> 	assert(check_shift_overflow(1, 31, &u32) == false && u32 == (1UL << 31));
> 	assert(check_shift_overflow(1, 32, &u32) == true);
> 	assert(check_shift_overflow(-1, 1, &u32) == true);
> 	assert(check_shift_overflow(-1, 0, &u32) == true);
>
> 	assert(check_shift_overflow(0xFFFFFFFF, 0, &u32) == false && u32 == (0xFFFFFFFFUL << 0));
> 	assert(check_shift_overflow(0xFFFFFFFF, 1, &u32) == true);
> 	assert(check_shift_overflow(0xFFFFFFFF, 0, &s32) == true);
> 	assert(check_shift_overflow(0xFFFFFFFF, 1, &s32) == true);
> }
>
> Thanks,
> Jason
