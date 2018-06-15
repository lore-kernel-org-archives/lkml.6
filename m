Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5202C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F852088E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="uD6Jcl5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F852088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966432AbeFOUbd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:31:33 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:44475 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966118AbeFOUbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:31:32 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a3f163a9
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Jun 2018 20:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=HoGTEwbpksKQ9h0pJZ+rOAhPRbo=; b=uD6Jcl
        5vNug1MvsgmafPyjhafHqI83++nxpojWdWPP725oMBEGgEOhQOzX6upVAwI24gW6
        UKn84BIr7+3XlECur3SMSySB5ZHyZYwDvsw6nujpJITgUy7pX21ajcuc6LWCsqHr
        THUAj3Srxjlq2+NYvMuHzYbQD9baPayUPYBvwJnyPjv8Rec0DvRght4gTQVNnfKI
        p1jHffyROwvzSbtRbGyXpzmCMtPgJzrTpJvaF0LBrHZJdBtyP4K/EnFI6fe7D2XJ
        Y81YWZHQxGSfMktGGOcxxjyJdj17lCDv3S11dqJW3IQ7fMbgop2DTeduGs1tQl2z
        7lds8rylvOt4IKsA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2bb6e365 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Jun 2018 20:26:07 +0000 (UTC)
Received: by mail-ot0-f169.google.com with SMTP id 92-v6so12350894otw.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 13:31:31 -0700 (PDT)
X-Gm-Message-State: APt69E21nZeixgUaodKui6kuEYmTsyTReWar6oS/JZ2EZOqBAlWLhrTz
        G5i591KSEZh6my4POUUxgdsThiIHyVty1L+NNMg=
X-Google-Smtp-Source: ADUXVKLxsUCE5/d75m7Pjf0WzMziR4cXfmzgSJF4o8gh+Q0i4PWTlNqmgbm1s3iIhKC6pYAB9/k/kjgf+kzuHUSyGJs=
X-Received: by 2002:a9d:350a:: with SMTP id o10-v6mr1875799otc.247.1529094689666;
 Fri, 15 Jun 2018 13:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
 <alpine.DEB.2.21.1806151815080.1582@nanos.tec.linutronix.de> <20180615193438.GE2458@hirez.programming.kicks-ass.net>
In-Reply-To: <20180615193438.GE2458@hirez.programming.kicks-ass.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 15 Jun 2018 22:30:46 +0200
X-Gmail-Original-Message-ID: <CAHmME9qr4PzsGKK2r2sGoCty_Yum_3UqUdL76CPOAOq18K+a4A@mail.gmail.com>
Message-ID: <CAHmME9qr4PzsGKK2r2sGoCty_Yum_3UqUdL76CPOAOq18K+a4A@mail.gmail.com>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 9:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> Didn't we recently do a bunch of crypto patches to help with this?
>
> I think they had the pattern:
>
>         kernel_fpu_begin();
>         for (units-of-work) {
>                 do_unit_of_work();
>                 if (need_resched()) {
>                         kernel_fpu_end();
>                         cond_resched();
>                         kernel_fpu_begin();
>                 }
>         }
>         kernel_fpu_end();

Right, so that's the thing -- this is an optimization easily available
to individual crypto primitives. But I'm interested in applying this
kind of optimization to an entire queue of, say, tiny packets, where
each packet is processed individually. Or, to a cryptographic
construction, where several different primitives are used, such that
it'd be meaningful not to have to get the performance hit of
end()begin() in between each and everyone of them.
