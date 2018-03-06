Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbeCFFiW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 00:38:22 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46970 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeCFFiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 00:38:20 -0500
X-Google-Smtp-Source: AG47ELvSvEsmNFTdJk63dCPaqhzuvrEeJQ/r8VzkJplvfgKpmyI2UPeZ90EJnrhqhnPJx2NDgxYl/6q/2YWNu9XkbOM=
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKGXGBQSh3OeG_-bBSgv+uoANxB1CYU8RS0O6FrtaKaJQ@mail.gmail.com>
References: <cover.1520274879.git.amit.kucheria@linaro.org>
 <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
 <CAL_JsqKGXGBQSh3OeG_-bBSgv+uoANxB1CYU8RS0O6FrtaKaJQ@mail.gmail.com>
From: Amit Kucheria <amit.kucheria@linaro.org>
Date: Tue, 6 Mar 2018 11:08:18 +0530
Message-ID: <CAP245DUMi0HREPbS=bMkWXy3=PwXYhLVLNCY7xcfd5sDDU7+OQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: of: Allow selection of thermal governor in DT
To: Rob Herring <robh+dt@kernel.org>
Cc: DTML <devicetree@vger.kernel.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 1:38 AM, Rob Herring <robh+dt@kernel.org> wrote:
> On Mon, Mar 5, 2018 at 12:36 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>
>> There is currently no way for the governor to be selected for each thermal
>> zone in devicetree. This results in the default governor being used for all
>> thermal zones even though no such restriction exists in the core code.
>>
>> Add support for specifying the thermal governor to be used for a thermal
>> zone in the devicetree. The devicetree config should specify the governor
>> name as a string that matches any available governors. If not specified, we
>> maintain the current behaviour of using the default governor.
>>
>> Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/thermal/thermal.txt | 8 ++++++++
>>  drivers/thermal/of-thermal.c                          | 6 ++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
>> index 1719d47..fced9d3 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -168,6 +168,14 @@ Optional property:
>>                         by means of sensor ID. Additional coefficients are
>>                         interpreted as constant offset.
>>
>> +- thermal-governor:     Thermal governor to be used for this thermal zone.
>> +                       Expected values are:
>> +                       "step_wise": Use step wise governor.
>> +                       "fair_share": Use fair share governor.
>> +                       "user_space": Use user space governor.
>> +                       "power_allocator": Use power allocator governor.
>
> This looks pretty Linux specific. Not that we can't have Linux
> specific properties, but we try to avoid them.
>
> What determines the selection? I'd imagine only certain governors make
> sense for certain devices. We should perhaps describe those
> characteristics which can then infer the best governor. Not really
> sure though...

I'm not sure if it would be easy to assign preferred governors to
device classes. It is dependent on what devices are present on the
system, what throttling knobs they expose and how the system designer
decided to integrate it all. e.g. A GPU driver might be controlled in
kernel or userspace depending on whether it exposes a devfreq knob or
some more esoteric statistics to userspace.

Bang Bang governor seems to be designed for Fans with a simple ON/OFF iterface.
Userspace governor is designed to move thermal policy to userspace
(e.g. through thermald). So backlight brightness, battery charging,
GPU scaling, even cpu frequency scaling can be offloaded to userspace.
On embedded platforms, modem control typically happens in userspace
Power allocator governor is designed for a closed-loop system to keep
the total TDP of the platform under control while allowing various
devices (cpu, gpu, modem, etc.) to dynamically increase or decrease
their individual budget depending on the usecase.

Regards,
Amit
