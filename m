Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853B5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FCE23EB6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FCE23EB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932782AbeGFOGu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:06:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753630AbeGFOGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:06:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D0787264E;
        Fri,  6 Jul 2018 14:06:48 +0000 (UTC)
Received: from treble (ovpn-123-143.rdu2.redhat.com [10.10.123.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 868BA111DD00;
        Fri,  6 Jul 2018 14:06:45 +0000 (UTC)
Date:   Fri, 6 Jul 2018 09:06:43 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Borislav Petkov <bp@alien8.de>, linux-crypto@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        tglx@linutronix.de, luto@kernel.org, peterz@infradead.org,
        brgerst@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, h.peter.anvin@intel.com,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/crypto: Add missing RETs
Message-ID: <20180706140643.u2vau63nncg23hmi@treble>
References: <20180617194747.GA21160@zn.tnic>
 <1529289279.31745.3.camel@gmx.de>
 <20180623103622.GA2760@zn.tnic>
 <20180624071105.GA29407@gmail.com>
 <20180624104449.GA20159@avx2>
 <20180625072438.GA19063@gmail.com>
 <20180625131932.sge43esxdb5ejoxg@treble>
 <20180626064930.GB25879@gmail.com>
 <20180626123154.unjji5glpokedwal@treble>
 <20180705075815.GA20903@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180705075815.GA20903@gmail.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 06 Jul 2018 14:06:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 06 Jul 2018 14:06:48 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 09:58:15AM +0200, Ingo Molnar wrote:
> 
> * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > > So that's still incomplete in that doesn't analyze the 32-bit build yet, right?
> > 
> > We could do INT3s on 64-bit and NOPs on 32-bit.
> > 
> > Or, possibly even better, we could just keep NOPs everywhere and instead
> > make objtool smart enough to detect function fallthroughs.  That should
> > be pretty easy, actually.  It already does it for C files.
> > 
> > Something like the below should work, though it's still got a few
> > issues:
> > 
> >   a) objtool is currently disabled for crypto code because it doesn't
> >      yet understand crypto stack re-alignments (which really needs
> >      fixing anyway); and
> > 
> >   b) it complains about the blank xen hypercalls falling through.  Those
> >      aren't actual functions anyway, so we should probably annotate
> >      those somehow so that objtool ignores them anyway.
> > 
> > I'm a bit swamped at the moment but I can fix those once I get a little
> > more bandwidth.  I at least verified that this patch caught the crypto
> > missing RETs.
> 
> Great, I'd be perfectly fine with such an approach.
> 
> Also, if we have that then we could re-apply Alexey's patch and switch to INT3 
> (only on 64-bit kernels) without any trouble, because objtool should detect any 
> execution flow bugs before the INT3 could trigger, right?
> 
> I.e. any INT3 fault would show a combination of *both* an objtool bug and a 
> probable code flow bug - which I suspect would warrant crashing the box ...

Sounds good to me.  I can take Alexey's patch and submit a 64-bit
version of it, along with the relevant objtool changes (though it may
still be a few weeks before I get the chance).

-- 
Josh
