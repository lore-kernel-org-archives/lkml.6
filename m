Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932544AbeCMUtz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:49:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:63227 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752149AbeCMUty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:49:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,466,1515484800";
   d="scan'208";a="33559886"
Subject: Re: [PATCH V2] perf/x86/intel/uncore: Querying number of CHAs from
 CAPID6 register
To: "Kroening, Gary" <gary.kroening@hpe.com>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
Cc: "Travis, Mike" <mike.travis@hpe.com>,
        "Banman, Andrew" <abanman@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1520967094-13219-1-git-send-email-kan.liang@linux.intel.com>
 <CS1PR84MB01181FC374E9E14AD2EA6618F6D20@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <822804d4-2301-e292-74c0-3b7212994c75@linux.intel.com>
Date: Tue, 13 Mar 2018 16:49:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CS1PR84MB01181FC374E9E14AD2EA6618F6D20@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/2018 4:24 PM, Kroening, Gary wrote:
> I've tested this patch on the same set of hubless (single-segment) and scalable (segment-per-socket) configurations as for Kan's version 1.
> 
> As far as we can tell this will also work for Cascade Lake, but will need revisiting for Ice Lake.

For Ice lake, there will be another method to query the number of CHAs.
This patch is only for Skylake server.

Thanks,
Kan

> 
> Thanks.
> Gary
> 
>> -----Original Message-----
>> From: kan.liang@linux.intel.com [mailto:kan.liang@linux.intel.com]
>> Sent: Tuesday, March 13, 2018 1:52 PM
>> To: mingo@redhat.com; hpa@zytor.com; tglx@linutronix.de;
>> peterz@infradead.org; andy.shevchenko@gmail.com
>> Cc: Kroening, Gary; Travis, Mike; Banman, Andrew; Sivanich, Dimitri;
>> Anderson, Russ; x86@kernel.org; linux-kernel@vger.kernel.org; Kan Liang
>> Subject: [PATCH V2] perf/x86/intel/uncore: Querying number of CHAs from
>> CAPID6 register
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The number of CHAs is miscalculated on multi PCI domain systems on
>> Skylake server.
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
>>
>> Changes since V1:
>>   - add missed pci_dev_put()
>>   - Drop ugly casting by using hweight32()
>>   - Add comments for macros.
>>
>>   arch/x86/events/intel/uncore_snbep.c | 31 +++++++++++++++++--------------
>>   1 file changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore_snbep.c
>> b/arch/x86/events/intel/uncore_snbep.c
>> index 6d8044a..8970f71 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -3562,24 +3562,27 @@ static struct intel_uncore_type *skx_msr_uncores[]
>> = {
>>   	NULL,
>>   };
>>
>> +/*
>> + * To determine the number of CHAs, it should read bits 27:0 in the
>> CAPID6
>> + * register which located at Device 30, Function 3, Offset 0x9C. PCI ID
>> 0x2083.
>> + */
>> +#define SKX_CAPID6		0x9c
>> +#define SKX_CHA_BIT_MASK	GENMASK(27, 0)
>> +
>>   static int skx_count_chabox(void)
>>   {
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
>> +		goto out;
>>
>> -	pci_dev_put(chabox_dev);
>> -	return count;
>> +	pci_read_config_dword(dev, SKX_CAPID6, &val);
>> +	val &= SKX_CHA_BIT_MASK;
>> +out:
>> +	pci_dev_put(dev);
>> +	return hweight32(val);
>>   }
>>
>>   void skx_uncore_cpu_init(void)
>> --
>> 2.7.4
> 
