Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC06ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 02:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7056F2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 02:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z9aqTdax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7056F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeGNDP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 23:15:58 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40054 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731422AbeGNDP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 23:15:58 -0400
Received: by mail-io0-f196.google.com with SMTP id l14-v6so23007111iob.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIyp2qrK0Y3Ul1Av0RMnNgWR0nKZD2gx5DitEMTvRGg=;
        b=Z9aqTdaxBcbLfVYXvoqCpo2o+wFBo11+E6GKIOchw/RY1+Q77kj5aMT4wLgIt2CBzc
         gZaS1CqKE7LXBERZk3uIBqNyrkpyzr+TeC+EFkQwNuZI5TIscaE1xwE9HdyRmDqM8/hM
         WIUJXlKAivBe3y6alDCNScTd6CN7qyZMDDsF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIyp2qrK0Y3Ul1Av0RMnNgWR0nKZD2gx5DitEMTvRGg=;
        b=kvEwivSAMIF/Yovi82MZ146PtMN05CqbgUNOktUhRLmJnPvY3xv7jvPzMbP+WWh1Vj
         X03tkSu9cLIF/CeyMJjPsGJx8wlyibyrAXK1FYo9YupH0GxLKGNzaGKzYJ/J+Fzs0847
         dB+NKS0TxZb6N37CqOBH11qtocxLjyvr0UvNePBC7rsxvvkTZO7a/RkTJI/exbyppBJA
         4g+ldcR2iq2SocZZRJIPprhMcP4+WvyV+MG7hsMimOoM2Cpos7NhDi2NDLo8EueJH20q
         BeARWM6/hJcuS5vWT2WTluwadXOByVkXjzAihy4QY0XZVGNjnqrxZV7thxxRPZjJ512v
         s42Q==
X-Gm-Message-State: APt69E2sd/Azo3gtW84l0hMyabsOZBCcoaZL6n3HwLcghDHzR17P14Dw
        qt/OMRkVGcbTyN1JHq1ANB4LFgwNbQfP+C1Fd0c=
X-Google-Smtp-Source: AAOMgpcb8MkiFQ1VaMf1EffsU44Yke6ttqpx4omx28455uGk3uk4v84k6UfeZaYwEx7fStoWBPYQphDZXdafD69lMV8=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr18383510iom.238.1531537116949;
 Fri, 13 Jul 2018 19:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180713190638.GA4269@andrea> <Pine.LNX.4.44L0.1807132133330.26947-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1807132133330.26947-100000@netrider.rowland.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Jul 2018 19:58:25 -0700
Message-ID: <CA+55aFwKpkU5C23OYt1HCiD3X5bJHVh1jz5G2dSnF1+kVrOCTA@mail.gmail.com>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 6:51 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> The point being that the scenarios under discussion in this thread all
> fall most definitely into the "Non-standard usage; you'd better know
> exactly what you're doing" category.

Well, yes and no.

The thing is, people expected unlock+lock to give a memory ordering.
It happened in RCU, and it's happened before elsewhere.

So it *is* the "pure locking" thing that ends up confusing people.
Yes, you have some other access that then cares about the memory
ordering, but this is a fairly natural expectation to have
(considering that we've had the same issue before).

              Linus
