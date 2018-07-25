Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAC8C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E113420833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E113420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbeGZAl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:41:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731410AbeGZAl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:41:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30C0A814F0B8;
        Wed, 25 Jul 2018 23:28:00 +0000 (UTC)
Received: from treble (ovpn-112-79.rdu2.redhat.com [10.10.112.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F5081C59A;
        Wed, 25 Jul 2018 23:27:56 +0000 (UTC)
Date:   Wed, 25 Jul 2018 18:27:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] x86/bugs: protect against userspace-userspace spectreRSB
Message-ID: <20180725232754.libahpxmohmv3vtp@treble>
References: <nycvar.YFH.7.76.1807242147560.997@cbobk.fhfr.pm>
 <CA+55aFz+5e3-YudC1a0YPx-dUN5YjHxQKF=ROPv9J2N-6b1ZDw@mail.gmail.com>
 <nycvar.YFH.7.76.1807260102300.997@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1807260102300.997@cbobk.fhfr.pm>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 25 Jul 2018 23:28:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 25 Jul 2018 23:28:00 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 01:11:01AM +0200, Jiri Kosina wrote:
> On Wed, 25 Jul 2018, Linus Torvalds wrote:
> 
> > > Mitigate userspace-userspace attacks by always unconditionally filling RSB on
> > > context switch when generic spectrev2 mitigation has been enabled.
> > 
> > Shouldn't this also do something like
> > 
> >      x86_spec_ctrl_base |= x86_spec_ctrl_mask & SPEC_CTRL_STIBP;
> > 
> > if we have HT enabled?
> 
> So IIUC your comment is not really tightly related to spectreRSB, is it?
> 
> If you're making a more general remark about things that we'd also have to 
> do in order to improve userspace-userspace spectrev2 prevention, then I 
> agree.
> 
> It probably wouldn't be as simple as adding it to x86_spec_ctrl_base I 
> think though, as the VM switching also has to save/restore it properly 
> (the same way we handle SSBD). So I'd rather handle this separately, as it 
> really is in principle a completely different protection.
> 
> STIBP is plugging much smaller hole than spectreRSB (as the bigger part is 
> already plugged by IBPB)

Just to clarify, the IBPB hole is *not* plugged for context switches.
It's only enabled for non-dumpable processes (which are basically
non-existent in practice).

> so I'd rather have that one in first, and look at improving STIBP
> later if noone beats me to it.

It would be interesting to see performance measurements for STIBP, but
based on what we've seen with IBRS in user space, I'd guess that it's
not pretty.

-- 
Josh
