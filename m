Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016E1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC9C2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC9C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbeGSVhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:37:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34200 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbeGSVhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:37:00 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fgFu9-0006CY-Bf; Thu, 19 Jul 2018 22:52:05 +0200
Date:   Thu, 19 Jul 2018 22:52:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Brian Gerst <brgerst@gmail.com>
cc:     Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        dhgutteridge@sympatico.ca, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 07/39] x86/entry/32: Enter the kernel via trampoline
 stack
In-Reply-To: <CAMzpN2gqxu7rgVj8rfweanLNgHBci+nqZMqEYpvgRUd1828umQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1807192250360.1693@nanos.tec.linutronix.de>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org> <1531906876-13451-8-git-send-email-joro@8bytes.org> <CAMzpN2gqxu7rgVj8rfweanLNgHBci+nqZMqEYpvgRUd1828umQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Brian Gerst wrote:
> > +.Lcopy_pt_regs_\@:
> > +#endif
> > +
> > +       /* Allocate frame on task-stack */
> > +       subl    %ecx, %edi
> > +
> > +       /* Switch to task-stack */
> > +       movl    %edi, %esp
> > +
> > +       /*
> > +        * We are now on the task-stack and can safely copy over the
> > +        * stack-frame
> > +        */
> > +       shrl    $2, %ecx
> 
> This shift can be removed if you divide the constants by 4 above.
> Ditto on the exit path in the next patch.

No, the

> > +       /* Allocate frame on task-stack */
> > +       subl    %ecx, %edi

needs the full value in bytes ....

Thanks,

	tglx
