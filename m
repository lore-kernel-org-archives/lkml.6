Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A1DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46D921A33
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="edcw6xr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46D921A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeHHTWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:22:36 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:48123 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbeHHTWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:22:35 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0344710C0443;
        Wed,  8 Aug 2018 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533747721; bh=B/EC3a255cb429Na0WNv1klMpKKEpZCEG6tpHdOzJ+w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=edcw6xr5PTuliaZiQHvOuMKEBKnmkeXt1+3+/rso4NyaW0A1T8Wg16HMDp5wU8KM4
         3Rxjj5oJE7cBKbw+et+uS9Yo2opY57NtRx8t58cu5LOpCmHnhkfFUWuEtdJsFA4JEV
         LPZwQGd/id4eMGHGScwM5IrGertu8DdV+GvuOVNyxye+gXXBgSWmyi1UBSnMzajwxt
         pFY0BlyA79Tr6HaM/xyf7vHx54u0IYJeW2rbmnwAZ5yg0lJF+gKxOq97XIPmt8ai+D
         qAvpaonau5bbhFGlZKaxacMOFXdQMJHc1yYWs8DYkZG3y9tszD5DO/8AwTkC8ZK3Qs
         uuUyVjx0DWEyw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id A875F5529;
        Wed,  8 Aug 2018 10:02:00 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 8 Aug 2018 10:02:00 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 8 Aug 2018 19:01:58 +0200
Received: from [10.0.2.15] (10.107.25.93) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 8 Aug
 2018 19:01:58 +0200
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        ijc+devicetree <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
 <1532120272-17157-2-git-send-email-soares@synopsys.com>
 <CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com>
 <9fdfaf4e-5a20-af81-82ef-0d9e327f9133@synopsys.com>
 <CAHp75Vd6Ok6i3wQjT=jd3mtFAC2na1vwUs2cr-xhStQ_OjKjAg@mail.gmail.com>
From:   vitor <Vitor.Soares@synopsys.com>
Message-ID: <ce858157-8353-2c8f-53f2-dbf2339355e9@synopsys.com>
Date:   Wed, 8 Aug 2018 18:01:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd6Ok6i3wQjT=jd3mtFAC2na1vwUs2cr-xhStQ_OjKjAg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.25.93]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,


On 25-07-2018 17:56, Andy Shevchenko wrote:
> On Wed, Jul 25, 2018 at 11:43 AM, Vitor Soares
> <Vitor.Soares@synopsys.com> wrote:
>> On Fri, Jul 20, 2018 at 11:57 PM, Vitor soares
>> <Vitor.Soares@synopsys.com> wrote:
>>
> Thanks for answers, my comments below.
>
>> This patch add driver for Synopsys DesignWare IP on top of
>> I3C subsystem patchset proposal V6
> ...
>
>> +#include <linux/reset.h>
>> Reset API.
>>
>> All of them required? Why?
> Thanks, got it.
>
>> There is some header files that are already included by others header files.
>> Should I add them too? it there any rule for that?
> No need.
> Usually we drop some "wired" headers (when we sure that one will
> always include the other one, like module.h vs. init.h)
>
>> +               writel(cmd->cmd_hi, master->regs + COMMAND_QUEUE_PORT);
>> +               writel(cmd->cmd_lo, master->regs + COMMAND_QUEUE_PORT);
>>
>> hmm... writesl()?
>> Is there any advantage here?
> Here maybe not. Just a material to think about. If you can refactor
> code to utilize them, good.
>
>> +       info->pid = (u64)readl(master->regs + SLV_PID_VALUE);
>>
>> Why explicit casting?
>> info->pid is u64 size.
> In C standard there is an integer promotion which allows you not to
> use explicit casting in such cases.
>
>> +       u32 r;
>> +
>> +
>> +       core_rate = clk_get_rate(master->core_clk);
>>
>> Too many blank lines in between.
>>
>>
>> For me in that way it's better to filter code parts. Do you think that is
>> not readable?
> The point is it's useless.
> On the other hand, you have a lot of inconsistency with that style.
>
>> +               p = (ret >> 6) ^ (ret >> 5) ^ (ret >> 4) ^ (ret >> 3) ^
>> +                   (ret >> 2) ^ (ret >> 1) ^ ret ^ 1;
>> +               p = p & 1;
>>
>> Is it parity calculus? Do we have something implemented in kernel already?
>>
>> Btw,
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__graphics.stanford.edu_-7Eseander_bithacks.html-23ParityNaive&d=DwIBaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=qVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=5FpGHBbT8tYA6PB4RT_9O6PJk3v-wYcy1MV59xoqK4I&s=FSJ3EcuoxPtRJWmsk9Yt4s_UH9kxFBam01Xvas2ZFdo&e=
>> offered this
>>
>> v ^= v >> 4;
>> v &= 0xf;
>> v = (0x6996 >> v) & 1;
>>
>>
>> I search into the kernel and I didn't find any function for that. In your
>> opinion what shoud I use?
> If license of the piece above is okay to use in kernel, then
> definitely it would be better (even we might create a helper out of
> it).
>
Thanks for your comments I will take them into account for the next version.

Best regards,
Vitor Soares
