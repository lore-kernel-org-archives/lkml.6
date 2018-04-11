Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeDKEcW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 00:32:22 -0400
Received: from emcscan.emc.com.tw ([192.72.220.5]:31946 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeDKEcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 00:32:20 -0400
From: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
To: "'Benjamin Tissoires'" <benjamin.tissoires@redhat.com>
Cc: "'Dmitry Torokhov'" <dmitry.torokhov@gmail.com>,
        "'Oliver Haessler'" <oliver@redhat.com>,
        "'Benjamin Berg'" <bberg@redhat.com>,
        "'open list:HID CORE LAYER'" <linux-input@vger.kernel.org>,
        "'lkml'" <linux-kernel@vger.kernel.org>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com> <20180405235126.GB57189@dtor-ws> <CAO-hwJLY=OR1bk2y9c-6MZzoAYzorH9MEKf70=dnhqz8s-dCQg@mail.gmail.com> <000301d3d08f$24b356b0$6e1a0410$@emc.com.tw> <CAO-hwJKM51-N=ffO2sfZ6-j=L+qEsUt_bFJ+YOdJboROodPmOg@mail.gmail.com>
In-Reply-To: <CAO-hwJKM51-N=ffO2sfZ6-j=L+qEsUt_bFJ+YOdJboROodPmOg@mail.gmail.com>
Subject: RE: [PATCH 0/8] Input: support for latest Lenovo thinkpads (series 80)
Date: Wed, 11 Apr 2018 12:32:17 +0800
Message-ID: <013f01d3d14e$12c570e0$385052a0$@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGx3tF9q04NbCgqaz93Ar88cJmSXgH4DjZEAnkTkxECI3evvgLDIooFo/QIGuA=
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

-----Original Message-----
From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com] 
Sent: Tuesday, April 10, 2018 3:35 PM
To: 廖崇榮
Cc: Dmitry Torokhov; Oliver Haessler; Benjamin Berg; open list:HID CORE LAYER; lkml
Subject: Re: [PATCH 0/8] Input: support for latest Lenovo thinkpads (series 80)

Hi KT,

On Tue, Apr 10, 2018 at 7:45 AM, 廖崇榮 <kt.liao@emc.com.tw> wrote:
> Hi Benjamin,
>
> Thanks so much for your patch.
>
> I have tested them for Elan Gen5/Gen6(new) touchpad with SMbus/PS2.
> It works fine in my thinkpad so far but I find an issue today after lid-close/open.
>
> I am not sure if you can see it in T480S , I "guess" it may be relative to i2c_i801.
>
> The lid-close will enter deep sleep and cut touchpad power.
> I can see the resume flow after lid-open and SMbus-initial try to request hello package but fail.
> Strangely, I can't see any SMbus host signal on LA scope after power-on.

That's weird. I do not see this, by either closing the lid or directly calling 'systemctl suspend'.
On my system, i2c-i801 is also compiled as a module but psmouse is not (directly in vmlinuz).
[KT] : It's good to know your system doesn't meet this problem. 
     My SMbus laptop is an engineer sample in 2015, and PM tell me that NFC attaches to the same bus.
     I guess it's a single case because it's not a stable platform.

>
> I can't switch to SMbus after rmmod/modprobe psmouse because error happen in elantech_create_smbus.

If the SMBus adapter is failing, it is somewhat expected. Reloading psmouse will force a re-trigger of the SMBus probe function, but if the underlying communication fails, there is no way for psmouse to know it failed, so the PS/2 node will disappear. And the SMBus device will not be there.
[KT] : It switch to PS/2 interface after rmmod/modprobe psmouse.

> It will be recovered only if I rmmod/modprobe i2c_i801 first.

Just to be sure, what happens if you rmmod/modprobe elan_i2c instead of i2c_i801?
[KT] :I tried rmmod/modprobe elan_i2c first , but can't recover touchpad. 
    No error printed in the dmesg. I will add more message to check it later.

And which kernel are you running? On a vanilla 4.16 + Dmitry's next branch I do not see such issues.
[KT]: I use 4.15, I may try 4.16 later.

>
> Do you have any idea about it?

If reloading elan_i2c doesn't fix the situation, it must be in i2c_i801. But this is weird that this happens on your platform but not on my t480s going into S3.
[KT] I think so. As I mention that I can't see bus signal on scope. That make me guess it's the bus adaptor issue.
    It's an early-stage engineer system, power Issue will be expected.

Cheers,
Benjamin

>
> Thanks
> KT
> -----Original Message-----
> From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> Sent: Friday, April 06, 2018 2:51 PM
> To: Dmitry Torokhov
> Cc: 廖崇榮; Oliver Haessler; Benjamin Berg; open list:HID CORE LAYER; 
> lkml
> Subject: Re: [PATCH 0/8] Input: support for latest Lenovo thinkpads 
> (series 80)
>
> Hi Dmitry,
>
> On Fri, Apr 6, 2018 at 1:51 AM, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> Hi Benjamin,
>>
>> On Thu, Apr 05, 2018 at 03:25:29PM +0200, Benjamin Tissoires wrote:
>>> Hi Dmitry,
>>>
>>> well, this year, Lenovo gave us a surprise and decided to not use 
>>> the same touchpad/trackstick in all its model. And by default, the 
>>> support under Linux is less than ideal.
>>>
>>> Please find a series that should fix those issues. Compared to the 
>>> 60 series, there do not seem to e BIOS table issues this time, and 
>>> suspend/resume works fine thanks to your latest trackstick fixes.
>>>
>>> The T480s is a different beast, as it uses an Elan touchpad.
>>> I have been carrying the patches 3-6 for a while and tested previous 
>>> versions on various Elan PS/2 hardware without an issue as far as I 
>>> could tell. I was lacking tests from users with SMBus as all the 
>>> laptops I tried where puer PS/2.
>>>
>>> Anyway, it would be cool if you could have a look at the series.
>>
>> I am mostly happy with the series, but I would love to hear KT's take 
>> on it.
>
> thanks for the quick review.
> I worked closely with KT for this series. He helped me a lot for the tiny firmware changes that were required. However, quoting his email from Tuesday:
> "There will be a spring vacation in Taiwan from tomorrow." I guess we won't hear from him until the end of next week as we always have a backlog of urgent things to do after holidays...
>
> Cheers,
> Benjamin
>
