Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03200C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB22E25A4A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB22E25A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933829AbeFYNTj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:19:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754582AbeFYNTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:19:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C9497C6A9;
        Mon, 25 Jun 2018 13:19:36 +0000 (UTC)
Received: from treble (ovpn-123-175.rdu2.redhat.com [10.10.123.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30C352166B5D;
        Mon, 25 Jun 2018 13:19:34 +0000 (UTC)
Date:   Mon, 25 Jun 2018 08:19:32 -0500
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
Message-ID: <20180625131932.sge43esxdb5ejoxg@treble>
References: <1529235613.4572.7.camel@gmx.de>
 <20180617120012.GB16877@zn.tnic>
 <1529242717.4472.3.camel@gmx.de>
 <1529244178.4674.1.camel@gmx.de>
 <20180617194747.GA21160@zn.tnic>
 <1529289279.31745.3.camel@gmx.de>
 <20180623103622.GA2760@zn.tnic>
 <20180624071105.GA29407@gmail.com>
 <20180624104449.GA20159@avx2>
 <20180625072438.GA19063@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625072438.GA19063@gmail.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 25 Jun 2018 13:19:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 25 Jun 2018 13:19:36 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 09:24:38AM +0200, Ingo Molnar wrote:
> 
> * Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > On Sun, Jun 24, 2018 at 09:11:05AM +0200, Ingo Molnar wrote:
> > > > Add explicit RETs to the tail calls of AEGIS and MORUS crypto algorithms
> > > > otherwise they run into INT3 padding due to
> > > > 
> > > >   51bad67ffbce ("x86/asm: Pad assembly functions with INT3 instructions")
> > > > 
> > > > leading to spurious debug exceptions.
> > > > 
> > > > Mike Galbraith <efault@gmx.de> took care of all the remaining callsites.
> > > 
> > > Note that 51bad67ffbce has been zapped because it caused too many problems like 
> > > this, but the explicit RETs make sense nevertheless.
> > 
> > So commit which found real bug(s) was zapped.
> > 
> > OK
> 
> No, what happened is that the commit was first moved into WIP.x86/debug showing 
> its work-in-progress status, because it was incomplete and caused bugs:
> 
>    https://lore.kernel.org/lkml/20180518073644.GA8593@gmail.com/T/#u
> 
> ... and finally, after weeks of inaction I zapped it because I didn't see progress 
> and you didn't answer my question.
> 
> If a fixed patch with updated tooling to detect these crashes before they occur on 
> live systems is submitted we'll reconsider - it didn't get NAK-ed, it's just 
> incomplete in the current form.

Hm, what happened to the objtool patch to detect these at build time?
Did it not work?

  https://lore.kernel.org/lkml/20180517134934.eog2fgoby5azq5a7@treble

-- 
Josh
