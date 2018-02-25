Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519566602; cv=none;
        d=google.com; s=arc-20160816;
        b=edLXKl7vxVv7ZbjFHalaPeyIdIf/UEozDpdddgUT6RlpZoQO++OeSLhCL+NALsk8HX
         pM7C84yk0Xo+JZNEr1IDFRdN7loJhxTpzUkH8CRkRXUBPbG1ldedSsdkQ3uR4D4y6HiP
         tX4c7RnqmmrAvDxwJgWHH/GrQ5Wo44LMu/AstV+KqHsmxZOk28ZvLsMoNhjObaUwQbUS
         R5Ni3kak0W2oR8rK6m+dvxddhDqGgxxqyD1dd9A+LrVHy9AcY/zIx5T+uh+eB8RH9ouV
         u/pshRevCiROsfGAJQn1uaOS+2iRtm+0Wv9ZhuG9rBfwc3y10f84Vm9C6ErQrFnYldzS
         p3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=E2cT5kdGXlohAuyO1Q8htVEG4wRUXvDc/kGgRKXyWgQ=;
        b=n90sVyKr82OlkOeSOgMgui7Qy367Ur0sSLduztpMp0NYMoqO0prc0/vuC0qka2TKbe
         eE3k6S+9eT1Kk+bcbA1TIRJ2Rbjpr5Ce8OoB14+okoUex/LVjncFHfXR+qBarkP2Hx/Z
         GZuU+KMnn93JyY1QKV8CeA9EiFgMMh3Kl9FglsaeKoUWSyGxko2HwwwbA6ZbgUfRY/TF
         VS1UKZOHh+NxEEA4M1Ft9n/QFIJJUq3Z18fkWAmt7kxZoeDbLY2+Zk10M9zCRjDX0mq1
         kR7KYHUeymo+jVTPOUBOtvUBVhdK+wC74Ap6C7NgHQxMVh2BS71nfSbcLnsrUoSYFyo7
         Yyvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AG47ELsojjCJLlPmsborYhW2OivTWyGnK4Q8asRP+P3uPp5yJu38jdqo3+R+DZUoMqNyf6XFbonEDQ==
Subject: Re: [PATCH 12/12] extcon: axp288: Set USB role where necessary
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Mathias Nyman <mathias.nyman@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 USB <linux-usb@vger.kernel.org>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-13-hdegoede@redhat.com>
 <CAHp75VcNpnx1vknr43sgDPEi8hu9yYRKv2JzOtg+ruuWoik3pg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <5bb7a9d5-c4d2-f48b-f17e-c64cc3b2bb6d@redhat.com>
Date: Sun, 25 Feb 2018 14:49:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcNpnx1vknr43sgDPEi8hu9yYRKv2JzOtg+ruuWoik3pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592554260273548820?=
X-GMAIL-MSGID: =?utf-8?q?1593381070060508691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 16-02-18 14:19, Andy Shevchenko wrote:
> On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The AXP288 BC1.2 charger detection / extcon code may seem like a strange
>> place to add code to control the USB role-switch on devices with an AXP288,
>> but there are 2 reasons to do this inside the axp288 extcon code:
>>
>> 1) On many devices the USB role is controlled by ACPI AML code, but the AML
>>     code only switches between the host and none roles, because of Windows
>>     not really using device mode. To make device mode work we need to toggle
>>     between the none/device roles based on VBus presence, and the axp288
>>     extcon gets interrupts on VBus insertion / removal.
>>
>> 2) In order for our BC1.2 charger detection to work properly the role
>>     mux must be properly set to device mode before we do the detection.
>>
>> Also note the Kconfig help-text / obsolete depends on USB_PHY which are
>> remnants from older never upstreamed code also controlling the mux from
>> the axp288 extcon code.
>>
>> This commit also adds code to get notifications from the INT3496 extcon
>> device, which is used on some devices to notify the kernel about id-pin
>> changes instead of them being handled through AML code.
>>
>> This fixes:
>> -Device mode not working on most CHT devices with an AXP288
>> -Host mode not working on devices with an INT3496 ACPI device
>> -Charger-type misdetection (always SDP) on devices with an INT3496 when the
>>   USB role (always) gets initialized as host
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
>>   config EXTCON_AXP288
>>          tristate "X-Power AXP288 EXTCON support"
>> -       depends on MFD_AXP20X && USB_PHY
>> +       depends on MFD_AXP20X && USB_SUPPORT
>> +       select USB_ROLE_SWITCH
> 
> Is it supposed to work outside of x86 world?..

No.

>> +#include <asm/cpu_device_id.h>
>> +#include <asm/intel-family.h>
> 
> ...if yes, this should go under CONFIG_X86 along with accompanying parts.
> 
> ...if no, put corresponding dependency to Kconfig.

Ack, added the dependency for v2 of the patch-set.

>> +       if (info->role_sw) {
>> +               ret = devm_add_action_or_reset(dev, axp288_put_role_sw, info);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               if (acpi_dev_present("INT3496", NULL, -1)) {
>> +                       info->id_extcon = extcon_get_extcon_dev("INT3496:00");
> 
> Please use instance found by acpi_dev_present(). Okay, actually new
> helper is here:
> acpi_dev_get_first_match_name().

Good call, I've switched to acpi_dev_get_first_match_name() for v2.


> 
>> +                       if (!info->id_extcon)
>> +                               return -EPROBE_DEFER;
>> +
>> +                       dev_info(dev, "controlling USB role\n");
>> +               } else {
>> +                       dev_info(dev, "controlling USB role based on vbus presence\n");
>> +               }
>> +       }
>> +
> 

Andy, Thank you for all the reviews!

Regards,

Hans
