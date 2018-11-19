Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164EDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC35320870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC35320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbeKTGEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:04:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:42392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728295AbeKTGEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:04:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18243AF80;
        Mon, 19 Nov 2018 19:39:43 +0000 (UTC)
Date:   Mon, 19 Nov 2018 20:39:41 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [Patch v5 11/16] x86/speculation: Add Spectre v2 app to app
 protection modes
In-Reply-To: <20181119193253.GE29258@redhat.com>
Message-ID: <nycvar.YFH.7.76.1811192035590.21108@cbobk.fhfr.pm>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com> <nycvar.YFH.7.76.1811171044510.21108@cbobk.fhfr.pm> <nycvar.YFH.7.76.1811182358370.21108@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1811191433100.1537@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811191438290.21108@cbobk.fhfr.pm> <20181119193253.GE29258@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Andrea Arcangeli wrote:

> Generally speaking the untrusted code that would try to use spectrev2
> to attack the other processes is more likely to run inside SECCOMP
> jail than outside, so if SECCOMP should be used as a best effort
> heuristic to decide when to enable STIBP, it would make more sense to
> enable STIBP outside SECCOMP, and not inside. I.e. the exact opposite
> of what you're proposing above.

Hmm, that's a very good point. But I actually don't see why both 
directions wouldn't be possible real-blackhat-world scenarios. So perhaps 
we'd want, under the basic asumption that "SECCOMP should really be 
sandboxed from outisde interventions and from causing them from inside as 
well", flush on both switch-to-seccomp and switch-from-seccomp?

> Code running under SECCOMP is not necessarily less performance critical 
> so if we don't protect what's outside, I doubt we should protect what's 
> inside.
> 
> In short I doubt we can make an association between SECCOMP and STIBP
> here and we should leave SECCOMP alone this time.
> 
> The prctl is a nice to have feature, but it is more for specialized
> apps like gpg that aren't performance critical anyway.
> 
> The system wide default is more a decision the admin should do without 
> having to add prctl wrappers to all apps or change config files. Clearly 
> the prctl won't hurt especially if it can be overridden (and forced off) 
> with the global tweak like with the ssbd options. The only thing I don't 
> understand is why one has to reboot to change the global defaults for 
> ssbd and now STIBP (unless you're already planning to make the global 
> tweak runtime tunable) despite there's no runtime benefit by forcing 
> these decision at boot time only. Would be nice to add runtime tweak 
> options for at least STIBP and SSBD that aren't confined to the prctl.

So if I understand you correctly, what you are proposing here is to keep 
the current code, but just switch the default, and make it 
runtime/boottime togglable?

Thanks,

-- 
Jiri Kosina
SUSE Labs

