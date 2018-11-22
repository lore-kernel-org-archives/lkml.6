Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A21C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9C520672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpSJHqBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9C520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394691AbeKVWAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:00:22 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:35990 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388069AbeKVWAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:00:21 -0500
Received: by mail-wm1-f46.google.com with SMTP id s11so8768128wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 03:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+5BJaw87VRzTeg66XYGawhrAcpMr8Ws0HMWhlxmFph0=;
        b=TpSJHqBWb21wv3dkLVlVSpi3B4JRf3l4LqCo1EeobWn8TIzWPpq/JhbXNlkIZOwpGK
         FCEfUuwiZ9xm8dOg7ajQ5FOKnYikXZ9E39mnqcXxt+hPUdGeHCui/EJLYT+0lSuztPS0
         ctrubIVs6Y4TPquVlqA+ghYJcpJgAoJp/s17r7+DyalPsYRzil6djL+m8dmjTjIlRCeA
         4DZePhDikQ6KknDqV/v4DE/lxw3znO18w35/7V/jbWw7TXYZ17+jl46er7kT7yDT3SvI
         pvoiS3VGYJArrWggG7WazNUO6fWoJJaSWuZM4ONfOTx/7P4MsXLmxsYWjPvQUm7w88s1
         YTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+5BJaw87VRzTeg66XYGawhrAcpMr8Ws0HMWhlxmFph0=;
        b=A1w8GJIB6ig8Hg5H884termt06ZvyeCv891fn+QRVzERdyLUY7hBs8Uq2vzSBhJ6ui
         cfcLiD1n3wUeukIqKeJFgwh+xiRlR1YZgGG+Wu1uVU4DcfjuTzpeULmwWFWy5e4n23c2
         DLwh4AuwwGBbaZndQVHUDxIHBRY5r8DkN+HY5pojsRdZfW3CcqXKCFdxy7BeROQ0TPWI
         QLlAQWCWTZcxSQ5ZP41XrJp2AJNWc5HH7zJDYNCcD+ILfe/X652cgNVYOZX1s8dOpijS
         Z3+foRIJCErXptxuUByfyhoFpeuT7ZeVQlnLaAepZJNYTYvoPikBJqfb/ifzcxGG/7Dq
         wBbA==
X-Gm-Message-State: AGRZ1gJ1OQroATSu/ShbIOqMOe0FEkcNW6X75Tpe/Bpa6Y93CJBK4ET+
        sXMECWMLVNJCu8xk2SraZBc=
X-Google-Smtp-Source: AFSGD/W9SVIBjb+0s3YmbXeh41wBJMbUtrRmkkDD8obgnuZbTL2VA+EhrUqZlQmw4k8lahRROebTJA==
X-Received: by 2002:a1c:1348:: with SMTP id 69mr9518128wmt.71.1542885683197;
        Thu, 22 Nov 2018 03:21:23 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q7-v6sm3851080wmg.27.2018.11.22.03.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 03:21:22 -0800 (PST)
Date:   Thu, 22 Nov 2018 12:21:19 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     pabeni@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, dvlasenk@redhat.com,
        brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
Message-ID: <20181122112119.GA108224@gmail.com>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com>
 <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com>
 <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
 <CAHk-=wjweUiVewcnk39mUccEN-SjxHeTZdB3VOXZrvvW4Cs3dw@mail.gmail.com>
 <CAHk-=wiDLq5CVnTJhFNEEduqYP_VSsQPSNvi=w6a8Y9figuh7g@mail.gmail.com>
 <20181122103231.GA102790@gmail.com>
 <20181122111341.GA107459@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122111341.GA107459@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> So I dug into this some more:
> 
> 1)
> 
> Firstly I tracked down GCC bloating the might_fault() checks and the 
> related out-of-line code exception handling which bloats the full 
> generated function.

Sorry, I mis-remembered that detail when I wrote the email: it was 
CONFIG_HARDENED_USERCOPY=y and its object size checks that distros enable 
- and I disabled that option to simplify the size analysis.

(might_fault() doesn't have inline conditionals so shouldn't have any 
effect on the generated code.)

Thanks,

	Ingo
