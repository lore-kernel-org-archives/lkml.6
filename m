Return-Path: <agraf@suse.de>
X-Google-Smtp-Source: AB8JxZrmmUji5i/D6F8pZeabdRnHn0H61LnmiimpYiPKVcSgSlOu+5HJg8i6sHcwqaGs/wTMTCYf
ARC-Seal: i=1; a=rsa-sha256; t=1525859863; cv=none;
        d=google.com; s=arc-20160816;
        b=vJuUYLUKiSNL6ZPmNdTxIJJ2BpecdH5t07ItYyL5eWL9ptXen6TGfT2vpSoWadFNdl
         0GmxpY/cA+H5/tUCNDcHHNQO3bOJyv8kfQ//U2FJx4X5EtOAItPWZqCQg0Sf8gzCTY5b
         0TOmwYLWo+tH0MpKsNv7YcmBsFagh8Tib58+KHb6TP8ZYSBzUsvcXkSmAeYryhH4piDp
         9T0WP85ES1ds0IE9Xzp0Zfj2u6Hn+2vhTppJQFNLy1buQbEBwBsoTzbVpMADJcCKFcsT
         HLXpJmM20CXg1AhJm0Kt1CKVACNNx7V8mX9VLJEGHuOcNDnCIqsvawTnnxXYwFgQR+yj
         MYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Z7a0CVly30/EKhsb0GHS6esECLx5yfdizr3Y3b0gQjA=;
        b=PMnbTNV9KOMf2ekj/o1UCGYqhZATf6+3ym8EjuFuDNUw08lHDfMN4ULTRZNoOZhCvO
         QSW3L5IQuzIPWXayq85Icpbpy2tUIgCauszC+WrP17T1BBlN7Afzhq8zVFcfuf1dgUma
         lokkDn7K9EDFSS7zIqSTJWmZhG29bv+4UEwT8RB27ZBJJh7IFVmSjwxhVpFMZc1qoP/2
         PaH6fjk3dVX/KDxP3cJ2bJYpT8arz3laW774R/qSWWReSaiWEZihClVHGi0daQPRpcQg
         dLx5aM+ufapvhRdH0J88iWQA2cA4NQa06bFkJy2oOvvPbANN/TPuwTMV1PJiHSZZXPNd
         U4fg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of agraf@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=agraf@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of agraf@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=agraf@suse.de
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grant Likely <grant.likely@arm.com>, Linus Walleij
 <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Architecture Mailman List <boot-architecture@lists.linaro.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
References: <20180501213114.20183-1-robh@kernel.org>
 <20180507183106.GF2259@tuxbook-pro>
 <CAL_Jsq+PRUR5rCeV820XZuQmQH3gD-X=6a5fNuF-9qVbq5dqFg@mail.gmail.com>
 <20180507223438.GB14924@minitux>
From: Alexander Graf <agraf@suse.de>
Message-ID: <90fffaee-1d0e-da96-3fbe-2d99fb530937@suse.de>
Date: Wed, 9 May 2018 11:57:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507223438.GB14924@minitux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1599980032473317254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/08/2018 12:34 AM, Bjorn Andersson wrote:
> On Mon 07 May 12:55 PDT 2018, Rob Herring wrote:
>
>> On Mon, May 7, 2018 at 1:31 PM, Bjorn Andersson
>> <bjorn.andersson@linaro.org> wrote:
>>> On Tue 01 May 14:31 PDT 2018, Rob Herring wrote:
>>>
>>>> Deferred probe will currently wait forever on dependent devices to probe,
>>>> but sometimes a driver will never exist. It's also not always critical for
>>>> a driver to exist. Platforms can rely on default configuration from the
>>>> bootloader or reset defaults for things such as pinctrl and power domains.
>>> But how do you know if this is the case?
>> Because the platform worked before adding the dependency in the dts.
>>
> I'm worried about how to write dts files and drivers to support all
> permutation of forward and backward dependencies. And you most
> definitely have the same case with bootloader-enabled clocks,
> regulators and interconnects.
>
>>>> This is often the case with initial platform support until various drivers
>>>> get enabled.
>>> Can you please name platform that has enough support for Alexander to
>>> care about backwards and forwards compatibility but lacks a pinctrl
>>> driver.
>> Alex will have to answer that. I do agree pinctrl drivers shouldn't be
>> that hard because it is all just translating a bunch of pin data into
>> one-time (mostly) register writes, so it shouldn't take that long to
>> implement support. OTOH, maybe a pinctrl driver is low priority
>> because nothing needs it yet. Either a given board works with the
>> defaults and only some new board needs to change things or you don't
>> need pinctrl until low power modes are implemented. However, power
>> domains have the same problem and it can take years for those to get
>> proper support.
>>
>> Alex proposed declaring dts files stable and then enforcing
>> compatibility after that point. If anyone believes that will work,
>> then please send a patch marking all the platforms in the kernel tree
>> that are stable.
>>
> That might be a reasonable idea, but at least in our corner the current
> decision that devicetree should be backwards compatible does make it
> quite cumbersome to break this assumption - and in the cases we have had
> to do it it's really been necessary.

I'm sure Rob would be happy to get a list of every one of those 
instances so we can see how to solve them going forward.

To give you some background: The whole discussion started with a 
proposal from me to support embedded (maybe dtc aided) overlays. Some 
way to have a single dtb that only enables new features such as pinctrl 
when the kernel indicates support for them.

I think eventually we will have to have a mechanism like that for 
platforms that want to maintain compatibility. But the less we have to 
solve using it the better off everyone is, because it just increases 
complexity.

>
>>>> There's at least 2 scenarios where deferred probe can render
>>>> a platform broken. Both involve using a DT which has more devices and
>>>> dependencies than the kernel supports. The 1st case is a driver may be
>>>> disabled in the kernel config.
>>> I agree that there is a chance that you _might_ get some parts of the
>>> system working by relying on the boot loader configuration, but
>>> misconfiguration issues applies to any other fundamental providers, such
>>> as clocks, regulators, power domains and gpios as well.
>> If it is only a chance, then perhaps we shouldn't allow things
>> upstream without proper drivers for all these things. That will only
>> give users the wrong impression.
>>
> It's not as much the drivers that's the problem here as it is the
> composition of the drivers. For this particular case it would be
> convenient not to ship the partial dtb, or at least not ship it with the
> promise that it's stable.

Yes, we of course need a gatekeeping event. Not every DT is in a state 
where you can promise compatibility.

However, if you want to have a stable OS interface so that slow moving 
Linux distribtions work well with the platform and non-Linux OSs jump on 
the platform, you will have to provide some guarantees. And people just 
need to be aware that they either give the guarantees or they don't get 
their benefits :).

>
>>>> The 2nd case is the kernel version may
>>>> simply not have the dependent driver. This can happen if using a newer DT
>>>> (provided by firmware perhaps) with a stable kernel version.
>>>>
>>> As above, this is in no way limited to pinctrl drivers.
>> Yes, I wasn't trying to imply that with this patch. I was just
>> starting with 1 example. IOMMUs (which essentially is already doing
>> what this patch does) and power domains are the main other 2.
> qcom,iommu-v1 is bool, but depends on e.g. CONFIG_MSM_GCC_8916 which is
> tristate. So you would need to s/tristate/bool/ everything in
> drivers/clk/qcom/Kconfig as well. Not to mention that there are
> interconnects and power domains actually involved here as well...
>
>> Clocks is an obvious one too, but from the discussion I referenced
>> that problem is a bit different as platforms change from dummy
>> fixed-clocks to a real clock controller driver. That will need a
>> different solution.
> So how are you going to deal with the case when a vendor decides to ship
> their firmware package with all clocks enabled and only fixed clocks
> described in DT and as they upstream a clock driver and patch their
> firmware to do the right thing?

That is the ZynqMP case. I think this really needs to be solved using 
embedded overlays, but Rob might have additional ideas :).

> (Or the much less extreme case where this happens for a single clock,
> regulator, pinctrl, interconnect, etc to fix some bug/power management
> behavior)
>
> And is this really a problem that does not exists in the ACPI world?
>
>>>> Unfortunately, this change breaks with modules as we have no way of
>>>> knowing when modules are done loading. One possibility is to make this
>>>> opt in or out based on compatible strings rather than at a subsystem level.
>>>> Ideally this information could be extracted automatically somehow. OTOH,
>>>> maybe the lists are pretty small. There's only a handful of subsystems
>>>> that can be optional, and then only so many drivers in those that can be
>>>> modules (at least for pinctrl, many drivers are built-in only).
>>>>
>>> On the Qualcomm platform most drivers are tristate and on most platforms
>>> there are size restrictions in the proprietary boot loader preventing us
>>> from boot the kernel after switching all these frameworks from tristate
>>> to bool (which feels like a more appropriate solution than your hack).
>> BTW, QCom platforms are almost the only ones with pinctrl drivers as
>> modules. They are also happen to be PIA to configure correctly for a
>> board.
>>
> There are a few pinctrl drivers for chips sitting on i2c busses, as such
> changing this requirement would trickle down to a number of possible i2c
> masters as well.
>
> Sorry to hear that you find it so difficult to configure the pinctrl,
> it's (almost) entirely using the common pinctrl bindings. Perhaps we
> need to add some documentation of the hardware in the binding?
>
>> However, I would like a solution that works with modules. It would be
>> nice to know when userspace finished processing all the coldplug
>> uevents. That would be sufficient to support modules. I researched
>> that a bit and it doesn't seem the kernel can tell when that has
>> happened.
>>
> It's not that far from the issue I have in remoteproc, where I would
> like to boot a DSP as soon as the firmware is available - which might be
> probed at any time after boot.
>
> [..]
>>>> I tested this on a RPi3 B with the pinctrl driver forced off. With this
>>>> change, the MMC/SD and UART drivers can function without the pinctrl
>>>> driver.
>>>>
>>> Cool, so what about graphics, audio, networking, usb and all the other
>>> things that people actually expect when they _use_ a distro?
>> I often care about none of those things. When I do, I'd rather boot to
>> a working console with those broken than have to debug why the kernel
>> panicked.
>>
> But that's developer-you speaking, developer-me totally agree.
>
> But when I take the role of being a user of a distro I most definitely
> do expect functionality beyond the basics used by the boot loader (UART
> and dependencies of the primary storage device).
>
> My argument is simply that in neither of these cases this patch is
> helpful.

The patch allows firmware to provide pinctrl information but maintain 
backwards compatibility with kernels that don't implement pinctrl 
setting. It's useful to solve that part of the transition of the DT to 
enable new functionality. If you now add a device that explicitly needs 
pinctrl configuration to work, that would probably need to get added 
using the overlay mechanism I described above.


Alex
