Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C03C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9007D26EAB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPhjuQ30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9007D26EAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933589AbeFZR1r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:27:47 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44188 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932518AbeFZR1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:27:44 -0400
Received: by mail-ua0-f196.google.com with SMTP id v15-v6so4559403ual.11;
        Tue, 26 Jun 2018 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cr7qspbGaRJuybJEdCiRgV6I5YJZwIMaF6bbbF94FSc=;
        b=CPhjuQ30b/72PPBIzhVb5eFpXY17SYOKZRVQyAxu4B2DnnSUbv/hlnrjfZyDigfwOR
         OzzAPws1IvKCvlZV5a0MHxidBd4cbYMgza6ObuKaJRsgIHmlI859OR0Ir2nlCUJlzVIL
         F0IKP1dMN8/UAJ/JuDboNwH89RhGZhDbQqVMuOuzWWRMVkbGw/VkRCPnz564bynGC13W
         7EJxnExKADYjkJAfcrORcAEd7/DmRLb/UvDeoMaX9seLg0EEoNm0Q+J0IGRgTMnESt4J
         81T/4awrQ+2O/CTVgADzAYqW5NMHAQWvkf9HI4BcCaz+zjYJ3WrvVKvOOk9Rq2VwAGVm
         eVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cr7qspbGaRJuybJEdCiRgV6I5YJZwIMaF6bbbF94FSc=;
        b=cgf9T4QN6MzNCm3ggy7nN1ZHi4GxTlbaAvZC7zPNsVMa7/ZDMXXwSq6gVWOLDyAcEK
         nUbxFA+SDw3WDWAtULk1exn7iqVtepRnT5xVhs9n8vfGUUCokg0SFI4UOiGiNl4zeIwW
         4dQU8IySmGJJYOBHBI0jfOtqk/vda62blkAp+FPeUcASnNECNcv+kww0d+9poJsNcfaB
         hhingQl+byNzHVZNTl0AJAon3MaXFkCCsI1GFC4NtpIBCM8WxLdlzicmtunIB4OASq85
         uJtgUcemmwm3Oqqyw9UEzghy3fphH1cTjdnwITFwdMp+OgNmBDOHJ5tnqH9gNl233Wzr
         Y6FQ==
X-Gm-Message-State: APt69E3OIj5QfrJOeispd4ci56Yr4X/6tMulmPdl78klSsIoZbnIVdpQ
        JDV4vK5svioIOp9x8WcoYosblqE+36Ujq/uEvcw=
X-Google-Smtp-Source: AAOMgpdwuaCldAttfNMHUJzWRnuLO5pmA7fTI/1uBXblhwaxoY8ejzt5Mvc0zArB6Gu1OeGY+wvtIYaANQYNAbsbz70=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr1597248uae.12.1530034063823;
 Tue, 26 Jun 2018 10:27:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 10:27:43
 -0700 (PDT)
In-Reply-To: <152996983664.143105.1441423217241075965@swboyd.mtv.corp.google.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
 <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
 <CAJZ5v0iJcTg=X_j-4nap9d_H4jq2rwOETT8Sukx6UL5UsDKjgA@mail.gmail.com>
 <152908459103.16708.4012421602830600322@swboyd.mtv.corp.google.com>
 <CAJZ5v0gA76NwwgRnuztY+dUOKXS+__-7Ghw7Azb-84h_eMRt4w@mail.gmail.com>
 <152994466823.143105.11787470853817181844@swboyd.mtv.corp.google.com>
 <914341e7-ca94-054d-6127-522b745006b4@arm.com> <152996983664.143105.1441423217241075965@swboyd.mtv.corp.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 20:27:43 +0300
Message-ID: <CAHp75VfJQOZ9K=SusdDpV5NGeSnCvLvcg9w7nqqiyudH7+QGgA@mail.gmail.com>
Subject: Re: ACPI support in common clock framework
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 2:37 AM, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Sudeep Holla (2018-06-25 10:15:45)
>>
>>
>> On 25/06/18 17:37, Stephen Boyd wrote:
>> > Quoting Rafael J. Wysocki (2018-06-16 08:50:18)
>> >> On Fri, Jun 15, 2018 at 7:43 PM, Stephen Boyd <sboyd@kernel.org> wrote:
>> >>>
>> >>> Is this for clk_enable/disable? What about clk_set_rate() or
>> >>> clk_set_phase()? Is ACPI's AML taking care of that?
>> >>
>> >> That's for clk_enable/disable AFAICS.
>> >>
>> >> AML doesn't manage device performance states at all.
>> >
>> > Alright. We may need to add a better way for device drivers to get
>> > handles to clk pointers on ACPI firmware so they can change frequencies
>> > or phase, etc.
>>
>> Is there any specific usecase/device needing this in the kernel ? SPI
>> slaves ?
>
> Mark Brown has been pushing x86 folks to use clk framework for audio
> drivers in ASoC. I haven't seen other uses besides that really.

All LPSS code based on fixed rate clocks created by some platform
code. Since we have no board files for modern x86 platforms the clock
providers and consumers often are located in the same / adjoining
drivers.

-- 
With Best Regards,
Andy Shevchenko
