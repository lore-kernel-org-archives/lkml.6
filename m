Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36049C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA141216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmjAW1Un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA141216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeI1CZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:25:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41955 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1CZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:25:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id m77-v6so2644203pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tm7N6Yk9GSXZKXWZw5e6qivtPz56ewYd2JTkDX9Emtw=;
        b=NmjAW1Uns4rSsAY+HZNG7pbAMQEpfKIlYbO5dcw1u7e+fKOAKD9AJu+lOpQ80wJ/BI
         Al4ySw/vy3Eab9BAFWg/gJQ65f29HKm0c4nWzW3gicf5KLSpEL6qJX4mADpnXDf+hyw5
         JZnmJp46YsS4NBheilHDCCwiZCYgyx8mmvj00b+2hlZSAlyTX1KZ8sGUKW4dOaSZacl/
         HO2fmUiD+JXLRbXbNzXQdfdwMPVyUJ7+bGkNwIriUeMKHnLCYBM5DRJRsqKOVOyWSRWk
         hYXjAMqVkVqlSTHBzwdA9EjqItPrSPUoKqF/EEti7k87qi+jGkepBrFAFUUUCpenI1BY
         9KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tm7N6Yk9GSXZKXWZw5e6qivtPz56ewYd2JTkDX9Emtw=;
        b=K4sVIAYrJM+R2tlcV/+H9p85OUu6l5oVOhc+Ac8m+gzCZp+0NuoyAx43a5wXpVV+hg
         CZ3CLv8K528VzxKWD9uhdiP1N2tUXa0JpWFfXkzcMibNVha1gxGtVrRCmFvU42xvqvOS
         2j3SJX+N6p4FZdJHmJYXbx7Kq4sdxi0zRmDY8emwrZio1m88U5rDfEn4LC1onZHHjuQv
         XNrENUOnIW4bYmKr2gPsSl+ZlxfMO+TydP5Gz34iPDGUWTQvTWsYSZf9oN6VuPkOLUnm
         i044bZjJPnZ9ocERqvqEQjMqo/FXhursKBdaoaE/mVPHzurBrYEN8dDB2CrPcSAWB2qO
         9XaA==
X-Gm-Message-State: ABuFfoiog7NRwI42P1rPjkU+fAJPFwB5rWJq86Lzlk6OyGFb44qQZS48
        X6EVdOlje2aGzpg1k9BxZFbdyX4If3zQIsHv/DBX2jNqS84=
X-Google-Smtp-Source: ACcGV62AxDb+GCzF0A+EhCkUmnwfFdzSpsQ4Li5IK2/oCTtB7z/v8dwLh8koyUYcOaghZXxf+MKcBcRPdbPqGhykoWo=
X-Received: by 2002:a62:1895:: with SMTP id 143-v6mr12942075pfy.227.1538078754542;
 Thu, 27 Sep 2018 13:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180926232055.31951-1-natechancellor@gmail.com> <20180927051634.GA32508@kroah.com>
In-Reply-To: <20180927051634.GA32508@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 13:05:43 -0700
Message-ID: <CAKwvOdm3Au2V159PtripyZReZf167TtL5o7P9uYY-okr+n4xPw@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as used
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:16 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 26, 2018 at 04:20:55PM -0700, Nathan Chancellor wrote:
> > Clang emits the following warning:
> >
> > drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
> > 'acpi_ids' is not needed and will not be emitted
> > [-Wunneeded-internal-declaration]
> > static const struct acpi_device_id acpi_ids[] = {
> >                                    ^
> > 1 warning generated.
> >
> > Mark acpi_ids with the attribute __used, which makes it clear to Clang
> > that we don't want this warning while not inhibiting Clang's dead code
> > elimination from removing the unreferenced internal symbol when moving
> > the data to the globally available symbol with MODULE_DEVICE_TABLE.
> >
> > $ nm -S drivers/staging/rtl8723bs/os_dep/sdio_intf.o | grep acpi
> > 0000000000000000 0000000000000040 R __mod_acpi__acpi_ids_device_table
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/169
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > index 6d02904de63f..7c03b69b8ed3 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > @@ -22,7 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
> >       { SDIO_DEVICE(0x024c, 0xb723), },
> >       { /* end: all zeroes */                         },
> >  };
> > -static const struct acpi_device_id acpi_ids[] = {
> > +static const struct acpi_device_id acpi_ids[] __used = {
>
> Can't we put __used somewhere in the MODULE_DEVICE_TABLE() macro so we
> don't have to go adding it to all individual entries?

Maybe; I'm still trying to think of what we could do in that macro to
make its arg appear to be used while still being no functional change.

This is not a million-little-commits problem; more like 2 drivers in
the whole tree have this problem.

Note that this change that Nathan has DOES NOT need to applied to
every driver that uses MODULE_DEVICE_TABLE.  Only when the struct has
no other references other than JUST being passed to
MODULE_DEVICE_TABLE() is this a problem.  For an allyesconfig, I only
see 2 instances of this case in the whole tree:

https://github.com/ClangBuiltLinux/linux/issues/169 <- this patch is addressing
https://github.com/ClangBuiltLinux/linux/issues/178 <- waiting on the
results of this patch

If you're ok with this change to two drivers, then:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
