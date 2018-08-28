Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36EEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607D620833
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FqifKzsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607D620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeH1Sk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:40:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43840 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbeH1Sk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:40:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so1849758wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z8u4+QUscOOBbFDXMTgV8XJh97AeyBBGr/ABcvtAHYw=;
        b=FqifKzsMMib3ctgZCeV7WiuATY0pprQsExUPs6ehoIX8nKW6dkHIugKQ5ALxj9fzTj
         semUMHJQD4xO0FGE2R9jjVQhvs0U+y3/Ar4zPtZaecQ5NCPxENrjH82coW60TXc0doXE
         hwOHprv59DIPR3WxceqM/j7VUwFW9XGqx8Wvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z8u4+QUscOOBbFDXMTgV8XJh97AeyBBGr/ABcvtAHYw=;
        b=HGI8+CBic15EfWSLCYtiAEoFQFVJvcEdSOkjfLHIt6W0Et5zneXzNLGZRlFISYgjEL
         GDcIdfbEzC0CMH+KCLdRmSdbW21SbqsVfa/04666wxQkDNDS1x4GyVWmShNDBO/IbqLs
         HhZnxWAdv1OdSs9NGF6b1A3PHPEsuWW2ovty6RsE7FMuUNy+5C+F9k3l3lpPwVQUWJsg
         h7vcrwGs0aVpAVK6F6oYYjvGZ6EzHM7qZOWiyEjk1Om0avZuif2ZtblK8UpzF+98EHjC
         LzCrRa+sAKoQ9MyjrEA6TsUIgr2RnkyMudD0b8zyqsHRNoQ/7+3j2CdlwH6KFnjFGH3N
         ruHQ==
X-Gm-Message-State: APzg51BujeuQReX7vW8hpCt2WGtigSuYtFTQsetBTBhXL0ySHXGlm8SO
        FOwExOO2pcTWuBFhS/vdA9faoA==
X-Google-Smtp-Source: ANB0VdYiLlA6hrkJyF271yXChKrIOtNQnbHSSQB4x/XcE3tRFJ1gX8pRZ6g3Znz28TUrj8CpC2GKgw==
X-Received: by 2002:adf:93c2:: with SMTP id 60-v6mr1293010wrp.81.1535467703738;
        Tue, 28 Aug 2018 07:48:23 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id g133-v6sm1928311wmf.44.2018.08.28.07.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 07:48:22 -0700 (PDT)
Subject: Re: [PATCH v2 01/29] nvmem: add support for cell lookups
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-doc <linux-doc@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        David Lechner <david@lechnology.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sven Van Asbroeck <svendev@arcx.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, Naren <naren.kernel@gmail.com>,
        netdev <netdev@vger.kernel.org>, Alban Bedel <albeu@free.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-2-brgl@bgdev.pl> <20180824170848.29594318@bbrezillon>
 <20180824152740.GD27483@lunn.ch> <20180825082722.567e8c9a@bbrezillon>
 <CAMRc=Men-MPk5DGshWcVEc0v=gH2WSpx1j-CawOeydwp59tejw@mail.gmail.com>
 <20180827110055.122988d0@bbrezillon>
 <CAMRc=MfpZJUEAhM4OoLbmJcnX3rTJk8fvdiL6=9BjNkVcsf=SA@mail.gmail.com>
 <8cb75723-dc87-f127-2aab-54dd0b08eee8@linaro.org>
 <CAMRc=Mex5WAm8uiV4T=0+bLduBBdj18iekuYT55W9gA_rzQ_sg@mail.gmail.com>
 <916e3e89-82b3-0d52-2b77-4374261a9d0f@linaro.org>
 <CAMRc=MeALxpyBQhWxGPt9BubO_ZwKGih1d8zhRzFYZ0+3kHFAA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <626e6122-2e58-3317-89b2-77959c9310f7@linaro.org>
Date:   Tue, 28 Aug 2018 15:48:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=MeALxpyBQhWxGPt9BubO_ZwKGih1d8zhRzFYZ0+3kHFAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/08/18 15:41, Bartosz Golaszewski wrote:
> 2018-08-28 15:45 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>>
>>
...
>>> I would like to support an additional use case here: the provider is
>>> generic and is not aware of its cells at all. Since the only way of
>>> defining nvmem cells is through DT or nvmem_config, we lack a way to
>>> allow machine code to define cells without the provider code being
>>> aware.
>>
>>
>> machine driver should be able to do
>> nvmem_device_get()
>> nvmem_add_cells()
>>
> 
> Indeed, I missed the fact that you can retrieve the nvmem device by
> name. Except that we cannot know that the nvmem provider has been
> registered yet when calling nvmem_device_get(). This could potentially
> be solved by my other patch that adds notifiers to nvmem, but it would
> require much more boilerplate code in every board file. I think that
> removing nvmem_cell_info from nvmem_config and having external cell
> definitions would be cleaner.

Yes, notifiers would work!

...
>>>
>>> Yes, I would like to rework nvmem a bit. I don't see any non-DT users
>>> defining nvmem-cells using nvmem_config. I think that what we need is
>>> a way of specifying cell config outside of nvmem providers in some
>>> kind of structures. These tables would reference the provider by name
>>> and define the cells. Then we would have an additional lookup
>>> structure which would associate the consumer (by dev_id and con_id,
>>> where dev_id could optionally be NULL and where we would fall back to
>>> using con_id only) and the nvmem provider + cell together. Similarly
>>> to how GPIO consumers are associated with the gpiochip and hwnum. How
>>> does it sound?
>>
>> Yes, sounds good.
>>
>> Correct me if am wrong!
>> You should be able to add the new cells using struct nvmem_cell_info and add
>> them to particular provider using nvmem_add_cells().
>>
>> Sounds like thats exactly what nvmem_add_lookup_table() would look like.
>>
>> We should add new nvmem_device_cell_get(nvmem, conn_id) which would return
>> nvmem cell which is specific to the provider. This cell can be used by the
>> machine driver to read/write.
> 
> Except that we could do it lazily - when the nvmem provider actually
> gets registered instead of doing it right away and risking that the
> device isn't even there yet.
> 
Yes, it makes more sense to do it once the provider is actually present!

>>
>>>>>
>>>>> BTW: of_nvmem_cell_get() seems to always allocate an nvmem_cell
>>>>> instance even if the cell for this node was already added to the nvmem
>>>>> device.
>>>>
>>>>
>>>> I hope you got the reason why of_nvmem_cell_get() always allocates new
>>>> instance for every get!!
>>>
>>>
>>>
>>> I admit I didn't test it, but just from reading the code it seems like
>>> in nvmem_cell_get() for DT-users we'll always get to
>>> of_nvmem_cell_get() and in there we always end up calling line 873:
>>> cell = kzalloc(sizeof(*cell), GFP_KERNEL);
>>>
>> That is correct, this cell is created when we do a get and release when we
>> do a put().
>>
> 
> Shouldn't we add the cell to the list, and check first if it's there
> and only create it if not?
Yes I agree, duplicate entry checks are missing!

--srini
> 
> Bart
> 
