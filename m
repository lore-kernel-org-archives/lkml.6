Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD5CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E84421476
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKJ1jqCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E84421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeHFLBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:01:25 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42710 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeHFLBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:01:25 -0400
Received: by mail-oi0-f67.google.com with SMTP id b16-v6so7460196oic.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GV3BZs6rPzal+Ww8teASVsLpUUkAS3149bLeKPycJv4=;
        b=GKJ1jqCd+S2zaszDVVwzFS+wg6MmQq4/VU3gR/j/nNHP72JoVIWR/x3tb3+sqH+VHC
         ayOZtqvPuKl6PluTftpLTVvnGtT8PHtj91tTRId6VGmXVbJJMer0FTLSxd6ndoKvYvHr
         03OTGlQ/APspi/UM1q2KgbFLKtcUTLOtms8j6OaPoyJML3L6doCRWcmSjDhwywavvqkj
         sZeyhfanJ0o2g/VLy57WCzFgHY+9Q8jf38tuvloREdW6P0j3d5Co1y9iWa9Z4nFgHUbM
         9pTfyKhenr6OGIMjQXn7YjxYZVSQCMJLK7zBxirUBaR51JewlXvq7nXlyCWXrH27MAhz
         CR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GV3BZs6rPzal+Ww8teASVsLpUUkAS3149bLeKPycJv4=;
        b=TaJeX1edqk/Mnl7dil4R43XNoNqP/iVU6FZ+2iVQeK3qMcut5fOjVrbWZvZYEyg/JN
         F/eFNKmVPjoEBkZ2/l3l5vahWXvOVeqsGg1wy0rnbaVA4lx+rpSjavMVe6uDLKg82E3Y
         AXGEy7VqNrNBvj663YjtBKkF+qCwr5c6XSnmMPkOpxILbGstgFN4as4/7D1EagGv9LBm
         DWl7UndsZq9P6S3AK3ZbjRLy8jZh3rp13ohHZa0oY9pN81hPijipsD1K3rVu85owh9nO
         qyUhQFg6O0AkOjZMS5FUV/cISJmSyVoOEAo5sQ6EPQAPRC6bKdSUqaP1jeV71emezkWS
         kHUg==
X-Gm-Message-State: AOUpUlEf0NLF62JcBHbdHsI4zoS+WfG2k+RUEIQIkO83ANDdsdGCLRGr
        qxWbq8BKqiEWXJPg1Fek8uc6gfgduSmte82/a/0=
X-Google-Smtp-Source: AAOMgpfWsIgp0lIbsuUyq/0ZQX/0KX3z/A4iBg4gKQEVlAg0yEkummsWGS5+cX3DOj4lhqTK0l6tiKqNrdj1961isnE=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr14098986oie.174.1533545602100;
 Mon, 06 Aug 2018 01:53:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 01:53:21 -0700 (PDT)
In-Reply-To: <de9fc0924f73bc26e067cce6c18d2714@codeaurora.org>
References: <1532035440-7860-1-git-send-email-rishabhb@codeaurora.org>
 <CAJZ5v0gWqx5Op-Bbg7bAYALCyBPsc=-+homAYj2Q1qd3WsqmDw@mail.gmail.com>
 <e4ca8572ed913ab65f63be8a351d4439@codeaurora.org> <CAJZ5v0ixuWo9RC21Z8zVhuHfkr1uV4vdqMh4s+qGMR7R8Wycag@mail.gmail.com>
 <68b90830d5024ce75a20b017aaf21c05@codeaurora.org> <CAJZ5v0jpm8tVjyWjA36Sp-bTEWUE+6cExjH7=CM=LUB-6xvePA@mail.gmail.com>
 <CA+tyz+6ZwtpKM=G5F2Do_sXWyo8r83ma19fWpn4HELiy0XT7=w@mail.gmail.com> <de9fc0924f73bc26e067cce6c18d2714@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Aug 2018 10:53:21 +0200
X-Google-Sender-Auth: FQd8-IiOvBP9ScqPD8Rjbk2hl2A
Message-ID: <CAJZ5v0h4=TqzXY3W-eVRyCh1FLzAWASoOdNEJyAmHHgJQEMWeg@mail.gmail.com>
Subject: Re: [PATCH] dd: Invoke one probe retry cycle after every initcall level
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        tsoni@codeaurora.org, Vikram Mulukutla <markivx@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ckadabi@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 12:20 AM, Sodagudi Prasad
<psodagud@codeaurora.org> wrote:
>> From: RAFAEL J. WYSOCKI <rafael@kernel.org>
>> Date: Wed, Aug 1, 2018 at 2:21 PM
>> Subject: Re: [PATCH] dd: Invoke one probe retry cycle after every
>> initcall level
>> To: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>, Linux Kernel Mailing List
>> <linux-kernel@vger.kernel.org>, ckadabi@codeaurora.org,
>> tsoni@codeaurora.org, Vikram Mulukutla <markivx@codeaurora.org>
>>
>>
>> On Wed, Aug 1, 2018 at 11:18 PM,  <rishabhb@codeaurora.org> wrote:
>>>
>>> On 2018-07-24 01:24, Rafael J. Wysocki wrote:
>>>>
>>>>
>>>> On Mon, Jul 23, 2018 at 10:22 PM,  <rishabhb@codeaurora.org> wrote:
>>>>>
>>>>>
>>>>> On 2018-07-23 04:17, Rafael J. Wysocki wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Thu, Jul 19, 2018 at 11:24 PM, Rishabh Bhatnagar
>>>>>> <rishabhb@codeaurora.org> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Drivers that are registered at an initcall level may have to
>>>>>>> wait until late_init before the probe deferral mechanism can
>>>>>>> retry their probe functions. It is possible that their
>>>>>>> dependencies were resolved much earlier, in some cases even
>>>>>>> before the next initcall level. Invoke one probe retry cycle
>>>>>>> at every _sync initcall level, allowing these drivers to be
>>>>>>> probed earlier.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Can you please say something about the actual use case this is
>>>>>> expected to address?
>>>>>
>>>>>
>>>>>
>>>>> We have a display driver that depends 3 other devices to be
>>>>> probed so that it can bring-up the display. Because of
>>
>> dependencies
>>>>>
>>>>> not being met the deferral mechanism defers the probes for a later
>>
>> time,
>>>>>
>>>>> even though the dependencies might be met earlier. With this
>>
>> change
>>>>>
>>>>> display can be brought up much earlier.
>>>>
>>>>
>>>>
>>>> OK
>>>>
>>>> What runlevel brings up the display after the change?
>>>>
>>>> Thanks,
>>>> Rafael
>>>
>>> After the change the display can come up after device_initcall level
>>> itself.
>>> The above mentioned 3 devices are probed at 0.503253, 0.505210 and
>>
>> 0.523264
>>>
>>> secs.
>>> Only the first device is probed successfully. With the current
>>> deferral mechanism the devices get probed again after late_initcall
>>> at 9.19 and 9.35 secs. So display can only come up after 9.35 secs.
>>> With this change the devices are re-probed successfully at 0.60 and
>>> 0.613 secs. Therefore display can come just after 0.613 secs.
>>
>>
>> OK, so why do you touch the initcall levels earlier than device_?
>
> 1)      re-probe probing devices in the active list on every level help to
> avoid circular dependency pending list.
> 2)      There are so many devices which gets deferred in earlier init call
> levels, so we wanted to reprobe them at every successive init call level.

Do you have specific examples of devices for which that helps?

>>
>>> This change helps in overall android bootup as well.
>>
>>
>> How exactly?
>
> We have seen less no of re-probes at late_init and most of the driver's
> dependency met earlier than late_init call level. It helped display and
> couple of other drivers by executing the re probe work at every init level.

So I can believe that walking the deferred list on device_initcall and
maybe on device_initcall_sync may help, but I'm not quite convinced
that it matters for the earlier initcall levels.
