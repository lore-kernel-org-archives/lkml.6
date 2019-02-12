Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C856C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A79B217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo9keMXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbfBLQUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:20:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32975 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbfBLQUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:20:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so1489194pgu.0;
        Tue, 12 Feb 2019 08:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fn3V75Mf9/HbiODX89yQ8/MGcSX2G4LNhUE84jpD4lA=;
        b=lo9keMXmk59/FG3dhA2Vj48XeD82ktuy8tpqtQo8BQ2E/fGgy5m4JJUH2GRxEpkzoc
         SE00ufigt7aYEJERjMxrepKeWmn663eJXX7QOHpr/2KTUXRXBiYp16440DZFqijSVNzy
         156bEKZo0Cda6w7nw6q/vDqfCmvonlaKT8VTuRB+ODbNczUbHdsqaJaXOY33dCVZuzfj
         SGl3fkrjfXJ35vmRcAEutf5BnKNtccvLWTqpWui1uiKl5wbRlgWzF89IpeRibkfEP32L
         pZWMSypBlFj8yn1Rter5aK1/jLtfea1jQnjCnyxcqCTd10JGr32y97YU0v3P4g9zhMd9
         yPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fn3V75Mf9/HbiODX89yQ8/MGcSX2G4LNhUE84jpD4lA=;
        b=sW9nWlIrf7itEZvpPaNca/hv30kJ5MhJyjXORJ6B6FGYVRZHJ3qbjOuEU9XpxG1won
         xIZqPZ8hZSBqc1Ycm1+2tYJUT43PjJUKy/GZ4zf1cXH57AT6Kz4K7lNZ2DNF4tzvm8Nu
         acOrjpp88WPvu3QGh8gv8wr8Usl9Ko5OvMaHI67ylR7RtKMRjK9T3LS+7LlhH3cTebh6
         1Apr1YhrKUrcH5OHcxpIa/ZNTXlHw8nb3j9KIUOUcQ0lgXL1DrWEQVd6z7bjgVIDpBtz
         JApdf2i94mcN1V89bWtVBbM7iyQNW7n/x7uhERM4LrhLqJkX9pm85aX8Ib2UUY9VsXjA
         cytw==
X-Gm-Message-State: AHQUAubm9wkWJ8YrON++JpYS2/Zgm2Qxa1b6jLpsfvnveHcWE8dEqYFS
        +gx+SUrEAwYo8e4nc2aU1FCoNIY6
X-Google-Smtp-Source: AHgI3IZHlonO9RRfLyvkWcxeJJBbDCJeYfalJn/ihv8/NzNDHL53xk65eGF6W1H9XGhba5wJwR9LkA==
X-Received: by 2002:a63:5b48:: with SMTP id l8mr4380137pgm.80.1549988399494;
        Tue, 12 Feb 2019 08:19:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l19sm23932978pfi.71.2019.02.12.08.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:19:58 -0800 (PST)
Subject: Re: [PATCH] usb: typec: tcpm: Export partner Source Capabilities
To:     Greg KH <gregkh@linuxfoundation.org>, Kyle Tso <kyletso@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190131035411.53576-1-kyletso@google.com>
 <20190131070238.GA4500@kroah.com>
 <CAGZ6i=07EOHqd3r9y1MpYn_e1nFeYGt_wp9arhMZWWeTBm-udA@mail.gmail.com>
 <20190212105421.GA23271@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c838e214-4888-c708-6a7c-a8de6ecb5282@roeck-us.net>
Date:   Tue, 12 Feb 2019 08:19:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190212105421.GA23271@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 2:54 AM, Greg KH wrote:
> On Tue, Feb 12, 2019 at 06:29:39PM +0800, Kyle Tso wrote:
>> On Thu, Jan 31, 2019 at 3:02 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>>> On Thu, Jan 31, 2019 at 11:54:11AM +0800, Kyle Tso wrote:
>>>> Provide a function to get the partner Source Capabilities.
>>>>
>>>> Signed-off-by: Kyle Tso <kyletso@google.com>
>>>> ---
>>>>   drivers/usb/typec/tcpm/tcpm.c | 23 +++++++++++++++++++++++
>>>>   include/linux/usb/tcpm.h      |  1 +
>>>>   2 files changed, 24 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c
>>> b/drivers/usb/typec/tcpm/tcpm.c
>>>> index f1d3e54210df..29cd84ba9960 100644
>>>> --- a/drivers/usb/typec/tcpm/tcpm.c
>>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>>>> @@ -4494,6 +4494,29 @@ int tcpm_update_sink_capabilities(struct
>>> tcpm_port *port, const u32 *pdo,
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
>>>>
>>>> +/*
>>>> + * Don't call this function in interrupt context. Caller needs to free
>>> the
>>>> + * memory itself.
>>>> + */
>>>> +int tcpm_get_partner_src_caps(struct tcpm_port *port, u32 **src_pdo)
>>>> +{
>>>> +     unsigned int nr_pdo;
>>>> +
>>>> +     if (port->nr_source_caps == 0)
>>>> +             return -ENODATA;
>>>> +
>>>> +     *src_pdo = kcalloc(port->nr_source_caps, sizeof(u32), GFP_KERNEL);
>>>> +     if (!src_pdo)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     mutex_lock(&port->lock);
>>>> +     nr_pdo = tcpm_copy_pdos(*src_pdo, port->source_caps,
>>>> +                             port->nr_source_caps);
>>>> +     mutex_unlock(&port->lock);
>>>> +     return nr_pdo;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(tcpm_get_partner_src_caps);
>>>
>>> We don't add new functions that no one uses :(
>>>
>>>
>> This function is useful if the PD Device Policy Manager is implemented
>> outside of TCPM.
>> In this situation, Device Policy Manager needs to know the partner
>> capabilities to optimize
>> the charging process.
> 
> And where is that code?
> 

Agreed - that code should be sent upstream as well to let us see the
entire context.

>> Take existing functions in TCPM for example:
>> Function "tcpm_update_sink_capabilities" and
>> "tcpm_update_source_capabilities" are exposed
>> as well. And no one uses them now.
> 
> Great, let's go delete them now, we should not have apis that no one
> uses.  This isn't a new thing...
> 

I sent a patch to do just that. Quite frankly I don't recal
why I thought those functions might be needed.

Guenter
