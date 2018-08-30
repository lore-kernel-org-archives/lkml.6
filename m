Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA39C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AA22054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/QixW41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AA22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeH3G05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:26:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37906 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeH3G05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:26:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id e2-v6so3180352pgv.5;
        Wed, 29 Aug 2018 19:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vU6w4wvBzeDZnF5vpHFe6LswcGCa0S7fCoMN+xaYo08=;
        b=g/QixW41gve4nLwv22+G0Qsb1ZfqKIGGqVmwOCyha++1WYbYoEqTFXkVm+V9Kwpu4k
         gi4BP9qvW7aE0JVNY/HDiiNd6VqgDzRdZWazAJluq6KeNwsm17FyB0W/dYsYts9FdSFL
         K3ao4X4aTRanZSxW80xK0RxARXU4s5uAC2WfIPySjvmpjsoAuuCEoDROMDtZBpfvhXhE
         TIlyQ65RXFAAHuMj2G6SOz+01OytEse810rSi8EmIiEGyLPrFoW5XZ2vshFV/kR4kb3y
         ++tnoHgCdvqarmHyaQx5fsXKY2hjeuIkeuxd7nAOK77N9lhLVvWeHcRe3Gc+TwvLIzez
         WU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vU6w4wvBzeDZnF5vpHFe6LswcGCa0S7fCoMN+xaYo08=;
        b=s8LdEtBFvd+V3rr3v2ZuC/WnSnx0axebxkPxeWNwvQCeG8INULqxzSVPtzuDjT3BWl
         DL1Gk7RWYA7YJOa1uzR383MJwtgIUmDa3PzOu3Vbl9N0ErWe3CfbXMh9W5JJKeTU4CFx
         87CifGuJfRNernzV15CLAPHa7FpaPvz/V+CYx4fkqiFcwyrORsfPb2ir4SttXpB48gg/
         6DLej0aIA1yWnBGJ11C54VJC9oxe/4Gw43zN494QVqQxKKCDlFin3B6uNavB61ncANjs
         cphdnKXY/V3Vpfg2CkeHFg0ini2mI/ZpYqA8iv2WYbJo1zdtX5gtT84wkhzxwE8SWtqF
         od0w==
X-Gm-Message-State: APzg51CERh0NqcaFhRJTkQu2T3lmIEcoQhLf7GXg4CXbjfEAbNvyK/8+
        w0JczwwfF812ZHOHfPiSMZw=
X-Google-Smtp-Source: ANB0VdaaFdsEipjbcdq98Yf98Mfq7H3ixnLC/0L9bNUQQ5w27fPPf1AghCtsw761GCbTQAqD2+Jv8g==
X-Received: by 2002:a65:5b48:: with SMTP id y8-v6mr7989342pgr.125.1535596027282;
        Wed, 29 Aug 2018 19:27:07 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::7:e5c6])
        by smtp.gmail.com with ESMTPSA id v8-v6sm6884551pff.120.2018.08.29.19.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 19:27:06 -0700 (PDT)
Date:   Wed, 29 Aug 2018 19:27:04 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        jannh@google.com, keescook@chromium.org, kristen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/3] KASLR feature to randomize each loadable module
Message-ID: <20180830022703.xxl5eolthinicgwp@ast-mbp>
References: <1535583579-6138-1-git-send-email-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535583579-6138-1-git-send-email-rick.p.edgecombe@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 03:59:36PM -0700, Rick Edgecombe wrote:
> Hi,
> 
> This is v4 of the "KASLR feature to randomize each loadable module" patchset.
> The purpose is to increase the randomization and also to make the modules
> randomized in relation to each other instead of just the base, so that if one
> module leaks the location of the others can't be inferred. It is enabled for
> x86_64 for now.
> 
> V4 is a few small fixes. I humbly think this is in pretty good shape at this
> point, unless anyone has any comments. The only other big change I was
> considering was moving the new randomization algorithm into vmalloc so it could
> be re-used for other architectures or possibly other vmalloc usages.
> 
> A few words on how this was tested - As previously mentioned, the entropy
> estimates were done using extracted module text sizes from the in-tree modules.
> These were also used to run 100,000's of simulated module allocations by calling
> module_alloc from a test module, including testing until allocation failure. The
> simulations kept track of every allocation address to make sure there were no
> collisions, and verified memory was actually mapped.
> 
> In addition the __vmalloc_node_try_addr function has a suite of unit tests that
> verify for a bunch of edge cases that it:
>  - Allows for allocations when it should
>  - Reports the right error code if it collides with a lazy-free area or real
>    allocation
>  - Verifies it frees a lazy free area when it should
> 
> These synthetic tests were also how the performance metrics were gathered.
> 
> Changes for V4:
>  - Fix issue caused by KASAN, kmemleak being provided different allocation
>    lengths (padding).
>  - Avoid kmalloc until sure its needed in __vmalloc_node_try_addr.
>  - Fix for debug file hang when the last VA is a lazy purge area
>  - Fixed issues reported by 0-day build system.
> 
> Changes for V3:
>  - Code cleanup based on internal feedback. (thanks to Dave Hansen and Andriy
>    Shevchenko)
>  - Slight refactor of existing algorithm to more cleanly live along side new
>    one.
>  - BPF synthetic benchmark

I don't see this benchmark in this patch set.
Could you prepare it as a test in tools/testing/selftests/bpf/ ?
so we can double check what is being tested and run it regularly
like we do for all other tests in there.

