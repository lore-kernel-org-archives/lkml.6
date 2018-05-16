Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751395AbeEPVCU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:02:20 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:54898 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeEPVCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:02:18 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH v5 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, alexandre.belloni@bootlin.com,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180516103251.74707-1-giulio.benetti@micronovasrl.com>
 <20180516103251.74707-4-giulio.benetti@micronovasrl.com>
 <CAHp75VdC74jW+Vox2ogDVzG17Z3kD0Vg-1du4SeK30WajT7N-Q@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <836407b4-8c51-5efa-8e29-f487bbcb528d@micronovasrl.com>
Date: Wed, 16 May 2018 23:02:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdC74jW+Vox2ogDVzG17Z3kD0Vg-1du4SeK30WajT7N-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 16/05/2018 22:22, Andy Shevchenko ha scritto:
> On Wed, May 16, 2018 at 1:32 PM, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>> On m41txx you can enable open-drain OUT pin to check if offset is ok.
>> Enabling OUT pin with frequency_test_enable attribute, OUT pin will tick
>> 512 times faster than 1s tick base.
>>
>> Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
>> +static ssize_t frequency_test_enable_store(struct device *dev,
>> +                                          struct device_attribute *attr,
>> +                                          const char *buf, size_t count)
>> +{
>> +       struct ds1307 *ds1307 = dev_get_drvdata(dev);
>> +       unsigned long freq_test = 0;
>> +       int retval;
>> +
>> +       retval = kstrtoul(buf, 10, &freq_test);
>> +       if ((retval < 0) || (retval > 1)) {
> 
> kstrtobool() then?

Yes, you're right.

> 
>> +               dev_err(dev, "Failed to store RTC Frequency Test attribute\n");
> 
>> +               return -EINVAL;
> 
> ...and do not shadow actual error code.

Ok

> 
>> +       }
>> +
>> +       regmap_update_bits(ds1307->regmap, M41TXX_REG_CONTROL, M41TXX_BIT_FT,
>> +                          freq_test ? M41TXX_BIT_FT : 0);
>> +
> 
>> +       return retval ? retval : count;
> 
> Does the condition make any sense?

You're right, not at all.
I changed it into:
"return count;"

> 
>> +}
> 
>> +static ssize_t frequency_test_enable_show(struct device *dev,
>> +                                         struct device_attribute *attr,
>> +                                         char *buf)
>> +{
> 
>> +       int freq_test_en = 0;
> 
>> +       if (ctrl_reg & M41TXX_BIT_FT)
>> +               freq_test_en = true;
>> +       else
>> +               freq_test_en = false;
>> +
>> +       return sprintf(buf, "%d\n", freq_test_en);
> 
> So, is it boolean or integer? This code makes it confusing a lot.

It is a boolean, so now I've updated with this:

if (ctrl_reg & M41TXX_BIT_FT)
	return scnprintf(buf, PAGE_SIZE, "on\n");
else
	return scnprintf(buf, PAGE_SIZE, "off\n");

> 
>> +}
> 

Thank you very much for review

Giulio Benetti
