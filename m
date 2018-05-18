Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeERNOI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:14:08 -0400
Received: from ozlabs.org ([203.11.71.1]:55491 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751395AbeERNOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:14:06 -0400
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
Subject: Re: [PATCH 1/2] powerpc: Detect the presence of big-core with interleaved threads
In-Reply-To: <20180516043516.GA14826@in.ibm.com>
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com> <1526037444-22876-2-git-send-email-ego@linux.vnet.ibm.com> <1526268071.30369.20.camel@neuling.org> <20180516043516.GA14826@in.ibm.com>
Date: Fri, 18 May 2018 23:14:04 +1000
Message-ID: <87k1s1xg0z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
...
>> > @@ -565,7 +615,16 @@ void __init smp_setup_cpu_maps(void)
>> >  	vdso_data->processorCount = num_present_cpus();
>> >  #endif /* CONFIG_PPC64 */
>> >  
>> > -        /* Initialize CPU <=> thread mapping/
>> > +	dn = of_find_node_by_type(NULL, "cpu");
>> > +	if (dn) {
>> > +		if (check_for_interleaved_big_core(dn)) {
>> > +			has_interleaved_big_core = true;
>> > +			pr_info("Detected interleaved big-cores\n");
>> 
>> Is there a runtime way to check this also?  If the dmesg buffer overflows, we
>> lose this.
>
> Where do you suggest we put this ? Should it be a part of
> /proc/cpuinfo ?

Hmm, it'd be nice not to pollute it with more junk.

Can you just look at the pir files in sysfs?

eg. on a normal system:

  # cd /sys/devices/system/cpu
  # grep . cpu[0-7]/pir
  cpu0/pir:20
  cpu1/pir:21
  cpu2/pir:22
  cpu3/pir:23
  cpu4/pir:24
  cpu5/pir:25
  cpu6/pir:26
  cpu7/pir:27


cheers
