Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2699C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B187A208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B187A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeK0HoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:44:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbeK0HoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:44:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D9D28CAF;
        Mon, 26 Nov 2018 20:48:43 +0000 (UTC)
Received: from sky.random (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35C47608E6;
        Mon, 26 Nov 2018 20:48:43 +0000 (UTC)
Date:   Mon, 26 Nov 2018 15:48:42 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, thomas.lendacky@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 27/28] x86/speculation: Add seccomp Spectre v2 user
 space protection mode
Message-ID: <20181126204842.GC16136@redhat.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185006.051663132@linutronix.de>
 <CAHk-=whtiX45YPjFPMFuktZ3WB23zqBZR-rL6RewrTyvrFj2Fw@mail.gmail.com>
 <alpine.DEB.2.21.1811252321300.1684@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811252321300.1684@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 26 Nov 2018 20:48:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Nov 25, 2018 at 11:28:59PM +0100, Thomas Gleixner wrote:
> Indeed. Just checked the documentation again, it's also not clear whether
> IBPB is required if STIPB is in use.

I tried to ask this question too earlier:

https://lkml.kernel.org/r/20181119234528.GJ29258@redhat.com

If the BTB mistraining in SECCOMP context with STIBP set in SPEC_CTRL,
can still influence the hyperthreading sibling after STIBP is cleared,
IBPB is needed before clearing STIBP. Otherwise it's not. Unless told
otherwise, it'd be safe to assume IBPB is needed in such case.

The SPEC_CTRL MSR specs seems a catch-all lowest common denominator
and so intuition or measurement of the exact behavior in one CPU
model, don't necessarily give a result that can be applied to all
microcodes out there.

Thanks,
Andrea
