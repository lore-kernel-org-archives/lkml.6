Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965691AbeCAIgR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:36:17 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:43141 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964996AbeCAIgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:36:15 -0500
X-Google-Smtp-Source: AG47ELtvlmcwO6uZjcOnCrqrGuqArZkrrOV969H0QVPpLLXkDCoihCM80RmpD26B5PH7XuahW/Nq3eapKPy4Tdmz7Pk=
MIME-Version: 1.0
In-Reply-To: <93696fc8-bb93-aa20-3506-3d7216c17cd2@lechnology.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
 <1519071723-31790-11-git-send-email-david@lechnology.com> <CAMpxmJVxfGtO=kh63KF-5Uqew3yy97DsK4FSd14CyyRQTOhrTA@mail.gmail.com>
 <93696fc8-bb93-aa20-3506-3d7216c17cd2@lechnology.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 1 Mar 2018 09:36:14 +0100
Message-ID: <CAMpxmJVpMgikNfB4HgNCs+ep+EOHqH5bthiW82LsnDqzLfE5mg@mail.gmail.com>
Subject: Re: [PATCH v7 10/42] clk: davinci: New driver for davinci PSC clocks
To: David Lechner <david@lechnology.com>
Cc: linux-clk@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Adam Ford <aford173@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-28 22:40 GMT+01:00 David Lechner <david@lechnology.com>:
> On 02/28/2018 06:38 AM, Bartosz Golaszewski wrote:
>>
>>
>> I think I found the reason for the strange crashes we were
>> experiencing (emac core->name being NULL) thanks to Sekhar who pointed
>> me in the right direction.
>>
>> The mdio driver fails to probe with v7 due to the supplied clock rate
>> being wrong. Before failing we register the emac clock with
>> pm_clk_add_clk(). When clock_ops puts the clock, it decreases the
>> reference count of the clock, but we never actually increased it in
>> the first place in the line above. The core clock code then destroys
>> the associated clk_core structure. When the next user comes around (in
>> our case the clk debug functions) the system crashes.
>>
>> I believe there to be two issues: one is with v7 - we need to increase
>> the clock reference count in davinci_psc_genpd_attach_dev().
>>
>> Second is the error path in the clock framework - we should remove the
>> destroyed clk_core from the debug list, which is not being done now.
>>
>> Why we even need to track the refcount of clk_core is a mistery for me
>> though. Stephen, Mike?
>>
>> Best regards,
>> Bartosz Golaszewski
>
>
> Great find. I figured it had to be something like this, but I wasn't
> able to reproduce the problem yet.
>
> I suppose it is time to spin up a v8 with some fixes.

I still don't know why the mdio clock rate is much lower than in
mainline though. Any ideas?

Thanks,
Bart
