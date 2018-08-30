Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EB4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D937920835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D9ApLnNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D937920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeH3Umt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:42:49 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39695 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeH3Umt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:42:49 -0400
Received: by mail-it0-f66.google.com with SMTP id h1-v6so3538805itj.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucplOqeJ+XhmOT6TNr3LiGK5Tq5bzVhIcCRGE64PkmE=;
        b=D9ApLnNEN5itD3H0rawacqICVeZLRA5GlFf802X5Sjg/tg+e664oYP5kuiwzcxRaoA
         09oekUcPcl4wUABOkbI03q8WnDJkY3BKQufXFRNJn09BCnsnC65curVurcZS2S0awe+E
         MrxldV2A94l5MiXJuRujK6eSwIbY84AnzgiCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucplOqeJ+XhmOT6TNr3LiGK5Tq5bzVhIcCRGE64PkmE=;
        b=eHvLCqioQZkJ4gETneQybvKutE1gyEYC88ISa35CmOjreeUOjJHBiTG5UWKQpn/AYL
         R4YAgNLxh3IiAQ+6EvGwC44koNCjbTkcuBM0oQv+ATtouJ624LBv5KxQhpGULfk3bJIP
         Ppnea2E4ZRLvciAuBV7/p6BzmZ8NFUXFUM8FP9IRi9xwiCGGU+goj31fqgWsjRFcFrQC
         Db4uClbwUdYOP4kF7Al8t9bjjlStCoK7GGaHNc+Pz8qpc1ysWycKdj4/lrbwXTAnZ7iO
         MLP/mKXXj3Hh93jKHH/a4anoWeB8YyUIh02sqUl03lVN0jB8B9kIRm5r84RKJf9lH4l7
         V04Q==
X-Gm-Message-State: APzg51BUc+cqPaKU1QCWxmNUeoaF7/DjNnvD4N1TDlJZsWEfdlO2yJX1
        RifKvI3Nw5qWm/i7ldLLKc3GeraAUOiiH3eBprg=
X-Google-Smtp-Source: ANB0VdYnwieb8aO6r2R87wkrF0RLgXZFJulOl5x9SV5TakMn1PNaOVX5E9sdtg8MkWoixUHzSJ8o8SbraUJ4lwtC0s4=
X-Received: by 2002:a24:61d2:: with SMTP id s201-v6mr2968700itc.22.1535647189808;
 Thu, 30 Aug 2018 09:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
In-Reply-To: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Aug 2018 09:39:38 -0700
Message-ID: <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
Subject: Re: [PATCH 00/12] Avoid synchronous TLB invalidation for intermediate
 page-table entries on arm64
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 9:15 AM Will Deacon <will.deacon@arm.com> wrote:
>
> It's also had a lot more testing, but has held up nicely so far on arm64.
> I haven't figured out how to merge this yet, but I'll probably end up pulling
> the core changes out onto a separate branch.

This looks fine, and I'm actually ok getting the core changes through
the arm64 branch, since this has been discussed across architectures,
and I think "whoever does the work gets to drive the car".

After all, a lot of the core changes originally came from x86 people
(pretty much all of it, historically). No reason why arm64 can't get
some of that too.

But with the glory comes the blame when something breaks ;)

                Linus
