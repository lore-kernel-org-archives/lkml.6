Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFD8C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69060208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RcK0VYQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69060208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbeGGTys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 15:54:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50887 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754249AbeGGTyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 15:54:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so17647137wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 12:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gpBJCYDJFzqtJX3TLOV7ArANrDsOHqJFby7SpF5ExUE=;
        b=RcK0VYQ5KsvUhVna0w1W/G+uMu21VtuOFy4v+o51PzrkaARHgABkBGBXP1tPknsGLN
         PKe9sP7TEMHwIu58IL2ZV1JX6Ssv5w4728slmMrKc/0Eo7qqbKzN3i3Ei62Ol7r3GtuP
         5HGj4cpR00/Xf3uRiWXypk3FXI9D9ibZ6lwxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gpBJCYDJFzqtJX3TLOV7ArANrDsOHqJFby7SpF5ExUE=;
        b=Cjq7Ema7HyKw0XlmjvmlcPFGPNzp100mhdQLut+DGUe5s7VbEfn2Fe4yyrsZ3EcZr5
         yZN4L7pJ3pRpz7BYfYADeQiO7Ld79G+ugKNT0woQfgMSVZqjZBfL2xJX34TnQNAPUSKA
         67i8Txc9+QCGbgS5ainan1lHTUSmNeXMaITyuSEDoKL83NKTqIUjnMlTwZ/sb1GlW6N+
         cFSushtIeAf/kr9cdyrVIPBeVootN8P8Hv+PLrWj8YZ7NGtGK26YrHL1cFrPv8EjLWuF
         HTCcqiOGWVQlVQbEIMTEh4xz+IJPHKcv5XV/+popwzu1SfxudAApJwPZZb00eCLpuKNL
         P6RQ==
X-Gm-Message-State: APt69E2gyR0QPRcN6FTy0gu8zIZ7U63AQ37G5A2O/+UCM5wxgP+YChQz
        i7joausiesvkl4jVa6lm1q93OA==
X-Google-Smtp-Source: AAOMgpeWgXBGwXGzwRMXAGLW/VDUp8loDdwNY3P2KahrHlymeK1h86k1ipiAAG7QOS+Jkcmk9H56zw==
X-Received: by 2002:a1c:8e54:: with SMTP id q81-v6mr8545176wmd.135.1530993284907;
        Sat, 07 Jul 2018 12:54:44 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id f15-v6sm6206585wrr.10.2018.07.07.12.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 12:54:44 -0700 (PDT)
Date:   Sat, 7 Jul 2018 21:54:37 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org,
        green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180707195437.GA3225@andrea>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
 <20180706115614.GV2476@hirez.programming.kicks-ass.net>
 <20180707074209.GA32147@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707074209.GA32147@guoren>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On Sat, Jul 07, 2018 at 03:42:10PM +0800, Guo Ren wrote:
> On Fri, Jul 06, 2018 at 01:56:14PM +0200, Peter Zijlstra wrote:
> > 	CPU0			CPU1
> > 
> > 	r1 = READ_ONCE(x);	WRITE_ONCE(y, 1);
> > 	r2 = xchg(&y, 2);	smp_store_release(&x, 1);
> > 
> > must not allow: r1==1 && r2==0
> CPU1 smp_store_release could be finished before WRITE_ONCE, so r1=1 &&
> r2=0?

The emphasis is on the "must": your implementation __must__ prevent this
from happening (say, by inserting memory barriers in smp_store_release());
if your implementation allows the state (r1==1 && r2==0), then the imple-
mentation is incorrect.

I'd suggest you have a look at the Linux-kernel memory consistency model
documentation and the associated tools, starting with:

  Documentation/memory-barriers.txt
  tools/memory-model/

(and please do not hesitate to ask questions about them, if something is
 unclear).

  Andrea
