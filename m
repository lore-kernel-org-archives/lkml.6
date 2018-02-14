Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161074AbeBNRRR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:17:17 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:38109 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161059AbeBNRRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:17:14 -0500
X-Google-Smtp-Source: AH8x226So6VgeIj/0qP6PJo3luGmrAf8Q6y2aGGnvl3y1iuf2zpfoOA5Mr3Gpqgh83tNsDj5C2HWPA==
Reply-To: minyard@acm.org
Subject: Re: ipmi_si fails to get BMC ID
To: Chris Chiu <chiu@endlessm.com>
Cc: openipmi-developer@lists.sourceforge.net,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
References: <CAB4CAwfino0JaeeZV1byp3aoaRrOGL1=BYgkruvxYMr6=c=5PQ@mail.gmail.com>
 <3b812894-46a0-3c87-1b9f-468fc63ea5bd@acm.org>
 <CAB4CAwdTa=A78hr4ZrHNpCwJBo3-kmdK8nq1ZS_k0VanPm0dMw@mail.gmail.com>
 <afea7262-4b56-55be-803c-8f89d3b3b567@acm.org>
 <CAB4CAwfeBXzA156hsR0u6bmxXq8NutSq+4iW5fbhrXRx0qSm7Q@mail.gmail.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <78761f14-acc1-dc00-64d1-97aee4e42c02@acm.org>
Date: Wed, 14 Feb 2018 11:17:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAB4CAwfeBXzA156hsR0u6bmxXq8NutSq+4iW5fbhrXRx0qSm7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm removing Greg and Arnd from the email, I don't think this requires 
their participation.



On 02/13/2018 08:44 PM, Chris Chiu wrote:
> On Fri, Feb 9, 2018 at 9:34 PM, Corey Minyard <minyard@acm.org> wrote:
>> On 02/08/2018 09:09 PM, Chris Chiu wrote:
>>> On Thu, Feb 8, 2018 at 11:53 PM, Corey Minyard <minyard@acm.org> wrote:
>>>> On 02/07/2018 09:01 PM, Chris Chiu wrote:
>>>>> Hi,
>>>>>        We are working with a new desktop Acer Veriton Z4640G and get
>>>>> stumbled on failing to enter S3 suspend with kernel version 4.14 even
>>>>> the latest 4.15+. Here's the kernel log
>>>>> https://gist.github.com/mschiu77/76888f1fd4eb56aa8959d76759a912bb.
>>>>
>>>> This is a little strange, nobody had reported this before.  Can you
>>>> reproduce this
>>>> at will, or was it a one-time thing?
>>> It can be reproduced on each reboot.
>>>> Does the IPMI driver always take this long to issue that error, even if
>>>> you
>>>> are not
>>>> entering sleep state?
>>>>
>>> Yep, it will always print "ipmi_si 0000:02:00.3: There appears to be
>>> no BMC at this
>>> location" few minutes after boot.
>>>
>>>> And it started with 4.14, and didn't occur before then, right?
>>>>
>>> I haven't try pre-4.14 kernel. Will do that and update here.
>>
>> Ah.  It's probably still worth trying, but I doubt it will make any
>> difference.
>>
>> Are you sure there is actually an IPMI BMC installed in this system?  It
>> might
>> be a plug-in card that is not installed, but the interface still appears on
>> the
>> PCI bus.  So there is enough hardware to go part-way through the motions
>> of being an IPMI interface, but not enough to actually work.
>>
>> If there is a BMC there, do you know the register layout?  The IPMI spec has
>> an algorithm to go through to discover some of the parameters, and the
>> driver follows it, but IMHO it's not really very good.  I'll need to know
>> the
>> size of the registers, and the spacing between the registers.
>>
>> -corey
>>
>>
> Sorry for late response because it's close to Chinese New Year.
> I can get the IPMI working with the driver here on Windows.
> https://www.drivermax.com/Realtek-Virtual-IPMI-Realtek-PCI-VEN-10EC-DEV-816C-1_0_0718_2013-2013-07-18-509795-driver.htm
> Then you will see the device (hightlighted) on the control panel as follows
> https://pasteboard.co/H7xm3fJ.png

Hmm, Windows has a built-in IPMI driver.  I wonder why the aren't using 
that.
And I don't know what "Virtual IPMI" means.

> I don't know how to get the register layout you need. I can only take a
> picture of the content of the PCI resources.
> https://pasteboard.co/H7xnhz0.png
>
> The contents of BAR1, BAR3, BAR5 are all 0xff. Can you point me out
> where the useful information might be and I can try to dump FYI.

This whole thing sounds like they have created a non-standard IPMI interface
and put it on the PCI bus like a standard one.  Unless we can get 
documentation
for this, there's not much I can do but blacklist it.

Do you have any ties with Realtek?  I can't find anything on their web 
site related
to IPMI.

-corey

>
> Chris
>
>>>> There's a bug in the PCI utils database, I submitted a report a while
>>>> ago.
>>>> This is
>>>> a KCS, not a SMIC interface.
>>>>
>>>> It looks like the driver is trying to detect that there is a device out
>>>> there and
>>>> there is something that kind of works, but doesn't work completely. The
>>>> interface
>>>> specific code was all split out into separate files in 4.14.  It is
>>>> possible
>>>> the
>>>> detection code got messed up in the process.  Nothing jumps out looking
>>>> at
>>>> the code differences, and I know it works on some PCI machines.
>>>>
>>>> Assuming this is reproducible, can you send the the output of a pre-4.14
>>>> kernel?  If that doesn't make it obvious I may have to have access to the
>>>> machine itself.
>>>>
>>>> -corey
>>>>
>>>>
>>> It's an All-in-One machine so I think it would be difficult for
>>> shipment. I'll see what
>>> I can do. Thanks for help.
>>>
>>> Chris
>>>
>>>>>        As you see, it is due to "ipmi_probe+0x430/0x430 [ipmi_si]". After
>>>>> the message "ipmi_si 0000:02:00.3: There appears to be no BMC at this
>>>>> location" shows up, then it can really go to suspend w/o problem.
>>>>> Although it took around 3 mins. The IPMI device is probed from PCI and
>>>>> here's the output of lspci
>>>>> https://gist.github.com/mschiu77/33f0372be41670d8a69c97e64f833087. The
>>>>> IPMI device is "02:00.3 IPMI SMIC interface [0c07]". We get stuck here
>>>>> because we don't really know why it took so long in try_get_dev_id() /
>>>>> ipmi_si_intf.c. Any suggestion about this to help us moving forward?
>>>>> Thanks
>>>>>
>>>>>
>>>>> Chris
>>>>
>>>>
