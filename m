Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAD4C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF8920834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/IEFHuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF8920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeJZPqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:46:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43169 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZPqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:46:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id q41-v6so128686qtq.10;
        Fri, 26 Oct 2018 00:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Us7nGtnYgYzQwJsKG++n5CfLReYIgJQveEM9nKXuzCU=;
        b=D/IEFHuWw7ijFOTTwsJJDRxjn2n/Gn+gVaLWrfzU6lv8lN9unMIKPZNDSSNIEDFncx
         0E2YOzg3Ex76auFSctkI3WrDekyW6QZPzxxJJZdT7P0WC6MGTrc8KaJYS7ETYaX8ulZx
         lovk+Z4OZyEt6LP0bcgZhvHfFWWU44PLhFv7RyLkM2nmcCWC6WX7pG0zXVsL+8+cBBdU
         arnVRSEmvbmmmnF/7cAzXHMU1yrwKemSAQqLFEh5X0HVPBcdc1DXww46VgZpS+Xlfdgu
         eSB/JepVFt1aXJp9S4EMH9HILz2ClFh8YJv2gB3rcKBbXkPd0FbkkveZ/eIUWdaJxqB9
         ltlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Us7nGtnYgYzQwJsKG++n5CfLReYIgJQveEM9nKXuzCU=;
        b=Pkzcm8sKHlFUpryZtCK+PMgKzbp33U2isBrAYO4loT7DM4LLP+/eRM+RvIt2U8q8uY
         S/1uzlA3PZVMOjPOsaGt0/tahsEuO6pkCGmWDquF4xJARDoJuZ/WKc4EkShmiC0aN4GE
         /hjfyZtl7FQJgyLe8Bc/SLK7DHA+uIfEHuvkDpSfjEjsFp/u0UT4jB+3/rlu4WP2v65Y
         OmT8h7A5kw7EJed6jUIq633wE6Xy1ejeENWXNWDDiOkbL/ciE8X2F9JZPsf09TBXDh7c
         7F/TOfSl6Yt6AFbHSbmlxYrnGAuj1MpPb2CORG2dvtSpgAyV9blR83R9EVU5TF7CPItL
         wfjw==
X-Gm-Message-State: AGRZ1gLjpQBKqwRAzFMNGibXt/FZTLEbLJpZaClHvkeVg6Ba4bssgj/u
        VPbUDfVXEHesNxVuYGa1f4F2Kgsh8AnJhuU6Tbs=
X-Google-Smtp-Source: AJdET5fheU73pF3Wb7ERERXllMUOmNF776pkHLTPJwWUhoQKYoU1WwRC4LwmeQAUda9hVy45AyjPjDbmxn0eSXi6CtI=
X-Received: by 2002:aed:35cb:: with SMTP id d11-v6mr2114754qte.212.1540537861919;
 Fri, 26 Oct 2018 00:11:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:988d:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 00:11:01
 -0700 (PDT)
In-Reply-To: <201810261140543493998@zte.com.cn>
References: <CAHp75Ves+GCP8ZfOCXDcZNkyEo31hiPTyarRoYvhkjHeV+9dug@mail.gmail.com>
 <201810261140543493998@zte.com.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Oct 2018 09:11:01 +0200
X-Google-Sender-Auth: UMksFSJKhuecCb10SILWd_Bqfig
Message-ID: <CAK8P3a0Y7en4Aa_-ho7fdp17SsG=XnTePhTeqxFmr5PE4LvHeA@mail.gmail.com>
Subject: Re: Re: [PATCH V2 2/4] misc/pvpanic: add MMIO support
To:     peng.hao2@zte.com.cn
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, gregkh@linuxfoundation.org,
        andy@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18, peng.hao2@zte.com.cn <peng.hao2@zte.com.cn> wrote:
>>
>> On some architectures (e.g. arm64), it's preferable to use MMIO, since
>> this can be used standalone. Add MMIO support to the pvpanic driver.
>>
>>
>>No global variables, please.

There obviously has to be at least one global variable here, since the
caller of panic() has no context about the device that provides
the MMIO register. But I agree that using ioreadxx() here would
be nice to simplify the code, and it avoids having separate variables
for pio and mmio mode.

>>If your switch to ioreadxx()iowritexx() it would really help you here.
>>
> I can use iowrite8, but here:
>  if (base)
>       iounmap(base);
> I found the nearest API pci_iounmap, but it's a bit strange to see how this
> function is
> used here from the name of the function.
> And I do not confirm that this API is suitable for all architectures.

From reading the driver, I think you either come from a caller that
always uses PIO or from one that always uses MMIO, and they
are paired with probe/remove, so you can assign the global
__iomem pointer using either ioport_map() or ioremap(), and
undo that using ioport_unmap/iounmap respectively, while the
user just uses iowrite8() unconditionally. This is allowed by the
iowritexx() interfaces.

Alternatively, using devm_ioremap_resource() should work for
either pio or mmio, but it requires a device pointer, which in turn
means you have to slightly rewrite the ACPI portion to use a
platform_driver instead.

      Arnd
