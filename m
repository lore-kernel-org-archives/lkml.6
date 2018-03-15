Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeCOOy2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:54:28 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47317 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752218AbeCOOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:54:26 -0400
X-ME-Sender: <xms:IYmqWq8TxNI4Dlzm8mea9i2CR1Chg1qtKTQ6Hcthx8inGkej3Z8stw>
Date: Thu, 15 Mar 2018 11:54:21 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Emanuel Czirai <xftroxgpx@protonmail.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [PATCH 2/2] x86/microcode: Fix CPU synchronization routine
Message-ID: <20180315145421.7n6rky4b5vaqnrxt@khazad-dum.debian.net>
References: <20180314183615.17629-1-bp@alien8.de>
 <20180314183615.17629-2-bp@alien8.de>
 <20180315010014.xsedkarzrgqiunxf@khazad-dum.debian.net>
 <20180315010152.GE11061@pd.tnic>
 <20180315040132.m3i3ozykkbjrxa66@khazad-dum.debian.net>
 <20180315095803.GB27816@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315095803.GB27816@pd.tnic>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Borislav Petkov wrote:
> it is injecting faults and attempting to manipulate some size field -
> I'm guessing the encrypted data size. And I'm also guessing that if you
> manipulate that size, it would simply take a lot longer to attempt to
> decrypt and verify that it is broken microcode and reject it. So it is
> not actually a real update - it is just taking a lot longer to reject
> it.

That paper measures the sucessful updates too (see below).

That the fault injection tests took less cycles than the sucessful
updates did, is not explicitly written in the paper.  IMO, it is implied
by "fig 7" and also by the text nearby and immediately after "fig 8"
(looking at the html version of the paper), though.

> Now, I'm talking about genuine microcode updates. And that paper also
> claims that they take thousands of cycles.

"Observation #4" in the paper is the sucessful non-fault-injection, i.e.
regular microcode update measurement.  Here's the numbers from the paper
for a regular, sucessfull update on a Core i5 M460 (microcode revisions
were not disclosed by the paper):

Average:  488953 cycles
Std. Dev:  12270 cycles.

What I observed on my Xeon X5550 (signature 0x106a5, microcode update is
~10KiB in size) matches what the paper describes: the Xeon X5550 has
microcode updates that are a little bigger than the ones for the Core i5
M460 (signature 0x20655, microcode update is ~3KiB in size).

This is not a potshot at Intel.  Their microcode update loader does a
lot of work, so it would make sense for it to take a lot of cycles to do
it.  AFAIK, it is doing RSA-2048 decription in microcode, updating
several internal subsystems as well as the MCRAM, etc.

> Now let's look at your previous, hm, "statement":
> 
> > Intel takes anything from twenty thousand cycles to several *million*
> > cycles per core, proportional to microcode update size.
> 
> So you took a fault injection measurement out of context to claim that
> *regular* microcode updates take millions of cycles.

I tested a *few* interations of sucessful, regular microcode updates on
a Xeon X5550, and it matched the magnitude of the number of cycles given
in the paper for a successful, regular microcode update.

I claimed an intel microcode update would take from 20000 to millions of
cycles depending on update size, based on:

1. the paper's description and measurements of how the loader does the
   signature validation;

2. the fact that a 10KiB update took ~800000 cycles on a Xeon X5550 core
   (the BSP, data I measured myself), and that a 3KiB update took ~480000
   cycles in average on a Core i5 M460 (data from the inertiawar paper).

Now, this might be comparing two different subspecies of oranges, so I
did try to run my measurement patch at a Core i5-2500 I had access to,
so as to compare *regular*, sucessfull microcode early updates using the
same kernel on two different processors.

I recall the results on the i5-2500 were coherent with the paper's
findings and the results for the Xeon X5550.  Unfortunately, I have
misplaced the results for the i5-2500, or I would have already provided
them.  According to the notes I found, these tests were done circa
august 2014, and I was not exactly considering them to be important
stuff that needs to be documented and archived properly.

> So you had to say something - doesn't matter if it is apples and oranges
> - as long as it is dramatic. Fuck the truth.

I do believe that [intel microcode updates on recent processors take
hundreds of thousands of cycles up to millions of cycles in the worst
case] to be the truth from both my reading of that paper, and my own
simple attempts to verify the time it took for a sucessful, regular
microcode update.

If I am wrong about this, it will be because I measured things
incorrectly, and that would also be true for the inertiawar paper as far
as I can tell.

I am certainly not doing anything out of malice, or trying to be
dramatic.  Please consider that you presently believe that an Intel
microcode update [on recent processors] takes on the order of thousands
of cycles per core, where I presently believe it takes at least a
hundred times more cycles than that.

Wouldn't that difference in beliefs, regardless of which one is correct,
account for any of my comments related to microcode update cycle cost
appearing to be overly dramatic to you?

It was not my intention to annoy or upset you, and I had no idea we
expected intel microcode updates to have cycle costs that are two to
three orders of magnitude apart, so I never took that into account on
any of my comments.

> > When I measured my Xeon X5550 workstation doing an early update, the
> > Xeon took about 1M cycles for the BSP, and 800k cycles for the APs (see
> > below).
> >
> > To measure that, as far as I recall I just did a rdtsc right before the
> 
> RDTSC gets executed speculatively, so you need barriers around it. I
> hope you added them.

I searched for, and found some old notes I took at the time.  FWIW:

I did not have speculation barriers before the WRMSR that does the
microcode update.  There was a compiler barrier() only, as in
"barrier(); time1 = get_cycles(); WRMSR".  But that WRMSR is supposed to
be a serializing instruction, and it does seem to behave like that.

I did have a compiler barrier() right after the second rdtsc, and a
sync_core() fully serializing barrier a bit later in the code flow, but
before I used any of the rdtsc results.

I did look at the resulting object code at the time, and the rdtsc calls
were at the proper place before and after the wrmsr instruction, as
expected given the use of barrier() to get the compiler to behave.  And
the CPUID implementing sync_core() was between the rdtsc, and the code
that used the result.

>From my notes, I did not use local_irq_disable(), since I was
instrumenting the early loader.  That might have skewed the results for
the BSP if interrupts were already being serviced at that point.

The fact that I did not have a sync_core() right after the second rdtsc
might have added some systematic error, but I would not expect it to be
large enough to matter since the noise was already above 10000 cycles.

Sibling hyperthreads were properly skipped by the early loader as being
already up-to-date.  The cpu ordering on that box also ensured the other
hyperthread of a core was still "offline" (in whatever state it was left
by the BIOS -- no UEFI on that box) while the first was doing the
microcode update: CPU 0-3 were the first hyperthreads of cores 0 to 3,
and CPU 4-7 were the second hyperthreads of cores 0 to 3.

-- 
  Henrique Holschuh
