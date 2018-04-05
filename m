Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeDEOAS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:00:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53536 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDEOAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:00:16 -0400
X-Google-Smtp-Source: AIpwx487elmzUsIXM6ephhlpNzjvLpKYwjgb7bBLxHAYgJ+sQIFv7F0ky01c6fhEtYsx1Acwdeeb9A==
Subject: Re: [PATCH] ata: ahci-platform: add reset control support
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Patrice CHOTARD <patrice.chotard@st.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tejun Heo <tj@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org"
        <linux-mediatek@lists.infradead.org>
References: <1521768653-11824-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20180405095429.GA7506@ulmo> <e33f54ed-2848-9a4f-9669-7fada8c60326@st.com>
 <1f7d0738-1963-21c5-c293-e46fb0214ecf@redhat.com>
 <20180405135435.GA10860@ulmo>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <6ce60a0b-0409-016a-d29c-91b8b9e2ad07@redhat.com>
Date: Thu, 5 Apr 2018 16:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405135435.GA10860@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05-04-18 15:54, Thierry Reding wrote:
> On Thu, Apr 05, 2018 at 03:27:03PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 05-04-18 15:17, Patrice CHOTARD wrote:
>>> Hi Thierry
>>>
>>> On 04/05/2018 11:54 AM, Thierry Reding wrote:
>>>> On Fri, Mar 23, 2018 at 10:30:53AM +0900, Kunihiko Hayashi wrote:
>>>>> Add support to get and control a list of resets for the device
>>>>> as optional and shared. These resets must be kept de-asserted until
>>>>> the device is enabled.
>>>>>
>>>>> This is specified as shared because some SoCs like UniPhier series
>>>>> have common reset controls with all ahci controller instances.
>>>>>
>>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>>> ---
>>>>>     .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
>>>>>     drivers/ata/ahci.h                                 |  1 +
>>>>>     drivers/ata/libahci_platform.c                     | 24 +++++++++++++++++++---
>>>>>     3 files changed, 23 insertions(+), 3 deletions(-)
>>>>
>>>> This causes a regression on Tegra because we explicitly request the
>>>> resets after the call to ahci_platform_get_resources().
>>>
>>> I confirm, we got exactly the same behavior on STi platform.
>>>
>>>>
>>>>    From a quick look, ahci_mtk and ahci_st are in the same boat, adding the
>>>> corresponding maintainers to Cc.
>>>>
>>>> Patrice, Matthias: does SATA still work for you after this patch? This
>>>> has been in linux-next since next-20180327.
>>>
>>> SATA is still working after this patch, but a kernel warning is
>>> triggered due to the fact that resets are both requested by
>>> libahci_platform and by ahci_st driver.
>>
>> So in your case you might be able to remove the reset handling
>> from the ahci_st driver and rely on the new libahci_platform
>> handling instead? If that works that seems like a win to me.
>>
>> As said elsewhere in this thread I think it makes sense to keep (or re-add
>> after a revert) the libahci_platform reset code, but make it conditional
>> on a flag passed to ahci_platform_get_resources(). This way we get
>> the shared code for most cases and platforms which need special handling
>> can opt-out.
> 
> Agreed, although I prefer such helpers to be opt-in, rather than
> opt-out. In my experience that tends make the helpers more resilient to
> this kind of regression. It also simplifies things because instead of
> drivers saying "I want all the helpers except this one and that one",
> they can simply say "I want these helpers and that one". In the former
> case whenever you add some new (opt-out) feature, you have to update all
> drivers and add the exception. In the latter you only need to extend the
> drivers that want to make use of the new helper.
> 
> With that in mind, rather than adding a flag to the
> ahci_platform_get_resources() function, it might be more flexible to
> split the helpers into finer-grained functions. That way drivers can
> pick whatever functionality they want from the helpers.

Good point, so lets:

1) Revert the patch for now
2) Have a new version of the patch which adds a ahci_platform_get_resets() helper
3) Modify the generic drivers/ata/ahci_platform.c driver to call the new
    ahci_platform_get_resets() between its ahci_platform_get_resources()
    and ahci_platform_enable_resources() calls.
    I think that ahci_platform_enable_resources() should still automatically
    do the right thing wrt resets if ahci_platform_get_resets() was called
    (otherwise the resets array will be empty and should be skipped)

This should make the generic driver usable for the UniPhier SoCs and
maybe some other drivers like the ahci_st driver can also switch to the
new ahci_platform_get_resets() functionality to reduce their code a bit.

Regards,

Hans
