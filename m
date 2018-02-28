Return-Path: <benjamin.gaignard@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519804409; cv=none;
        d=google.com; s=arc-20160816;
        b=pJdawl3ZBq++IT8HRe9kYF0Z2cS5flaZ9KLCaPnDShplgtV9iD5bBhxIjsOv0f6GnA
         pggPGDUs+YxCqLIPG71Wkjb+erXb+5VtCy99DIIMsHkkn9+lGdcyS+SZvTr26NPBOGv5
         d5clpiz/GGrvMKfMbe0NJp1OBIwQN9tRasmVucbqcaleAbTaD3mwnJQGTCTDr1OCA/dq
         fLOCN3WNiaTXWZ+PeFPczxj/Cxc/A9BX4PMBJ6UjZNjOzFeY0zpJO+zFSAYuI8cCJSKy
         SfhE625OI6MPWdG1PLz6WzBwa03Q66b0+2XRPdbZX0nFq2WG663RdK8Ss0Yz/K5ndfdn
         /vZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=6b2NYE4zz6Gj/5iGDm93r2MpitDjxU5wqJafZIuvv9c=;
        b=b3pTMvso5jyyhnx7e3AqNF40W26l1nizMy+q2haK++OFuEz7YCbbI2gBMRqoxcOlPu
         1VmgRy5RS8zqPeJih4LN0TmmqHQJcuDUKQ65aWk2rz/qTZ0ISYx60mh016I/w3v6a8HH
         ks6KA+aRT8j27e76cSl6FHgKmhIolljzbJoqAhCB6y4xRo2jD53EBjZdP//DVBAv/2bl
         FjKUhl+TOcwTcvpjtUJgRGYBaMlFAnU2OhsHhugCvUHQN41PZzurncmIRfsU0iiWh04y
         spDdzCNvLDY+5zqdf6NsGy7Y/lF59pvRt6i+C0om2a3ne6NjhaWZ+mZFThpPkaawRpB6
         gYlw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HmcdUlIv;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HmcdUlIv;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtqWHaWjrmUtrmHsbXaMv1OPBZzDlWnbjK01HSjUg//jV34WhMNV2lvg1AUFqStLu2BtldmkRMBkJ6IyQVS2io=
MIME-Version: 1.0
In-Reply-To: <11c3ceb2-8b8d-de59-a0be-0777a42f63a7@arm.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
 <20180227171124.h2yjhicmlfrwr4nh@lakrids.cambridge.arm.com>
 <CA+M3ks6qV_pGdE6mr3n7TiY9VhbqEkrdH6tN=8e-A=oa4UbDHw@mail.gmail.com> <11c3ceb2-8b8d-de59-a0be-0777a42f63a7@arm.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Wed, 28 Feb 2018 08:53:28 +0100
Message-ID: <CA+M3ks5qR++8Vwwk8=5Oh6DBdT9NF3ysqfjayq4Gze-oke8Ayg@mail.gmail.com>
Subject: Re: [PATCH 0/3] STM32 Extended TrustZone Protection driver
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@st.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593563499941739218?=
X-GMAIL-MSGID: =?utf-8?q?1593630428746602232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-27 20:46 GMT+01:00 Robin Murphy <robin.murphy@arm.com>:
> On 27/02/18 19:16, Benjamin Gaignard wrote:
>>
>> 2018-02-27 18:11 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
>>>
>>> On Tue, Feb 27, 2018 at 03:09:23PM +0100, Benjamin Gaignard wrote:
>>>>
>>>> On early boot stages STM32MP1 platform is able to dedicate some hardware
>>>> blocks
>>>> to a secure OS running in TrustZone.
>>>> We need to avoid using those hardware blocks on non-secure context (i.e.
>>>> kernel)
>>>> because read/write access will all be discarded.
>>>>
>>>> Extended TrustZone Protection driver register itself as listener of
>>>> BUS_NOTIFY_BIND_DRIVER and check, given the device address, if the
>>>> hardware block
>>>> could be used in a Linux context. If not it returns NOTIFY_BAD to driver
>>>> core
>>>> to stop driver probing.
>>>
>>>
>>> Huh?
>>>
>>> If these devices are not usable from the non-secure side, why are they
>>> not removed form the DT (or marked disabled)?
>>>
>>> In other cases, where resources are carved out for the secure side (e.g.
>>> DRAM carveouts), that's how we handle things.
>>>
>>
>> That true you can parse and disable a device a boot time but if DT doesn't
>> exactly reflect etzpc status bits we will in trouble when try to get
>> access to
>> the device.
>
>
> Well, yes. If the DT doesn't correctly represent the hardware, things will
> probably go wrong; that's hardly a novel concept, and it's certainly not
> unique to this particular SoC.
>
>> Changing the DT is a software protection while etzpc is an hardware
>> protection
>> so we need to check it anyway.
>
>
> There are several in-tree DT and code examples where devices are marked as
> disabled on certain boards/SoC variants/etc. because attempting to access
> them can abort/lock up/trigger a secure watchdog reset/etc. The only
> "special" thing in this particular situation is apparently that this device
> even allows its secure configuration to be probed from the non-secure side
> at all.
>
> Implementing a boardfile so that you can "check" the DT makes very little
> sense to me; Linux is not a firmware validation suite.

It is not about to "check" the DT but if Linux could get access to the hardware.
Hardware block assignment to secure or non-secure world could change at runtime
for example I2C block could be manage by secure OS for a trusted
application and when
it have finish "release" the it for Linux. I don't think that could be
done by changing DT.

I think that dhecking hardware blocks status bits before probe them is
also more robust than let
each driver discover at probe time that it hardware isn't responding.

Benjamin

>
> Robin.
