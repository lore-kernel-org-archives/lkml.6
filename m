Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbeD2QMb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 12:12:31 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45484 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbeD2QM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 12:12:29 -0400
X-Google-Smtp-Source: AB8JxZruRhBmMr8gohDlrk3ZDY5/sxwP6+QnJY5divWd60z0KpDeskA/gQQc5SIgWnEGTORsTkfyUg==
Subject: Re: [PATCH v2] hwmon: (k10temp) Fix reading critical temperature
 register
To: Gabriel C <nix.or.die@gmail.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-hwmon@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Brian Woods <brian.woods@amd.com>
References: <1525014504-14742-1-git-send-email-linux@roeck-us.net>
 <CAEJqkgg8tchaUBsupH6_k0pHrOtY52N7iBq0o=8SUAHzNuf+Ug@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e3eab27c-e65c-95f6-0b62-26bfb2e00d3e@roeck-us.net>
Date: Sun, 29 Apr 2018 09:12:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgg8tchaUBsupH6_k0pHrOtY52N7iBq0o=8SUAHzNuf+Ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29/2018 09:03 AM, Gabriel C wrote:
> 2018-04-29 17:08 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:
>> The HTC (Hardware Temperature Control) register has moved
>> for recent chips.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Actually call the new function pointer from show_temp_crit().
>>
>>   drivers/hwmon/k10temp.c | 40 ++++++++++++++++++++++++++++++----------
>>   1 file changed, 30 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>> index d2cc55e21374..34b5448b00be 100644
>> --- a/drivers/hwmon/k10temp.c
>> +++ b/drivers/hwmon/k10temp.c
>> @@ -63,10 +63,12 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>>   #define  NB_CAP_HTC                    0x00000400
>>
>>   /*
>> - * For F15h M60h, functionality of REG_REPORTED_TEMPERATURE
>> - * has been moved to D0F0xBC_xD820_0CA4 [Reported Temperature
>> - * Control]
>> + * For F15h M60h and M70h, REG_HARDWARE_THERMAL_CONTROL
>> + * and REG_REPORTED_TEMPERATURE have been moved to
>> + * D0F0xBC_xD820_0C64 [Hardware Temperature Control]
>> + * D0F0xBC_xD820_0CA4 [Reported Temperature Control]
>>    */
>> +#define F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET    0xd8200c64
>>   #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET    0xd8200ca4
>>
>>   /* F17h M01h Access througn SMN */
>> @@ -74,6 +76,7 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>>
>>   struct k10temp_data {
>>          struct pci_dev *pdev;
>> +       void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
>>          void (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
>>          int temp_offset;
>>          u32 temp_adjust_mask;
>> @@ -98,6 +101,11 @@ static const struct tctl_offset tctl_offset_table[] = {
>>          { 0x17, "AMD Ryzen Threadripper 1910", 10000 },
>>   };
>>
>> +static void read_htcreg_pci(struct pci_dev *pdev, u32 *regval)
>> +{
>> +       pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL, regval);
>> +}
>> +
>>   static void read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
>>   {
>>          pci_read_config_dword(pdev, REG_REPORTED_TEMPERATURE, regval);
>> @@ -114,6 +122,12 @@ static void amd_nb_index_read(struct pci_dev *pdev, unsigned int devfn,
>>          mutex_unlock(&nb_smu_ind_mutex);
>>   }
>>
>> +static void read_htcreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>> +{
>> +       amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
>> +                         F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET, regval);
>> +}
>> +
>>   static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>>   {
>>          amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
>> @@ -160,8 +174,7 @@ static ssize_t show_temp_crit(struct device *dev,
>>          u32 regval;
>>          int value;
>>
>> -       pci_read_config_dword(data->pdev,
>> -                             REG_HARDWARE_THERMAL_CONTROL, &regval);
>> +       data->read_htcreg(data->pdev, &regval);
>>          value = ((regval >> 16) & 0x7f) * 500 + 52000;
>>          if (show_hyst)
>>                  value -= ((regval >> 24) & 0xf) * 500;
>> @@ -181,13 +194,18 @@ static umode_t k10temp_is_visible(struct kobject *kobj,
>>          struct pci_dev *pdev = data->pdev;
>>
>>          if (index >= 2) {
>> -               u32 reg_caps, reg_htc;
>> +               u32 reg;
>> +
>> +               if (!data->read_htcreg)
>> +                       return 0;
>>
>>                  pci_read_config_dword(pdev, REG_NORTHBRIDGE_CAPABILITIES,
>> -                                     &reg_caps);
>> -               pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL,
>> -                                     &reg_htc);
>> -               if (!(reg_caps & NB_CAP_HTC) || !(reg_htc & HTC_ENABLE))
>> +                                     &reg);
>> +               if (!(reg & NB_CAP_HTC))
>> +                       return 0;
>> +
>> +               data->read_htcreg(data->pdev, &reg);
>> +               if (!(reg & HTC_ENABLE))
>>                          return 0;
>>          }
>>          return attr->mode;
>> @@ -268,11 +286,13 @@ static int k10temp_probe(struct pci_dev *pdev,
>>
>>          if (boot_cpu_data.x86 == 0x15 && (boot_cpu_data.x86_model == 0x60 ||
>>                                            boot_cpu_data.x86_model == 0x70)) {
>> +               data->read_htcreg = read_htcreg_nb_f15;
>>                  data->read_tempreg = read_tempreg_nb_f15;
>>          } else if (boot_cpu_data.x86 == 0x17) {
>>                  data->temp_adjust_mask = 0x80000;
>>                  data->read_tempreg = read_tempreg_nb_f17;
>>          } else {
>> +               data->read_htcreg = read_htcreg_pci;
>>                  data->read_tempreg = read_tempreg_pci;
>>          }
>>
>> --
>> 2.7.4
>>
> 
> Tested on 4.17.0-rc2-00398-gcdface520934 , works fine for me.
> 
> Tested-by: Gabriel Craciunescu <nix.or.die@gmail.com>
> 
Thanks a lot!

Guenter
