Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A16C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CE32098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="N2gi5ZnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CE32098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJMJqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:46:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36346 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeJMJqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:46:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id l81-v6so7046083pfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 19:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6XZWKP2pbysVG8F4WKX4YkunFpUXVJoneS2qWT0rIgM=;
        b=N2gi5ZnNq30pQxOnEBYq6zdh6G0ns+SI6AVZkhimNQGD9yQOm5UYR6JGFwS2BUFCIW
         FauhTl3Q+WSZVHehFg8SNEE/bWYFsI9CNtDr8BWvee6Gq8YU62TJwxNiZpLSShCoUVdR
         L56i07BfoCPIOURgBXyQvQokxNKgq+N+jyEKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6XZWKP2pbysVG8F4WKX4YkunFpUXVJoneS2qWT0rIgM=;
        b=riiJ2CDuVEUWNwtsneifJVdbGTUJ69x38xvkU/mozGimUX0tAzvar/WMi5XSTSgq8u
         rZfpQjHlriv0sXUCtW+HNaejWteMHiUDU1A6YpE+iF0wRBAnjt/4hu6UdVr0uy+1Niu2
         6LIUWxeeIxRSXIQbL57mUXrcYMK0ZD8X6CcIrtpXCj8/1gddpuUbwBRnNzRzVT/q8Rkm
         SwvVAeWaVA7Ksvjalq/lonFvYSh8uOpd4riDw9sbY5rP1K1SNNIBGkDHX1fTtKKDvne+
         h8odN8zlcz4Bga8qHAf+yxGJQL1OBGMPEb3YYcK189pZwAm49XMmmHfqDfwvT/QOI8xq
         0xTQ==
X-Gm-Message-State: ABuFfoiApGcEZv0ngUrGwRkvclorLto7TU6Z1ZYwGlVIEwYATohbuZT7
        tILWE22vMUeFqLZvM+lTi5pzPA==
X-Google-Smtp-Source: ACcGV63F+9SrXFCpEUHB+XptA5Iqqus34UkUro+5Ai/GVN+L0Yg6ILmrGMV/JAu7RXyjGdEg/oMq4Q==
X-Received: by 2002:a65:5147:: with SMTP id g7-v6mr7890713pgq.252.1539396659739;
        Fri, 12 Oct 2018 19:10:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id b29-v6sm4669490pfj.183.2018.10.12.19.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 19:10:58 -0700 (PDT)
Date:   Fri, 12 Oct 2018 19:10:57 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     David Miller <davem@davemloft.net>, kirill@shutemov.name,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Minchan Kim <minchan@kernel.org>,
        Ramon Pantin <pantin@google.com>, hughd@google.com,
        Lokesh Gidra <lokeshgidra@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, chris@zankel.net,
        dave.hansen@linux.intel.com, elfring@users.sourceforge.net,
        fenghua.yu@intel.com, geert@linux-m68k.org, gxt@pku.edu.cn,
        deller@gmx.de, mingo@redhat.com, jejb@parisc-linux.org,
        jdike@addtoit.com, jonas@southpole.se, Julia.Lawall@lip6.fr,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        lftan@altera.com, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm <linux-mm@kvack.org>, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, jcmvbkbc@gmail.com,
        nios2-dev@lists.rocketboards.org,
        Peter Zijlstra <peterz@infradead.org>, richard@nod.at
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181013021057.GA213522@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net>
 <20181013013540.GA207108@joelaf.mtv.corp.google.com>
 <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
 <20181013014429.GB207108@joelaf.mtv.corp.google.com>
 <CAKOZues25aaKz3_AiyfJ=r2QBd5MghgY3ky_ptg4Z8=ST4DCgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZues25aaKz3_AiyfJ=r2QBd5MghgY3ky_ptg4Z8=ST4DCgw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 06:54:33PM -0700, Daniel Colascione wrote:
> I wonder whether it makes sense to expose to userspace somehow whether
> mremap is "fast" for a particular architecture. If a feature relies on
> fast mremap, it might be better for some userland component to disable
> that feature entirely rather than blindly use mremap and end up
> performing very poorly. If we're disabling fast mremap when THP is
> enabled, the userland component can't just rely on an architecture
> switch and some kind of runtime feature detection becomes even more
> important.

I hate to point out that its forbidden to top post on LKML :-)
https://kernelnewbies.org/mailinglistguidelines
So don't that Mr. Dan! :D

But anyway, I think this runtime detection thing is not needed. THP is
actually expected to be as fast as this anyway, so if that's available then
we should already be as fast. This is for non-THP where THP cannot be enabled
and there is still room for some improvement. Most/all architectures will be
just fine with this. This flag is more of a safety-net type of thing where in
the future if there is this one or two weird architectures that don't play
well, then they can turn it off at the architecture level by not selecting
the flag. See my latest patches for the per-architecture compile-time
controls. Ideally we'd like to blanket turn it on on all, but this is just
playing it extra safe as Kirill and me were discussing on other threads.

thanks!

- Joel

