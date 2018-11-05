Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02ACC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891852086B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5U9hHuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891852086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbeKFEnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:43:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387980AbeKFEnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:43:02 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BDFF20819
        for <linux-kernel@vger.kernel.org>; Mon,  5 Nov 2018 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541445709;
        bh=aF9qvnjhfywfEa1pURnRB62B8dAkUH4YrmssXcmCju0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l5U9hHuzd/EaK1ZDdPDzG3W+Q+XOR44tOUNUbtXtSLV4XpsErZP7cqRLsGyqGU5Gv
         /meisQAgbDi3kHfmAVizwtW1F79kFGjvv6NMK4ybtuP2pE69ylZsu4isvVk469ABmf
         UsN50X6Xi1+nXojKElJxtRpvdhUs23lMZpIWdc08=
Received: by mail-wr1-f46.google.com with SMTP id k15-v6so7826053wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:21:49 -0800 (PST)
X-Gm-Message-State: AGRZ1gLDc6FdoFbIMY7XtyLGW5sHq3/YveM8d+1YinoeGKNiM8U2iA/k
        O3YCUXpZQgNrk0E+HIWs+3MdlvETFRKnAtKCNQE5aw==
X-Google-Smtp-Source: AJdET5cdc8O0qua4ePUpgcoGahlciRjCFdegSnDU7ZdMWwcJqGkh6hqCKVd4mTYRhcSF0MaDMXusIOMf1vOu+jaVZoQ=
X-Received: by 2002:adf:b1db:: with SMTP id r27-v6mr20629494wra.95.1541445696001;
 Mon, 05 Nov 2018 11:21:36 -0800 (PST)
MIME-Version: 1.0
References: <1541187610-5322-1-git-send-email-longman@redhat.com>
 <a3584dd1-c030-cebe-3f3d-eadc0744580a@intel.com> <fb715262-df9e-3e77-6964-80ec4a1c7a24@redhat.com>
 <47b1c477-46a7-6b04-7537-378e2910611b@intel.com> <CALCETrV0RYZPbZ0vyRehvS=L-yZwLQ06=eov+=GkzFm0GoQQpQ@mail.gmail.com>
 <CALCETrXfvWiGNjyusMeOt-xo61zpmFzahnkwUwMnWjnv_gsNnA@mail.gmail.com> <08752b15-8771-266f-0155-3b721203e721@intel.com>
In-Reply-To: <08752b15-8771-266f-0155-3b721203e721@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 5 Nov 2018 11:21:24 -0800
X-Gmail-Original-Message-ID: <CALCETrX7NU02=kMED--p_TXkRPrm4_Bntc6W13tdtS4GJspLKw@mail.gmail.com>
Message-ID: <CALCETrX7NU02=kMED--p_TXkRPrm4_Bntc6W13tdtS4GJspLKw@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/mm/fault: Allow stack access below %rsp
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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

On Mon, Nov 5, 2018 at 9:20 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
>
> On 11/4/18 9:14 PM, Andy Lutomirski wrote:
> > I should add: if this patch is *not* applied, then I think we'll
> > need to replace the sw_error_code check with user_mode(regs) to avoid
> > an info leak if CET is enabled.  Because, with CET, WRUSS will allow
> > a *kernel* mode access (where regs->sp is the kernel stack pointer)
> > with user permissions.
>
> Are you saying that WRUSS, if it faults will set the "user" page fault
> error code bit?  I seem to have some rough recollection about it being
> that way, and the shadow-stack spec does say:
>
>         paging access control checks will be treated as a user-mode
>         shadow stack store
>

I believe so, and it would make sense for it to work this way.  I
would love some instructions for directly accessing normal user
memory, too.  Maybe a prefix?

> But the SDM says:
>
>         For all instruction fetches and most data accesses, this
>         distinction is determined by the current privilege level (CPL):
>         accesses made while CPL < 3 are supervisor-mode accesses, while
>         accesses made while CPL = 3 are user-mode accesses.
>
> It would certainly be ideal if things affecting the core architecture
> like this were in the SDM itself before we merged them.  It makes things
> like this a lot easier to figure out.

Agreed.  The current documentation situation is not so good.
