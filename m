Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbeFELGG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:06:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52863 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeFELGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:06:05 -0400
X-Google-Smtp-Source: ADUXVKI1gllxjIPcy5b2oOtiaJnJabALheXEOXDeNJQqrIxuCC5q5O8l+eL3qf/k+OdqOKuyzBsTbw==
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: Call new led hw_changed API
 on kbd brightness change
To: Benjamin Berg <benjamin@sipsolutions.net>,
        Bastien Nocera <hadess@hadess.net>, Chris Chiu <chiu@endlessm.com>,
        Darren Hart <dvhart@infradead.org>
Cc: Daniel Drake <drake@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Linux Upstreaming Team <linux@endlessm.com>
References: <20180604123238.82200-1-chiu@endlessm.com>
 <ea0b7233-da00-ee24-5138-9f49a63e4a5a@redhat.com>
 <CAD8Lp45FmOMK3B537sKfnC3STtxwspNdoRVKTyaoDnsJ3EMEtg@mail.gmail.com>
 <bad0e19f-e994-110e-fce9-b614233e66aa@redhat.com>
 <20180605023124.GE47042@localhost.localdomain>
 <CAB4CAwc-J3+xaXzKKpFc-UMeuCsX8zbs0S7-a82x2LJcD5r7jA@mail.gmail.com>
 <38cb3527-8480-bdb9-a5d9-b601bc494a5f@redhat.com>
 <71df09bc89619aba975147e6b07920f1dfc2f46f.camel@hadess.net>
 <cd6a5d86-1fdb-2561-1e29-0553be53c41a@redhat.com>
 <94789b55b88ae5a296e1fca3b0311318e7b507ee.camel@hadess.net>
 <0443419b-3147-163b-374d-bb8651b08837@redhat.com>
 <cfb6ff791a9034f8ade738085475e946b3d7519b.camel@sipsolutions.net>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <362131bf-3b6b-58aa-bda6-003f5ffb5e8e@redhat.com>
Date: Tue, 5 Jun 2018 13:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cfb6ff791a9034f8ade738085475e946b3d7519b.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05-06-18 12:46, Benjamin Berg wrote:
> Hey,
> 
> On Tue, 2018-06-05 at 12:31 +0200, Hans de Goede wrote:
>> On 05-06-18 12:14, Bastien Nocera wrote:
>>> On Tue, 2018-06-05 at 12:05 +0200, Hans de Goede wrote:
>>>> On 05-06-18 11:58, Bastien Nocera wrote:
>>>>> [SNIP]
>>>>
>>>> Ok, so what are you suggestion, do you really want to hardcode
>>>> the cycle behavior in the kernel as these 2 patches are doing,
>>>> without any option to intervene from userspace?
>>>>
>>>> As mentioned before in the thread there are several example
>>>> of the kernel deciding to handle key-presses itself, putting
>>>> policy in the kernel and they have all ended poorly (think
>>>> e.g. rfkill, acpi-video dealing with LC brightnesskey presses
>>>> itself).
>>>>
>>>> I guess one thing we could do here is code out both solutions,
>>>> have a module option which controls if we:
>>>>
>>>> 1) Handle this in the kernel as these patches do
>>>> 2) Or send a new KEY_KBDILLUMCYCLE event
>>>>
>>>> Combined with a Kconfig option to select which is the default
>>>> behavior. Then Endless can select 1 for now and then in
>>>> Fedora (which defaults to Wayland now) we could default to
>>>> 2. once all the code for handling 2 is in place.
>>>>
>>>> This is ugly (on the kernel side) but it might be the best
>>>> compromise we can do.
>>>
>>> I don't really mind which option is used, I'm listing the problems with
>>> the different options. If you don't care about Xorg, then definitely go
>>> for adding a new key. Otherwise, processing it in the kernel is the
>>> least ugly, especially given that the key goes through the same driver
>>> that controls the brightness anyway. There's no crazy cross driver
>>> interaction as there was in the other cases you listed.
>>
>> Unfortunately not caring about Xorg is not really an option.
>>
>> Ok, new idea, how about we make g-s-d behavior upon detecting a
>> KEY_KBDILLUMTOGGLE event configurable, if we're on a Mac do a
>> toggle, otherwise do a cycle.
>>
>> Or we could do this through hwdb, then we could add a hwdb entry
>> for this laptop setting the udev property to do a cycle instead of
>> a toggle on receiving the keypress.
> 
> If we are adding hwdb entries anyway to control the userspace
> interpretation of the TOGGLE key, then we could also add the new CYCLE
> key and explicitly re-map it to TOGGLE. That requires slightly more
> logic in hwdb, but it does mean that we could theoretically just drop
> the workaround if we ever stop caring about Xorg.

Hmm, interesting proposal, I say go for it :)

Regards,

Hans
