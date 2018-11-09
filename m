Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C735FC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988152086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988152086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeKJEpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:45:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbeKJEpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:45:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A3C958E31;
        Fri,  9 Nov 2018 19:03:23 +0000 (UTC)
Received: from treble (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CBE9600CD;
        Fri,  9 Nov 2018 19:03:22 +0000 (UTC)
Date:   Fri, 9 Nov 2018 13:03:20 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
Message-ID: <20181109190320.tn3fpaegg5dkgvdb@treble>
References: <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <CAKv+Gu9bMkFEx_GxH3uLm0gveQurp7ELDi6C5NvpugufPFMbRA@mail.gmail.com>
 <20181109151028.faifw66enzye32gg@treble>
 <CAKv+Gu_J1b30+pMNRF0icEpyew4TM_VP3ShG=4HkLnk=fRL9zg@mail.gmail.com>
 <CAKv+Gu-DOW2WT=h8C0x5igbCDAc2bp3mTRM6U_wTJST+RnVicg@mail.gmail.com>
 <20181109173106.kbghzsdsu7oachl6@treble>
 <CAKv+Gu-9XYOwAPJ5m6F4Cn9Uo6dvbtEG9p0knX+_XcjHp2QKGA@mail.gmail.com>
 <20181109174608.eahqh4fkyl3k2gvs@treble>
 <CAKv+Gu8b1KbRtJPrbXk3+K=1uRV6OcvB+zEMYk-UK3sFxKzsgQ@mail.gmail.com>
 <CAKv+Gu9iJAyZ1u5AjPjTyxP4QJYOjMsMBi1eoMahtUjnLwqSHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9iJAyZ1u5AjPjTyxP4QJYOjMsMBi1eoMahtUjnLwqSHQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 09 Nov 2018 19:03:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 06:53:21PM +0100, Ard Biesheuvel wrote:
> > It's a bit fiddly since inline and out-of-line both use
> > arch_static_call_transform(), but what I need to do is basically:
> >
> > - for out-of-line, the trampoline needs to be patched into a
> > movn/movk/movk/br sequence if the target is too far
> > - for inline, the trampoline itself needs to be patched from
> > adrp/ldr/br (which does a load and a indirect branch) to
> > movn/movk/movk/br (which uses immediates), and the call sites need to
> > be patched into calls to the veneer if the target is out of range.
> >
> > So arch_static_call_transform() needs to know where the trampoline is
> > for this use case, so could we perhaps add a 'void *orig' in the key
> > struct that keeps track of the original value of 'addr' ?
> 
> ... and pass it to arch_static_call_transform

Ok.  So in both cases, you need both the call site address and the tramp
address, right?  We could add a 'tramp' pointer to the key struct -- I
assume that's what you mean?

And also change

  void arch_static_call_transform(unsigned long insn, void *dest)

to

  void arch_static_call_transform(void *call_site, void *tramp, void *dest)

-- 
Josh
