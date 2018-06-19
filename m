Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7969C5AE5E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891B620661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891B620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757312AbeFSUyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:54:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52789 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755453AbeFSUys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:54:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id p126-v6so2526354wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NLn+dVQDKRljftsbFrdUMpfx152VpcJDaDlwRMjgCgU=;
        b=XpQsUvbJ6N3ZRM2LiLVBLOC1Qhg1ffU9d5GolZGkuYVZWWaxH148Lifx3xaUyPamPL
         FqHsTHvlB90wPV7M9/LqA6tR5qF2WekkPZWLWw5JDZd9btHvBN/aFOiN8dE2EMqDdDc5
         /CC1DavdCtnH28Kg6YJnTh2x8pBQexiM8YF1TDJM9LgNisHlTNCRhEJkBM5yrDZwEQbA
         +ISIYrsPSqOHFGhnxoBhGVx/j2LWEkXz6IaYkiEyGhoL7MHGBxz1ZlGoNCt8KlXkmJJd
         9vLEElRsyWHoWsit1NVwqEH+LD6QrEcUFnu7R5R1RyL0/K/B+pfhBzp2R07AizvqyxqF
         8oFg==
X-Gm-Message-State: APt69E3e/n+xragM+RaIdvgqTAv3ooNWSCISLhPDslmsWr4FwTYrZgJn
        PFtXPwzyyJyUDe0wH3kFlfVh8g==
X-Google-Smtp-Source: ADUXVKJD/NlKNTiPfEstmNLH28ZJNQsvB6C92N9B4ZS9+hHUr5qbGuRTc7Kqr+eO8L48oq+dluo4Ww==
X-Received: by 2002:a1c:d809:: with SMTP id p9-v6mr12623166wmg.111.1529441687459;
        Tue, 19 Jun 2018 13:54:47 -0700 (PDT)
Received: from [192.168.1.13] ([90.77.100.34])
        by smtp.gmail.com with ESMTPSA id c53-v6sm1356095wrg.12.2018.06.19.13.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 13:54:46 -0700 (PDT)
Subject: Re: [RFC PATCH v2] driver core: add a debugfs entry to show deferred
 devices
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180619183356.32106-1-javierm@redhat.com>
 <CAHp75Vcn39N9rZ0UO3szGrODVLxek4X746uWs+RPXwy4i0s1Ug@mail.gmail.com>
 <CAHp75VdpHdanWJmcwLBRTSDoDkbpPxuAGwwVO0hosXSRn4PUoA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <c0003b93-886f-10d1-fd7b-17b0323b90a7@redhat.com>
Date:   Tue, 19 Jun 2018 22:54:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdpHdanWJmcwLBRTSDoDkbpPxuAGwwVO0hosXSRn4PUoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Thanks a lot for your feedback.

On 06/19/2018 09:55 PM, Andy Shevchenko wrote:
> On Tue, Jun 19, 2018 at 10:53 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Tue, Jun 19, 2018 at 9:33 PM, Javier Martinez Canillas
>> <javierm@redhat.com> wrote:
>>> For debugging purposes it may be useful to know what are the devices whose
>>> probe function was deferred. Add a debugfs entry showing that information.
> 
>>> +static int deferred_devs_open(struct inode *inode, struct file *file)
>>> +{
>>> +       return single_open(file, deferred_devs_show, inode->i_private);
>>> +}
>>> +
>>> +static const struct file_operations deferred_devs_fops = {
>>> +       .owner = THIS_MODULE,
>>> +       .open = deferred_devs_open,
>>> +       .read = seq_read,
>>> +       .llseek = seq_lseek,
>>> +       .release = single_release,
>>> +};
>>
>> Isn't this DEFINE_SHOW_ATTRIBUTE() ?
>

Indeed.
 
> Besides that, you are summoning Greg's dark side :-)
> See below.
> 
>>> +       if (IS_ENABLED(CONFIG_DEBUG_FS)) {
>>> +               deferred_devices = debugfs_create_file("deferred_devices",
>>> +                                                      0444, NULL, NULL,
>>> +                                                      &deferred_devs_fops);
> 
>>> +               if (!deferred_devices)
>>> +                       return -ENOMEM;
> 
> This must not prevent the execution. So, the check introduces actually
> a regression.
>

Fair enough, I'll fix these an re-spin the patch.
 
>>> +       }
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
