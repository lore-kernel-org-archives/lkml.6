Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF6C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEFE208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEFE208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeHGWh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:37:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49529 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHGWh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:37:29 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fn8Tb-0006vr-00; Tue, 07 Aug 2018 22:21:07 +0200
Date:   Tue, 7 Aug 2018 22:21:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 2/3] x86/mm/pti: Don't clear permissions in
 pti_clone_pmd()
In-Reply-To: <CALCETrXj1-CC-rcnM5s2SvbSFKjZPMYj0O-9d1PY0MRdGEKs-g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808072218310.1672@nanos.tec.linutronix.de>
References: <1533637471-30953-1-git-send-email-joro@8bytes.org> <1533637471-30953-3-git-send-email-joro@8bytes.org> <feea2aff-91ff-89a6-9d7c-5402a1d6a27f@intel.com> <CALCETrXj1-CC-rcnM5s2SvbSFKjZPMYj0O-9d1PY0MRdGEKs-g@mail.gmail.com>
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

On Tue, 7 Aug 2018, Andy Lutomirski wrote:

> On Tue, Aug 7, 2018 at 11:34 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> > On 08/07/2018 03:24 AM, Joerg Roedel wrote:
> >> The function sets the global-bit on cloned PMD entries,
> >> which only makes sense when the permissions are identical
> >> between the user and the kernel page-table.
> >>
> >> Further, only write-permissions are cleared for entry-text
> >> and kernel-text sections, which are not writeable anyway.
> >
> > I think this patch is correct, but I'd be curious if Andy remembers why
> > we chose to clear _PAGE_RW on these things.  It might have been that we
> > were trying to say that the *entry* code shouldn't write to this stuff,
> > regardless of whether the normal kernel can.
> >
> > But, either way, I agree with the logic here that Global pages must
> > share permissions between both mappings, so feel free to add my Ack.  I
> > just want to make sure Andy doesn't remember some detail I'm forgetting.
> 
> I suspect it's because we used to (and maybe still do) initialize the
> user tables before mark_read_only().

We still do that because we need the entry stuff working for interrupts
early on. We now repeat the clone after mark_ro so the mask RW is not
longer required.

Thanks,

	tglx

