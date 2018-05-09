Return-Path: <agraf@suse.de>
X-Google-Smtp-Source: AB8JxZrbGSZCrhk8NGlzXdBSs/B3xF8b2TUADlPwiswAICcRZgZBMMvKD1q4NZ0Ik3xyI9mt7KHv
ARC-Seal: i=1; a=rsa-sha256; t=1525859099; cv=none;
        d=google.com; s=arc-20160816;
        b=V5dsBJkQSKhga0d8AqjbnBfxjTInMTCQSRzsQalrstf1k2+R3U+/9gZfvnZTVlQZKm
         umJfgWPFQoW+6osCsdQ9SWbAsI9hgPq6B2yss6YMft1T9e8jN3DRENFmdcHkdt6chsPJ
         660Mfrt0yxiRC1bPDhTOsAfs7KplM76FepEcjCe7XrmERkj6bzaA1Y0c7Nv+hHJI4gSW
         7hdakYpTzDZS5eqfeMRp9eewd15RW2hLV+pqkWCbDgnFweBef9dIC7I/oH1WwYVmOOHR
         /D5cL0sFbx7q1bulJcfh6281NSbJpknm5N9PD9Qas5aKkq+0suddF+s7j0aog2hyg2LI
         LqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=MQLez/jkf8e1Mf1KBT5k5tOWoPwPgCei3a+VstPodyU=;
        b=vvheALAL+Xt5iKy+itmKxBA1Fee8i2Vpn6nC7eKlY3je0UUvDUi0TmJ+k+NxTZjmdv
         3m8C7TP3hUXEu6uPDoCclfCFp+R8X/NgL0WK4NzI13VCTYUkV8LwcSxrjXrHIrYYgdr+
         wyOB2vsKS5Zi9Kz8boudGNyIoWC1e8bRemRaIDOuTGopKO3RqbtmpnzxKM40MGBUXUz1
         gceBWbU1k33Q8xU899Eoshi3TYSiy6Tj6NaLfCHy5AZ78HbRNei+MbfpK8dunTysb4d0
         hcGm1nP8ikWz23E3U90p9fhn297q2yC0MWZO68a7y+kg3ZcezW6W4o8AvKcL+c/sJJUM
         Jadw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of agraf@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=agraf@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of agraf@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=agraf@suse.de
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grant Likely <grant.likely@arm.com>, Linus Walleij
 <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, boot-architecture@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org
References: <20180501213114.20183-1-robh@kernel.org>
 <20180507183106.GF2259@tuxbook-pro>
From: Alexander Graf <agraf@suse.de>
Message-ID: <91dad272-e07d-2ab6-2afa-538294e9cefa@suse.de>
Date: Wed, 9 May 2018 11:44:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507183106.GF2259@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1599979230758759633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/07/2018 08:31 PM, Bjorn Andersson wrote:
> On Tue 01 May 14:31 PDT 2018, Rob Herring wrote:
>
>> Deferred probe will currently wait forever on dependent devices to probe,
>> but sometimes a driver will never exist. It's also not always critical for
>> a driver to exist. Platforms can rely on default configuration from the
>> bootloader or reset defaults for things such as pinctrl and power domains.
> But how do you know if this is the case?
>
>> This is often the case with initial platform support until various drivers
>> get enabled.
> Can you please name platform that has enough support for Alexander to
> care about backwards and forwards compatibility but lacks a pinctrl
> driver.

ZynqMP is one example that immediately comes to my mind. I'm sure there 
are others too.

In general it's very frustrating to debug what goes wrong when you can't 
even get serial to output anything at all just because there are now 
pinctrl bindings that your kernel may not know about yet. I've run into 
that too many times.

>
>> There's at least 2 scenarios where deferred probe can render
>> a platform broken. Both involve using a DT which has more devices and
>> dependencies than the kernel supports. The 1st case is a driver may be
>> disabled in the kernel config.
> I agree that there is a chance that you _might_ get some parts of the
> system working by relying on the boot loader configuration, but
> misconfiguration issues applies to any other fundamental providers, such
> as clocks, regulators, power domains and gpios as well.
>
>> The 2nd case is the kernel version may
>> simply not have the dependent driver. This can happen if using a newer DT
>> (provided by firmware perhaps) with a stable kernel version.
>>
> As above, this is in no way limited to pinctrl drivers.
>
>> Unfortunately, this change breaks with modules as we have no way of
>> knowing when modules are done loading. One possibility is to make this
>> opt in or out based on compatible strings rather than at a subsystem level.
>> Ideally this information could be extracted automatically somehow. OTOH,
>> maybe the lists are pretty small. There's only a handful of subsystems
>> that can be optional, and then only so many drivers in those that can be
>> modules (at least for pinctrl, many drivers are built-in only).
>>
> On the Qualcomm platform most drivers are tristate and on most platforms
> there are size restrictions in the proprietary boot loader preventing us
> from boot the kernel after switching all these frameworks from tristate
> to bool (which feels like a more appropriate solution than your hack).

I don't see how setting them to bool contradicts with the hack? The goal 
of this patch is to allow systems to load drivers on firmware provided 
pinctrl setups if there is no matching pinctrl driver in the kernel.

>
>> Cc: Alexander Graf <agraf@suse.de>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> This patch came out of a discussion on the ARM boot-architecture
>> list[1] about DT forwards and backwards compatibility issues. There are
>> issues with newer DTs breaking on older, stable kernels. Some of these
>> are difficult to solve, but cases of optional devices not having
>> kernel support should be solvable.
>>
> There are two cases here:
> 1) DT contains compatibles that isn't supported by the kernel. In this
> case the associated device will remain in the probe deferral list and
> user space won't know about the device.
>
> 2) DT contains compatibles known to the kernel but has new optional
> properties that makes things functional or works around hardware bugs.

The key point is not to regress. Imagine you have firmware 1.0 which 
works with OS 1.0. Firmware provides the device tree.

When you update to firmware to 1.1 you want to make sure OS 1.0 still 
works. The bug you're referring to that existed before of course still 
exists. But we're not worse off.

>
>> I tested this on a RPi3 B with the pinctrl driver forced off. With this
>> change, the MMC/SD and UART drivers can function without the pinctrl
>> driver.
>>
> Cool, so what about graphics, audio, networking, usb and all the other
> things that people actually expect when they _use_ a distro?

Again, it's about regressions. If audio didn't work before, a firmware 
update may not get you working audio with OS 1.0. But it may enable OS 
1.1 to provide audio.


Alex
