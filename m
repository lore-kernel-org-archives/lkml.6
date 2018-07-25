Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBF1C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F0120843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F0120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbeGZAY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:24:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:43614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731417AbeGZAY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:24:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE0F7AE55;
        Wed, 25 Jul 2018 23:11:02 +0000 (UTC)
Date:   Thu, 26 Jul 2018 01:11:01 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/bugs: protect against userspace-userspace
 spectreRSB
In-Reply-To: <CA+55aFz+5e3-YudC1a0YPx-dUN5YjHxQKF=ROPv9J2N-6b1ZDw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1807260102300.997@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1807242147560.997@cbobk.fhfr.pm> <CA+55aFz+5e3-YudC1a0YPx-dUN5YjHxQKF=ROPv9J2N-6b1ZDw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018, Linus Torvalds wrote:

> > Mitigate userspace-userspace attacks by always unconditionally filling RSB on
> > context switch when generic spectrev2 mitigation has been enabled.
> 
> Shouldn't this also do something like
> 
>      x86_spec_ctrl_base |= x86_spec_ctrl_mask & SPEC_CTRL_STIBP;
> 
> if we have HT enabled?

So IIUC your comment is not really tightly related to spectreRSB, is it?

If you're making a more general remark about things that we'd also have to 
do in order to improve userspace-userspace spectrev2 prevention, then I 
agree.

It probably wouldn't be as simple as adding it to x86_spec_ctrl_base I 
think though, as the VM switching also has to save/restore it properly 
(the same way we handle SSBD). So I'd rather handle this separately, as it 
really is in principle a completely different protection.

STIBP is plugging much smaller hole than spectreRSB (as the bigger part is 
already plugged by IBPB), so I'd rather have that one in first, and look 
at improving STIBP later if noone beats me to it.

Thanks,

-- 
Jiri Kosina
SUSE Labs

