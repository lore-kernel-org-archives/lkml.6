Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D0BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC56221479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfACUbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:31:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfACUbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:31:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1657C059B8C;
        Thu,  3 Jan 2019 20:31:12 +0000 (UTC)
Received: from treble (ovpn-125-50.rdu2.redhat.com [10.10.125.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4390D1001F41;
        Thu,  3 Jan 2019 20:31:11 +0000 (UTC)
Date:   Thu, 3 Jan 2019 14:31:09 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC v2 0/6] x86: dynamic indirect branch promotion
Message-ID: <20190103203109.cdck5kwck5gnkko7@treble>
References: <20181231072112.21051-1-namit@vmware.com>
 <CALCETrW_52zEv1kHa7AdhF4PUGvyX4VyHqig1bFAJM_3VAXn=A@mail.gmail.com>
 <A7D88101-837A-4FD2-B397-019D1845A418@vmware.com>
 <20190103181057.lflra4lkoaeg2btv@treble>
 <7FA580EA-9DEA-4813-8832-F1BE034A857C@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7FA580EA-9DEA-4813-8832-F1BE034A857C@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 03 Jan 2019 20:31:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 06:30:08PM +0000, Nadav Amit wrote:
> > On Jan 3, 2019, at 10:10 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > On Mon, Dec 31, 2018 at 07:53:06PM +0000, Nadav Amit wrote:
> >>> On Dec 31, 2018, at 11:51 AM, Andy Lutomirski <luto@kernel.org> wrote:
> >>> 
> >>> On Sun, Dec 30, 2018 at 11:20 PM Nadav Amit <namit@vmware.com> wrote:
> >>>> This is a revised version of optpolines (formerly named retpolines) for
> >>>> dynamic indirect branch promotion in order to reduce retpoline overheads
> >>>> [1].
> >>> 
> >>> Some of your changelogs still call them "relpolines".
> >>> 
> >>> I have a crazy suggestion: maybe don't give them a cute name at all?
> >>> Where it's actually necessary to name them (like in a config option),
> >>> use a description like CONFIG_DYNAMIC_DEVIRTUALIZATION or
> >>> CONFIG_PATCH_INDIRECT_CALLS or something.
> > 
> > Cute or not, naming is important.
> > 
> > If you want a description instead of a name, it will be a challenge to
> > describe it in 2-3 words.
> > 
> > I have no idea what "dynamic devirtualization" means.
> > 
> > "Patch indirect calls" doesn't fully describe it either (and could be
> > easily confused with static calls and some other approaches).
> > 
> >> I’m totally fine with that (don’t turn me into a "marketing” guy). It was
> >> just a way to refer to the mechanism. I need more feedback about the more
> >> fundamental issues to go on.
> > 
> > Naming isn't marketing.  It's a real issue: it affects both usability
> > and code readability.
> 
> Well, allow me to be on the fence not this one.
> 
> I look for the path of least resistance. I think it would be easiest if I
> first manage to make Josh’s static calls to be less intrusive. For that, I
> try to add in the GCC plugin an attribute to annotate the function pointers
> whose calls should be promoted. However, I don’t manage to get the
> declaration from the call instruction's rtx. If anyone has a pointer on how
> it can be done, that’s would be very helpful.

Ok.  FYI, I'll be posting v3 in the next few days or so.

-- 
Josh
