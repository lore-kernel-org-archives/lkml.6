Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B5EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C152086A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wqpa1hOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C152086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeKOMyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:54:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37564 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeKOMyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:54:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id 40so16776689oth.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 18:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gqZFRUt4g07cI8dv2cNp0ihFGPT49C7QA8w4vntyb3I=;
        b=Wqpa1hOJm34Mi7zJOZBdVs+AApqojNi8fG/RF6cf12Nx/wK+Y5thTDkT+Bv2Ak9bap
         opD1dvLpSMOGVaM1FOe81sFaG/Yux58s5X7un7YbBjxjDumOl6tK3Q2LbL2EMrmVI6v+
         dotyGaRZrKXiNXRzRAymtBmMc1g8YVT1bcOP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gqZFRUt4g07cI8dv2cNp0ihFGPT49C7QA8w4vntyb3I=;
        b=ZeY/VPLcFsOYrqCkgS/2Y4rXLXOmqW8mvORISwEMxgg2Sh6dTzJjMC1z69Sg328Y01
         L/Atlus/i9fA6DkeQ0wVui8TCkHPpjNrIM0CRlVmwn9Kd7usmVwhSpgyPVzNEqfTBnKd
         aD0LDxTiA1WKx/igtMOEViir1jYUshS5p6/ikndkNpTKYTX0Xr3C5jRXGU+rL/mJ38GS
         sAKsf2o4WtW203ej7TVlZBoZxZYX9EV2zovHo3sqLCyr6ATmdVwhMVJaKxNS+wTux/6O
         TSGPF8PywZZYenGfRPQ+Vvu9Yw9zFSK4eiwUPHjulfJb4b+i9rg7Adudp81FXV5tRXv8
         qwLQ==
X-Gm-Message-State: AGRZ1gKUMOZYzIrZbGUcZj2VUEuuXYHF/opqZt1naW8gXtf7o2Md5+mo
        E+8kB1e1aQQqwm2iKR2wUblI7+mRUxw=
X-Google-Smtp-Source: AJdET5fmlcqYF4VRBHrNvH3HEWP6GyMAQ7Y1pVvqbMnLJ/zLTo3+Zrm8RQ9wi2JhuvdunKNycb+kcg==
X-Received: by 2002:a9d:72a:: with SMTP id 39mr2848361ote.134.1542250128285;
        Wed, 14 Nov 2018 18:48:48 -0800 (PST)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id d124-v6sm9580570oia.29.2018.11.14.18.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 18:48:47 -0800 (PST)
Subject: Re: [RFC PATCH 07/12] soc: qcom: ipa: IPA register abstraction
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-8-elder@linaro.org>
 <CAK8P3a2FsgR=SYAWsgFURVni1ReiCugKs1iUAfQzZhPkbW8aOA@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <e9114caf-0c92-7cac-33cd-6bea548b0375@linaro.org>
Date:   Wed, 14 Nov 2018 20:48:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2FsgR=SYAWsgFURVni1ReiCugKs1iUAfQzZhPkbW8aOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 9:00 AM, Arnd Bergmann wrote:
> On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>> diff --git a/drivers/net/ipa/ipa_reg.c b/drivers/net/ipa/ipa_reg.c
>> new file mode 100644
>> index 000000000000..5e0aa6163235
>> --- /dev/null
>> +++ b/drivers/net/ipa/ipa_reg.c
>> @@ -0,0 +1,972 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
>> + * Copyright (C) 2018 Linaro Ltd.
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/io.h>
>> +#include <linux/bitfield.h>
>> +
>> +#include "ipa_reg.h"
>> +
>> +/* I/O remapped base address of IPA register space */
>> +static void __iomem *ipa_reg_virt;
> 
> This should of course be part of the device structure.

Yes, this should have been be in that structure to begin with.

I'm working through doing a comprehensive replacement of
global variables like this with values passed around as
arguments.  I've intended to do it all along but your nudge
pushed it to the top of my list.  It's a *lot* of work, much
more than I realized.  But I'm making rapid progress.

>> +/* struct ipa_reg_desc - descriptor for an abstracted hardware register
>> + *
>> + * @construct - fn to construct the register value from its field structure
>> + * @parse - function to parse register field values into its field structure
>> + * @offset - register offset relative to base address
>> + * @n_ofst - size multiplier for "N-parameterized" registers
>> + */
>> +struct ipa_reg_desc {
>> +       u32 (*construct)(enum ipa_reg reg, const void *fields);
>> +       void (*parse)(enum ipa_reg reg, void *fields, u32 val);
>> +       u32 offset;
>> +       u16 n_ofst;
>> +};
> 
> Indirect function pointers can be a bit expensive in the post-spectre
> days. It's probably not overly important if these are always part of
> an MMIO access function, but you should be careful about using
> these in the data path.

OK.

There used to be a more elaborate scheme for supporting
lots of versions, and I have tried to preserve at least part
of the underlying mechanism (the parse and construct functions).
Not all of these registers use the indirect functions, and
it looks to me like none of them are in the data path.

The most important registers for the fast path are found in
the GSI code.  And that doesn't use this construct--it only
reads and writes 32-bit registers.  (I think it differs
because it was originally developed by a different team.)

> How many different versions do we have to support in practice
I don't know for sure how many versions really were used,
but the original code had about 10 distinct version values,
many of which shared most (but not all) register definitions
(offset and bit field widths) with older versions.

With the upstream code the decision was made to ignore anything
older than IPA version 3 (and 3.5.1 in particular, which is
found in the SDM845 SoC).  

It may be that this parse/construct mechanism isn't justified
at this point.  I thought the way it presented a generic
interface was useful, but with just one (initial) hardware
target we don't (yet) realize its potential benefit.  It could
be added back later, as support for new versions is added.

As of now I don't plan to change this, but if you or someone
else feels it would be better without it I can do that.

					-Alex


>        Arnd
> 

