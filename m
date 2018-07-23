Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5169EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E1720852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobile-devices.fr header.i=@mobile-devices.fr header.b="p69MH4vy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naG0a90T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E1720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbeGWRjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:39:54 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43993 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388368AbeGWRjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:39:54 -0400
Received: by mail-qk0-f194.google.com with SMTP id z74-v6so800063qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobile-devices.fr; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=S8QKSN5LK06Nvb3KuzPK9Cj34nJfXTG0UXS1FDRmP/Q=;
        b=p69MH4vyP6iFjwd6exR/5JWynmjJWB7mP8vxPjpFhkSopfUBOvgNgo4OYELyBUWQnU
         2o3BUqPXBLP4JFi++Jeyi3ruNWIsajEdO95hnJ9ME/fy+w/RnyAnsF4TV7rCFTx8KSyC
         pdoO+ZN1yKb/9/3p+5h5u2ZxjHC4Xy2oU1nLU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=S8QKSN5LK06Nvb3KuzPK9Cj34nJfXTG0UXS1FDRmP/Q=;
        b=naG0a90TFZ0WYk5n12nRzV2jLc+avip/Ju3qwbcZgCQKyw6N5XMueTOU2R1m3esuc4
         RHagtxavG/ZyqZw+jVke2z0Dgs2gdZ1XeNRvL4gylfcGzVfEz8wt5bClr2uPobvcC0j0
         8tfBfHhTalPnhmIq94xQQHwK7v7suFxwMlKKZr/YQRpwzxcjnpqOBp6snZApfyJnmEYC
         zMdjBFkSPGgAcB+jrAUDfgDQ2TeI17wO8ewpc1hiviknwjkGnbo6OMjpG3gW2cmBtsF0
         o2YAr4hqySPGPaaxY9gpEzWW9ZeM+KrxjNen/OtbmV23luNois/obBCpH4CBYoK3H05/
         Nb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=S8QKSN5LK06Nvb3KuzPK9Cj34nJfXTG0UXS1FDRmP/Q=;
        b=tlcSJuAhPxJ74hK/JmX0RtAr10oE+zQOO+RJOV6gmWyx48xToKCzvbFdxZrk41X6G8
         DDBzD1QmUDjyZ2QzHXYUVFH3ElozG9vH1KEdJoV+DT/I7KnP146i3/VRnCOD16RNXQcv
         dCSARCsW6lLXkVu9iHttLMVLOxmOCQmRZ9d29iNNYA4oiWvCqupiC2QNgkQcXp0T1e43
         YSNIr6juMNDb2vxu17AzWPbht+iP1JYe6FCaQg845BjFc3WXwN8ez5eHu8dPeaGomHfr
         LuVk2lQkgja1sFYcnapc+cAwzaEOm+LMb2HUsz1j0SXSsFVSo65fzKtlxgJdqXRfesSo
         VZ7w==
X-Gm-Message-State: AOUpUlFOlFunx1oEBeY7eAkb3i04o6VfyH9hq/ero+jJU8Nk45UYehlL
        N4LUUfAFzqttr71aiExHkOK9Q5hOsFiWjp8pqgfahQ==
X-Google-Smtp-Source: AAOMgpfVA4nTUAgd3x/wV3k/2o3Gqcae+mvluYZovIeXqhut2A10Ke3ry77ldHjizqBYjZ/OBaVXZUP/SHvoZQvjsyI=
X-Received: by 2002:a37:b5c7:: with SMTP id e190-v6mr11858427qkf.384.1532363871979;
 Mon, 23 Jul 2018 09:37:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2edb:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 09:37:31
 -0700 (PDT)
In-Reply-To: <73f2233a-cafd-a477-0c0a-260be832777d@gmail.com>
References: <20180723140220.7166-1-romain.izard.pro@gmail.com> <73f2233a-cafd-a477-0c0a-260be832777d@gmail.com>
From:   Romain Izard <romain.izard.pro@gmail.com>
Date:   Mon, 23 Jul 2018 18:37:31 +0200
X-Google-Sender-Auth: rygLMrJCTMsRJ__BuqN2BPLlKsI
Message-ID: <CAGkQfmOfGZSr3fsHcveX2gjkaevnWnP7bGrY+pn+di-KaOducg@mail.gmail.com>
Subject: Re: [PATCH] option: Do not try to bind to ADB interfaces
To:     Lars Melin <larsm17@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-23 17:15 GMT+02:00 Lars Melin <larsm17@gmail.com>:
> On 7/23/2018 21:02, Romain Izard wrote:
>>
>> Some modems now use the Android Debug Bridge to provide a debugging
>> interface, and some phones can also export serial ports managed by the
>> "option" driver.
>>
>> The ADB daemon running in userspace tries to use USB interfaces with
>> bDeviceClass=0xFF, bDeviceSubClass=0x42, bDeviceProtocol=1
>>
>> Prevent the option driver from binding to those interfaces, as they
>> will not be serial ports.
>
>
> You are assuming that an interface with these attributes are always a
> ADB interface - that is wrong. Vendor specific class (0xff) is not
> standardized to be something specific.

Yes. And the option driver binds to all the vendor-specific interfaces for many
devices, assuming all the vendor-specific interfaces are serial ports, unless
they are blacklisted.

>
>> This can fix issues like:
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=781256
>>
>
> You are trying to solve a 4++ years old bug report where it was assumed that
> the option driver was the culprit. The device in question, a Qualcomm modem
> with vid/pid 05c6:9025 has never been included in option.

While I'm not going to investigate why the 3.16 kernel did it, in the bug
report the logs indicated that 05c6:9025 was bound to the option driver. But I
did not try to solve this issue directly, I reported it as it led me to the
solution for a similar problem that I encountered last week.

A vendor for an SDK based on a modem was using an old Ubuntu 16.04, and
everything was working correctly. But on my 18.04, and on an up-to-date 16.04
LTS, it was impossible to use ADB with the vendor's SDK.

As ADB has many other failure modes, it took a lot of time to see the source of
the problem. The option driver in the old Ubuntu did not know about the modem's
vid/pid, so the driver was not bound by default and the ADB interface was free.
But the modem was added in the stable branch of the kernel, so the driver was
greedily binding to all interfaces that were not blacklisted. As a result, it
was not possible to use ADB as long as the interface was bound to the option
driver.

One of the reasons for the problem, of course, was the reuse by the modem
manufacturer of the same vid/pid for the standard version of the modem and for
the SDK version.

I see my change as a useful heuristic. ADB is a quite common protocol, using
one of the 65536 vendor subclass/protocol combinations. As you can see in
https://github.com/apkudo/adbusbini more than 3000 vendors have been spotted
using it in the wild, including more than half of those mentioned in the option
driver.

And on the other hand, I don't expect any existing modem to use 0xff,0x42,0x01
for its serial port interface, and a USB facedancer would not gain anything by
doing so.

Best regards,
-- 
Romain Izard
