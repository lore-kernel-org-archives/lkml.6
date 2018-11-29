Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16617C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98822145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98822145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeK3JSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:18:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56706 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeK3JSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:18:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B617827C520
Subject: Re: [PATCH v3 8/8] mfd: cros_ec: add a dev_release empty method.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@google.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-9-enric.balletbo@collabora.com>
 <CABXOdTeL6ZC4mfGdU52bkz3-5g-EUL7wMvd-nDjmeBHWM2XSuA@mail.gmail.com>
 <20181127175219.GA30900@kroah.com>
 <CABXOdTehDNf_8DHjua6BTJ-_AA6wcfcis1DPFS5=93sEh-6LQA@mail.gmail.com>
 <20181129075530.GH12347@kroah.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <9239cea5-4101-1247-e8de-b48bb56172bf@collabora.com>
Date:   Thu, 29 Nov 2018 23:11:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181129075530.GH12347@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/11/18 8:55, Greg Kroah-Hartman wrote:
> On Wed, Nov 28, 2018 at 05:17:22PM -0800, Guenter Roeck wrote:
>> Hi Greg,
>>
>> On Tue, Nov 27, 2018 at 9:52 AM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Tue, Nov 27, 2018 at 09:29:38AM -0800, Guenter Roeck wrote:
>>>> Hi Enric,
>>>>
>>>> On Tue, Nov 27, 2018 at 4:19 AM Enric Balletbo i Serra
>>>> <enric.balletbo@collabora.com> wrote:
>>>>>
>>>>> Devices are required to provide a release method. This patch fixes the
>>>>> following WARN():
>>>>>
>>>>> [   47.218707] ------------[ cut here ]------------
>>>>> [   47.223901] Device 'cros_ec' does not have a release() function, it is broken and must be fixed.
>>>>> [   47.234430] WARNING: CPU: 0 PID: 3585 at drivers/base/core.c:895 device_release+0x80/0x90
>>>>> [   47.243560] Modules linked in: btusb btrtl btintel btbcm bluetooth ecdh_generic [...]
>>>>> [   47.323851] CPU: 0 PID: 3585 Comm: rmmod Not tainted 4.20.0-rc2+ #29
>>>>> [   47.330947] Hardware name: Google Kevin (DT)
>>>>> [   47.335714] pstate: 40000005 (nZcv daif -PAN -UAO)
>>>>> [   47.341063] pc : device_release+0x80/0x90
>>>>> [   47.345537] lr : device_release+0x80/0x90
>>>>> [   47.350001] sp : ffff00000b17bc70
>>>>> [   47.353698] x29: ffff00000b17bc70 x28: ffff8000e48e9a80
>>>>> [   47.359629] x27: 0000000000000000 x26: 0000000000000000
>>>>> [   47.365561] x25: 0000000056000000 x24: 0000000000000015
>>>>> [   47.371492] x23: ffff8000f0248060 x22: ffff000000b700a0
>>>>> [   47.377414] x21: ffff8000edf56100 x20: ffff8000edd13028
>>>>> [   47.383346] x19: ffff8000edd13018 x18: 0000000000000095
>>>>> [   47.389278] x17: 0000000000000000 x16: 0000000000000000
>>>>> [   47.395209] x15: 0000000000000400 x14: 0000000000000400
>>>>> [   47.401131] x13: 00000000000001a7 x12: 0000000000000000
>>>>> [   47.407053] x11: 0000000000000001 x10: 0000000000000960
>>>>> [   47.412976] x9 : ffff00000b17b9b0 x8 : ffff8000e48ea440
>>>>> [   47.418898] x7 : ffff8000ee9090c0 x6 : ffff8000f7d0b0b8
>>>>> [   47.424830] x5 : ffff8000f7d0b0b8 x4 : 0000000000000000
>>>>> [   47.430752] x3 : ffff8000f7d11e68 x2 : ffff8000e48e9a80
>>>>> [   47.436674] x1 : 37d859939c964800 x0 : 0000000000000000
>>>>> [   47.442597] Call trace:
>>>>> [   47.445324]  device_release+0x80/0x90
>>>>> [   47.449414]  kobject_put+0x74/0xe8
>>>>> [   47.453210]  device_unregister+0x20/0x30
>>>>> [   47.457592]  ec_device_remove+0x34/0x48 [cros_ec_dev]
>>>>> [   47.463233]  platform_drv_remove+0x28/0x48
>>>>> [   47.467805]  device_release_driver_internal+0x1a8/0x240
>>>>> [   47.473630]  driver_detach+0x40/0x80
>>>>> [   47.477609]  bus_remove_driver+0x54/0xa8
>>>>> [   47.481986]  driver_unregister+0x2c/0x58
>>>>> [   47.486355]  platform_driver_unregister+0x10/0x18
>>>>> [   47.491599]  cros_ec_dev_exit+0x1c/0x258 [cros_ec_dev]
>>>>> [   47.497338]  __arm64_sys_delete_module+0x16c/0x1f8
>>>>> [   47.502689]  el0_svc_common+0x84/0xd8
>>>>> [   47.506776]  el0_svc_handler+0x2c/0x80
>>>>> [   47.510960]  el0_svc+0x8/0xc
>>>>> [   47.514171] ---[ end trace 9087279fc8c03450 ]---
>>>>>
>>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>>> ---
>>>>>
>>>>> Changes in v3: None
>>>>> Changes in v2:
>>>>> - Fix WARN when unloading. This is new in these series.
>>>>>
>>>>>  drivers/mfd/cros_ec_dev.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
>>>>> index 1ba98a32715e..cdb941c6db98 100644
>>>>> --- a/drivers/mfd/cros_ec_dev.c
>>>>> +++ b/drivers/mfd/cros_ec_dev.c
>>>>> @@ -35,9 +35,14 @@
>>>>>  #define CROS_MAX_DEV 128
>>>>>  static int ec_major;
>>>>>
>>>>> +static void cros_ec_dev_release(struct device *dev)
>>>>> +{
>>>>> +}
>>>
>>> Yeah, as part of the in-kernel documentation, I now get to make fun of
>>> you in public!
>>>
>>> You did read the documentation, right?
>>>
>>
>> To be fair, the problem is difficult to understand. Maybe it is easy
>> for you, but that is not true for everyone, including me. Remember the
>> block discussion we just had ? As for the in-kernel documentation,
>> maybe there is a comprehensive explanation someone, one that clueless
>> people like me can understand, but all I found was
>>
>> "If a bus driver unregisters a device, it should not immediately free
>>   it. It should instead wait for the driver model core to call the
>>   device's release method, then free the bus-specific object.
>>   (There may be other code that is currently referencing the device
>>   structure, and it would be rude to free the device while that is
>>   happening)"
>>
>> Does that apply to mfd devices ? What other code may that be that
>> accesses the structure ? What else does it mean, or in other words,
>> what other cleanup code besides releasing the data structure needs to
>> reside in the release function ?
> 

I think that this can be one of those cases where using device managed
allocations is not right. If so we only need to revert commit

3aa2177e4787 ("mfd: cros_ec: Use devm_kzalloc for private data")

I think that the problem might be a dereference when a file operation call
happens if accesses to the device but the struct is already freed, so the
allocated structure should be freed after the last release call because you
can't guarantee is _not_ used before that. In this case class_dev is embedded to
the struct so I guess that the only resource we need to free is the cros_ec
device struct. I can be wrong, I didn't continue the research.

This is what Guenter make me think when he said "object lifetime", then I read
the Greg's answer. I felt bad and I just abandoned that task and switch to
another one. There were still open questions in my mind but I was not so
motivated to solve it.

Before send the patch I looked at the code and I saw that there are different
places where an "empty" release function is used. If this is never allowed,
maybe we can create a cocci script to catch these cases, I started this script
(thanks Peter for helping me). Only detects two places, but the script is not
complete as should also take in consideration when the release function is
assigned in a function (usually people does this) instead of assigning the
function directly in the struct. I'll be happy to help on this if people think
will be useful.


@r1@
identifier I, s, func;
@@
struct I s = { ..., .dev_release = func, ...};

@r2@
identifier r1.func;
position p1;
@@
func@p1(...){}

@script:python@
fn << r1.func;
p1 << r2.p1;
@@

print ("%s:%s empty release function at lines %s" % (p1[0].file,fn,p1[0].line))

Thanks
 Enric

> To quote Documentation/kobject.txt:
> 	One important point cannot be overstated: every kobject must
> 	have a release() method, and the kobject must persist (in a
> 	consistent state) until that method is called. If these
> 	constraints are not met, the code is flawed.  Note that the
> 	kernel will warn you if you forget to provide a release()
> 	method.  Do not try to get rid of this warning by providing an
> 	"empty" release function; you will be mocked mercilessly by the
> 	kobject maintainer if you attempt this.
> 
> The fact that you couldn't even find this means that it probably is in
> the wrong place, but then, where is the "right" place for where everyone
> can see it?  Should I refer to this file in the kernel error message?
> 
> That file also should answer your other questions about lifetime rules
> of kobjects, which is really the same thing as 'struct device' here.  If
> not, please let me know and I can fix it up.
> 
> thanks,
> 
> greg k-h
> 
