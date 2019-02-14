Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F258AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5452147C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NvmVXhXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503244AbfBNUuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:50:16 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38053 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503209AbfBNUuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:50:15 -0500
Received: by mail-it1-f195.google.com with SMTP id l66so7798660itg.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WvvgtO108VJAafNVgcU1w9YurHp/03az+8ivNdW3JSg=;
        b=NvmVXhXBpNpPBQgWL8YV4nbeZP02AfShQpx1zIyxh+F9p6wQjy05jKkAPtNhaoLuH7
         H5q9ZDd7UY4KWCjbBsNR7Tt5Ix+RF+u4BWBodmtKMJ9jlHmib1LqW/ZtCAUv944xxVJb
         c107WiFNermdI6GhOR8gy4T3hvszRloeExIBquIM9+ZMGJL7G5jGIjs5VQeBJva2Ydr+
         30GUcBg1Yh3q1jMw5qMaZB5KsWfCgdZCKJO4Bt4a612ieUzUY0D3zxS1+tzbQqm/zuWD
         bVsCsoqE0+4yQ2rsPQSCw+eQkKt5u83P/h4lFre16OBvG8/8h+Ngh0LRUDLv52f4gt4w
         0fEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WvvgtO108VJAafNVgcU1w9YurHp/03az+8ivNdW3JSg=;
        b=CAPhN/mv41XsMuxWM3Ze/zd+hfrxpfRGiTagf7v4NnSdB9W9ed3aV7n5DYRr3W2x3A
         HFFLQXyLzC3D7ECk7LGezXK0lFiIywx1KnlOEUGNn15OzZv86Xg87EVr/YIIuBYDe3Nh
         w26GaJoyXBcfZ4uuETLJAMj7DAYWpdnUWlZgtumrWjX3ZVlITzRqNPqyy2lploaSX5nA
         YDWr5UdfZP0CiFv+9j3P4s9lSeUKaLzFhKov8Px09fVnviYni8D3AJBN3hXeFyxvnnFr
         NcTr6YWIwailDLjWr9FICHy+9gvDtruNzfboDUwKu7u8Q2dBJj8E5BiJuGsUND6SbWzS
         cyEg==
X-Gm-Message-State: AHQUAuZJiiD+UZEkaUd6Rx/2L7J+NXp5KTJ58c+KURLz2weeFZJSSn2P
        w4gublrw+qnKcCE4/mgd4qbTO9X6VnpBGQ==
X-Google-Smtp-Source: AHgI3IZFZdPLh9nFsFMorfx1YpqKvUHnUP3JjKQZCPYQFrcRRXU0wjvylkOlrRppGS+yaI4QUj+Yvg==
X-Received: by 2002:a24:a10:: with SMTP id 16mr3455673itw.42.1550177414296;
        Thu, 14 Feb 2019 12:50:14 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id g186sm1607648ite.39.2019.02.14.12.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 12:50:13 -0800 (PST)
Subject: Re: KASAN warning in bt_for_each
To:     Evan Green <evgreen@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAE=gft4_WiL87FtZnVmZok+oXPjK=GUb5tDUPGQFijddrB0Pbg@mail.gmail.com>
 <1550172827.93548.5.camel@acm.org>
 <CAE=gft5GR1xEM1gNQjMyo_wfhs_JUAc2AUHHk5qr36EjaWv1hg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a1471a88-f45b-885d-b62e-a3c539c6583d@kernel.dk>
Date:   Thu, 14 Feb 2019 13:50:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft5GR1xEM1gNQjMyo_wfhs_JUAc2AUHHk5qr36EjaWv1hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 1:45 PM, Evan Green wrote:
> On Thu, Feb 14, 2019 at 11:33 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On Thu, 2019-02-14 at 10:04 -0800, Evan Green wrote:
>>> Greetings, block experts!
>>>
>>> I'm trying to track down a KASAN warning I'm seeing in our downstream
>>> 4.19 kernel, and I could use a little help. The warning looks like
>>> this:
>>>
>>> [  224.564894] BUG: KASAN: use-after-free in bt_for_each+0x1ac/0x28c
>>> [  224.571195] Read of size 8 at addr ffffffc17c621340 by task fio/3851
>>> [  224.577745]
>>> [  224.579320] CPU: 2 PID: 3851 Comm: fio Tainted: G W 4.19.16 #398
>>
>> Please have a look at this e-mail thread:
>> https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/
> 
> Oh, yep, that's totally it. Did that patch make it in anywhere?

It didn't, since I didn't get any response to it.

-- 
Jens Axboe

