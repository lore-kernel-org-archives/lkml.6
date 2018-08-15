Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CE0C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AD32152A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lk15Sw52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AD32152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeHOVPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:15:39 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35683 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeHOVPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:15:38 -0400
Received: by mail-io0-f194.google.com with SMTP id w11-v6so1766175iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnvD6okTjKo7w0R6YkWBETy34ZHsBdXS3LvptV9sVlo=;
        b=Lk15Sw52GP1+654UYNafvbR6ILXh6A9qGNKZzOjLGOpo+/omoPGGsTG//p6b5vw1dl
         n9qvYJSAswbtrR6b/yZIhKX5o6LSaqs4WHPG8v+hcmUwYn/v/t7nfkTGCiB6PjlmQ4A8
         ZpqCcyrVZzxOpuvFqjlfSZB+HEHyp+LQn5U3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnvD6okTjKo7w0R6YkWBETy34ZHsBdXS3LvptV9sVlo=;
        b=P72UufgUtQgo3SFGTUErIcU4IgZ6mc+XEl5C39dBqwrZL/j8/p1rpfexeLrhIhNwbe
         ESGTYfqp0OyvpgIkzCHyKGGrctCIDF4s2YFnw1w1UeY9qi26fs3tdNEWgUyznlb820ef
         CrKr92ik0wyKc0rn61x+mdnwnZ5/779vKC/xqAhqtt7+Gn1GDnu5C32FuqxpVCudGiJZ
         epluSRxx55WSnGpXywIkci076VIMwQ/kvu+Wi4311Qh2DozXBsHNE4eqHM8hCCQYhApF
         s3sYG61tq4BvHWHkVBthS5lCHgAs4SzT40T1WcNlk49TwpiphywrmbyXyMXAXCCIz+6G
         iVAg==
X-Gm-Message-State: AOUpUlHCJl3fvqg9scbuS1iJQzX8fgv1DHV3U1oYydGTfRJEDXboHA9S
        a6rmy486DP2HUq2EBvqk1S5UJql5+/xltxvIo68=
X-Google-Smtp-Source: AA+uWPxOK//J3SFkEGATX9rhjhuCLe4pm9Tr/86IqknDV7AKQzuMJb8EOt4PB3iJDgJ/Tm/sEpWkE0XCCJA+9s/28mw=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr6397846ioh.259.1534357343923;
 Wed, 15 Aug 2018 11:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180815100053.13609-1-yannik@sembritzki.me> <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
 <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me> <CA+55aFz4J+B7jvxVAGkjdsDJQff46WU2oo00_HaktncFigmxmA@mail.gmail.com>
 <d152000f-28ad-d7c1-d656-a4bd46bba450@sembritzki.me>
In-Reply-To: <d152000f-28ad-d7c1-d656-a4bd46bba450@sembritzki.me>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 11:22:12 -0700
Message-ID: <CA+55aFxXzfW+85Xf5OmNCsp2YRQqN3zJT5NhobauK=yn44_xiQ@mail.gmail.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform
 keys to boot
To:     yannik@sembritzki.me
Cc:     David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 11:19 AM Yannik Sembritzki <yannik@sembritzki.me> wrote:
>
> > No, I meant that it would have to go into the proper header files, and
> > also be used by verify_pkcs7_signature() and pkcs7_preparse() etc, so
> > that you could actually grep for this, and understand what it does.
> Thanks, Linus, I'll take care of this right away.
>
> This is my first patch and I'm not familiar with the kernel; can you
> give me a quick hint which header file(s) would be the right place for
> this #define?

I think

    include/linux/verification.h

is the right point, it's where verify_pkcs7_signature() is declared
too (and "struct key" is forward-declared), so it would seem to make
most sense there.

             Linus
