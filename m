Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeDFKMR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 06:12:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52973 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbeDFKMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 06:12:14 -0400
X-Google-Smtp-Source: AIpwx48UK2SniaxPgHCOXFgjuVkU/YSnZ0sEp3ADc+VkTIfO7mkw+DZdamBwNuX+CcIMuo2hDjR0fA==
Subject: Re: [PATCH] ata: ahci-platform: add reset control support
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Patrice CHOTARD <patrice.chotard@st.com>, Tejun Heo <tj@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org"
        <linux-mediatek@lists.infradead.org>
References: <20180406134838.2ADC.4A936039@socionext.com>
 <22a2bcd7-eff5-c20f-e056-f5946e579d5e@redhat.com>
 <20180406183623.CA38.4A936039@socionext.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <68d50624-d31b-09cf-210e-9fb7c73b5df0@redhat.com>
Date: Fri, 6 Apr 2018 12:12:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406183623.CA38.4A936039@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-04-18 11:36, Kunihiko Hayashi wrote:
> Hi Hans,
> 
> On Fri, 6 Apr 2018 10:29:37 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi,
>>
>> On 06-04-18 06:48, Kunihiko Hayashi wrote:
>>> Hi Hans,
>>>> On Thu, 5 Apr 2018 16:08:24 +0200
>>> Hans de Goede <hdegoede@redhat.com> wrote:
>>>>> Hi,
>>>>
>>>> On 05-04-18 16:00, Hans de Goede wrote:
>>>>> Hi,
>>>>>> On 05-04-18 15:54, Thierry Reding wrote:
>>>>>> On Thu, Apr 05, 2018 at 03:27:03PM +0200, Hans de Goede wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 05-04-18 15:17, Patrice CHOTARD wrote:
>>>>>>>> Hi Thierry
>>>>>>>>
>>>>>>>> On 04/05/2018 11:54 AM, Thierry Reding wrote:
>>>>>>>>> On Fri, Mar 23, 2018 at 10:30:53AM +0900, Kunihiko Hayashi wrote:
>>>>>>>>>> Add support to get and control a list of resets for the device
>>>>>>>>>> as optional and shared. These resets must be kept de-asserted until
>>>>>>>>>> the device is enabled.
>>>>>>>>>>
>>>>>>>>>> This is specified as shared because some SoCs like UniPhier series
>>>>>>>>>> have common reset controls with all ahci controller instances.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>>>>>>>> ---
>>>>>>>>>> ??? .../devicetree/bindings/ata/ahci-platform.txt????? |? 1 +
>>>>>>>>>> ??? drivers/ata/ahci.h???????????????????????????????? |? 1 +
>>>>>>>>>> ??? drivers/ata/libahci_platform.c???????????????????? | 24 +++++++++++++++++++---
>>>>>>>>>> ??? 3 files changed, 23 insertions(+), 3 deletions(-)
>>>>>>>>>
>>>>>>>>> This causes a regression on Tegra because we explicitly request the
>>>>>>>>> resets after the call to ahci_platform_get_resources().
>>>>>>>>
>>>>>>>> I confirm, we got exactly the same behavior on STi platform.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> ?? From a quick look, ahci_mtk and ahci_st are in the same boat, adding the
>>>>>>>>> corresponding maintainers to Cc.
>>>>>>>>>
>>>>>>>>> Patrice, Matthias: does SATA still work for you after this patch? This
>>>>>>>>> has been in linux-next since next-20180327.
>>>>>>>>
>>>>>>>> SATA is still working after this patch, but a kernel warning is
>>>>>>>> triggered due to the fact that resets are both requested by
>>>>>>>> libahci_platform and by ahci_st driver.
>>>>>>>
>>>>>>> So in your case you might be able to remove the reset handling
>>>>>>> from the ahci_st driver and rely on the new libahci_platform
>>>>>>> handling instead? If that works that seems like a win to me.
>>>>>>>
>>>>>>> As said elsewhere in this thread I think it makes sense to keep (or re-add
>>>>>>> after a revert) the libahci_platform reset code, but make it conditional
>>>>>>> on a flag passed to ahci_platform_get_resources(). This way we get
>>>>>>> the shared code for most cases and platforms which need special handling
>>>>>>> can opt-out.
>>>>>>
>>>>>> Agreed, although I prefer such helpers to be opt-in, rather than
>>>>>> opt-out. In my experience that tends make the helpers more resilient to
>>>>>> this kind of regression. It also simplifies things because instead of
>>>>>> drivers saying "I want all the helpers except this one and that one",
>>>>>> they can simply say "I want these helpers and that one". In the former
>>>>>> case whenever you add some new (opt-out) feature, you have to update all
>>>>>> drivers and add the exception. In the latter you only need to extend the
>>>>>> drivers that want to make use of the new helper.
>>>>
>>>> Erm, the idea never was to make this opt-out but rather opt in, so
>>>> we add a flags parameter to ahci_platform_get_resources() and all
>>>> current users pass in 0 for that to keep the current behavior.
>>>>
>>>> And only the generic drivers/ata/ahci_platform.c driver will pass
>>>> in a the new AHCI_PLATFORM_GET_RESETS flag, which makes
>>>> ahci_platform_get_resources() (and the other functions) also deal
>>>> with resets.
>>>>
>>>>>> With that in mind, rather than adding a flag to the
>>>>>> ahci_platform_get_resources() function, it might be more flexible to
>>>>>> split the helpers into finer-grained functions. That way drivers can
>>>>>> pick whatever functionality they want from the helpers.
>>>>>> Good point, so lets:
>>>>>> 1) Revert the patch for now
>>>>> 2) Have a new version of the patch which adds a ahci_platform_get_resets() helper
>>>>> 3) Modify the generic drivers/ata/ahci_platform.c driver to call the new
>>>>>    ?? ahci_platform_get_resets() between its ahci_platform_get_resources()
>>>>>    ?? and ahci_platform_enable_resources() calls.
>>>>>    ?? I think that ahci_platform_enable_resources() should still automatically
>>>>>    ?? do the right thing wrt resets if ahci_platform_get_resets() was called
>>>>>    ?? (otherwise the resets array will be empty and should be skipped)
>>>>>> This should make the generic driver usable for the UniPhier SoCs and
>>>>> maybe some other drivers like the ahci_st driver can also switch to the
>>>>> new ahci_platform_get_resets() functionality to reduce their code a bit.
>>>>
>>>> So thinking slightly longer about this, with the opt-in variant
>>>> (which is what I intended all along) I do think that a flags parameter
>>>> is better, because the whole idea behind lib_ahci_platform is to avoid
>>>> having to do err = get_resource_a(), if (err) bail, err = get_resource_b()
>>>> if (err) bail, etc. in all the ahci (platform) drivers. And having fine
>>>> grained helpers re-introduces that.
>>>> In case of adding a flag instead of get_resource_a(),
>>> for example, we add the flag for use of resets,
>>>> -struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
>>> +struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>> +                                                  bool use_reset)
>>>> and for now all the drivers using this function need to add the argument as false
>>> to the caller.
>>>> -       hpriv = ahci_platform_get_resources(pdev);
>>> +       hpriv = ahci_platform_get_resources(pdev, false);
>>>> Surely this can avoid adding functions such get_resource_a(). If we apply another
>>> feature later, we add its flag as one of the arguments instead. Is it right?
>>
>> Yes, that is right, but instead of adding a "bool use_reset" please add
>> an "unsigned int flags" parameter instead and a:
>>
>> #define AHCI_PLATFORM_GET_RESETS	0x01
>>
>> And update all callers of ahci_platform_get_resources to pass 0 for flags
>> except for drivers/ata/ahci_platform.c. This way we only need to modify
>> all callers once, and if we want to add another optional resource in
>> the future we can add a:
>>
>> #define AHCI_PLATFORM_GET_FOO		0x02
>>
>> Without needing to change all callers again.
> 
> Indeed. This is more flexible to add another resources.
> 
> Although I'm about to prepare the candidate patch to fix this issue,
> I think we need to revert the previous patch first if some SoCs have
> issues because of it.

Ack. It is probably best if you do a "git revert f0f56716fc3e5d547fd7811eb218a30ed0695605"
on a tree with that commit and then send a patch to Tejun for this.

Regards,

Hans
