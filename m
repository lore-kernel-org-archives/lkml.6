Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AG47ELvSB3uv1Wqh6rs9KGzorgarYrUYq+F4yrWPbIOrmoL36PnyhMlqMXdPG7KJHslpDVJGshKh
ARC-Seal: i=1; a=rsa-sha256; t=1519760793; cv=none;
        d=google.com; s=arc-20160816;
        b=O7umo5QtqeuDpTKAQFE7bdMnk+L9gFr0YivOUKX00cpUtj3JEBcUwhBHimgq9LCI/u
         babdGFJCfqwe+vjlvy0XzHsBSCjXLzDUtrY+/GYqCWgr4X43jdgBC0NAlXv8A9kpdKw7
         D01PK2QiUx3RwVvKoamDk4Vm9XE5/612lyROew73O2qDbF7EI59mLcx1Uw3iNvo5K0Xf
         wTC/k0xRbqB/giBHFH3Sf2bfZP3GPGssNfxk9QbAWHZ9e0HuSx8C+DOEFa2AOjXm/xnW
         IuVLUe1VJN/FG0hzSZ5DtOPeUlZVRw1T1uSQvHs/BT8gs+3dXKSTQ8FZgSpEa16ZmURQ
         tggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=7HZqC8rw8uactYufHEoux7QvVclijsSur5gugWBtSek=;
        b=qfBvVZwEZc9CzQ2JTChZcHH5iaJ/2iUDSqJ21mFaaDS5KoPmPTMds+WZisUmfQNjid
         XwNbw38VV1OlKu9K6piwOhzPe0CMr+L+X74CTeSz7IvMXZpUfzZx+HbHPmw4X3TbPcGG
         qvBT6CwoLsQaHqxEHwREScIkGwbL7qCAKRP7asPlFUfTQfJxqo04lhxdGgz8s3gcXeBx
         J1ydUJPgq09bbmQTmZSCN6/xxfC3yp7q3xjDgEEdOaofSTHFzrQig/J57fki3EiXYmZL
         XIgprD77VD4oagXJyGI42PjCQ4Isq1Gh0X7UssL8TVtfFv1Ihqxk9EGWtLogZJg+FOYP
         wLlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH 0/3] STM32 Extended TrustZone Protection driver
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Linux ARM
 <linux-arm-kernel@lists.infradead.org>,
 Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
 <20180227171124.h2yjhicmlfrwr4nh@lakrids.cambridge.arm.com>
 <CA+M3ks6qV_pGdE6mr3n7TiY9VhbqEkrdH6tN=8e-A=oa4UbDHw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <11c3ceb2-8b8d-de59-a0be-0777a42f63a7@arm.com>
Date: Tue, 27 Feb 2018 19:46:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+M3ks6qV_pGdE6mr3n7TiY9VhbqEkrdH6tN=8e-A=oa4UbDHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593563499941739218?=
X-GMAIL-MSGID: =?utf-8?q?1593584693613821058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27/02/18 19:16, Benjamin Gaignard wrote:
> 2018-02-27 18:11 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
>> On Tue, Feb 27, 2018 at 03:09:23PM +0100, Benjamin Gaignard wrote:
>>> On early boot stages STM32MP1 platform is able to dedicate some hardware blocks
>>> to a secure OS running in TrustZone.
>>> We need to avoid using those hardware blocks on non-secure context (i.e. kernel)
>>> because read/write access will all be discarded.
>>>
>>> Extended TrustZone Protection driver register itself as listener of
>>> BUS_NOTIFY_BIND_DRIVER and check, given the device address, if the hardware block
>>> could be used in a Linux context. If not it returns NOTIFY_BAD to driver core
>>> to stop driver probing.
>>
>> Huh?
>>
>> If these devices are not usable from the non-secure side, why are they
>> not removed form the DT (or marked disabled)?
>>
>> In other cases, where resources are carved out for the secure side (e.g.
>> DRAM carveouts), that's how we handle things.
>>
> 
> That true you can parse and disable a device a boot time but if DT doesn't
> exactly reflect etzpc status bits we will in trouble when try to get access to
> the device.

Well, yes. If the DT doesn't correctly represent the hardware, things 
will probably go wrong; that's hardly a novel concept, and it's 
certainly not unique to this particular SoC.

> Changing the DT is a software protection while etzpc is an hardware protection
> so we need to check it anyway.

There are several in-tree DT and code examples where devices are marked 
as disabled on certain boards/SoC variants/etc. because attempting to 
access them can abort/lock up/trigger a secure watchdog reset/etc. The 
only "special" thing in this particular situation is apparently that 
this device even allows its secure configuration to be probed from the 
non-secure side at all.

Implementing a boardfile so that you can "check" the DT makes very 
little sense to me; Linux is not a firmware validation suite.

Robin.
