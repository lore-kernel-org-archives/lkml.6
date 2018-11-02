Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEE0C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C09A2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQJGiYaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C09A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeKCFUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725728AbeKCFUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:20:38 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF01B20847
        for <linux-kernel@vger.kernel.org>; Fri,  2 Nov 2018 20:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541189525;
        bh=u4p1RNF3EEbbDEWjYtGvYoNaHMDvEfPPCmImjEVWqXA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lQJGiYaW/jp3aPRvfE0C7E3XIiQ28OXdITbO7OkuGAvEAxO+mFGK4L2ZHBOsikBEO
         V2FYCsfFGsaCWhOnudWHZk2XhWSTl5ScYh3DhZ7etiETVOPlYgY3QzIuDPFuq7XCY9
         DTkSHQJ0uxNadLmorKggcElC2WHosiuU1SU3TQPk=
Received: by mail-wr1-f45.google.com with SMTP id k15-v6so191956wre.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:12:04 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKs8YubcwxnLmkCWh262ncnd5daDzGYTv8AKGKevpj8dSsg7UyC
        a/tqwe7v+1iPgBzQE4PE91RkuZ9+A7cZ5Mb1FxxMwA==
X-Google-Smtp-Source: AJdET5c7xd2e6tbeJdpW3GC7CDGfUfeaTs7ZRXsCktAtWRPWypad1Jz9rOzDjSYcmhu8ndL2WsVeSTclhUydSXJdZcY=
X-Received: by 2002:adf:97d3:: with SMTP id t19-v6mr11959807wrb.283.1541189523387;
 Fri, 02 Nov 2018 13:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <1541187610-5322-1-git-send-email-longman@redhat.com>
 <a3584dd1-c030-cebe-3f3d-eadc0744580a@intel.com> <fb715262-df9e-3e77-6964-80ec4a1c7a24@redhat.com>
In-Reply-To: <fb715262-df9e-3e77-6964-80ec4a1c7a24@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 2 Nov 2018 13:11:50 -0700
X-Gmail-Original-Message-ID: <CALCETrVqe2BhHTMG0joSC3eTk6CibAtn1c5gd7Ou6zLXQrgO3w@mail.gmail.com>
Message-ID: <CALCETrVqe2BhHTMG0joSC3eTk6CibAtn1c5gd7Ou6zLXQrgO3w@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/mm/fault: Allow stack access below %rsp
To:     Waiman Long <longman@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 12:50 PM Waiman Long <longman@redhat.com> wrote:
>
> On 11/02/2018 03:44 PM, Dave Hansen wrote:
> > On 11/2/18 12:40 PM, Waiman Long wrote:
> >> The 64k+ limit check is kind of arbitrary. So the check is now removed
> >> to just let expand_stack() decide if a segmentation fault should happen.
> > With the 64k check removed, what's the next limit that we bump into?  Is
> > it just the stack_guard_gap space above the next-lowest VMA?
>
> I think it is both the stack_guard_gap space above the next lowest VMA
> and the rlimit(RLIMIT_STACK).
>

Did the non-working programs ever work?  Because, if not, I say let them fail.
