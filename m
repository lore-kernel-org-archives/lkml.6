Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5699C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889FF23C49
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcYsaCed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889FF23C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753504AbeGCWb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:31:29 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42450 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbeGCWb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:31:28 -0400
Received: by mail-vk0-f66.google.com with SMTP id t4-v6so1933209vke.9;
        Tue, 03 Jul 2018 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DMDkvuFsIfk5J8nNcur2i8btVlg6u+c03iCWTquYw24=;
        b=DcYsaCedRyt0YTkBkmU7m1K5sb/ZzYSaL6yrqlgJ15UIEXdqH5Cyqy8zJMjUa63qQp
         aIkMIzsbfHuADB9eBA2IFVsojxADs+uTObQRdJV75M0OOfIGIcmWmYwojXlhrisFSGh9
         74mEm8JpzS4mvHgUdWrehtpfcfuYQp4Rdb2O++Xs3I4wCxPjnCY8cusCoLmpVWALrP0d
         4Pgh8zzkVRXVWlzN07nv71uJW8cl9Eqwrlw2U5BG0GE0yO6WwP7y2dHXzkt8DJ0bJ354
         L/BsGYvVEPzgn2jr6EmapXoY+pQtBBOZrQH37TAVPXPDPqcCDyJ5zy5HP31HDjAG4tCo
         8ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DMDkvuFsIfk5J8nNcur2i8btVlg6u+c03iCWTquYw24=;
        b=ji/8mr6qINuVnRhFA+5Pp2XBTRk113v0burmPlf3IcvPG5IRx6X8DInAVKtOVeyua0
         o7GswZjKdu57tSkzfS+A0knq3VFFMKghmVT8ZQ4tw6j91bqPbAdJR8HGJlr3muArTS5K
         72S4NWGXnlOtG4R7O+W5bpJDfu9q/xBIQMFfOmTxQwwaStc0/MJHRd6nmprreXtTKFMD
         eGPgZf1l6Bm6K1VF3kTJP1KTGR4mQ8G+ALCz0p5Pbcs4DhNtGrazV1eiZyrLCtR4LA8B
         R/I9F8b1vLpq07FVPhHh4eea8IAGID824gAPqJNxmpKXuECtIvl2DC5/WeRp78RB860c
         rDMg==
X-Gm-Message-State: APt69E26+xq63dYcXeuhbcXK+2fOy2eyeVJP1O0v/nboU8jqU1C0/4+l
        CAPmkzsbGfrWbkQdKcv/0qsfUJt/AbhoXD6Se+I=
X-Google-Smtp-Source: AAOMgpdLcuyXYVDOuj6FSEWHNsE0F4MV+59tKIlZoWpcfr5lTy4Dy6bocnZyW/m+/w7w3soqfT9Gjy+L/YxgPgggfEc=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr19713678vkd.161.1530657087408;
 Tue, 03 Jul 2018 15:31:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 15:31:26 -0700 (PDT)
In-Reply-To: <CAHp75Vdn-Fn_bwgBjvnLa_s2LORgdEjLH0jpRvVDjwyxKOLEBw@mail.gmail.com>
References: <93a290d7082ed2e4d3e2b91dc7f6e941c9242a41.1530600804.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vdn-Fn_bwgBjvnLa_s2LORgdEjLH0jpRvVDjwyxKOLEBw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 01:31:26 +0300
Message-ID: <CAHp75VeKbXA1wtJr_u0y+Ndjouf2GH51UHsLcsC6s32kWtA3zw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bus.c: Let acpi_device_get_match_data() return DT
 compatibility data
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 12:31 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>> When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
>> of_device_id table "compatible" strings in DSD, a pointer to the
>> corresponding DT table entry should be returned instead of a null
>> pointer. An acpi_device_id match still takes precedence.
>
> I'm not sure what you are trying to achieve here.
> This works solely for ACPI case.

Okay, now, after a bit of browsing sources, I got your problem.
Indeed, we have acpi_of_match_device() which returns matched OF item,
but no caller is interested in it...


-- 
With Best Regards,
Andy Shevchenko
