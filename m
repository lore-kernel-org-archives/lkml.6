Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeCMRnB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:43:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:4797 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbeCMRm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:42:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,465,1515484800";
   d="scan'208";a="37868655"
Subject: Re: [PATCH 1/1] x86/platform/x86: Fix count of CHas on
 multi-pci-segment arches
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Kroening, Gary" <gary.kroening@hpe.com>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Travis, Mike" <mike.travis@hpe.com>,
        "Banman, Andrew" <abanman@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CS1PR84MB01182561B15688095C4DBF30F6D80@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
 <9efcdfa1-9da3-f4de-749f-0950d20a5758@linux.intel.com>
 <CAHp75VdYG+i+m12yotuUa2JwW4ndMMXTV0ZSs_qOS5EAw7=M4w@mail.gmail.com>
 <55123ef5-3287-d4c9-4499-62140c598474@linux.intel.com>
Message-ID: <f452e41a-533f-60d5-2e19-9bdbcdc16396@linux.intel.com>
Date: Tue, 13 Mar 2018 13:42:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <55123ef5-3287-d4c9-4499-62140c598474@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/2018 1:16 PM, Liang, Kan wrote:
> 
> 
> On 3/13/2018 11:58 AM, Andy Shevchenko wrote:
>> On Tue, Mar 13, 2018 at 3:42 AM, Liang, Kan 
>> <kan.liang@linux.intel.com> wrote:
>>
>>> +#define SKX_CAPID6             0x9c
>>> +#define SKX_CHA_BIT_WIDTH      28
>>> +
>>>   static int skx_count_chabox(void)
>>>   {
>>> +       struct pci_dev *dev = NULL;
>>> +       u32 val = 0;
>>>
>>
>>> +       dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x2083, dev);
>>> +       if (!dev)
>>> +               return 0;
>>
>> Where is pci_dev_put()?
>>
>>>
>>> +       pci_read_config_dword(dev, SKX_CAPID6, &val);
>>> +       return bitmap_weight((unsigned long *)&val, SKX_CHA_BIT_WIDTH);
>>
>> UB is here.
>> Fix is simple, use unsigned long and drop this ugly casting.
>>

Just noticed that we have to do casting anyway.
pci_read_config_dword uses u32.
bitmap_weight uses unsigned long.

Thanks,
Kan
