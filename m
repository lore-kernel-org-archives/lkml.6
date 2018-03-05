Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbeCEFnx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 00:43:53 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:37922 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932711AbeCEFnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 00:43:50 -0500
X-Google-Smtp-Source: AG47ELs8nj7J8xaW/ipYvGzEOb7thZWUR+84hKK1xjIx3baBtWISC0zSR3nyzoB4tt8xDFBf70A6NE7Za0NC4pdKfJE=
MIME-Version: 1.0
In-Reply-To: <684152b5-4992-68b5-5abf-78ea2d6b34bc@roeck-us.net>
References: <20180302063746.10993-1-joel@jms.id.au> <20180302063746.10993-3-joel@jms.id.au>
 <684152b5-4992-68b5-5abf-78ea2d6b34bc@roeck-us.net>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 5 Mar 2018 16:13:28 +1030
X-Google-Sender-Auth: A5RWaYSdcXw13z8r_8jwPl4ePO0
Message-ID: <CACPK8XfBphFYxJKbHBWLjZFOOVt6m-c7fDZvFwqbBNx+0dm+DQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: Add Nuvoton NPCM watchdog driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 3, 2018 at 12:29 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> +static int npcm_wdt_start(struct watchdog_device *wdd)
>> +{
>> +       struct npcm_wdt *wdt = to_npcm_wdt(wdd);
>> +       u32 val;
>> +
>> +       val = NPCM_WTRE | NPCM_WTE | NPCM_WTR | NPCM_WTIE;
>> +
>> +       if (wdd->timeout < 2)
>> +               val |= 0x800;
>> +       else if (wdd->timeout < 3)
>> +               val |= 0x420;
>> +       else if (wdd->timeout < 6)
>> +               val |= 0x810;
>> +       else if (wdd->timeout < 11)
>> +               val |= 0x430;
>> +       else if (wdd->timeout < 22)
>> +               val |= 0x820;
>> +       else if (wdd->timeout < 44)
>> +               val |= 0xC00;
>> +       else if (wdd->timeout < 87)
>> +               val |= 0x830;
>> +       else if (wdd->timeout < 173)
>> +               val |= 0xC10;
>> +       else if (wdd->timeout < 688)
>> +               val |= 0xC20;
>> +       else if (wdd->timeout < 2751)
>> +               val |= 0xC30;
>> +       else
>> +               val |= 0x830;
>
>
> I am lost here. If the requested timeout is 2751, the actual timeout
> is set to 85.6 seconds. Why ?
>

I suspect this was the default, so the original code decided to fall
back to this value.

I think it would make more sense to use 2750.

Cheers,

Joel
