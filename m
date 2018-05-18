Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeERNGd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:06:33 -0400
Received: from ozlabs.org ([203.11.71.1]:34489 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752662AbeERNGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:06:00 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc: Enable ASYM_SMT on interleaved big-core systems
In-Reply-To: <20180516050508.GB14826@in.ibm.com>
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com> <1526037444-22876-3-git-send-email-ego@linux.vnet.ibm.com> <1526268127.30369.21.camel@neuling.org> <20180516050508.GB14826@in.ibm.com>
Date: Fri, 18 May 2018 23:05:57 +1000
Message-ID: <87muwxxgei.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:

> On Mon, May 14, 2018 at 01:22:07PM +1000, Michael Neuling wrote:
>> On Fri, 2018-05-11 at 16:47 +0530, Gautham R. Shenoy wrote:
>> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> > 
>> > Each of the SMT4 cores forming a fused-core are more or less
>> > independent units. Thus when multiple tasks are scheduled to run on
>> > the fused core, we get the best performance when the tasks are spread
>> > across the pair of SMT4 cores.
>> > 
>> > Since the threads in the pair of SMT4 cores of an interleaved big-core
>> > are numbered {0,2,4,6} and {1,3,5,7} respectively, enable ASYM_SMT on
>> > such interleaved big-cores that will bias the load-balancing of tasks
>> > on smaller numbered threads, which will automatically result in
>> > spreading the tasks uniformly across the associated pair of SMT4
>> > cores.
>> > 
>> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> > ---
>> >  arch/powerpc/kernel/smp.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> > index 9ca7148..0153f01 100644
>> > --- a/arch/powerpc/kernel/smp.c
>> > +++ b/arch/powerpc/kernel/smp.c
>> > @@ -1082,7 +1082,7 @@ static int powerpc_smt_flags(void)
>> >  {
>> >  	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
>> >  
>> > -	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
>> > +	if (cpu_has_feature(CPU_FTR_ASYM_SMT) || has_interleaved_big_core) {
>> 
>> Shouldn't we just set CPU_FTR_ASYM_SMT and leave this code
> unchanged?
>
> Yes, that would have the same effect. I refrained from doing that
> since I thought CPU_FTR_ASYM_SMT has the "lower numbered threads
> expedite thread-folding" connotation from the POWER7 generation.

The above code is the only use of the feature, so I don't think we need
to worry about any other connotations.

> If it is ok to overload CPU_FTR_ASYM_SMT, we can do what you suggest
> and have all the changes in setup-common.c

Yeah let's do that.

cheers
