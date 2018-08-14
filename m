Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5ECC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DCA21653
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VP4trLg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DCA21653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbeHNUIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:08:48 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55643 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732947AbeHNUIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:08:47 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so19282211itj.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 10:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNHSvoj8eckkD/+qgU3HFodRvk3FV2BaQZgtwZPHhIg=;
        b=VP4trLg0i1HTTbNtKl1yTmxAwXg/zxS3JeTTsMZPWgu3akCFqCaFH2NFO3uL9Spr+V
         V5t7WPcT+GeBXej3kC+39FlalpIw928SgFama4cfDpsm4RB3FuNTZe3pfMs8QcGMSH7M
         NmzuLjbAF56FgoVeYjzH5UldDx/+u3InE55xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNHSvoj8eckkD/+qgU3HFodRvk3FV2BaQZgtwZPHhIg=;
        b=VZGtB5ZHaK1+rS2YdckCtyXftg1pmhCR14r13IjJFUvdaSQzIZEwkVkBQB/hJkYpm3
         CPhd8hw5l+PwOPTgwazZ0XmHz/9yctpyC2O1pAjSjBmHd81tK2+PmPxKCSqc+Fm4IHEv
         96tAwXMsm8KrcI9I6MYMXCf0lI1Z4jLusTPmdv1FbdloMgM1j1BUx9XJHp0mQ9haEMwR
         czX2Vo7gQWqCbgM57uxaAuzvPEydoPlDfo9jok14I+pXM4YtzqDsrAKj2YCREaoDXSTk
         9Y93Ldpkp0paOcpGWMikO+o/pbwGUC/V9pacuashwjw0c+OFqhAdOqGKSyfj8Cz/ZJ7S
         YRnw==
X-Gm-Message-State: AOUpUlF4WZUr237KDpbiu5kSCLRlsovzTO0yiQgZ+A1BT2co7Yf4L3q/
        ZWmI3dWKZVALQ2fBcc3btIOK57QLsVGmNPNBGAk=
X-Google-Smtp-Source: AA+uWPyW/+zr59sROEDvDsxKffHBwvlPT2aHScqXtmVI/XgWC2bpzIrKerIEA/64obycW1doLolRTPWdq7EF4QuVN2I=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr14824925ite.1.1534267243328;
 Tue, 14 Aug 2018 10:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180814170904.GA12768@roeck-us.net>
In-Reply-To: <20180814170904.GA12768@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Aug 2018 10:20:32 -0700
Message-ID: <CA+55aFy0SFGaNmzCcpwMCeY_f3ZTG54NmV3SosbK6=QdE20=5A@mail.gmail.com>
Subject: Re: Build failures with gcc 4.5 and older
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 10:09 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Does that mean that gcc 4.5 and older are now officially no longer
> supported for compiling the kernel ?

I guess we might as well make this the excuse for making that official.

Maybe it's trivially fixable, but I don't even want to look at it,
since we've talked about updating the minimum gcc version so long.

> If so, would it make sense to update include/linux/compiler-gcc.h
> accordingly ?

Unless somebody cares, and comes with a trivial fix to make old
compilers happy, let's just do that.

We had some other reasons to just say gcc-4.6 is the minimum version anyway.

            Linus
