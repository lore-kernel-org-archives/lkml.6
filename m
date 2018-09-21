Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F04ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B40521550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HXIlIBDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B40521550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391326AbeIVA4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:56:11 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40743 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbeIVA4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:56:11 -0400
Received: by mail-yw1-f66.google.com with SMTP id z143-v6so5601444ywa.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0kX0CW3oXMRPAKLy/XAJVTomtiZwcxdTJHbjiGSfIp8=;
        b=HXIlIBDJ+UbfrrbZz3nTBh+VAs+CYYtGFVZ7ghy0xZNFyg43SLMxiYV6ZGmAv2Q5Y0
         zvopKM1GweHi+hf3+6rhX51XTlaoJ4JYeqxnYnGAQSAY2JWhtmP9JVjYBIrWbf2z5xwe
         9YDi46ZyZKKM04iPtxuRJiI5S9T2l7nX6+z2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0kX0CW3oXMRPAKLy/XAJVTomtiZwcxdTJHbjiGSfIp8=;
        b=EbX+kfqzv1iPOkm7h4POVYNyTVTgOvzyWIzzHa7nlhUC/1pTuW8rP9piHxJLlrQI2s
         eSy3CCyrRJh6o1FGDM47Lesg0oTcZgJ/6wQH+sl7EKnsvrlUgd7e+zyDHH2Ogf8sSqJ1
         On5zQGM1lnZI18rqBUoPfT7J/jke+rM7qNHxRJF452X6qiMOjQBRcbFPc4AvCxJImX1B
         ErlAgrRSDqlCLF7lBlbZOHBAI+I+d0OcTW8dRm4R71xsRpnYirKX4tZNYs2vB6+n4LX5
         xCH56nI+zUp4/ylr58ERGytJzON9RM1/UT99VHIcHZ2UTB71lbnNu0le7KFMsPVMxuas
         jCQg==
X-Gm-Message-State: APzg51BXbe7wf/bRG3bQHORBF6WLxqrHH+XtjlHIlrGJj9Ja5/LH6E5/
        M9cWgsDStSgUNTZl36dSbPXo4noOH8c=
X-Google-Smtp-Source: ANB0VdZZ43DETRnz4hawKYDmwx57U8IB951whv1wSs0Pt6gaEn5oTFY3u7uPXTZPIh0CXsGGzY7lTg==
X-Received: by 2002:a81:6b57:: with SMTP id g84-v6mr2984493ywc.280.1537556757339;
        Fri, 21 Sep 2018 12:05:57 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id a184-v6sm747087ywc.16.2018.09.21.12.05.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 12:05:56 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id j131-v6so5588841ywc.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:05:56 -0700 (PDT)
X-Received: by 2002:a81:2288:: with SMTP id i130-v6mr5594303ywi.288.1537556756027;
 Fri, 21 Sep 2018 12:05:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 12:05:55
 -0700 (PDT)
In-Reply-To: <1536874298-23492-1-git-send-email-rick.p.edgecombe@intel.com>
References: <1536874298-23492-1-git-send-email-rick.p.edgecombe@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 12:05:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKpwGHRJ92q7yCc+y8esdG6orFVOiZGoGMCi1XiY0JBoQ@mail.gmail.com>
Message-ID: <CAGXu5jKpwGHRJ92q7yCc+y8esdG6orFVOiZGoGMCi1XiY0JBoQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] KASLR feature to randomize each loadable module
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 2:31 PM, Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> This is V6 of the "KASLR feature to randomize each loadable module" patchset.
> The purpose is to increase the randomization and also to make the modules
> randomized in relation to each other instead of just the base, so that if one
> module leaks the location of the others can't be inferred.

I'm excited for this! :)

> Rick Edgecombe (4):
>   vmalloc: Add __vmalloc_node_try_addr function
>   x86/modules: Increase randomization for modules
>   vmalloc: Add debugfs modfraginfo
>   Kselftest for module text allocation benchmarking

Yay for self-tests! This is much appreciated.

-Kees

-- 
Kees Cook
Pixel Security
