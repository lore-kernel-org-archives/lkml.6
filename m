Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551A3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2D420878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6VHVVXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2D420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeH1TBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:01:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40735 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeH1TBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:01:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so1917696wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1ysuMyjslnNmKPvA1Q8Cl4aIB7ZkQNm5F4YreX8quzE=;
        b=Y6VHVVXy5OcolDYbpbhoDyREzRqmZ1OeUNDfaefg67fOCHmuvoeI3O8KVbOkLo0gbn
         qsHXscBoQ+iZDexppXZu965fWr8OZYXgA5dI5IDotqdUmsfHUysYfVkuvHMH9k1yb7is
         8OPV0PhODqnISuILw5nrTb4LJjtXFbN+mbq+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ysuMyjslnNmKPvA1Q8Cl4aIB7ZkQNm5F4YreX8quzE=;
        b=Ed0of3WydMtw27xGaE5d/J9OOy4MdpwbcYCKHBgFaiWhSFUJK2sA/Xy07dYtv9tY3i
         /1pPgxdche9Oil6/SSHT9llxQNi6q4vLyn79U3cEiDz0fZhcNplXxnCzptLPdDtDz9Vf
         kMyZ/qUGNu2zVy69w4SDR+cIaIKhTFf9c4mZyNHtW2K9h5iNygEHXFsyHbN0p6Se0wY6
         0KhMbSXme3Uot9bMwMuLETIO8yxmsUUzpKTwucwTAN/eKEd8RsEdyiE+f2SBi8UyLY6/
         RQiyq2jy6CYkHfghAI7wZRzlGyh1VDdf5unhIyFw56z6eAiWVBkWBhQFRhnHLipAb/O2
         9HXQ==
X-Gm-Message-State: APzg51BrZYdh2sOc/X+c0G/niMZb3JoD/M+8aMnAq4bZhru5Eqz1mI5I
        PL1xXudFuIMHm1ACM8h4Z/WO/Q==
X-Google-Smtp-Source: ANB0VdYfJDCvkUlbOerVbEIU868dvteCd+l+UHkYxuwCGPGBZjvBeGVQ4sWOtPuuoLQGHkU6d1vz4g==
X-Received: by 2002:a5d:4fc3:: with SMTP id h3-v6mr1462763wrw.261.1535468949787;
        Tue, 28 Aug 2018 08:09:09 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id l24-v6sm2676159wrb.65.2018.08.28.08.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:09:09 -0700 (PDT)
Subject: Re: [PATCH v2 01/29] nvmem: add support for cell lookups
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andrew Lunn <andrew@lunn.ch>,
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
 <20180828165309.0594ae13@bbrezillon>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <af94be21-328b-d6a2-2024-67b98860c3d5@linaro.org>
Date:   Tue, 28 Aug 2018 16:09:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180828165309.0594ae13@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/08/18 15:53, Boris Brezillon wrote:
> On Tue, 28 Aug 2018 16:41:04 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 

...
> 
>>>
>>>   static struct nvmem_cell *nvmem_find_cell(const char *cell_id)
> 
> Can we get rid of this function and just have the the version that
> takes an nvmem_name and a cell_id.

That should be feasible!


>>>>>
>>>>> I hope you got the reason why of_nvmem_cell_get() always allocates new
>>>>> instance for every get!!
>>>>
>>>>
>>>>
>>>> I admit I didn't test it, but just from reading the code it seems like
>>>> in nvmem_cell_get() for DT-users we'll always get to
>>>> of_nvmem_cell_get() and in there we always end up calling line 873:
>>>> cell = kzalloc(sizeof(*cell), GFP_KERNEL);
>>>>   
>>> That is correct, this cell is created when we do a get and release when we
>>> do a put().
>>>   
>>
>> Shouldn't we add the cell to the list, and check first if it's there
>> and only create it if not?
> 
> Or even better: create the cells at registration time so that the
> search code is the same for both DT and non-DT cases. Only the
> registration would differ (with one path parsing the DT, and the other
> one searching for nvmem cells defined with a nvmem-provider-lookup
> table).
Makes sense! and that would go very well with the plan of "nvmem-cell" 
compatible for cells!.
> 
