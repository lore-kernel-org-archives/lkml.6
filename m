Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754625AbeBGPWT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:22:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54116 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754570AbeBGPWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:22:19 -0500
Date: Wed, 7 Feb 2018 16:21:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Stanislav Kozina <skozina@redhat.com>
Cc: Petr Oros <poros@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/intel: print previous microcode revision
 during early update
Message-ID: <20180207152158.GB8698@pd.tnic>
References: <20180126103451.16863-1-poros@redhat.com>
 <20180126104109.slxxoq4vkqytqjxd@pd.tnic>
 <1516967135.2801.1.camel@redhat.com>
 <20180126115800.bvqrzik2f3hmmiah@pd.tnic>
 <1516974600.2801.10.camel@redhat.com>
 <20180126144918.7jiaezmdhjsiman5@pd.tnic>
 <1518012133.13585.13.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518012133.13585.13.camel@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 03:02:13PM +0100, Stanislav Kozina wrote:
> Although Spectre might be the most visible CPU issue, it's not the only
> one. What if some issue causes failure during early microcode update?

And you think failure to update early microcode will allow you to see
*anything* printed on the screen?

All the upgrade failures I've seen so far result in freezes and triple
faults.

> What if the issue triggers only on update from a certain microcode
> version? We should be transparent about what microcode version we
> update from and to.

We blacklist those microcode revisions. And we're transparent:

	pr_warn("Intel Spectre v2 broken microcode detected; disabling Speculation Control\n");

Note that we *don't* issue the old revision here either.

We issue it only for this one moronic late loading case where the
erratum is limited to a certain model of certain size and with certain
minimum revision (and when the moon and the sun are aligned properly):

        if (c->x86 == 6 &&
            c->x86_model == INTEL_FAM6_BROADWELL_X &&
            c->x86_mask == 0x01 &&
            llc_size_per_core > 2621440 &&
            c->microcode < 0x0b000021) {
                pr_err_once("Erratum BDF90: late loading with revision < 0x0b000021 (0x%x) disabled.\n", c->microcode);

because there we have a minimal good version.

And mind you, we don't really need it there either because we have
blacklisted the old revision and user can see it in /proc/cpuinfo.

> The double reboot with "dis_ucode_ldr" argument requires to schedule a
> full system reboot just to figure out what version has been provided by
> the system firmware.

With the proper blacklisting code - which is already upstream:

a5b296636453 ("x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early Spectre v2 microcodes")

you don't need to do any of that. You either get the upgrade or you
don't and if you don't, speculation control gets disabled.

> The current microcode version is already printed in the dmesg. Many
> people do care what revision they are running and what provided this
> revision. It is the most important information on triaging CPU issues,
> especially if anything goes awry.

The microcode revision is the most important information on triaging CPU
issues??!?! Yeah, right.

It sounds to me you're just grasping for arguments to validate having
the previous revision in dmesg.

Gah, how hard is it to understand: the microcode revision is a detail
like a gazillion other details pertaining to a platform.

Look at the commit above: that's 23 *different* revisions. Now, if you
wanna talk about a blacklisted revision, you need to add the CPU *model*
*and* *stepping* to the report too because those revisions are per model
and stepping.

And I wouldn't be surprised if some revisions are also *additionally*
determined by platform flags and whatnot.

That's making it worse, not better.

Now let's take a step back: you don't really need the previous revision
in the spectre case! Not really.

Why?

Well:

1. if the blacklisted revision can be safely updated to a good one, then
you don't care.

2. If it cannot be safely updated by the OS microcode loading mechanism,
then printing the previous revision doesn't help either: there you need
to *disable* the updating of the microcode so that the machine remains
somewhat usable and the update doesn't make it worse.

Still don't need the old revision printed.

3. If it is one of those blacklisted patches which makes the box
explode, then you more than ever don't need printing the old revision -
you need to disable updating to the blacklisted microcode.

So there's not a single case where you need to print the old revision
and confuse bug reporters and debuggers.

Instead, you need to get the proper blacklisting mechanism in place.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
