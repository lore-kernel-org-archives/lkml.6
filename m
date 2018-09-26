Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06138C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D85204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D85204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeIZNhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:37:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42673 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIZNhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:37:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id z8-v6so16198241qto.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OnfXwgLTes9pySMDd786bIpmxRKQ00q4cgRfY3FT1jY=;
        b=hkei7b4Mql+MFKvLcE3NePjzl84DfG1psJ46tel/vQm+Ynzpes4Pw7yG9zuLkkUSmu
         BwYTlU5+0963RUKcc9fb/oHXR81xITaQDRyzUod0qa510KlbZaweY76sAD0moX6ExKkL
         1xo+qyZehcBBCA/2InSEQ9/Box5XhZoMBXXLInwGAgNDSbZoiC0+MUGgty2kuRmsO44b
         voDolXs+cCKm9XoH6PcqszxM6OIbTGXUuDD/0QMEF+y/5G8iXeSiGUGlDaZbJiPdwIAt
         TYjkbU6VI1R06FW/78+Ur6UAXDuu3CCVaUV37jzTEDEdtFLteZTbKnxVmxXK4pBeDCPp
         dlBA==
X-Gm-Message-State: ABuFfogA1lIHUxwktbsC3y2c4enERahX4S779JGFrgwcDByjnssYdNen
        DSGKGuPg3jn0ZBzTLcvi1jL+KiLU94FyO0LlddSJtC+5
X-Google-Smtp-Source: ACcGV60upGgn+xTHOpKfPpWR/Lt/fAUOQ2T2D/kwORjfPmnY5A99hfEx79kbLDdvMz56P5ipaPESZ0Renybizo5hPz8=
X-Received: by 2002:aed:3608:: with SMTP id e8-v6mr3595379qtb.75.1537946742805;
 Wed, 26 Sep 2018 00:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180925212018.27132-1-stefan@agner.ch>
In-Reply-To: <20180925212018.27132-1-stefan@agner.ch>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 26 Sep 2018 09:25:26 +0200
Message-ID: <CAK8P3a3naNgsWRLCyMbACntte4DOaYz3tzP72SMZGDzaUoZtPQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: use choice for kernel unwinders
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:20 PM Stefan Agner <stefan@agner.ch> wrote:
>
> While in theory multiple unwinders could be compiled in, it does
> not make sense in practise. Use a choice to make the unwinder
> selection mutually exclusive and mandatory.
>
> Already before this commit it has not been possible to deselect
> FRAME_POINTER. Remove the obsolete comment.
>
> Furthermore, to produce a meaningful backtrace with FRAME_POINTER
> enabled the kernel needs a specific function prologue:
>     mov    ip, sp
>     stmfd    sp!, {fp, ip, lr, pc}
>     sub    fp, ip, #4
>
> To get to the required prologue gcc uses apcs and no-sched-prolog.
> This compiler options are not available on clang, and clang is not
> able to generate the required prologue. Make the FRAME_POINTER
> config symbol depending on !clang.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I've tested an earlier version of this patch on my randconfig builder
without issues.

       Arnd
