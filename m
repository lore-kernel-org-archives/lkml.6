Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1AAC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D501C23F71
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D501C23F71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeFVJNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:13:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42150 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeFVJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:13:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so817059edr.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 02:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wHc8GcehQSwbWr8/frinbF57cpnb1LSGtQr+vaiAOZ4=;
        b=WOCL6L+eXz1CJLl9fGzjpcee2MjYYmAIhhwdyYCDhaJQ0j7hl1dw/7dRBhVwlJHeIH
         d8g6MPE/Dfhvcbu7F13XtQt1r3VS9dgKE+XVNUKPjpxYkdui1kgnOPKy1xyXjkzdU03b
         JfVReg03g1YVvb56bm+yugWBjBPLidgBQl45lTHiTBnQeyyKmUz2Y/8vCJJG3it0MYPo
         FXfrWyVeHXd+S7B+9o71u00vD1tw3ZeurXk6d6tn73krNJK/2oybgedN8EPukXoXtrAS
         4qYRKuAhT7xmJa5uRLf2yEFiHfI2Pf3CkKanT63jjeIiHJ6ulBhePuVq9FrN+NsT63lO
         WQKg==
X-Gm-Message-State: APt69E2jOiiNqRl+5PZZJHHziS/pJgR3whqJFKzxMQ+VVVCxAXVlsDgi
        dyEKwdwO8fXdj5AwHotPej76Pw==
X-Google-Smtp-Source: ADUXVKI89aW4iYtX5d7WHBilXg9hsbExwJxkhZmqvMRJrY/edx0gFWEoTR+fjGQ+x0+uxa5uUzqjsA==
X-Received: by 2002:a50:dac9:: with SMTP id s9-v6mr1125184edj.241.1529658789085;
        Fri, 22 Jun 2018 02:13:09 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s21-v6sm3057020edr.62.2018.06.22.02.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 02:13:08 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] HID: i2c-hid: Use devm to allocate i2c_hid struct
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Doug Anderson <dianders@chromium.org>
References: <20180622022717.134300-1-swboyd@chromium.org>
 <20180622022717.134300-2-swboyd@chromium.org>
 <CAO-hwJJxSHqwEcypc-PVSDUoOSM4OHcOP18QJpoxq6OqKcbq-w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <095738e5-eb31-905b-b496-0d78489e253d@redhat.com>
Date:   Fri, 22 Jun 2018 11:13:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAO-hwJJxSHqwEcypc-PVSDUoOSM4OHcOP18QJpoxq6OqKcbq-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22-06-18 09:16, Benjamin Tissoires wrote:
> On Fri, Jun 22, 2018 at 4:27 AM, Stephen Boyd <swboyd@chromium.org> wrote:
>> Use devm here to save some lines and prepare for bulk regulator usage in
>> this driver. Otherwise, when we devm bulk get regulators we'll free the
>> containing i2c_hid structure and try to put regulator pointers from
>> freed memory.
>>
>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Dmitry Torokhov <dtor@chromium.org>
>> Cc: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>   drivers/hid/i2c-hid/i2c-hid.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
>> index c1652bb7bd15..c7d6738dc524 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid.c
>> @@ -1002,18 +1002,18 @@ static int i2c_hid_probe(struct i2c_client *client,
>>                  return client->irq;
>>          }
>>
>> -       ihid = kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
>> +       ihid = devm_kzalloc(&client->dev, sizeof(*ihid), GFP_KERNEL);
> 
> IIRC, I never made the switch towards devm for i2c_hid because at the
> time there was a "all or nothing" rule regarding devm.

I'm not aware of any such rule. Sure ideally everything should use
devm, because it makes life just so much easier. But I've seen mixed
use in plenty of cases.

With that said converting fully to devm is not necessarily a bad
idea.

Regards,

Hans


> But given that the regulator already has a devm inside, I think we are
> screwed here and we should probably try to devm-ize the module.
> 
> I seem to remember that someone posted a devm version of
> hid_allocate_device/hid-add_device, but I don't think this ever went
> upstream (because no use).
> 
> Otherwise, for the series:
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Cheers,
> Benjamin
> 
> 
> 
>>          if (!ihid)
>>                  return -ENOMEM;
>>
>>          if (client->dev.of_node) {
>>                  ret = i2c_hid_of_probe(client, &ihid->pdata);
>>                  if (ret)
>> -                       goto err;
>> +                       return ret;
>>          } else if (!platform_data) {
>>                  ret = i2c_hid_acpi_pdata(client, &ihid->pdata);
>>                  if (ret)
>> -                       goto err;
>> +                       return ret;
>>          } else {
>>                  ihid->pdata = *platform_data;
>>          }
>> @@ -1126,7 +1126,6 @@ static int i2c_hid_probe(struct i2c_client *client,
>>
>>   err:
>>          i2c_hid_free_buffers(ihid);
>> -       kfree(ihid);
>>          return ret;
>>   }
>>
>> @@ -1150,8 +1149,6 @@ static int i2c_hid_remove(struct i2c_client *client)
>>
>>          regulator_disable(ihid->pdata.supply);
>>
>> -       kfree(ihid);
>> -
>>          return 0;
>>   }
>>
>> --
>> Sent by a computer through tubes
>>
