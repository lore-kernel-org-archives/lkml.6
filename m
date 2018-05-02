Return-Path: <agraf@suse.de>
X-Google-Smtp-Source: AB8JxZrg6G4u3QhCBQGjPxrOXnNStdnAkj1p7AQPApXsUBZ2wHbdZhJOVPXPetKqjZZck8w0tbP5
ARC-Seal: i=1; a=rsa-sha256; t=1525266978; cv=none;
        d=google.com; s=arc-20160816;
        b=pP59XWXRnMUcxurcRUT19z85jD2QhhlZiD10ePk2olFX4fjz5svqn9GKL22dJguiSJ
         7GnLD7HoBhbiyImopzzOCOKLuz2Vtn4uPDAbS5gi0nM8rE3yZGGR9I7ZD6WfKJcNqKVr
         UPEhCdWdRZ99VW700nE+ntmBDh0/B1NDdOknmriYTF+JgCdE3ctJqUPvoOzC6/BxN7R2
         VKghFmkKJxWfZHnuVDaO9Crkr6xpNgQfpZRgjvUFc5IM9S0ZEPIHBdELT2CgeUf4wgQ3
         D0gU9Co8qFiO8maoFp745TVuEF750mnIhz2NfW4j1X45GzbugrVJyZOo081VdHeM2BSf
         KEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=4Ko+V7IlSu5tZEkwd6zwNfliw7mqIVuxiV2PWqgDWXo=;
        b=g/BWmDPUB/OvA7AFOiBvCPX70QbAa/yWu2JS8hmFLaSOaW9H1DSPo9Agyz7vjppr1M
         Tyc9dqBde6fEVGz4SiNF9/6TOIjbvA4IVWONa9nFv0h1ag9KHSshkMoKTdawYDHCXbds
         URe2skUpIKmAAI1W8vvOL5/XEBgEhTseVG3Ajf2GZ+6x1gbMmZdoI53bSmyKeuncfEih
         Uzpwl08oGbOjhnguFGVaw35Z7eHInLGBo8hl5dw5kxpXyCB8lebpi3lCIzDOfxsRRh4n
         Cxo7S7ycRGyfNFqP3TlP5X0/6bUzVP4/M/enjXZ7JOvjHMS3yOL573ihsr8zXDa07MQN
         c4Zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of agraf@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=agraf@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of agraf@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=agraf@suse.de
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
To: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grant Likely <grant.likely@arm.com>, Linus Walleij
 <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, boot-architecture@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org
References: <20180501213114.20183-1-robh@kernel.org>
From: Alexander Graf <agraf@suse.de>
Message-ID: <e7755330-bb6f-ad3a-fb82-7fc85a4cfac3@suse.de>
Date: Wed, 2 May 2018 15:16:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501213114.20183-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1599358346910684928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/01/2018 11:31 PM, Rob Herring wrote:
> Deferred probe will currently wait forever on dependent devices to probe,
> but sometimes a driver will never exist. It's also not always critical for
> a driver to exist. Platforms can rely on default configuration from the
> bootloader or reset defaults for things such as pinctrl and power domains.
> This is often the case with initial platform support until various drivers
> get enabled. There's at least 2 scenarios where deferred probe can render
> a platform broken. Both involve using a DT which has more devices and
> dependencies than the kernel supports. The 1st case is a driver may be
> disabled in the kernel config. The 2nd case is the kernel version may
> simply not have the dependent driver. This can happen if using a newer DT
> (provided by firmware perhaps) with a stable kernel version.
>
> Unfortunately, this change breaks with modules as we have no way of
> knowing when modules are done loading. One possibility is to make this
> opt in or out based on compatible strings rather than at a subsystem level.
> Ideally this information could be extracted automatically somehow. OTOH,
> maybe the lists are pretty small. There's only a handful of subsystems
> that can be optional, and then only so many drivers in those that can be
> modules (at least for pinctrl, many drivers are built-in only).
>
> Cc: Alexander Graf <agraf@suse.de>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This patch came out of a discussion on the ARM boot-architecture
> list[1] about DT forwards and backwards compatibility issues. There are
> issues with newer DTs breaking on older, stable kernels. Some of these
> are difficult to solve, but cases of optional devices not having
> kernel support should be solvable.

I think this is a reasonable approach. Maybe this should be a CONFIG 
option that disallows pinctrl drivers (and power domain later) to be =m? 
Then by default we could force those drivers to be compiled in, but if 
you really wanted to do kernel modules for pinctrl/pd you'd consciously 
potentially lose forward compatibility.


Alex
