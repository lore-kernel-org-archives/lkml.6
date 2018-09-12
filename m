Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B485C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37742146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37742146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeIMCw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 22:52:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:47502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbeIMCw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 22:52:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8AD04B062;
        Wed, 12 Sep 2018 21:45:57 +0000 (UTC)
Date:   Wed, 12 Sep 2018 23:45:54 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 2/2] x86/speculation: Enable cross-hyperthread spectre
 v2 STIBP mitigation
In-Reply-To: <d098fa9b-f244-68d2-77f2-e3f5dd30f174@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1809122330090.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809101123520.15880@cbobk.fhfr.pm> <alpine.DEB.2.21.1809101158080.1402@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1809101259520.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809101343370.15880@cbobk.fhfr.pm>
 <f0fcbcd9-4619-391e-3c1b-34d06b00de50@linux.intel.com> <alpine.DEB.2.21.1809112315320.1427@nanos.tec.linutronix.de> <f95c28d6-70f2-3f18-4ab9-c756c7581126@amd.com> <d098fa9b-f244-68d2-77f2-e3f5dd30f174@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Tim Chen wrote:

> I'm working on a patch for choosing the Spectre v2 app to app
> mitigation option.
> 
> Something like the following:
> 
> enum spectre_v2_app2app_mitigation {
>         SPECTRE_V2_APP2APP_NONE,
>         SPECTRE_V2_APP2APP_LITE,
>         SPECTRE_V2_APP2APP_IBPB,
>         SPECTRE_V2_APP2APP_STIBP,
>         SPECTRE_V2_APP2APP_STRICT,
> };
> 
> static const char *spectre_v2_app2app_strings[] = {
>         [SPECTRE_V2_APP2APP_NONE]               = "App-App Vulnerable",
>         [SPECTRE_V2_APP2APP_LITE]               = "App-App Mitigation: Protect only non-dumpable process",
>         [SPECTRE_V2_APP2APP_IBPB]               = "App-App Mitigation: Protect app against attack from same cpu",
>         [SPECTRE_V2_APP2APP_STIBP]              = "App-App Mitigation: Protect app against attack from sibling cpu",
>         [SPECTRE_V2_APP2APP_STRICT]             = "App-App Mitigation: Full app to app attack protection",
> };
> 
> So the APP2APP_LITE protection's intention is to turn on STIBP and IBPB for non-dumpable
> process.  But in my first version I may limit it to IBPB as choosing
> STIBP based on process characteristics will require some frobbing of
> the flags as what we've done in SSBD.  That will require more careful
> work and tests.
> 
> The STRICT option will turn STIBP on always and IBPB always on
> non-ptraceable context switches.
> 
> Is this something reasonable?

It's probably 100% correct, but it's also 100% super-complex at the same 
time if you ask me.

Try to imagine you're a very advanced senior sysadmin, who has heard that 
spectre and meltdown existed of course, but figured out that updating to 
latest kernel/distro vendor update fixes all the security issues (and it 
actually indeed did).

Now, all of a sudden, this new option pops up, and the poor sysadmin has 
to make a decision again.

	"Do you care only about security across non-dumpable process 
	 boundaries?"

	"Scheduled to same CPU at the time of attack? Can you guarantee that this 
	 is (not) happening?"

	"If the processess can actually ptrace/debug each other, are you okay with 
	 them attacking each other?"

	 "Shared HT siblings return target buffer, do you want it or 
	  not?"

These are the questions that even an excellent sysadmin might not have 
qualified answers to so far. Now, all of a sudden, he/her has to make 
these decisions?

I don't think that's how it should work. It all should be digestible by 
"linux end-users" (where users are also super-advanced sysadmins) easily.

We currently have "I do care about spectrev2 / I don't care about 
spectrev2" boot-time switch, and I don't see us going any deeper / more 
fine-grained without sacrificing clarity and sanity.

Or do you see a way how to do that nicely?

Thanks,

-- 
Jiri Kosina
SUSE Labs

