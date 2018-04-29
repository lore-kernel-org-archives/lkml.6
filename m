Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeD2SUc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 14:20:32 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45790 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754017AbeD2SUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 14:20:30 -0400
X-Google-Smtp-Source: AB8JxZpezsi1TqN1WGSYt7D0TrfVfJ8aD2e89FQMZ8Ea+eN60d0KE/Y/qzMfGr/s/CenbY+VKb1ReJcyXC8nWFI6Qe0=
MIME-Version: 1.0
In-Reply-To: <2db436f9-a335-9e25-d177-23095c2527ff@roeck-us.net>
References: <1524966879-9424-1-git-send-email-linux@roeck-us.net>
 <1524966879-9424-2-git-send-email-linux@roeck-us.net> <2db436f9-a335-9e25-d177-23095c2527ff@roeck-us.net>
From: Gabriel C <nix.or.die@gmail.com>
Date: Sun, 29 Apr 2018 20:19:58 +0200
Message-ID: <CAEJqkggwaQL3H-F=eJ5CWAMp0NNxQnbLkPK1LcUfP8ihsbJ-wA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (k10temp) Use API function to access System
 Management Network
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Clemens Ladisch <clemens@ladisch.de>, X86 ML <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Brian Woods <brian.woods@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3TIKcU6027378

2018-04-29 19:46 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:
> On 04/28/2018 06:54 PM, Guenter Roeck wrote:
>>
>> The SMN (System Management Network) on Family 17h AMD CPUs is also
>> accessed
>> from other drivers, specifically EDAC. Accessing it directly is racy.
>> On top of that, accessing the SMN through root bridge 00:00 is wrong on
>> multi-die CPUs and may result in reading the temperature from the wrong
>> die. Use available API functions to fix the problem.
>>
>> For this to work, also change the Raven Ridge PCI device ID to point to
>> Data Fabric Function 3, since this ID is used by the API functions to
>> find the CPU node.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/k10temp.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>> index b06bb1f90853..00e785afae0d 100644
>> --- a/drivers/hwmon/k10temp.c
>> +++ b/drivers/hwmon/k10temp.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/init.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>> +#include <asm/amd_nb.h>
>>   #include <asm/processor.h>
>>     MODULE_DESCRIPTION("AMD Family 10h+ CPU core temperature monitor");
>> @@ -40,8 +41,8 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>>   #define PCI_DEVICE_ID_AMD_17H_DF_F3   0x1463
>>   #endif
>>   -#ifndef PCI_DEVICE_ID_AMD_17H_RR_NB
>> -#define PCI_DEVICE_ID_AMD_17H_RR_NB    0x15d0
>> +#ifndef PCI_DEVICE_ID_AMD_17H_RR_DF_F3
>> +#define PCI_DEVICE_ID_AMD_17H_RR_DF_F3 0x14eb
>
>
> This should have been 0x15eb. I'll resend after a week or so, waiting for
> more feedback.


re-tested with that too .. Doesn't seems to matter here ..

with original patch:

crazy@ant:~/Work/Linux/linux$ sensors
k10temp-pci-00f3
Adapter: PCI adapter
Tdie:         +22.2°C  (high = +70.0°C)
Tctl:         +22.2°C

k10temp-pci-00e3
Adapter: PCI adapter
Tdie:         +23.8°C  (high = +70.0°C)
Tctl:         +23.8°C

k10temp-pci-00d3
Adapter: PCI adapter
Tdie:         +23.0°C  (high = +70.0°C)
Tctl:         +23.0°C

k10temp-pci-00c3
Adapter: PCI adapter
Tdie:         +25.0°C  (high = +70.0°C)
Tctl:         +25.0°C

k10temp-pci-00fb
Adapter: PCI adapter
Tdie:         +22.8°C  (high = +70.0°C)
Tctl:         +22.8°C

k10temp-pci-00eb
Adapter: PCI adapter
Tdie:         +23.2°C  (high = +70.0°C)
Tctl:         +23.2°C

k10temp-pci-00db
Adapter: PCI adapter
Tdie:         +22.8°C  (high = +70.0°C)
Tctl:         +22.8°C

k10temp-pci-00cb
Adapter: PCI adapter
Tdie:         +22.6°C  (high = +70.0°C)
Tctl:         +22.6°C

now with 0x15eb

crazy@ant:~/Work/Linux/linux$ sudo rmmod k10temp
crazy@ant:~/Work/Linux/linux$ git grep -w PCI_DEVICE_ID_AMD_17H_RR_DF_F3
arch/x86/kernel/amd_nb.c:#define PCI_DEVICE_ID_AMD_17H_RR_DF_F3 0x15eb
arch/x86/kernel/amd_nb.c:       { PCI_DEVICE(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_17H_RR_DF_F3) },
drivers/hwmon/k10temp.c:#ifndef PCI_DEVICE_ID_AMD_17H_RR_DF_F3
drivers/hwmon/k10temp.c:#define PCI_DEVICE_ID_AMD_17H_RR_DF_F3  0x15eb
drivers/hwmon/k10temp.c:        { PCI_VDEVICE(AMD,
PCI_DEVICE_ID_AMD_17H_RR_DF_F3) },
crazy@ant:~/Work/Linux/linux$ sudo insmod ./drivers/hwmon/k10temp.ko
crazy@ant:~/Work/Linux/linux$ sensors
k10temp-pci-00f3
Adapter: PCI adapter
Tdie:         +22.2°C  (high = +70.0°C)
Tctl:         +22.2°C

k10temp-pci-00e3
Adapter: PCI adapter
Tdie:         +23.8°C  (high = +70.0°C)
Tctl:         +23.8°C

k10temp-pci-00d3
Adapter: PCI adapter
Tdie:         +23.0°C  (high = +70.0°C)
Tctl:         +23.0°C

k10temp-pci-00c3
Adapter: PCI adapter
Tdie:         +25.0°C  (high = +70.0°C)
Tctl:         +25.0°C

k10temp-pci-00fb
Adapter: PCI adapter
Tdie:         +22.9°C  (high = +70.0°C)
Tctl:         +22.9°C

k10temp-pci-00eb
Adapter: PCI adapter
Tdie:         +23.2°C  (high = +70.0°C)
Tctl:         +23.2°C

k10temp-pci-00db
Adapter: PCI adapter
Tdie:         +22.8°C  (high = +70.0°C)
Tctl:         +22.8°C

k10temp-pci-00cb
Adapter: PCI adapter
Tdie:         +22.8°C  (high = +70.0°C)
Tctl:         +22.8°C


>
>>   #endif
>>     /* CPUID function 0x80000001, ebx */
>> @@ -136,8 +137,8 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev,
>> u32 *regval)
>>     static void read_tempreg_nb_f17(struct pci_dev *pdev, u32 *regval)
>>   {
>> -       amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0x60,
>> -                         F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
>> +       amd_smn_read(amd_pci_dev_to_node_id(pdev),
>> +                    F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
>>   }
>>     static ssize_t temp1_input_show(struct device *dev,
>> @@ -323,7 +324,7 @@ static const struct pci_device_id k10temp_id_table[] =
>> {
>>         { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
>>         { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
>>         { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>> -       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_RR_NB) },
>> +       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_RR_DF_F3) },
>>         {}
>>   };
>>   MODULE_DEVICE_TABLE(pci, k10temp_id_table);
>>
>
