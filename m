Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05027C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34DF21852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBMXlAKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733273AbeLTNsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:48:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41341 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733197AbeLTNsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:48:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so958593pfi.8;
        Thu, 20 Dec 2018 05:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eb83Pe4gCxgGaSXjYfCfq71RNLUnyS1iIrp8zplpsIk=;
        b=kBMXlAKqquKxZJkf2+gZCi5uuKMM0q+M8s78orkOZ2rIXPqYJfPLZS6Pa8i9V9rufQ
         63yoq/Mo9g53vjiw+5YHmbtuvtC9cfJPJ8YBh7JwCU6TjwhjulOa90r8q3YvAu3AgjJP
         ByUGmk/B1ez9BUxVBKg2i5oF0eohIv7gC/WK3Q++3NNf+GVKgPp3sJFCCJakKEDDPmKI
         7veJJ46jye7z7j1KgfoSwd1KC3twSUEoj0sZg/csXdFSOUil3bipicBODLHEEAT0Jnle
         Bxo7Xtd2j1fE39GEEAugI0zNdpd++5RtqIFcZaycU9ohcY1fsY+5R3LteUe3Q55xqyV1
         KRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eb83Pe4gCxgGaSXjYfCfq71RNLUnyS1iIrp8zplpsIk=;
        b=q8+03z85O414viqbE04DMS96DndNJCjaYULbiDQ6/VCk6eeETHCm+qgTN3xTiL4399
         eTPh1GmMxsNgekaLRSx9wnTSZ7/ovpfmQqVBnfKTHJ73TXJkc3QEWBePhjeKFgyrVS/2
         vxg1fgJAJO/XTtmCCYXrwxXT8tvTCI/5U4lQxuMopO3YxhTZL4wzA6z/4HFul6LCSHot
         6g9o5HB4Ow0i/UEhVXeR1OPGSrCUUW8yfvkeMxlejM7GX4RAFzueMQW1+Lc1GUQv2lJc
         eZRwJ/V2kelSSx/PX2I0/NBVVJ0TvezFL0gnwEVps1FUz5FUYlBW2aGNCR4dsjhBgsrn
         NVpQ==
X-Gm-Message-State: AA+aEWbovcrVvF7Ij7Jts0NgYABeFYAyzj8wQWZLmkGalmFTajkiumZj
        LOGM8/qrLYOdX6wF8S0k2Qb+/ap9
X-Google-Smtp-Source: AFSGD/U8qAT7walmS38rprYxxkVGlT6Xih4ghqCxlE8C8ohOvBSs8VS1xo4gIhtAnBubuWhQHKNnzA==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr24721214pfv.216.1545313715201;
        Thu, 20 Dec 2018 05:48:35 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.24? ([2402:f000:1:1501:200:5efe:a66f:4718])
        by smtp.gmail.com with ESMTPSA id o84sm33676390pfi.172.2018.12.20.05.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 05:48:34 -0800 (PST)
Subject: Re: [BUG] usb: serial: garmin_gps: A possible concurrency
 use-after-free bug
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8b24e2fc-df9a-8e06-aa49-a27675fd36e9@gmail.com>
 <20181220134609.GA27701@localhost>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <794dc03a-527e-0e47-fba2-adf84fa3c7cf@gmail.com>
Date:   Thu, 20 Dec 2018 21:48:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181220134609.GA27701@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/20 21:46, Johan Hovold wrote:
> On Thu, Dec 20, 2018 at 09:41:16PM +0800, Jia-Ju Bai wrote:
>> In drivers/usb/serial/garmin_gps.c,
>> the functions garmin_read_bulk_callback() and garmin_write_bulk_callback()
>> may be concurrently executed.
>>
>> In garmin_write_bulk_callback() on line 969:
>>       kfree(urb->transfer_buffer);
>> In garmin_read_bulk_callback() on line 1165:
>>       unsigned char *data = urb->transfer_buffer;
>> Thus, a concurrency use-after-free bug may occur.
> No, they operate on different struct urb.
>
>> This possible bug is found by a static analysis tool written by myself.
> Seems you need to update your tool. Please also make sure to review its
> output before reporting anything.

Okay, thanks for your reply.
Sorry for my false positive...


Best wishes,
Jia-Ju Bai
