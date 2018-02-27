Return-Path: <benjamin.gaignard@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519759020; cv=none;
        d=google.com; s=arc-20160816;
        b=ZAQpuGSXOqbi4Ot1Nv49WoELPUv4ZS+KnjUTUOwG5ZluCN727hR8aoITuxwghwerbl
         CkIkEpjHZkqYWwgTSSeril7FlWnGUx1Eqo2fE/NMbjXIXrHC0nIDZltGXcyaN7HscP7I
         uLmm5gO+nMRB/Ley25jjTZYSsUMlWOnkVcSyyoQShobSoEN3rzOGP1MW7tdNdGm4s9Su
         eszpCPYXpwmxJS3l/dUbaSoJw75y1XzFbw3Xi5bWxZGZJqpL4Do8affi7SJwK7qXcXvh
         SJzlGFQjynhtYq2CkFXptbLkuuNSmm0AZclGOEq4dtxBJ8ri28Zk/EVdpEz8e/2d75Ji
         rYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=vpQYO4Zh5fx79ELZhf89ZlYXKU4sXDPCUasW4UBkqCM=;
        b=fJqfSQSs5hmMtBGbLmR6mpC4H7XylBi6Qj3qiV+jyygGFYEydj2i92oXooWNtMR5wi
         yXeSaxGPGUySQqCx6OCv9E35KbCiPjsrxNckP0GgmShEkp08swR8RgnvsbjWOoDNAMTZ
         LFnzFIsQmwS0Wh/0vk8wHnGCtYjtsLjuXwmmw5y/kz0FH1Ta565T6mj3rU4vyIgLHoD2
         oLh1ZTauaUA6e6vdwCS482wBYdNOGFf8lbYUDywX/jNmorOcaWvpUCZSp51dTnB4HwME
         iteGGH5p5/oNgDchuzV6+cRQ/HlhHI2sgD0XO9JJoBzt1aZk+3z4ONnRQvuRv6UV/vTC
         FLEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BYRqpvHr;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BYRqpvHr;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsDDzfHaOYEojaLFBzE9Kk+1+hNq2ICHJdVnNvI55AihxDXRGrGAwhF0LbFeiO77mmfxIbYjFryWHvdNN2GaGU=
MIME-Version: 1.0
In-Reply-To: <20180227171124.h2yjhicmlfrwr4nh@lakrids.cambridge.arm.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com> <20180227171124.h2yjhicmlfrwr4nh@lakrids.cambridge.arm.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 27 Feb 2018 20:16:59 +0100
Message-ID: <CA+M3ks6qV_pGdE6mr3n7TiY9VhbqEkrdH6tN=8e-A=oa4UbDHw@mail.gmail.com>
Subject: Re: [PATCH 0/3] STM32 Extended TrustZone Protection driver
To: Mark Rutland <mark.rutland@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>,
	devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593563499941739218?=
X-GMAIL-MSGID: =?utf-8?q?1593582834568532916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-27 18:11 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> On Tue, Feb 27, 2018 at 03:09:23PM +0100, Benjamin Gaignard wrote:
>> On early boot stages STM32MP1 platform is able to dedicate some hardware blocks
>> to a secure OS running in TrustZone.
>> We need to avoid using those hardware blocks on non-secure context (i.e. kernel)
>> because read/write access will all be discarded.
>>
>> Extended TrustZone Protection driver register itself as listener of
>> BUS_NOTIFY_BIND_DRIVER and check, given the device address, if the hardware block
>> could be used in a Linux context. If not it returns NOTIFY_BAD to driver core
>> to stop driver probing.
>
> Huh?
>
> If these devices are not usable from the non-secure side, why are they
> not removed form the DT (or marked disabled)?
>
> In other cases, where resources are carved out for the secure side (e.g.
> DRAM carveouts), that's how we handle things.
>

That true you can parse and disable a device a boot time but if DT doesn't
exactly reflect etzpc status bits we will in trouble when try to get access to
the device.
Changing the DT is a software protection while etzpc is an hardware protection
so we need to check it anyway.

Benjamin


> Mark.
>
>>
>> NOTE: patches 2 and 3 should be applied only on
>> git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
>> but until this patch: https://lkml.org/lkml/2018/2/26/386
>> find it way to mailine KBuild will complain about them.
>>
>> Benjamin Gaignard (3):
>>   driver core: check notifier_call_chain return value
>>   dt-bindings: stm32: Add bindings for Extended TrustZone Protection
>>   ARM: mach-stm32: Add Extended TrustZone Protection driver
>>
>>  .../bindings/arm/stm32/st,stm32mp1-etzpc.txt       |  13 ++
>>  arch/arm/mach-stm32/Kconfig                        |   7 +
>>  arch/arm/mach-stm32/Makefile                       |   1 +
>>  arch/arm/mach-stm32/stm32-etzpc.c                  | 252 +++++++++++++++++++++
>>  drivers/base/dd.c                                  |   9 +-
>>  5 files changed, 279 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
>>  create mode 100644 arch/arm/mach-stm32/stm32-etzpc.c
>>
>> --
>> 2.15.0
>>
