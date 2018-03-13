Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932751AbeCMM2q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:28:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:54633 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752162AbeCMM2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:28:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,464,1515484800";
   d="scan'208";a="33435486"
Subject: Re: [PATCH 1/1] x86/platform/x86: Fix count of CHas on
 multi-pci-segment arches
To: "Kroening, Gary" <gary.kroening@hpe.com>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>
Cc: "Travis, Mike" <mike.travis@hpe.com>,
        "Banman, Andrew" <abanman@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CS1PR84MB01182561B15688095C4DBF30F6D80@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
 <9efcdfa1-9da3-f4de-749f-0950d20a5758@linux.intel.com>
 <CS1PR84MB0118227E1E8F1257E37C75C3F6D20@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <560d1400-92e9-6f38-d699-011f936d0615@linux.intel.com>
Date: Tue, 13 Mar 2018 08:28:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CS1PR84MB0118227E1E8F1257E37C75C3F6D20@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/2018 1:06 AM, Kroening, Gary wrote:
> Thanks, Kan -- your patch looks good, and cleaner than the previous method!
> 
> Tonight, I've tested it on our in-house simulator for the following configurations. The simulator has been matching hardware well for this issue -- we'll do more testing on real hardware, but I'm confident you have it right.
>

That's great. Thanks a lot for the verification. :)

Thanks,
Kan

> Terminology:
> 
> "hubless" -- equivalent to "glueless" or "white box" where our BIOS sets things up with a single bus for all sockets.
> 
> "scalable" -- BIOS assigns a new segment/domain for each socket
> 
> Configurations tested so far:
> - single-socket hubless/scalable
> - two sockets, scalable
> - four sockets, hubless
> - eight sockets, scalable
> 
> In all cases, skx_count_chabox() is returning 28 for Skylake server.
> Thanks for the quick response!
> Gary
> 
>> -----Original Message-----
>> From: Liang, Kan [mailto:kan.liang@linux.intel.com]
>> Sent: Monday, March 12, 2018 8:43 PM
>> To: Kroening, Gary; mingo@redhat.com; hpa@zytor.com; tglx@linutronix.de;
>> peterz@infradead.org
>> Cc: Travis, Mike; Banman, Andrew; Sivanich, Dimitri; Anderson, Russ;
>> x86@kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/1] x86/platform/x86: Fix count of CHas on multi-pci-
>> segment arches
>>
>>
>>
>> On 3/7/2018 3:33 PM, Kroening, Gary wrote:
>>> For systems with a single PCI segment, it is sufficient to look for the
>>> bus number to change in order to determine that all of the CHa's have
>>> been counted for a single socket.
>>>
>>> However, for multi PCI segment systems, each socket is given a new
>>> segment and the bus number does NOT change.  So looking only for the
>>> bus number to change ends up counting all of the CHa's on all sockets
>>> in the system.  This leads to writing CPU MSRs beyond a valid range and
>>> causes an error in ivbep_uncore_msr_init_box().
>>>
>>> The fix is to check for either the bus number or segment number to
>> change.
>>>
>>
>> Hi Gary,
>>
>> There is a recommended way in uncore document to query the number of
>> CHAs on Skylake server.
>> I have a patch to implement the new way.
>>
>> Could you please take a look at the patch and see if it can fix your
>> issue?
>>
>>
>> Thanks,
>> Kan
>>
>> ------
>>   From 55f54b2fa3021c691c2fd4f5cfc8f441fd104e91 Mon Sep 17 00:00:00 2001
>> From: Kan Liang <kan.liang@linux.intel.com>
>> Date: Mon, 12 Mar 2018 13:03:40 -0700
>> Subject: [PATCH] perf/x86/intel/uncore: Querying number of CHAs from
>> CAPID6 register
>>
>> The number of CHAs is miscalculated on multi PCI domain systems on
>> Skylake server
>>
>> (From Kroening, Gary:
>>
>> For systems with a single PCI segment, it is sufficient to look for the
>> bus number to change in order to determine that all of the CHa's have
>> been counted for a single socket.
>> However, for multi PCI segment systems, each socket is given a new
>> segment and the bus number does NOT change.  So looking only for the
>> bus number to change ends up counting all of the CHa's on all sockets
>> in the system.  This leads to writing CPU MSRs beyond a valid range and
>> causes an error in ivbep_uncore_msr_init_box().)
>>
>> To determine the number of CHAs, it should read bits 27:0 in the CAPID6
>> register located at Device 30, Function 3, Offset 0x9C. These 28 bits
>> form a bit vector of available LLC slices and the CHAs that manage those
>> slices.
>>
>> Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore
>> support")
>> Reported-by: Kroening, Gary <gary.kroening@hpe.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>    arch/x86/events/intel/uncore_snbep.c | 24 ++++++++++--------------
>>    1 file changed, 10 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore_snbep.c
>> b/arch/x86/events/intel/uncore_snbep.c
>> index d4672ed..a42715b 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -3575,24 +3575,20 @@ static struct intel_uncore_type
>> *skx_msr_uncores[] = {
>>    	NULL,
>>    };
>>
>> +#define SKX_CAPID6		0x9c
>> +#define SKX_CHA_BIT_WIDTH	28
>> +
>>    static int skx_count_chabox(void)
>>    {
>> -	struct pci_dev *chabox_dev = NULL;
>> -	int bus, count = 0;
>> +	struct pci_dev *dev = NULL;
>> +	u32 val = 0;
>>
>> -	while (1) {
>> -		chabox_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x208d,
>> chabox_dev);
>> -		if (!chabox_dev)
>> -			break;
>> -		if (count == 0)
>> -			bus = chabox_dev->bus->number;
>> -		if (bus != chabox_dev->bus->number)
>> -			break;
>> -		count++;
>> -	}
>> +	dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x2083, dev);
>> +	if (!dev)
>> +		return 0;
>>
>> -	pci_dev_put(chabox_dev);
>> -	return count;
>> +	pci_read_config_dword(dev, SKX_CAPID6, &val);
>> +	return bitmap_weight((unsigned long *)&val, SKX_CHA_BIT_WIDTH);
>>    }
>>
>>    void skx_uncore_cpu_init(void)
>> --
>> 2.7.4
> 
