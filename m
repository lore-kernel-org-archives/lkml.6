Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D236FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD6D20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GHTBlBKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD6D20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbeHALVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:21:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40008 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733265AbeHALVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qunrXgFJB0QHjCw2knp328TgJdz5iWREUIV2dVW4+/U=; b=GHTBlBKPJ/xEqIT/AJNUgSO0g
        M393e6HrkX09/8TIvBfvsW3wxnFn4lmM38yffxVHjaxlrCpnUNb68M0EVkpKHrlpLm//TjwEfKz/u
        EhaD63eNvtsQ7OOpIqUrItPImHc/l+CZJyGa7zYtCnoFBlbmu68n7uQOT0isLGzU3AsAJhglW59fS
        jSXIMeNQb7KyyRIHKIsHqbP3q8LJGeLNMbSdZ7JWHeBqeJ/fbvHQLFUv4xU1NV7t6BbDZxRXbQVu1
        OWvt6vDN4qwWllAvAyG36qAsZVP6IkbAF63Fhyaf1RHSsokSBuQypj09JJ88CJH1dBSbpZOnDAqIG
        JAxV+SrEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fknY9-0003GG-0A; Wed, 01 Aug 2018 09:36:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEA4320532359; Wed,  1 Aug 2018 11:36:03 +0200 (CEST)
Date:   Wed, 1 Aug 2018 11:36:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@mellanox.com>,
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
Message-ID: <20180801093603.GI2530@hirez.programming.kicks-ass.net>
References: <20180624082353.16138-1-leon@kernel.org>
 <20180624082353.16138-9-leon@kernel.org>
 <CAKwiHFhgsyWYD+q+JFb2HJEphnjiiOp=o4Airv3MW031q2jx8w@mail.gmail.com>
 <20180625171157.GE5356@mellanox.com>
 <CAKwiHFiRYbyiJqDYCgKXKZYRr0KjCt8q9AwKwfqoCA1sT2KFyQ@mail.gmail.com>
 <20180626175435.GQ5356@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626175435.GQ5356@mellanox.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:54:35AM -0600, Jason Gunthorpe wrote:

> What about more like this?
> 
>           check_shift_overflow(a, s, d) ({

Should that not be: check_shl_overflow() ? Just 'shift' lacks a
direction.

> 	      // Shift is always performed on the machine's largest unsigned
>               u64 _a = a;
> 	      typeof(s) _s = s;
>               typeof(d) _d = d;
> 
> 	      // Make s safe against UB
> 	      unsigned int _to_shift = _s >= 0 && _s < 8*sizeof(*d) : _s ? 0;

Should we not do a gcc-plugin or something that fixes that particular
UB? Shift acting all retarded like that is just annoying. I feel we
should eliminate UBs from the language where possible, like
-fno-strict-overflow mandates 2s complement.

>               *_d = (_a << _to_shift);
> 
> 	       // s is malformed
>               (_to_shift != _s ||

Not strictly an overflow though, just not expected behaviour.

> 	       // d is a signed type and became negative
> 	       *_d < 0 ||

Only a problem if it wasn't negative to start out with.

> 	       // a is a signed type and was negative
> 	       _a < 0 ||

Why would that be a problem? You can shift left negative values just
fine. The only problem is when you run out of sign bits.

> 	       // Not invertable means a was truncated during shifting
> 	       (*_d >> _to_shift) != a))
>           })

And I'm not exactly seeing the use case for this macro. What's the point
of a shift-left if you cannot truncate bits. I suppose it's in the name
_overflow, but still.
