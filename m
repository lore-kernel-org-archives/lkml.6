Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AB8JxZq2lbyPvMxjdbd4Ciocmc1O0Ywyr4Vy4TjNvSa+7wffu18n11BwPikxT38K1CaFDDHR8A2m
ARC-Seal: i=1; a=rsa-sha256; t=1525287001; cv=none;
        d=google.com; s=arc-20160816;
        b=qVcoZhXFVcSsHX9uPpwi+NuMWeZjxSb5jVJ9qcR6RA3ON02yiSvMTuxuBi02UgQ/hh
         9ps0Eowi4lN8671No3zFamCH/dqKyH0D0mfXWLDt18TdYHtaVAhZkB6WoGJeKE0+q93+
         VJfnLZAvdP3XbHW8Fqd5n0kNL3oC43vWi1vVXYWy8qYEsM46SzZi2B4JO790zkFe7VCj
         XEanAKc81TuhsTnuKi5HO8zwNZkDN5YiN1501VL5MmWhhSj09OekHBZBKpFDQR4d8WP6
         PFifJoTi7HaqYWCJ8S/7lmeo/6P0lRQ6slnnZ8Bvn0NWbRgV5ef+Na5EbpE/wfvDjQaJ
         Sq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=lbBi5k3qfBJgmE3tE9utRbs/eeAFKLZ+sHmYyxAbAsM=;
        b=xvQC/9sg2Ts4sW7QzYJKCHbmN/BHI2h9KIqQIYAvIVe8R/yj0hkc549uDoSzobTxwG
         1IX/xc2fazagt1xHho8XYvDDzwX6mYqSlmdxWAP4D90WfcoOGtUn/wG+rdZ4P5QNO5AP
         k9qLCJBnbI1p8X/tHB21IXv95CoWyVsh8WT16ZybX2AsTCdWLsB9392SZ6jr6YGEnSAX
         AjNOZqGk7kIcTXgMFOy2RAaHz+nl5w+gdEPnvwmxDlQdf2kWanWWmPlmuMSw3OgaQfln
         H/mIe1tkRm/KO4VgHeDcc/JzNlTRNO9MbFO5d/W2vWNZrZaZXQOl2w4aTMMKm0h4XaUU
         kGUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 devicetree@vger.kernel.org, boot-architecture@lists.linaro.org,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Alexander Graf <agraf@suse.de>,
 Grant Likely <grant.likely@arm.com>, Mark Brown <broonie@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
References: <20180501213114.20183-1-robh@kernel.org>
 <f808a652-2454-941c-2fd1-60776fb353f6@arm.com>
 <CAL_JsqJvMyrKS4LsRC6fDus24Yg8U+VcrbNNvxtOXmKbrc8RAA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <74d495d8-04e2-fb7d-7d07-0905fbc8a6cf@arm.com>
Date: Wed, 2 May 2018 19:49:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJvMyrKS4LsRC6fDus24Yg8U+VcrbNNvxtOXmKbrc8RAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1599379342783544566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/05/18 15:48, Rob Herring wrote:
> On Wed, May 2, 2018 at 6:40 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 01/05/18 22:31, Rob Herring wrote:
>>>
>>> Deferred probe will currently wait forever on dependent devices to probe,
>>> but sometimes a driver will never exist. It's also not always critical for
>>> a driver to exist. Platforms can rely on default configuration from the
>>> bootloader or reset defaults for things such as pinctrl and power domains.
>>> This is often the case with initial platform support until various drivers
>>> get enabled. There's at least 2 scenarios where deferred probe can render
>>> a platform broken. Both involve using a DT which has more devices and
>>> dependencies than the kernel supports. The 1st case is a driver may be
>>> disabled in the kernel config. The 2nd case is the kernel version may
>>> simply not have the dependent driver. This can happen if using a newer DT
>>> (provided by firmware perhaps) with a stable kernel version.
>>>
>>> Unfortunately, this change breaks with modules as we have no way of
>>> knowing when modules are done loading. One possibility is to make this
>>> opt in or out based on compatible strings rather than at a subsystem
>>> level.
>>> Ideally this information could be extracted automatically somehow. OTOH,
>>> maybe the lists are pretty small. There's only a handful of subsystems
>>> that can be optional, and then only so many drivers in those that can be
>>> modules (at least for pinctrl, many drivers are built-in only).
>>
>>
>> Ooh, this is exactly what I wanted for of_iommu_xlate(), and would be much
>> nicer than the current bodge using system_state that I ended up with. The
>> context there is very similar - if the device has a parent IOMMU then we
>> want to wait for that to probe first if possible, but with a deadline such
>> that if it doesn't show up then we can go ahead and make progress without it
>> (on the assumption that DMA ops can fall back to CMA). The modules problem
>> doesn't currently apply to IOMMU drivers either, although we do use a
>> special of_device_id table for detecting built-in drivers via
>> OF_IOMMU_DECLARE() to avoid deferring at all when we know it would be
>> pointless - a more generic solution for that could certainly be useful too.
> 
> Ah, so you kept the IOMMU_OF_DECLARE() but it does nothing but define
> a table. We already have the driver match table which should pretty
> much be the same data, so it would be better if we could use that if
> possible. If we used MODULE_DEVICE_TABLE somehow, we could avoid
> modifying lots of drivers. Though many built-in only drivers omit
> that. The other problem is it would become a large set of tables to
> search thru because it is global. That would probably end up slower
> than just deferring. So we need something like
> <subsystem>_DEVICE_TABLE() to have per subsystem tables. Then this
> function in this patch would need to be told which table to use.
> However, this is all really just an optimization to avoid deferring at
> all and could be addressed later. Is there any data on how much time
> you save avoiding deferring? This has come up in the past and I don't
> think it is much.

In the of_iommu case it's not actually an optimisation, but dodges a big 
problem with the self-contained implementation - if we blindly defer on 
a not-yet-present IOMMU until all built-in drivers have had a chance to 
register themselves naturally, then by the time we could safely assume 
the relevant IOMMU driver *isn't* built-in, all the clients (which may 
include the boot device) can already be stuck on the deferred probe list 
with nothing left to kick it and make progress again. It's quite 
possible I could have done better, I just wasn't very familiar with the 
driver core at the time, and repurposing the magic table instead of 
entirely removing it was by far the easiest way forward.

With this patch we would have a guarantee that the deferred list gets at 
least one kick after the deadline for waiting has passed, so in theory 
we could then just use the regular driver matching mechanisms to see 
whether a given IOMMU node can possibly probe or not. I'm not sure we 
could get rid of the driver introspection aspect entirely, since it 
might be the case that the IOMMU itself has dependencies and winds up on 
the deferred list behind one or more of its clients, in which case we'd 
still want them to keep waiting even after the deadline is nominally up.

> I've also been thinking about if we could use MODULE_DEVICE_TABLE to
> provide a list compatible strings from modules as a whitelist of
> devices to keep deferring probe on. That would require building
> modules to build the kernel which I don't think would work. I think my
> conclusion is that the cases we care about may be short enough to just
> manually maintain such a list.

FWIW we did get rid of the equivalent table completely for the arm64 
ACPI code, but that only has to support 2 types of IOMMU so just 
evaluates the respective driver config symbols directly with 
IS_BUILTIN(). Sadly that method really can't scale to DT with multiple 
compatible strings per driver...

I guess there's also the possibility that a single driver may want 
multiple behaviours, if e.g. if SoC variants A and B have some identical 
peripherals but slightly different pinctrl/IOMMU/etc. hardware such that 
A has workable default behaviour and can be treated as optional, whereas 
B absolutely must be controlled by the kernel for the consumers to 
function properly, and they *should* defer forever otherwise. I think 
that would pretty much demand some sort of explicitly-curated 
white/blacklist setup at the subsystem or driver level.

Robin.
