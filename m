Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754133AbeD2SXd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 14:23:33 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36875 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753764AbeD2SXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 14:23:32 -0400
X-Google-Smtp-Source: AB8JxZp4FlhrVC9d5eJUVs1zoV2JIkt75LkK11jpIZqzq8XG9wsMALcjCBVbPqbTWQ1tH/1ziAreug==
Subject: Re: [PATCH 2/2] hwmon: (k10temp) Use API function to access System
 Management Network
To: Gabriel C <nix.or.die@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Clemens Ladisch <clemens@ladisch.de>, X86 ML <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Brian Woods <brian.woods@amd.com>
References: <1524966879-9424-1-git-send-email-linux@roeck-us.net>
 <1524966879-9424-2-git-send-email-linux@roeck-us.net>
 <2db436f9-a335-9e25-d177-23095c2527ff@roeck-us.net>
 <CAEJqkggwaQL3H-F=eJ5CWAMp0NNxQnbLkPK1LcUfP8ihsbJ-wA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b271675b-348d-ee1a-b488-28aa7d3e5c46@roeck-us.net>
Date: Sun, 29 Apr 2018 11:23:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkggwaQL3H-F=eJ5CWAMp0NNxQnbLkPK1LcUfP8ihsbJ-wA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29/2018 11:19 AM, Gabriel C wrote:
> 2018-04-29 19:46 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:
>> On 04/28/2018 06:54 PM, Guenter Roeck wrote:
>>>
>>> The SMN (System Management Network) on Family 17h AMD CPUs is also
>>> accessed
>>> from other drivers, specifically EDAC. Accessing it directly is racy.
>>> On top of that, accessing the SMN through root bridge 00:00 is wrong on
>>> multi-die CPUs and may result in reading the temperature from the wrong
>>> die. Use available API functions to fix the problem.
>>>
>>> For this to work, also change the Raven Ridge PCI device ID to point to
>>> Data Fabric Function 3, since this ID is used by the API functions to
>>> find the CPU node.
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>>    drivers/hwmon/k10temp.c | 11 ++++++-----
>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>>> index b06bb1f90853..00e785afae0d 100644
>>> --- a/drivers/hwmon/k10temp.c
>>> +++ b/drivers/hwmon/k10temp.c
>>> @@ -23,6 +23,7 @@
>>>    #include <linux/init.h>
>>>    #include <linux/module.h>
>>>    #include <linux/pci.h>
>>> +#include <asm/amd_nb.h>
>>>    #include <asm/processor.h>
>>>      MODULE_DESCRIPTION("AMD Family 10h+ CPU core temperature monitor");
>>> @@ -40,8 +41,8 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>>>    #define PCI_DEVICE_ID_AMD_17H_DF_F3   0x1463
>>>    #endif
>>>    -#ifndef PCI_DEVICE_ID_AMD_17H_RR_NB
>>> -#define PCI_DEVICE_ID_AMD_17H_RR_NB    0x15d0
>>> +#ifndef PCI_DEVICE_ID_AMD_17H_RR_DF_F3
>>> +#define PCI_DEVICE_ID_AMD_17H_RR_DF_F3 0x14eb
>>
>>
>> This should have been 0x15eb. I'll resend after a week or so, waiting for
>> more feedback.
> 
> 
> re-tested with that too .. Doesn't seems to matter here ..
> 

Yes, that only matters for Raven Ridge CPUs (eg 2200G, 2400G).

Thanks,
Guenter

> with original patch:
> 
> crazy@ant:~/Work/Linux/linux$ sensors
> k10temp-pci-00f3
> Adapter: PCI adapter
> Tdie:         +22.2°C  (high = +70.0°C)
> Tctl:         +22.2°C
> 
> k10temp-pci-00e3
> Adapter: PCI adapter
> Tdie:         +23.8°C  (high = +70.0°C)
> Tctl:         +23.8°C
> 
> k10temp-pci-00d3
> Adapter: PCI adapter
> Tdie:         +23.0°C  (high = +70.0°C)
> Tctl:         +23.0°C
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> Tdie:         +25.0°C  (high = +70.0°C)
> Tctl:         +25.0°C
> 
> k10temp-pci-00fb
> Adapter: PCI adapter
> Tdie:         +22.8°C  (high = +70.0°C)
> Tctl:         +22.8°C
> 
> k10temp-pci-00eb
> Adapter: PCI adapter
> Tdie:         +23.2°C  (high = +70.0°C)
> Tctl:         +23.2°C
> 
> k10temp-pci-00db
> Adapter: PCI adapter
> Tdie:         +22.8°C  (high = +70.0°C)
> Tctl:         +22.8°C
> 
> k10temp-pci-00cb
> Adapter: PCI adapter
> Tdie:         +22.6°C  (high = +70.0°C)
> Tctl:         +22.6°C
> 
> now with 0x15eb
> 
> crazy@ant:~/Work/Linux/linux$ sudo rmmod k10temp
> crazy@ant:~/Work/Linux/linux$ git grep -w PCI_DEVICE_ID_AMD_17H_RR_DF_F3
> arch/x86/kernel/amd_nb.c:#define PCI_DEVICE_ID_AMD_17H_RR_DF_F3 0x15eb
> arch/x86/kernel/amd_nb.c:       { PCI_DEVICE(PCI_VENDOR_ID_AMD,
> PCI_DEVICE_ID_AMD_17H_RR_DF_F3) },
> drivers/hwmon/k10temp.c:#ifndef PCI_DEVICE_ID_AMD_17H_RR_DF_F3
> drivers/hwmon/k10temp.c:#define PCI_DEVICE_ID_AMD_17H_RR_DF_F3  0x15eb
> drivers/hwmon/k10temp.c:        { PCI_VDEVICE(AMD,
> PCI_DEVICE_ID_AMD_17H_RR_DF_F3) },
> crazy@ant:~/Work/Linux/linux$ sudo insmod ./drivers/hwmon/k10temp.ko
> crazy@ant:~/Work/Linux/linux$ sensors
> k10temp-pci-00f3
> Adapter: PCI adapter
> Tdie:         +22.2°C  (high = +70.0°C)
> Tctl:         +22.2°C
> 
> k10temp-pci-00e3
> Adapter: PCI adapter
> Tdie:         +23.8°C  (high = +70.0°C)
> Tctl:         +23.8°C
> 
> k10temp-pci-00d3
> Adapter: PCI adapter
> Tdie:         +23.0°C  (high = +70.0°C)
> Tctl:         +23.0°C
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> Tdie:         +25.0°C  (high = +70.0°C)
> Tctl:         +25.0°C
> 
> k10temp-pci-00fb
> Adapter: PCI adapter
> Tdie:         +22.9°C  (high = +70.0°C)
> Tctl:         +22.9°C
> 
> k10temp-pci-00eb
> Adapter: PCI adapter
> Tdie:         +23.2°C  (high = +70.0°C)
> Tctl:         +23.2°C
> 
> k10temp-pci-00db
> Adapter: PCI adapter
> Tdie:         +22.8°C  (high = +70.0°C)
> Tctl:         +22.8°C
> 
> k10temp-pci-00cb
> Adapter: PCI adapter
> Tdie:         +22.8°C  (high = +70.0°C)
> Tctl:         +22.8°C
> 
> 
>>
>>>    #endif
>>>      /* CPUID function 0x80000001, ebx */
>>> @@ -136,8 +137,8 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev,
>>> u32 *regval)
>>>      static void read_tempreg_nb_f17(struct pci_dev *pdev, u32 *regval)
>>>    {
>>> -       amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0x60,
>>> -                         F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
>>> +       amd_smn_read(amd_pci_dev_to_node_id(pdev),
>>> +                    F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
>>>    }
>>>      static ssize_t temp1_input_show(struct device *dev,
>>> @@ -323,7 +324,7 @@ static const struct pci_device_id k10temp_id_table[] =
>>> {
>>>          { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
>>>          { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
>>>          { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>>> -       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_RR_NB) },
>>> +       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_RR_DF_F3) },
>>>          {}
>>>    };
>>>    MODULE_DEVICE_TABLE(pci, k10temp_id_table);
>>>
>>
> 
