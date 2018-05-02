Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AB8JxZoFCHwPxPr+8dHgUcRflW5hiZ25zxOYT+ktL7IYV95zq1xpB0m8ZhUQ3DlSrX8FQpFHEZs6
ARC-Seal: i=1; a=rsa-sha256; t=1525272554; cv=none;
        d=google.com; s=arc-20160816;
        b=CzCSonneiN8wQYgQO1/vZvsSfsYLF5ypYiViX1ToYYXcG+bS2gYHYYFJvTGKmG+3oL
         34RmI7BY1groTnlD72+Z8hTBjznuJX/3SSBXKnDakLMOEFn3O5TPSNjVZNE1NJTiUBHV
         SU/L/LEy/Gk79YhlQHZ3u2Z/c73LGZ5zGKhB0C0254IXLwt+EMOWNbeI9ucl+zExo0DX
         Qhkf+Ya3kOvSxO4Qsvm7rAVj1CbyRENPX0QBoiJxgLC69FCsGTv4tWT5KlF6eOy19LYx
         G/XoqSLUZbrBgEeCMBirJ/4k2AqC/urvhP8pp52ZhyPWv//NVBXotcIkL7+v73sYIg2x
         vtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=mTiMHUYHoHD2hA3zFZZZGOmuBFxpCtjieOMQTKy4Mec=;
        b=pR0bgfBg/mgAsuxx4NHlIjSTSgDsJPVrHG7RZPRlD+RDYC61WtHxb+SqO8FBQ1tAyS
         vKVweavEajhNjCgRvradYjdB4iI6+qAaScYbzBdphVdMzyNWmqIi8kW56fpnhPPdHRW8
         z9jyHpSOi79O/dhrBGIS++2j2pIGU5EtW6/OT0x1DnZyETcW7nYe8nSXEglNA2NwJ21l
         LRg9CSJCFu7HmwTgb8eU2VpqJ7asTu/6rLncyw1IIuYAPR+MI/fREDu0cbqPy+KBkKru
         TTHiC6HozdgzNlsOZqAr0YXTowE7KROKCJ9YIXiW6lrTlDbBhQhkLqqqDdOW0f1+2PUi
         y6iw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=cyQRPOhy;
       spf=pass (google.com: domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=cyQRPOhy;
       spf=pass (google.com: domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=kernel.org
MIME-Version: 1.0
In-Reply-To: <f808a652-2454-941c-2fd1-60776fb353f6@arm.com>
References: <20180501213114.20183-1-robh@kernel.org> <f808a652-2454-941c-2fd1-60776fb353f6@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 2 May 2018 09:48:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJvMyrKS4LsRC6fDus24Yg8U+VcrbNNvxtOXmKbrc8RAA@mail.gmail.com>
Message-ID: <CAL_JsqJvMyrKS4LsRC6fDus24Yg8U+VcrbNNvxtOXmKbrc8RAA@mail.gmail.com>
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
To: Robin Murphy <robin.murphy@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
	boot-architecture@lists.linaro.org, Stephen Boyd <sboyd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>,
	Alexander Graf <agraf@suse.de>, Grant Likely <grant.likely@arm.com>, Mark Brown <broonie@kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1599364194349239912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 6:40 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 01/05/18 22:31, Rob Herring wrote:
>>
>> Deferred probe will currently wait forever on dependent devices to probe,
>> but sometimes a driver will never exist. It's also not always critical for
>> a driver to exist. Platforms can rely on default configuration from the
>> bootloader or reset defaults for things such as pinctrl and power domains.
>> This is often the case with initial platform support until various drivers
>> get enabled. There's at least 2 scenarios where deferred probe can render
>> a platform broken. Both involve using a DT which has more devices and
>> dependencies than the kernel supports. The 1st case is a driver may be
>> disabled in the kernel config. The 2nd case is the kernel version may
>> simply not have the dependent driver. This can happen if using a newer DT
>> (provided by firmware perhaps) with a stable kernel version.
>>
>> Unfortunately, this change breaks with modules as we have no way of
>> knowing when modules are done loading. One possibility is to make this
>> opt in or out based on compatible strings rather than at a subsystem
>> level.
>> Ideally this information could be extracted automatically somehow. OTOH,
>> maybe the lists are pretty small. There's only a handful of subsystems
>> that can be optional, and then only so many drivers in those that can be
>> modules (at least for pinctrl, many drivers are built-in only).
>
>
> Ooh, this is exactly what I wanted for of_iommu_xlate(), and would be much
> nicer than the current bodge using system_state that I ended up with. The
> context there is very similar - if the device has a parent IOMMU then we
> want to wait for that to probe first if possible, but with a deadline such
> that if it doesn't show up then we can go ahead and make progress without it
> (on the assumption that DMA ops can fall back to CMA). The modules problem
> doesn't currently apply to IOMMU drivers either, although we do use a
> special of_device_id table for detecting built-in drivers via
> OF_IOMMU_DECLARE() to avoid deferring at all when we know it would be
> pointless - a more generic solution for that could certainly be useful too.

Ah, so you kept the IOMMU_OF_DECLARE() but it does nothing but define
a table. We already have the driver match table which should pretty
much be the same data, so it would be better if we could use that if
possible. If we used MODULE_DEVICE_TABLE somehow, we could avoid
modifying lots of drivers. Though many built-in only drivers omit
that. The other problem is it would become a large set of tables to
search thru because it is global. That would probably end up slower
than just deferring. So we need something like
<subsystem>_DEVICE_TABLE() to have per subsystem tables. Then this
function in this patch would need to be told which table to use.
However, this is all really just an optimization to avoid deferring at
all and could be addressed later. Is there any data on how much time
you save avoiding deferring? This has come up in the past and I don't
think it is much.

I've also been thinking about if we could use MODULE_DEVICE_TABLE to
provide a list compatible strings from modules as a whitelist of
devices to keep deferring probe on. That would require building
modules to build the kernel which I don't think would work. I think my
conclusion is that the cases we care about may be short enough to just
manually maintain such a list.

>
> I agree with Greg that the naming here is a bit tricky - FWIW my initial
> thought would be something like driver_defer_until_init(), which is still
> clunky but at least imperative.

Yeah, I didn't give it much thought as I expected more comments on the
general idea... Maybe my poor naming is a good diversion. :)

Rob
