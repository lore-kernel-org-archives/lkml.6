Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E100C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4762020823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4762020823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbeKTJmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:42:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbeKTJmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:42:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DD7676207;
        Mon, 19 Nov 2018 23:16:50 +0000 (UTC)
Received: from sky.random (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0F515C57B;
        Mon, 19 Nov 2018 23:16:49 +0000 (UTC)
Date:   Mon, 19 Nov 2018 18:16:49 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [Patch v5 11/16] x86/speculation: Add Spectre v2 app to app
 protection modes
Message-ID: <20181119231649.GI29258@redhat.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
 <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com>
 <nycvar.YFH.7.76.1811171044510.21108@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1811182358370.21108@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1811191433100.1537@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1811191438290.21108@cbobk.fhfr.pm>
 <20181119193253.GE29258@redhat.com>
 <4d102977-f516-e0b3-b728-e318e36c1449@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d102977-f516-e0b3-b728-e318e36c1449@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 19 Nov 2018 23:16:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:33:08PM -0800, Dave Hansen wrote:
> On 11/19/18 11:32 AM, Andrea Arcangeli wrote:
> > The specs don't say if by making it immune from BTB mistraining, it
> > also could prevent to mistrain the BTB in order to attack what's
> > outside the SECCOMP jail. Probably it won't and I doubt we can rely on
> > it even if some implementation could do that.
> 
> I just talked with Andi and Tim about this.  The *current* spec for
> STIBP[1] states that it bidirectional: setting it on one thread provides
> mitigation against any threads attacking any other thread on the core.
                     ^^^                   ^^^
> 
> This means that it provides protection for victims being in and out of
> SECCOMP jail when the attacker is either in or out of SECCOMP jail.
> 
> However, the current spec[1], differs from the *original* spec PDF that
> Intel released last year.  Both are correct in that they describe all
> current (Intel) implementations of STIBP.  However, the new
> _description_ of STIBP is stronger than it was originally.
> 
> Here's the current description:
> 
> > Setting ... STIBP ... on a logical processor prevents the predicted
> > targets of indirect branches on any logical processor of that core
                                    ^^^
> > from being controlled by software that executes (or executed
> > previously) on another logical processor of the same core.
                   ^^^^^^^
> 
> 1.
> https://software.intel.com/security-software-guidance/insights/deep-dive-single-thread-indirect-branch-predictors

I'm not used to official specs in a "insight & deep dive"
blog-post-like webpage, so I didn't notice this deep dive detail.

You use "any" vs "any" but the spec you quoted still says "any" vs
"another".

If I shall take the above literally it still means that if I set STIBP
inside SECCOMP, as long as it's set, it prevents indirect branches of
all siblings to be controlled from code outside the SECCOMP jail
running in another sibling (or that run previously in another
sibling). I.e. the "deep dive" stronger semantics of STIBP just mean
the code outside SECCOMP cannot attack itself while the code inside
SECCOMP runs and keeps STIBP set.

So you may want to ask why it wasn't written as your "any" vs "any" email:

Setting ... STIBP ... on a logical processor prevents the predicted
targets of indirect branches on any logical processor of that core
from being controlled by software that executes (or executed
previously) on any logical processor of the same core.

A s/another/any/ is still missing to match your exact interpretation,
otherwise it still seems a gray area and I've no idea why it wasn't
written as "any" which would clear any risk for misunderstanding and
instead it kind of uses a word that matches the somewhat more strict
pdf specs.

If this is clarified the concern that remains is that lots of
potentially performance critical stuff runs under SECCOMP but of
course it changes everything in terms of possibly enabling STIBP under
SECCOMP by default, it certainly would make more sense then.

Thanks,
Andrea
