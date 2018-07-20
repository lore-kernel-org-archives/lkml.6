Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED9DECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE8720661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="OiRyLp1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE8720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeGTWcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:32:50 -0400
Received: from 8bytes.org ([81.169.241.247]:41324 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbeGTWct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:32:49 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 872B5450; Fri, 20 Jul 2018 23:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532122957; bh=ZhC2aNozxwWqpuXFgfDAGyBpSgf58kVKJyUVakwZebo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiRyLp1yg0EVByxbxY83B1BWiWBa2kDncZLNsBeAJ/ug03UzRsMlKZnKNhayZ/dRs
         I9yvcshNIrzgPskkXF0AwJtUE1tJxhYEp11bDRwCgNPdAJtqHmbZuTdC7lUN0EEqW2
         PRKCCopoaEVn9Bx47fXSKZS+62JzUPA5fdOVEUNX6YCFEyTq2djXv+jSKtaStoJnLv
         zqB19+SjpBPWI/XS/+hqUyRB2dw2KO6+foxoRRv97oY8ibXfeSDZNfIk0uBG9PTlZw
         K8ICMhh6Vfqwbhj6r0US+h+/XoRB4LJS1uwoLzdN+MTMUZU9ERWJnwyEntQSjeMdwt
         x/PfAf3WjP5dA==
Date:   Fri, 20 Jul 2018 23:42:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 3/3] x86/entry/32: Copy only ptregs on paranoid
 entry/exit path
Message-ID: <20180720214237.GI18541@8bytes.org>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org>
 <1532103744-31902-4-git-send-email-joro@8bytes.org>
 <CALCETrWmd3arHdkTzAS7reLRjm96jrJC-1O5dYAPwbh2EqKMSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWmd3arHdkTzAS7reLRjm96jrJC-1O5dYAPwbh2EqKMSA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Re-sending because I accidentially replied only to Andy ]

On Fri, Jul 20, 2018 at 10:09:26AM -0700, Andy Lutomirski wrote:
> Can you give an example of the exact scenario in which any of this
> copying happens and why it's needed?  IMO you should just be able to
> *run* on the entry stack without copying anything at all.

So for example when we execute RESTORE_REGS on the path back to
user-space and get an exception while loading the user segment
registers.

When that happens we are already on the entry-stack and on user-cr3.
There is no question that when we return from the exception we need to
get back to entry-stack and user-cr3, despite we are returning to kernel
mode. Otherwise we enter user-space with kernel-cr3 or get a page-fault
and panic.

The exception runs through the common_exception path, and finally ends
up calling C code. And correct me if I am wrong, but calling into C code
from the entry-stack is a bad idea for multiple reasons.

First reason is the size of the stack. We can make it larger, but how
large does it need to be?

Next problem is that current_pt_regs doesn't work in the C code when
pt_regs are on the entry-stack.

These problems can all be solved, but it wouldn't be a robust solution
because when changes to the C code are made they are usually not tested
while on the entry-stack. That case is hard to trigger, so it can easily
break again.

For me, only the x86 selftests triggered all these corner-cases, but not
all developers run them on 32 bit when making changes to generic x86
code.

Regards,

	Joerg
