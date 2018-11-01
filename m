Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02880C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A2A205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cnTIdqoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A2A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeKAM3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 08:29:44 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34171 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeKAM3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 08:29:44 -0400
Received: by mail-yw1-f66.google.com with SMTP id v199-v6so7389204ywg.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 20:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zamWPB7Zrsbk1HU+g6DyYhjI1LOLXffcsrjOS1cfmoc=;
        b=cnTIdqoVbcehNhb9FKMitRDNdejZO0Uh4fHM64GEX5NlGgV/K5FQMWArwEJN8bWFnU
         yjVdKN2oGs+Fl4ZFjEZR0f48ZsnrB0TnFnAapbuRW3YuhENboxof8QwfUdgneZQ6xT0n
         mPwb4THqjBtZ6Wm7eNfxvBNDmeQla1kSlCmV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zamWPB7Zrsbk1HU+g6DyYhjI1LOLXffcsrjOS1cfmoc=;
        b=XgOrdot6dPscyRARjp2CxbdNdfIaA5q0YqY3y+G4PqYQTP+WfXm/KPWYZn89ZDr7Ug
         wQDuDH3u4lCcgM5z0gZhr0PdIhrZq09rRQVQ4Hf3B3zEE+AZFoRTUBP80WxlTXzP0kEb
         FykyrrEU0BKsbsB2LODABons3K3Z+k6s1SoAHhfmgXDx+873SAnzpCItf83/1V6DzRZc
         SD8NAxzxF/KnwiVCCdjF12rMv/Th0/yNgkMVX0fb/oNkyfv9T7Ig5HZn8MSdDCn2rFeL
         iY1xiLbJ0OS7gbLWRCdpH0hpI2F0FemAqvhpf22IJEft+2/vwqO79a7iuJ3qXaRrUI7V
         O4Wg==
X-Gm-Message-State: AGRZ1gJV4H1/E+LoCi8Nd5RkxOZqlwH/acf/rz+kfOkr0G0yGdenXcuT
        aRs1Nomt1kxiSPcutA3PHkHReAikbOo=
X-Google-Smtp-Source: AJdET5f1gU+eT47z1P3cGfUWDudQ9VE3dIsCztQuPWY2QcbMVk91eFmVS7NB7z3BAM0zoZRUZSmBww==
X-Received: by 2002:a0d:f606:: with SMTP id g6-v6mr5728967ywf.235.1541042918274;
        Wed, 31 Oct 2018 20:28:38 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id t184-v6sm3417118ywd.37.2018.10.31.20.28.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 20:28:36 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id g9-v6so7564340ybh.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 20:28:35 -0700 (PDT)
X-Received: by 2002:a25:7643:: with SMTP id r64-v6mr5969887ybc.403.1541042915047;
 Wed, 31 Oct 2018 20:28:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 20:28:33
 -0700 (PDT)
In-Reply-To: <20181031091048.GH744@hirez.programming.kicks-ass.net>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-17-igor.stoppa@huawei.com> <20181025001312.GA3159@worktop.c.hoisthospitality.com>
 <806bfff0-8d62-9918-480d-ec791b93841e@gmail.com> <20181030155841.GF8177@hirez.programming.kicks-ass.net>
 <20181030162815.GB20827@arm.com> <20181031091048.GH744@hirez.programming.kicks-ass.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 31 Oct 2018 20:28:33 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKmhoSsOTqDJmr3ijwDAh57Bfq3KVE+AjrBdLXjPz83+g@mail.gmail.com>
Message-ID: <CAGXu5jKmhoSsOTqDJmr3ijwDAh57Bfq3KVE+AjrBdLXjPz83+g@mail.gmail.com>
Subject: Re: [PATCH 16/17] prmem: pratomic-long
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 2:10 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Oct 30, 2018 at 04:28:16PM +0000, Will Deacon wrote:
>> On Tue, Oct 30, 2018 at 04:58:41PM +0100, Peter Zijlstra wrote:
>> > Like mentioned elsewhere; if you do write_enable() + write_disable()
>> > thingies, it all becomes:
>> >
>> >     write_enable();
>> >     atomic_foo(&bar);
>> >     write_disable();
>> >
>> > No magic gunk infested duplication at all. Of course, ideally you'd then
>> > teach objtool about this (or a GCC plugin I suppose) to ensure any
>> > enable reached a disable.
>>
>> Isn't the issue here that we don't want to change the page tables for the
>> mapping of &bar, but instead want to create a temporary writable alias
>> at a random virtual address?
>>
>> So you'd want:
>>
>>       wbar = write_enable(&bar);
>>       atomic_foo(wbar);
>>       write_disable(wbar);
>>
>> which is probably better expressed as a map/unmap API. I suspect this
>> would also be the only way to do things for cmpxchg() loops, where you
>> want to create the mapping outside of the loop to minimise your time in
>> the critical section.
>
> Ah, so I was thikning that the altnerative mm would have stuff in the
> same location, just RW instead of RO.

I was hoping for the same location too. That allows use to use a gcc
plugin to mark, say, function pointer tables, as read-only, and
annotate their rare updates with write_rare() without any
recalculation.

-Kees

-- 
Kees Cook
