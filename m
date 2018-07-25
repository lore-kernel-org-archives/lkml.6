Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E4FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D75C20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D75C20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeGYPCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:02:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:52422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728902AbeGYPCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:02:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E727AFBC;
        Wed, 25 Jul 2018 13:50:46 +0000 (UTC)
Date:   Wed, 25 Jul 2018 15:50:44 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/bugs: protect against userspace-userspace
 spectreRSB
In-Reply-To: <20180725134512.uquatm2neqr5jy7b@treble>
Message-ID: <nycvar.YFH.7.76.1807251547550.997@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1807242147560.997@cbobk.fhfr.pm> <20180725134512.uquatm2neqr5jy7b@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018, Josh Poimboeuf wrote:

> > The article "Spectre Returns! Speculation Attacks using the Return Stack
> > Buffer" [1] describes two new (sub-)variants of spectrev2-like attack,
> > making use solely of the RSB contents even on CPUs that don't fallback to
> > BTB on RSB underflow (Skylake+).
> > 
> > Mitigate userspace-userspace attacks by always unconditionally filling RSB on
> > context switch when generic spectrev2 mitigation has been enabled.
> > 
> > [1] https://arxiv.org/pdf/1807.07940.pdf
> > 
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> While I generally agree with this patch, isn't it odd that we would do
> RSB filling on every context switch, but almost never do IBPB?

Yeah, I have actually been wondering exactly the same, but that's what we 
have been doing so far on SKL+, so I didn't really want to mix this aspect 
in.

I actually believe that in the name of consistency we should've been doing 
the RSB fills under the same conditions we're issuing IBPB even on SKL+; I 
can resend a patch that re-adjusts that, if that's the consensus.

Thanks,

-- 
Jiri Kosina
SUSE Labs

