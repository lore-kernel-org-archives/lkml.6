Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAAAECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD43520836
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ+eLjYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD43520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbeGQUjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729805AbeGQUjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:39:33 -0400
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AEAB20843
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 20:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531857920;
        bh=fVjIUGEUgjVJzm4NA7k71aWq6598wWa/GZPckMr4Wzs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jJ+eLjYjtlmg8V5jz+Zj7xY2aq4m5zjhQCFKpk36riaD+KteYlWXUSKbM6O4qDZnP
         7gk2GSRYrB4PVzsydWWv3DfHutJsBYWhebddPB36+xoqPOGo7CY1XdAXTL1KaOFaZN
         pZo1kbK5yOuDn8XzyZwop2/IdQvrkQ1DNGCH5mfg=
Received: by mail-wm0-f52.google.com with SMTP id h20-v6so557828wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:05:20 -0700 (PDT)
X-Gm-Message-State: AOUpUlFCW2VbVcsVo7CFve1XBTk4ioNhbkNy4hzIA6K22Ykj6UwnQVaN
        wD9yhnhMUj3snxW600uBiuzIUevoZNa5a3w7IOHYIA==
X-Google-Smtp-Source: AAOMgpeApGRDS79uHWgtTpe/InXIh/c16usC+0nvFa7gAnYJglbeOgRgOs5hvYuRJu3NLNIDf1sAV3ensQkOrDSkLbs=
X-Received: by 2002:a1c:ef0f:: with SMTP id n15-v6mr2110520wmh.116.1531857918633;
 Tue, 17 Jul 2018 13:05:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:04:57
 -0700 (PDT)
In-Reply-To: <20180717070544.xok34ro76f7m32ha@suse.de>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
 <1531308586-29340-4-git-send-email-joro@8bytes.org> <823BAA9B-FACA-4E91-BE56-315FF569297C@amacapital.net>
 <20180713094849.5bsfpwhxzo5r5exk@8bytes.org> <CALCETrUP1QUKPLPJg6_L5=Mzmq33cSvq+NMaYW01wTCepdjCyg@mail.gmail.com>
 <CALCETrUBR-TGPY7wF4UwRb7jW39H+rJ4XFen35dgJRysk9sYTQ@mail.gmail.com> <20180717070544.xok34ro76f7m32ha@suse.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 17 Jul 2018 13:04:57 -0700
X-Gmail-Original-Message-ID: <CALCETrVza8cpwKPzH1hXUSuassq117MZN7pJaBD89CA=FvuTsw@mail.gmail.com>
Message-ID: <CALCETrVza8cpwKPzH1hXUSuassq117MZN7pJaBD89CA=FvuTsw@mail.gmail.com>
Subject: Re: [PATCH 03/39] x86/entry/32: Load task stack from x86_tss.sp1 in
 SYSENTER handler
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:05 AM, Joerg Roedel <jroedel@suse.de> wrote:
> On Fri, Jul 13, 2018 at 04:17:40PM -0700, Andy Lutomirski wrote:
>> I re-read it again.  How about keeping TSS_entry_stack but making it
>> be the offset from the TSS to the entry stack.  Then do the arithmetic
>> in asm.
>
> Hmm, I think its better to keep the arithmetic in the C file for better
> readability. How about renaming it to TSS_entry2task_stack?

That's okay with me.

>
>
> Regards,
>
>         Joerg
