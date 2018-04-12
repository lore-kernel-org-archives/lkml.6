Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeDLRmO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:42:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54403 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbeDLRmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:42:13 -0400
X-Google-Smtp-Source: AIpwx4+jXDg/Y9b4cR9vx6VDiYYhaiRggml1CQ+Ff6wKU9YMF0rFGXjSqFXDFlbOSjmo8SETFZWgnQ==
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        "Li, Philip" <philip.li@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <1523436077.16235.5.camel@intel.com>
 <CA+55aFzqJ2PfUnkVJ6A-8WRQTciWb8j+25r41JLCvz7h0QEJiA@mail.gmail.com>
 <1523509711.16235.25.camel@intel.com>
 <CA+55aFw0C-S0L-cnk0oROG=Khqy9s36O+g3_BxqPfewKGQ9_EQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1bbc5ab1-3532-95f5-1246-0bb89c566508@linaro.org>
Date: Thu, 12 Apr 2018 19:42:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFw0C-S0L-cnk0oROG=Khqy9s36O+g3_BxqPfewKGQ9_EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2018 18:55, Linus Torvalds wrote:
> On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com> wrote:
>>
>> could you please illustrate me what the kconfig & warning is?
> 
> Just "make allmodconfig" and the warning is about a uninitialized variable.
> 
> Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell history
> is to be believed.
> 
>                 Linus

These couple of warnings were introduced by:

commit 480b5bfc16e17ef51ca1c55bfcebf55db8673ebf
Author: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Tue Mar 6 15:43:45 2018 +0100

    thermal: exynos: remove parsing of samsung, tmu_default_temp_offset
property

    Trimming (one point based or two points based) is always used for
    the temperature calibration and the default non-trimming code should
    never be reached.

    Modify temp_to_code() and code_to_temp() accordingly (WARN_ON(1)
    in the default cases) and then remove no longer needed parsing of
    samsung,tmu_default_temp_offset property.

    There should be no functional changes caused by this patch.

    Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
    Signed-off-by: Eduardo Valentin <edubezval@gmail.com>


After digging into, there is no obvious fix. It returns effectively an
uninitialized value and the callers are assuming the value is always
correct, so it is also not possible to simply return an error.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
