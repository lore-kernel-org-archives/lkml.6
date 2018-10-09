Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D88C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8BA214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJiz2CQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8BA214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeJJFZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:25:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40472 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJFZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:25:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so1539543pfj.7;
        Tue, 09 Oct 2018 15:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Jbs2gZchJ/KmK602bqsC4jaHuMlIs0fZ9Knt/FA/3sA=;
        b=BJiz2CQXGlFOz7+OJXyRZ65+Y/BUjqaTcqqqGHA1wIsqat2CTl8PvFB27206KIFAaY
         3Q/OplGlYt04B43CTQIk9Y9KIOP02oJm8Dx48Yr9bFD5A9sjOWU+8F1KsPVZXeBff2ks
         Cz25K1tjTILLW+yvoR9ydYR4X/ZtopUB7ZQPs6HwKKCpm4jGQ/d/1E8fsEqeVkfIIMjG
         z77n11lomvJ/peLE9MjGXzi2PjgnxvrdROuGE26VHM6dpThrMYYgIHsjyqqs9YY9zgUu
         58Y45x/QazFEtZ3pVuPF7gpBYpZIrbu6K2gmfPdboeDoXF6UR7hiN46b/pnHK58yy1AY
         0awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Jbs2gZchJ/KmK602bqsC4jaHuMlIs0fZ9Knt/FA/3sA=;
        b=hCXbrsaIlvAe0ZW+ZtN4Cm1yqiqa0dq+wD7uYoMoxGcsXq9JYQW2wIZPH2G2ITBVI4
         CJvcPWzvuTEEl/J/HeWk4yX5DczEcAfIV+QwCUpn2kd4sRp9W9PsWali4xR7sQvzdRlU
         mys/2PnJh2866p4eCmW/QvYyPwvBNWczTQOXnWq/Urh0b0ZCrbtSSOK4BiJSHnxjvIMq
         m+rvivm76yBMeobbMgSUy5jaZLhnU17lk9wGjpubnICmw2Xe/Iw9EznsbYu8HsQfwcBZ
         iORMtpU28LWOnSaRttW2evMiG+A34LcWDLPASHV8HkCgKMvRMMGfNWeMTcHsyfYF+sE+
         pSug==
X-Gm-Message-State: ABuFfoh1AEPv1gSRuqKAGoqQaTWkDmebewqQTVcg/ind54KjmYC++YmM
        4t3L1NoP7YB+5rMo/xYV5HQ=
X-Google-Smtp-Source: ACcGV61Ak9g5eOOkt8IGRa58FlfxufjkZyzSik3Y544KjlNdQlDBf0JqXX5UcbfSd26QgudrUDnaag==
X-Received: by 2002:a62:c08b:: with SMTP id g11-v6mr32020325pfk.72.1539122761762;
        Tue, 09 Oct 2018 15:06:01 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:5423:3ce7:4c4e:7bce? ([2001:df0:0:200c:5423:3ce7:4c4e:7bce])
        by smtp.gmail.com with ESMTPSA id n80-v6sm33862287pfh.166.2018.10.09.15.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 15:06:01 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock
 behaviour
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     sashal@kernel.org, "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        alexander.levin@microsoft.com
References: <20181008152523.70705-1-sashal@kernel.org>
 <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
 <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <1cbc87c6-7920-1f53-879b-79de87d685fc@gmail.com>
Date:   Wed, 10 Oct 2018 11:05:56 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

I agree the bug is neither subtle nor recent, not security relevant and 
will affect only a handful of users at best.

If you're worried about weakening the rules around stable releases, by 
all means go ahead and veto the inclusion of these patches in the next 
stable release.

Cheers,

     Michael


On 09/10/18 08:20, Dmitry Torokhov wrote:
> Hi Michael,
>
> On Mon, Oct 8, 2018 at 12:09 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Dmitry,
>>
>> someone on debian-68k reported the bug, which (to me) indicates that the
>> code is not just used by me.
>>
>> Whether or not a functioning Capslock is essential to have? You be the
>> judge of that. If you are OK with applying the keymap patch, why not
>> this one?
> I have exactly the same concerns about the keymap patch. This all has
> not been working correctly for many many years (and it was not broken
> in a subtly way as far as I understand, but rather quite obvious).
> Thus I do not understand why this belongs to stable release. It is not
> a [recent] regression, nor secutiry bug, nor even enabling of new
> hardware, that is why I myself did not mark it as stable.
>
> I still maintain that we pick up for stable too many patches for no
> clear benefit. This is similar to the patch for Atmel controllers that
> was picked to stable and I asked why, as it is not clear how many
> users might be affected (or if the problem the patch was solving was
> purely theoretical, or only affecting hardware that is not in
> circulation yet).
>
>> Debian will carry stable patches without explicit action on behalf of
>> the maintainer. Unstable patches are a little harder to get accepted.
>>
>> Cheers,
>>
>>       Michael
>>
>>
>>
>> On 09/10/18 06:11, Dmitry Torokhov wrote:
>>> On Mon, Oct 8, 2018 at 8:25 AM Sasha Levin <sashal@kernel.org> wrote:
>>>> From: Michael Schmitz <schmitzmic@gmail.com>
>>>>
>>>> [ Upstream commit 52d2c7bf7c90217fbe875d2d76f310979c48eb83 ]
>>>>
>>>> The CapsLock key on Atari keyboards is not a toggle, it does send the
>>>> normal make and break scancodes.
>>>>
>>>> Drop the CapsLock toggle handling code, which did cause the CapsLock
>>>> key to merely act as a Shift key.
>>> This has been broken for 10+ years. Does it really make sense to
>>> promote it to stable?
>>>
>>>> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
>>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>>> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
>>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>>>> ---
>>>>    drivers/input/keyboard/atakbd.c | 10 ++--------
>>>>    1 file changed, 2 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
>>>> index 524a72bee55a..fdeda0b0fbd6 100644
>>>> --- a/drivers/input/keyboard/atakbd.c
>>>> +++ b/drivers/input/keyboard/atakbd.c
>>>> @@ -189,14 +189,8 @@ static void atakbd_interrupt(unsigned char scancode, char down)
>>>>
>>>>                   scancode = atakbd_keycode[scancode];
>>>>
>>>> -               if (scancode == KEY_CAPSLOCK) { /* CapsLock is a toggle switch key on Amiga */
>>>> -                       input_report_key(atakbd_dev, scancode, 1);
>>>> -                       input_report_key(atakbd_dev, scancode, 0);
>>>> -                       input_sync(atakbd_dev);
>>>> -               } else {
>>>> -                       input_report_key(atakbd_dev, scancode, down);
>>>> -                       input_sync(atakbd_dev);
>>>> -               }
>>>> +               input_report_key(atakbd_dev, scancode, down);
>>>> +               input_sync(atakbd_dev);
>>>>           } else                          /* scancodes >= 0xf3 are mouse data, most likely */
>>>>                   printk(KERN_INFO "atakbd: unhandled scancode %x\n", scancode);
>>>>
>>>> --
>>>> 2.17.1
>>>>
> Thanks.
>

