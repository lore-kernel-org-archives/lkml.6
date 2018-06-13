Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 29C85C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46B4208AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rp6MbROs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46B4208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934420AbeFMBou (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:44:50 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43638 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932985AbeFMBot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:44:49 -0400
Received: by mail-io0-f194.google.com with SMTP id t6-v6so1670914iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 18:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EGq5mKaA+J/QrCSpPPJZCRPMBsK/n4KwlU/7nVN1o4=;
        b=Rp6MbROspoESa0bdW/BhWiecnxfa22BGPbKXGaAOLE4yl62ZFX42o6x2bGcLsy8x4j
         w6nmABfK7Ug9iZePWl6iN54/dpQElDSJRukbqasiL5pahunF9VIeImUEgy74wXjo0iaS
         rFvzp5M8FndRvoU13mcN/74E8k6egQ88iskx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EGq5mKaA+J/QrCSpPPJZCRPMBsK/n4KwlU/7nVN1o4=;
        b=SepIYV/O4/tTYUzRW6cUAMxS49+Xk9AP2T0zh5dsvSfNQLAP1FFN1/81jxaQyGEVNp
         wtaMN2H7B6QlLVahznwnzwDw0pVkv7cPk1oetTp2a+YaAoo7ZbWoN31R1HxgCtCYKpqp
         s20PFRwT0BcYfHbeIfI1ic9EFnGdogpD5EmHBGtj3MeETK4yWU/utnCN31OCM7hWayHs
         bZfZZA3mSjTXeuQCElxZCOHe7uJkBCHn5v3huYEd52JFxP0hu7GJGqyLf9ijaq2+8uCO
         KHZCWmjYnafxtQSaUKq4vz4PrhJUGEJ/XHA2HY19Vnc23kOYOLocbH1c9NnZM7gO2DUI
         0RXQ==
X-Gm-Message-State: APt69E3pCkZmLbKCfNodz6JG86JIltBillGCZVMWg3NLZcehIWrkFYjv
        KajUagJlmDtD0PxaBi5pk0+J1UjhBlmSiNGcFaM=
X-Google-Smtp-Source: ADUXVKJG1BSqrSdpumoDQCNly7fxm+vJ5vXoM1rr1yNvLqn39rZiqADNg9+3S12OVH+uzV6h7RXIVgKQLsfAVeqrHLc=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr3016698iov.203.1528854288822;
 Tue, 12 Jun 2018 18:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180612233552.GA25041@beast>
In-Reply-To: <20180612233552.GA25041@beast>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 18:44:37 -0700
Message-ID: <CA+55aFy9mqnJCr=6JujNvmTjGu-rm0QYrUNkmKODb0ymQU9O8Q@mail.gmail.com>
Subject: Re: [GIT PULL] overflow updates (part 2) for v4.18-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 4:36 PM Kees Cook <keescook@chromium.org> wrote:
>
> - Treewide conversions of allocators to use either 2-factor argument
>   variant when available, or array_size() and array3_size() as needed (Kees)

Ok, some of this smells just a tad too much of automation, but I've
done the pull and it's going through my build tests.

Example nonsensical conversion:

-       res = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
+       res = kcalloc(2, sizeof(struct resource), GFP_KERNEL);

which isn't _wrong_, but...

In some of the cases it turns a compile-time constant into a function
call, ie this just makes for bigger and slower code for no reason
what-so-ever.

-       ch->tx_array = vzalloc(MIC_DMA_DESC_RX_SIZE * sizeof(*ch->tx_array));
+       ch->tx_array = vzalloc(array_size(MIC_DMA_DESC_RX_SIZE,
+                                         sizeof(*ch->tx_array)));

At least in the kzalloc/kcalloc conversion it results in more legible code.

The array_size() conversions, in contrast, actually result in *LESS*
legible code, in worse code generation, and absolutely no upside for
cases like the above.

To make up for it, there's some conversions *away* from nonsensical expressions:

-       hc_name = kzalloc(sizeof(char) * (HSMMC_NAME_LEN + 1), GFP_KERNEL);
+       hc_name = kzalloc(HSMMC_NAME_LEN + 1, GFP_KERNEL);

but I _really_ think you were way too eager to move to array_size()
even when it made no sense what-so-ever.

But at least with the kcalloc()/kmalloc_array() conversions now
preferred, those crazy cases are now a minority rather than "most of
the patch makes code worse".

I am *not* looking forward to the conflicts this causes, but maybe it
won't be too bad. Fingers crossed.

              Linus
