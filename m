Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeCMMzf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:55:35 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55045 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeCMMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:55:31 -0400
X-Google-Smtp-Source: AG47ELvNktztOvxeyhsuphzUbuTyUAoKY4jdGQxSO8kNF1PoOikEt4lM8Ky+TD9TzbXgPq9CKNaSUvsbFOEsM7SBm80=
MIME-Version: 1.0
In-Reply-To: <152094429237.515.2412380565628307987@mail.alporthouse.com>
References: <20180313120848.2658626-1-arnd@arndb.de> <152094429237.515.2412380565628307987@mail.alporthouse.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Mar 2018 13:55:29 +0100
X-Google-Sender-Auth: -elc5ej6xtlpcCKWu_lbtLXREIg
Message-ID: <CAK8P3a3Panvv8yJBrBW-jscbay4o+p14_yZKpWQ4KZTL1H-E3g@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/pmu: avoid -Wmaybe-uninitialized warning
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 1:31 PM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> Quoting Arnd Bergmann (2018-03-13 12:08:29)
>> The conditional spinlock confuses gcc into thinking the 'flags' value
>> might contain uninitialized data:
>>
>> drivers/gpu/drm/i915/i915_pmu.c: In function '__i915_pmu_event_read':
>> arch/x86/include/asm/paravirt_types.h:573:3: error: 'flags' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>
>> The code is correct, but it's easy to see how the compiler gets confused
>> here. This avoids the problem by pulling the lock outside of the function
>> into its only caller.
>>
>> Fixes: 1fe699e30113 ("drm/i915/pmu: Fix sleep under atomic in RC6 readout")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/gpu/drm/i915/i915_pmu.c | 25 ++++++++++---------------
>>  1 file changed, 10 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
>> index 4bc7aefa9541..2c8c705d1f18 100644
>> --- a/drivers/gpu/drm/i915/i915_pmu.c
>> +++ b/drivers/gpu/drm/i915/i915_pmu.c
>> @@ -415,7 +415,6 @@ static u64 __get_rc6(struct drm_i915_private *i915)
>>  static u64 get_rc6(struct drm_i915_private *i915, bool locked)
>
> bool locked is now unused, right?

Right, removing it now.

>> -                       val = get_rc6(i915, locked);
>> -                       break;
>> +                       if (!locked) {
>> +                               unsigned long flags;
>> +
>> +                               spin_lock_irqsave(&i915->pmu.lock, flags);
>> +                               val = get_rc6(i915, locked);
>> +                               spin_unlock_irqrestore(&i915->pmu.lock, flags);
>> +                               break;
>> +                       } else {
>> +                               val = get_rc6(i915, locked);
>> +                       }
>
> break is now on one path only; should be here.

Fixed as well. I'll wait a bit for more comments before resending.

Thanks for the review!

     Arnd
