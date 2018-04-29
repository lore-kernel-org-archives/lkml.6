Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753880AbeD2Q1R (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 12:27:17 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45142 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753546AbeD2Q1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 12:27:15 -0400
X-Google-Smtp-Source: AB8JxZoB45+pnv59Nju2XdCicWtIiJb36d4LWWPJHR5lG0ZioB4wp7rdiN/m1G8MOgkTpfcrlMKDIA==
Subject: Re: [PATCH 2/2] hwmon: (k10temp) Display both Tctl and Tdie
To: Gabriel C <nix.or.die@gmail.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Brian Woods <brian.woods@amd.com>
References: <1524798789-2239-1-git-send-email-linux@roeck-us.net>
 <1524798789-2239-2-git-send-email-linux@roeck-us.net>
 <CAEJqkggcXnTWwNvidc=qG5fWFu8Q-6uGtrapi88e5t3u7wD12Q@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c4ff12d1-b529-aa71-b9a7-760e2f7d9794@roeck-us.net>
Date: Sun, 29 Apr 2018 09:27:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkggcXnTWwNvidc=qG5fWFu8Q-6uGtrapi88e5t3u7wD12Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29/2018 09:13 AM, Gabriel C wrote:
> 2018-04-27 5:13 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:
>> On some AMD CPUs, there is a different between the die temperature
>> (Tdie) and the reported temperature (Tctl). Tdie is the real measured
>> temperature, and Tctl is used for fan control. Lets report both for
>> affected CPUs.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/k10temp.c | 55 ++++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 48 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>> index b06bb1f90853..1135b8f1ad0f 100644
>> --- a/drivers/hwmon/k10temp.c
>> +++ b/drivers/hwmon/k10temp.c
>> @@ -80,6 +80,7 @@ struct k10temp_data {
>>          void (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
>>          int temp_offset;
>>          u32 temp_adjust_mask;
>> +       bool show_tdie;
>>   };
>>
>>   struct tctl_offset {
>> @@ -140,17 +141,24 @@ static void read_tempreg_nb_f17(struct pci_dev *pdev, u32 *regval)
>>                            F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
>>   }
>>
>> -static ssize_t temp1_input_show(struct device *dev,
>> -                               struct device_attribute *attr, char *buf)
>> +unsigned int get_raw_temp(struct k10temp_data *data)
>>   {
>> -       struct k10temp_data *data = dev_get_drvdata(dev);
>> -       u32 regval;
>>          unsigned int temp;
>> +       u32 regval;
>>
>>          data->read_tempreg(data->pdev, &regval);
>>          temp = (regval >> 21) * 125;
>>          if (regval & data->temp_adjust_mask)
>>                  temp -= 49000;
>> +       return temp;
>> +}
>> +
>> +static ssize_t temp1_input_show(struct device *dev,
>> +                               struct device_attribute *attr, char *buf)
>> +{
>> +       struct k10temp_data *data = dev_get_drvdata(dev);
>> +       unsigned int temp = get_raw_temp(data);
>> +
>>          if (temp > data->temp_offset)
>>                  temp -= data->temp_offset;
>>          else
>> @@ -159,6 +167,23 @@ static ssize_t temp1_input_show(struct device *dev,
>>          return sprintf(buf, "%u\n", temp);
>>   }
>>
>> +static ssize_t temp2_input_show(struct device *dev,
>> +                               struct device_attribute *devattr, char *buf)
>> +{
>> +       struct k10temp_data *data = dev_get_drvdata(dev);
>> +       unsigned int temp = get_raw_temp(data);
>> +
>> +       return sprintf(buf, "%u\n", temp);
>> +}
>> +
>> +static ssize_t temp_label_show(struct device *dev,
>> +                              struct device_attribute *devattr, char *buf)
>> +{
>> +       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> +
>> +       return sprintf(buf, "%s\n", attr->index ? "Tctl" : "Tdie");
>> +}
>> +
>>   static ssize_t temp1_max_show(struct device *dev,
>>                                struct device_attribute *attr, char *buf)
>>   {
>> @@ -187,16 +212,23 @@ static DEVICE_ATTR_RO(temp1_max);
>>   static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL, 0);
>>   static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, show_temp_crit, NULL, 1);
>>
>> +static SENSOR_DEVICE_ATTR(temp1_label, 0444, temp_label_show, NULL, 0);
>> +static DEVICE_ATTR_RO(temp2_input);
>> +static SENSOR_DEVICE_ATTR(temp2_label, 0444, temp_label_show, NULL, 1);
>> +
>>   static umode_t k10temp_is_visible(struct kobject *kobj,
>>                                    struct attribute *attr, int index)
>>   {
>>          struct device *dev = container_of(kobj, struct device, kobj);
>>          struct k10temp_data *data = dev_get_drvdata(dev);
>>          struct pci_dev *pdev = data->pdev;
>> +       u32 reg;
>>
>> -       if (index >= 2) {
>> -               u32 reg;
>> -
>> +       switch (index) {
>> +       case 0 ... 1:   /* temp1_input, temp1_max */
>> +       default:
>> +               break;
>> +       case 2 ... 3:   /* temp1_crit, temp1_crit_hyst */
>>                  if (!data->read_htcreg)
>>                          return 0;
>>
>> @@ -208,6 +240,11 @@ static umode_t k10temp_is_visible(struct kobject *kobj,
>>                  data->read_htcreg(data->pdev, &reg);
>>                  if (!(reg & HTC_ENABLE))
>>                          return 0;
>> +               break;
>> +       case 4 ... 6:   /* temp1_label, temp2_input, temp2_label */
>> +               if (!data->show_tdie)
>> +                       return 0;
>> +               break;
>>          }
>>          return attr->mode;
>>   }
>> @@ -217,6 +254,9 @@ static struct attribute *k10temp_attrs[] = {
>>          &dev_attr_temp1_max.attr,
>>          &sensor_dev_attr_temp1_crit.dev_attr.attr,
>>          &sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
>> +       &sensor_dev_attr_temp1_label.dev_attr.attr,
>> +       &dev_attr_temp2_input.attr,
>> +       &sensor_dev_attr_temp2_label.dev_attr.attr,
>>          NULL
>>   };
>>
>> @@ -292,6 +332,7 @@ static int k10temp_probe(struct pci_dev *pdev,
>>          } else if (boot_cpu_data.x86 == 0x17) {
>>                  data->temp_adjust_mask = 0x80000;
>>                  data->read_tempreg = read_tempreg_nb_f17;
>> +               data->show_tdie = true;
>>          } else {
>>                  data->read_htcreg = read_htcreg_pci;
>>                  data->read_tempreg = read_tempreg_pci;
>> --
>> 2.7.4
>>
> 
> On my EPYC box Tdie and Tctl seems to have the same value.
> However the code is working fine and both values are displayed now.
> 

Yes, that is as expected; EPYC CPUs don't have a temperature offset
between Tctl and Tdie (at least not as far as I know). Tctl is the value
reported by the chip; if I recall correctly, it is in the low 20s on
your system if it is idle. If there was an offset, Tdie would be reported
as an even lower temperature, ie in the 10s, which would not make sense.

> Tested-by: Gabriel Craciunescu <nix.or.die@gmail.com>
> 
Thanks a lot for testing!

Guenter

> Regards
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
