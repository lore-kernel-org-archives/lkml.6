Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3867C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C023204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bYNxDG2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C023204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeKBHMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:12:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34558 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeKBHMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:12:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id n26-v6so20741lfl.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rT6gI7BrNi009KxaSg3ZD2FAM0Z+ST+3A4bR2b2INR8=;
        b=bYNxDG2oLMRhRuKZl8oR52RQxfXzW2v7y9mL2JvDla7HnMyXsm1Gh96hYsSu7gf29n
         4SwkB8X9Y9Wy27vsH6ePlvo4ECMwlKlFrzFU7WXQPzy0qxvP8kWRP5tUy0A6F1sODaxs
         S3YqvFNf0YNTAKcTNzZ2U12do+Qgj3YDztcjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rT6gI7BrNi009KxaSg3ZD2FAM0Z+ST+3A4bR2b2INR8=;
        b=itDd0h/bZiQTSD0DGgxMx8sKHyvkoyM4tLGSLfZ+3ow8kADy087y49BZ6AfqmxJ7aU
         HzlKtIMAeejBdQrGlrIMiVHXdyf07CqBhfc+Bbwhx1XyrZtVpN90hJNmXVu3pV5AZ5q2
         rb4VKO8tcU6FNjLEsT0MiW6cz2iQHsze3I7xhp8WMr7rlYut9Nt0+I6ekBZvRpshjtu8
         qsNdz4qrDnCY+CZyC9YmXs87qym3l7ZkWjaCVDUiJ9Lf645NltQBLPF5Q3RNislsGLfn
         tckwAfdEbfGYir/ilRq4soCzzL09GJ6Cj4BkqL6CKX1uerEyZvh27Q4GwQqHKVqa5/qA
         SX8Q==
X-Gm-Message-State: AGRZ1gK47ZZxXPNR2s+L42cb6OZIltMNOhB/gPPdP9PBysURzQhg3ECZ
        fq6WO+ymdiFeq+o9x95Y+V/VrHf7O0PFcw==
X-Google-Smtp-Source: AJdET5caiT0YryXFJUyuyKtUaCEUoXBXfw/NiH7D3W2FaP5A8qHcJVGNtG92QVAc1BCaIz8v51NTeQ==
X-Received: by 2002:a19:5a84:: with SMTP id y4mr5601496lfk.156.1541110035044;
        Thu, 01 Nov 2018 15:07:15 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 10-v6sm95457ljv.6.2018.11.01.15.07.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 15:07:14 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id t22-v6so761lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 15:07:14 -0700 (PDT)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr6518668ljj.6.1541109649937;
 Thu, 01 Nov 2018 15:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181101095844.24462-1-mathieu.desnoyers@efficios.com>
 <20181101095844.24462-4-mathieu.desnoyers@efficios.com> <alpine.DEB.2.21.1811011320160.1642@nanos.tec.linutronix.de>
 <20181101144623.61d43102@gandalf.local.home> <278477314.3995.1541102273591.JavaMail.zimbra@efficios.com>
In-Reply-To: <278477314.3995.1541102273591.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 15:00:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOm8x5KnBQH+FYN76sSjCeP2_9cxgzu4WArR3jP0MD8g@mail.gmail.com>
Message-ID: <CAHk-=wiOm8x5KnBQH+FYN76sSjCeP2_9cxgzu4WArR3jP0MD8g@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.21 03/16] mm: Replace BUG_ON() by WARN_ON() in vm_unmap_ram()
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        boqun.feng@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, luto@amacapital.net, davejwatson@fb.com,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux@arm.linux.org.uk, Ingo Molnar <mingo@redhat.com>,
        Peter Anvin <hpa@zytor.com>, andi@firstfloor.org,
        Christoph Lameter <cl@linux.com>, bmaurer@fb.com,
        josh@joshtriplett.org, Catalin Marinas <catalin.marinas@arm.com>,
        will.deacon@arm.com,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        mawilcox@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 12:57 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> > I think the graceful recovery is to simply return:
> >
> >       if (WARN_ON(cond))
> >               return;
> >
> > is better than just
> >
> >       BUG_ON(cond);
> >
> > As that's what Linus made pretty clear at the Maintainer's Summit.
>
> That's it. For an unmap function, this basically boils down to
> print a warning and leak the memory on internal unmap error.
>
> I will update the commit message describing this behavior.

It might be even better to use WARN_ON_ONCE().

If it's a "this shouldn't happen" situation, the advantage of
WARN_ON_ONCE() is that it will still show the backtrace of the "how
the heck did it happen after all" situation, but if it turns ouit to
be user-triggerable (or simply triggerable by some odd hw situation),
it won't spam your logs forever.

Obviously, things like rate limiting etc can also be good ideas, but
that's just overkill for "this really should never happen" cases.

(Side note: WARN_ON_ONCE() will _warn_ just once, but will always
return the condition that it warns for, so the return value is _not_
"I have warned", but "I have seen the condition that I should warn
about". Just in case people are worried about it).

                  Linus
