Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE6EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6332920819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUHdmX3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6332920819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbeKEWSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:18:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39914 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbeKEWSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:18:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id e4so14382421qkh.6;
        Mon, 05 Nov 2018 04:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YceYsjkhh07ude2ut1IfbiK/KQIyGLVF1t8rrKXixKY=;
        b=oUHdmX3J6oK7PMKLCO/OdXDsVB4kiGwAFdx5SB26KGJ+PhVP0lwJK+bSCibcXSqJwH
         I73Mt0uUJZFJR3ZpGLCgfbwIyUSv5S6umbR4EJTiqm32H5Ms1nx308oz0NIip5DRMGp1
         bGhGbcrJtC1EVKiOK/SVLF1WJZVJDHxcVLg7kAEfj740qta2I1CQQnrPsFozbZINmxYh
         c6aZTKdolFIwJ+gF4d/GS0nYpEl3QTjZ8f3lHm61KxeQsQ8DJWbGbWO54fwShI/nmUw+
         d9S6zJSz1cBRB/XW4y2mt5FAaPpvaAEC1XAUGR0IJAF2ZCbY428GDj3PGyZ3N8h0vFq7
         bchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YceYsjkhh07ude2ut1IfbiK/KQIyGLVF1t8rrKXixKY=;
        b=onhQADE5CFGC1DJa/5yYWNf66gtgfGFGpNL9ocQ/Cs2sAXX3uB+emyHKMgAUg2oYeK
         ayj5C/avEhVdJs8zId/4PzZlKQz7iCS45JSU707BIRx2AWeO82m5fFr5YWXOoL4N5Wjz
         MzgzfNSROang0GAtVRHrvqG4YDrS6NwTIatowWjvJSDJAtQV0Q02U05QBNq7JZ6df9DX
         ze4MiFNQIdqm3PEzaamx3qf5wWUwfWXGciBuU9N/j5gPXDXz0NVzNXMWhbew+uiscL2D
         YzPUg9hSKOvNS74w5WgQJdxcFWpf2nNGw5KlWl36FSI1PAC0WYnMLEi9dglB0o+/+g8B
         7R7g==
X-Gm-Message-State: AGRZ1gIzQSIZI/1EXWXqAagERSgGfXM6iAhIPGAjmGKFbEidBYWAB2/f
        mjSmujAhLrKfttvyXKyPMUDYBB+/iNSUpizKk60=
X-Google-Smtp-Source: AJdET5ctYx12LW5jpLHz8BRoEz2UnSARcZ8ppxY5ugZYINSg0+o8jiiLA++cFI0cGlEavxosGn1MRRiXe+CRvneCUqE=
X-Received: by 2002:a37:4792:: with SMTP id u140mr21038069qka.301.1541422705590;
 Mon, 05 Nov 2018 04:58:25 -0800 (PST)
MIME-Version: 1.0
References: <1541414431-84128-1-git-send-email-peng.hao2@zte.com.cn> <1541414431-84128-5-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1541414431-84128-5-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Nov 2018 14:58:14 +0200
Message-ID: <CAHp75VfP4d0fK9NDbAcHqy4aqTiMGTKBX5VQ36QbSyhRzrpOSQ@mail.gmail.com>
Subject: Re: [PATCH V7 5/9] misc/pvpanic: add support to get pvpanic device
 info by FDT
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 4:31 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> By default, when ACPI tables and FDT coexist for ARM64,
> current kernel takes precedence over FDT to get device information.
> Virt machine in qemu provides both FDT and ACPI table. Increases the
> way to get information through FDT.

> +#include <linux/acpi.h>
> +#include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
>  #include <linux/types.h>
> -#include <linux/acpi.h>

Adding new headers in this change is okay, while shuffling them is
logically a separate change.

-- 
With Best Regards,
Andy Shevchenko
