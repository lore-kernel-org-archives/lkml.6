Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBC2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F4820850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdZ8+fch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F4820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbeGRPE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:04:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35890 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbeGRPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:04:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id u7-v6so4278008lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uAPBffkEP6hzJQhAgZpqROpzhoxqEnmHBZuEr7Cl3wY=;
        b=WdZ8+fchC6Z113PVUHm8Z9naJ1nCiwKfseZFDQUAi3Run0qD/RTJApljpR/kg5abfA
         uHBy4CwzP9VHHqmkbWRk9yd9mUJkxRQR2zKnjs06c5dKpXlia51XuZ+0OeBcoFl1C04z
         ekfiymTKpCdzJISClUqCc3Kpsuzn6knmcL+0nzphQYB7ByuhCJsFgHMQpCRdSe25/FW3
         hV7d3fzf7/IsEyZxVH0RA1UPUBcYIbmfgZWxcqqWoOn7BEcnIcMclFB5OxYGxT9z8hXL
         ES6T3ujMpcBvL3JmOqJ0PTiEmgKi0VLFP6AdXftm7seimoo88PMXO5G/ae8M3f+60XFO
         vdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uAPBffkEP6hzJQhAgZpqROpzhoxqEnmHBZuEr7Cl3wY=;
        b=UAtO8jbA2+cpKj3GHa49tNhXADcVQ+23aN+aecnD8gSmnxrSBMrTzpKtFOUO6YHaY0
         Dgp02gBAOKitTM8DLXY/1RL72BwKnA1OBAY+2LmbOorPoWNu0+cypzPI4Wrf6XTA2+sL
         9LJ8zHx8TKjG6L5pBJqO4Qev/J/IbIf1umjw82XT60CkESZbo00smISw49vLF/PbGIQ+
         kP5NBpcPA0dvH91jP/spM3418NiLZEePPDUS+K3+omwXvS29HFg2JWSJmasVg1ik4sWL
         pgVFBXMBeLTapwEJo0BJBffsc6Nc56a1+vUjDf6GwMB4j0VyA6MDMGApDyiCd+ghexZB
         8QCg==
X-Gm-Message-State: AOUpUlEm3XmHIcBNlNDx4NQZWai4bLkKlqNVNKUJsiYAWFhaq8NKVUFb
        fmFToF3uo5K0CpzjOVOumPUtpitxtxzLYHzuV2o=
X-Google-Smtp-Source: AAOMgpdkukUAXWv07c10bMFmRwDD1yD3JESRzyN5ZxZ+NlJRCBL6VXrKiy//UnNUi4fyqsF+dui8Pi7gxcTobWrTA24=
X-Received: by 2002:a2e:9f4d:: with SMTP id v13-v6mr4717212ljk.42.1531923977174;
 Wed, 18 Jul 2018 07:26:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 07:26:16
 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.21.1807182333150.41@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de> <20180619140229.3615110-2-arnd@arndb.de>
 <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com>
 <alpine.LNX.2.21.1807182201560.41@nippy.intranet> <CAK8P3a0OBVu-o6kFCS=gV83EcH9ba9QYGZBBhB9D8cJrf=8akA@mail.gmail.com>
 <alpine.LNX.2.21.1807182333150.41@nippy.intranet>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Jul 2018 16:26:16 +0200
X-Google-Sender-Auth: lPXZCupQPtFyc6aeOJ_BBq5zMR0
Message-ID: <CAK8P3a3azDB5WsQWTKOSmXNqycTxz0qXtowS61_=zUsnMo+EXg@mail.gmail.com>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joshua Thompson <funaho@jurai.org>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Meelis Roos <mroos@linux.ee>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 3:49 PM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Wed, 18 Jul 2018, Arnd Bergmann wrote:

>>
>> -static long via_read_time(void)
>> +static time64_t via_read_time(void)
>>  {
>>         union {
>>                 __u8 cdata[4];
>> -               long idata;
>> +               __u32 idata;
>>         } result, last_result;
>> +       time64_t ret;
>
> ret isn't used.
>
>>         int count = 1;
>>
>>         via_pram_command(0x81, &last_result.cdata[3]);
>> @@ -279,12 +280,8 @@ static long via_read_time(void)
>>                 via_pram_command(0x89, &result.cdata[1]);
>>                 via_pram_command(0x8D, &result.cdata[0]);
>>
>> -               if (result.idata == last_result.idata) {
>> -                       if (result.idata < RTC_OFFSET)
>> -                               result.idata += 0x100000000ull;
>> -
>> -                       return result.idata - RTC_OFFSET;
>> -               }
>> +               if (result.idata == last_result.idata)
>> +                       return (time64_t(result.idata) - RTC_OFFSET);
>>
>
> Did you mean to write,
>
>                         return (time64_t)result.idata - RTC_OFFSET;
>
> ?

Right, I should have at least tried to build it again.

      Arnd
