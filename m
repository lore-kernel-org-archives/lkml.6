Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906F2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C0620883
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403770AbfAOWiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:38:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387763AbfAOWiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:38:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 702B086663;
        Tue, 15 Jan 2019 22:38:53 +0000 (UTC)
Received: from treble (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBFFD5D777;
        Tue, 15 Jan 2019 22:38:51 +0000 (UTC)
Date:   Tue, 15 Jan 2019 16:38:49 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Qian Cai <cai@lca.pw>, Paolo Bonzini <pbonzini@redhat.com>,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: add proper frame pointer logic for vmx
Message-ID: <20190115223849.apk6tcbl7f7kd5d4@treble>
References: <20190115064459.70513-1-cai@lca.pw>
 <a6477022-bbc0-fc00-2c8e-75007b468d3f@lca.pw>
 <5109b3c2-cac0-aa19-9cc7-801340afe198@redhat.com>
 <7d6ae0bc-b7c7-63ea-ae94-4437a29a31b1@lca.pw>
 <20190115190617.GD21622@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115190617.GD21622@linux.intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 15 Jan 2019 22:38:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 11:06:17AM -0800, Sean Christopherson wrote:
> > I can see there are five options to solve it.
> > 
> > 1) always inline vmx_vcpu_run()
> > 2) always noinline vmx_vcpu_run()
> > 3) add -fdiable-ipa-fnsplit option to Makefile for vmx.o
> > 4) let STACK_FRAME_NON_STANDARD support part.* syntax.
> > 5) trim-down vmx_vcpu_run() even more to not causing splitting by GCC.
> > 
> > Option 1) and 2) seems give away the decision for user with
> > CONFIG_CC_OPTIMIZE_FOR_(PERFORMANCE/SIZE).
> > 
> > Option 3) prevents other functions there for splitting for optimization.
> > 
> > Option 4) and 5) seems tricky to implement.
> > 
> > I am not more leaning to 3) as only other fuction will miss splitting is
> > vmx_segment_access_rights().
> 
> Option 4) is the most correct, but "tricky" is an understatement.  Unless
> Josh is willing to pick up the task it'll likely have to wait.
> 
> There's actually a few more options:
> 
>  6) Replace "pop %rbp" in the vmx_vmenter() asm blob with an open-coded
>     equivalent, e.g. "mov [%rsp], %rbp; add $8, %rsp".  This runs an end-
>     around on objtool since objtool explicitly keys off "pop %rbp" and NOT
>     "mov ..., %rbp" (which is probably an objtool checking flaw?").
> 
>  7) Move the vmx_vmenter() asm blob and a few other lines of code into a
>     separate helper, e.g. __vmx_vcpu_run(), and mark that as having a
>     non-standard stack frame.

Do you mean moving the asm blob to a .S file instead of inline asm?  If
so, I think that's definitely a good idea.  It would be a nice cleanup,
regardless of the objtool false positive.

That would allow vmx_vcpu_run() to be a "normal" C function which
objtool can validate (and also create ORC data for).  It would also
prevent future nasty GCC optimizations (which was why the __noclone was
needed in the first place).

And also, I *think* objtool would no longer warn in that case, because
there would no longer be any calls in the function after popping %rbp.
Though if I'm wrong about that, I'd be glad to help fix the warning one
way or another.

-- 
Josh
