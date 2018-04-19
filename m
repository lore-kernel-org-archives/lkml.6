Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753592AbeDSMwI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:52:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:55772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeDSMwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:52:06 -0400
Subject: Re: [PATCH] Input: xen-kbdfront - allow better run-time configuration
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, lyan@suse.com,
        boris.ostrovsky@oracle.com
Cc: andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180418150445.9805-1-andr2000@gmail.com>
 <ccb7a33b-7862-9803-fb24-67861d5ecab9@suse.com>
 <2bff035e-303e-d644-5f51-5e64150c097c@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <c833ab0d-746c-c734-3dbe-e02ae7951d1d@suse.com>
Date: Thu, 19 Apr 2018 14:52:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2bff035e-303e-d644-5f51-5e64150c097c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/18 13:44, Oleksandr Andrushchenko wrote:
> On 04/19/2018 02:25 PM, Juergen Gross wrote:
>> On 18/04/18 17:04, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> It is now only possible to control if multi-touch virtual device
>>> is created or not (via the corresponding XenStore entries),
>>> but keyboard and pointer devices are always created.
>> Why don't you want to go that route for keyboard and mouse, too?
>> Or does this really make no sense?
> Well, I would prefer not to touch anything outside Linux and
> this driver. And these settings seem to be implementation specific.
> So, this is why introduce Linux module parameters and don't extend
> the kbdif protocol.
>>> In some cases this is not desirable. For example, if virtual
>>> keyboard device is exposed to Android then the latter won't
>>> automatically show on-screen keyboard as it expects that a
>>> physical keyboard device can be used for typing.
>>>
>>> Make it possible to configure which virtual devices are created
>>> with module parameters:
>>>    - no_ptr_dev=1 if no pointer device needs to be created
>>>    - no_kbd_dev=1 if no keyboard device needs to be created
>>> Keep old behavior by default.
>>>
>>> Signed-off-by: Oleksandr Andrushchenko
>>> <oleksandr_andrushchenko@epam.com>
>>> Suggested-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
>>> Tested-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
>>> ---
>>>   drivers/input/misc/xen-kbdfront.c | 159 +++++++++++++++++-------------
>>>   1 file changed, 92 insertions(+), 67 deletions(-)
>>>
>>> diff --git a/drivers/input/misc/xen-kbdfront.c
>>> b/drivers/input/misc/xen-kbdfront.c
>>> index d91f3b1c5375..a3306aad40b0 100644
>>> --- a/drivers/input/misc/xen-kbdfront.c
>>> +++ b/drivers/input/misc/xen-kbdfront.c
>>> @@ -51,6 +51,16 @@ module_param_array(ptr_size, int, NULL, 0444);
>>>   MODULE_PARM_DESC(ptr_size,
>>>       "Pointing device width, height in pixels (default 800,600)");
>>>   +static unsigned int no_ptr_dev;
>>> +module_param(no_ptr_dev, uint, 0);
>> Use type invbool instead?
> Hm, better bool then? invbool will require parameter name change to
> something like "with_ptr_dev" which might confuse, e.g.
> default was to go with pointer device, now we have with_ptr_dev
> module parameter: do I now need to set it to preserve the old behavior?
> The answer is no (because of invbool), but you have to dig for it.
> 
> Will bool work for you?

As long as the default won't change from today: yes.


Juergen
