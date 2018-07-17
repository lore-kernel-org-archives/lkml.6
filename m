Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AA0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0876D208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0876D208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeGQHq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:46:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:51552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727600AbeGQHq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:46:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C162AAEB1;
        Tue, 17 Jul 2018 07:15:46 +0000 (UTC)
Date:   Tue, 17 Jul 2018 09:15:45 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Andy Lutomirski <luto@amacapital.net>
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
Subject: Re: [PATCH 10/39] x86/entry/32: Handle Entry from Kernel-Mode on
 Entry-Stack
Message-ID: <20180717071545.ojdall7tatbjtfai@suse.de>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
 <1531308586-29340-11-git-send-email-joro@8bytes.org>
 <CALCETrUg_4q8a2Tt_Z+GtVuBwj3Ct3=j7M-YhiK06=XjxOG82A@mail.gmail.com>
 <20180714052110.cobtew6rms23ih37@suse.de>
 <7AB4F269-E0E8-4290-A764-69D8605467E8@amacapital.net>
 <20180714080159.hqp36q7fxzb2ktlq@suse.de>
 <75BDF04F-9585-438C-AE04-918FBE00A174@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75BDF04F-9585-438C-AE04-918FBE00A174@amacapital.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 07:36:47AM -0700, Andy Lutomirski wrote:
> But I’m still unconvinced. If any code executed with IRQs enabled on
> the entry stack, then that code is terminally buggy. If you’re
> executing with IRQs off, you’re not going to get migrated.  64-bit
> kernels run on percpu stacks all the time, and it’s not a problem.

The code switches to the kernel-stack and kernel-cr3 and just remembers
where it came from (to handle the entry-from-kernel with entry-stack
and/or user-cr3 case). IRQs are disabled in the entry-code path. But
ultimately it calls into C code to handle the exception. And there IRQs
might get enabled again.

> IRET errors are genuinely special and, if they’re causing a problem
> for you, we should fix them the same way we deal with them on x86_64.

Right, IRET is handled differently and doesn't need this patch. But the
segment-writing exceptions do.

If you insist on it I can try to implement the assumption that we don't
get preempted in this code-path. That will safe us some cycles for
copying stack contents in this unlikely slow-path. But we definitly need
to handle the entry-from-kernel with entry-stack and/or user-cr3 case
correctly and make a switch to kernel-stack/cr3 because we are going to
call into C-code.


Regards,

	Joerg
