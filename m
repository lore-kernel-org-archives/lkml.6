Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBF8ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D2C21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D2C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJRJUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:20:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:47034 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeJRJUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:20:52 -0400
Received: by mail-io1-f65.google.com with SMTP id t7-v6so20013083ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 18:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjdNWVFJTGVBaq920sxl0SGbKsYcBJUkUutUCpRY/yw=;
        b=F7E3j8hvn0StGUT6Q1HnZTTTDXyaQ4O3yXFlNJb02xJk3QF7DBgq7Rght/+05VJPxM
         vYBGiep9coSgo2BV5WlmS61HMvL3VPh8fQe5A/eOSIWggpyu5JFQrk8F9byNXfz8k2ru
         tjf+jV583PUEjM0dH6uG0I8fb/wVi3gS+sL0oMiUmkRWa/tiSgMo6B4OJXVaLHWVPqZS
         SHqDR+eiKnntGjwkaVDF4iIzgg/HA2m1N5tj2aNN1uPqxkhIazfg1Ev19LeMU1n8gVuU
         PZaRFqiXEgYno6ZK3L7tdi+CecI4kqea4yWgBBNqcAF7pdFSRhTpQjRCDNZtEfbluuor
         pBOw==
X-Gm-Message-State: ABuFfogeD6ykGMG2SQ2n3sG/o1o5cFmiyju6VlCqUdLa0fnWbEW6mSw6
        fX2mRKVa0A4k36mzJ6f+900e4XdIu48M78OACqc=
X-Google-Smtp-Source: ACcGV61/aQDcPk9SUA4g5Odz59MfVe5CsVgkTvzgZkbSuYXz0N3BjKxyYjZ3B7omxzUdZJ+xmKT7CtfJ4sTxljxDZx8=
X-Received: by 2002:a6b:3b54:: with SMTP id i81-v6mr19110679ioa.133.1539825746113;
 Wed, 17 Oct 2018 18:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <1539739563-1886-1-git-send-email-chenhc@lemote.com> <20181017093540.GB16320@e107155-lin>
In-Reply-To: <20181017093540.GB16320@e107155-lin>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Thu, 18 Oct 2018 09:28:11 +0800
Message-ID: <CAAhV-H64KYE6YDLrBuK_oYkyBHe8F_5Ja433tY+Pp841kJw57g@mail.gmail.com>
Subject: Re: [PATCH] cacheinfo: Keep the old value if of_property_read_u32 fails
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        zhangfx <zhangfx@lemote.com>, wu zhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sudeep,

Please see this call-graph:

static int detect_cache_attributes(unsigned int cpu)
        ....
        ret = populate_cache_leaves(cpu);
        ....
        ret = cache_shared_cpu_map_setup(cpu); -->
cache_setup_of_node() --> cache_of_set_props() -->
cache_size()/cache_nr_sets

populate_cache_leaves() is arch-specific, All archs except arm64 have
provide initial values to cacheinfo:size and cacheinfo:number_of_sets.

Related files:
arch/nds32/kernel/cacheinfo.c
arch/riscv/kernel/cacheinfo.c
arch/s390/kernel/cache.c
arch/mips/kernel/cacheinfo.c
arch/x86/kernel/cpu/cacheinfo.c

Regards,
Huacai

On Wed, Oct 17, 2018 at 5:35 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Oct 17, 2018 at 09:26:03AM +0800, Huacai Chen wrote:
> > Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
> > property_read_u32 instead of get_property,read_number") makes cache
> > size and number_of_sets be 0 if DT doesn't provide there values. I
> > think this is unreasonable so make them keep the old values, which is
> > the same as old kernels.
> >
>
> What old values does the kernel have ? Which architecture are you referring ?
> If DT doesn't have entry then we can't expose sysfs, hence 0.
> Please provide more details on the issue you are seeing.
>
> --
> Regards,
> Sudeep
