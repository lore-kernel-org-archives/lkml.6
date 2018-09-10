Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC3BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC10E20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iU6hQsHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC10E20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeIJOoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:44:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42271 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeIJOoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:44:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so21173426wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G/ESRwqE/rb3ZBbl8EwSgeN9RXkMQLxc5ggH39Nshlg=;
        b=iU6hQsHMvHmEUeD5g+qzHHoynEJQfeh1cE41FvxJuvf+SNfH4J1Fvr062PPINVC5qU
         x++RyCxuwMzAQdhsNaQZQrJ7U84Hu+CVcYn4PRpxS/aB97Tv15C8DQE5/riMC09Iemjc
         S8PyVMk5apQ1c/znaG/enygxAX9ePp8UTbd+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G/ESRwqE/rb3ZBbl8EwSgeN9RXkMQLxc5ggH39Nshlg=;
        b=INZEM3qcaYsFx6PjEMH7p6AHpWPTXpUJACC9LZa6S1HV+oOrEkN77TX7OjWolzF6Qn
         DqLOUxI45d9ioS8JBoyp2KA8QfayCYMZj161/WTbuAuAXa3GBNSPvut8TcP9F3YVB0gA
         x69L+FbJ7c2vb8ZePidhxrAoVArj7xGaWI0tPWDltp48GKMB/5u/FKEpt9D3CRrvlIEA
         RxN3Ff+iqmn/TGujQkVDjxeu9M/ETisuNYpAts7jCjM220vDgMUBrkqwQseUqmbfdCHO
         6/CdyaD20PcQ3CPXaPJWzCWPBUh7eDgRjHL20ctUyYN3xgdMepgVWrBtzvSGPAN+JXKU
         Cm0w==
X-Gm-Message-State: APzg51C20rvuEev9GErKtmoRv8NwXfXNpUu5t+KRodfbYnHpAS34Q66s
        Vk2sE3Gce1uw9A5TE/KV/0EkNw==
X-Google-Smtp-Source: ANB0VdZjBeGT/kODCIKIsrdq3wjEyO+90NNpvZeVF2iZvzbcqA7mTzsDK89LIdl1BTIILA9XQ7T0GA==
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr13775094wrf.46.1536573060638;
        Mon, 10 Sep 2018 02:51:00 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id j44-v6sm22590038wre.40.2018.09.10.02.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 02:51:00 -0700 (PDT)
Subject: Re: [PATCH v2 13/16] nvmem: add support for cell lookups from machine
 code
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-14-brgl@bgdev.pl>
 <484b6ec5-cd8e-e5c5-0c5c-2f11c504ea1c@linaro.org>
 <CAMRc=MdnSHY1ah4X3Bu55HvZcOQHxPHaFudidDA4mEOW9ZzeEg@mail.gmail.com>
 <20180910102324.52ecd8f7@bbrezillon>
 <c72866dd-1fb0-c765-5815-ba63d051a09b@linaro.org>
 <CAMRc=Me0bYjdmaqqxKqFkRRSNdoOgDf1A==dASz0dJAtx9BDqg@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f161f5fd-a651-eee1-78ee-63607021db7f@linaro.org>
Date:   Mon, 10 Sep 2018 10:50:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=Me0bYjdmaqqxKqFkRRSNdoOgDf1A==dASz0dJAtx9BDqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/18 10:45, Bartosz Golaszewski wrote:
>> Yes, this is how it should be!
>>
> Any actual reason for not putting these definitions into a separate
> 'machine' header? This approach is currently used by gpio, pinctrl,
> iio and regulator framework because most systems use either DT or ACPI
> and don't need to pull in any stuff aimed at board files.

I don't want to create header files specific to usecase!
Lets keep it simple!

--srini
