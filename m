Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6626DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA072147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550643021;
	bh=FdfU5UWmFCpOivbjGlVGifcQ1NBmPwtve69/yhrIVYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hTxpEm1wIkuzbbbCkagK4skfjMoTASkw24P2Ajo4yFWpGjQ+rj/7fpPlv7mHh1dkm
	 rcxaVIT9oRcTK4SYZIah3YkXDNCqZQPAkBlmAFrLhtRBHDSoUcKvqDYy/dQSI9gfED
	 zPnu7rXjN7KJErc+XuK3yxQGaHmXni71+hiMXRuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfBTGKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:10:18 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33772 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfBTGKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:10:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id c55so1118370edb.0;
        Tue, 19 Feb 2019 22:10:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8u77boUVqczyZNaPnGObdhKIJY3Plmdl6iUPLJuvlE=;
        b=GabgM1SvoeBrTHHPD4SrtmynfbCBvTX4GYZB52XvQQDuxL+BUmIjoFzDZFpaP5A6on
         W9gs2Rtp6YFOrA90YkoYytxwOU8MJJygn/0ofUcAV+qz2yyoaq0CppKeR2A2pFBQK7Ui
         l/URjKVdO0FKHzzr/SQTY3ofwbEGS56uq3E6Z7GVehuz3pkiBH7af9Xcfh1Jtd/ZTgfQ
         VZiX4QbxCUoZHKWrXam4JsiNVxK9sQWmjYTBf4KRQosW9yFhrIuyb+IwyAlrx9GnKXaA
         TDORFX9q05GmDghcKNRrzPpc1UDKhpjNPmkNd8kxlozQZCfW7qhKDfTew5jRQlbuNPPx
         r+dQ==
X-Gm-Message-State: AHQUAuZg+Bmo4D2ZwCl56OiOpVLSddjA4EsDzspwaQd9hwdoKhlSrO42
        noaIP1VcEJH66DTmySJFVsHy3gAp3yUF5jTQZKk=
X-Google-Smtp-Source: AHgI3IYrviR1ZX0zn8iUsY0rZEmHjY9wXh7Yss8hXkMnHyc1gOYTZk2POxmDZBA54nHWSdoUHt+BjMGio9qhuS1W/ZE=
X-Received: by 2002:a17:906:114f:: with SMTP id i15mr18254341eja.29.1550643015769;
 Tue, 19 Feb 2019 22:10:15 -0800 (PST)
MIME-Version: 1.0
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <07d2908dc72bf964b27380999e1c826587d69136.1550545163.git.len.brown@intel.com> <4b9c3b83-5e45-068f-57fc-5a0e626ff0f3@linux.intel.com>
In-Reply-To: <4b9c3b83-5e45-068f-57fc-5a0e626ff0f3@linux.intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 20 Feb 2019 01:10:04 -0500
Message-ID: <CAJvTdKm+vGmWn=U+MLW1TzxnpAFxAiJRimO=HMArNp3FX1HXYA@mail.gmail.com>
Subject: Re: [PATCH 03/11] x86 topology: Add CPUID.1F multi-die/package support
To:     Like Xu <like.xu@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 9:59 PM Like Xu <like.xu@linux.intel.com> wrote:

> > -/* leaf 0xb sub-leaf types */
> > +/* extended topology sub-leaf types */
> >   #define INVALID_TYPE        0
> >   #define SMT_TYPE    1
> >   #define CORE_TYPE   2
> > +#define DIE_TYPE     5
>
> This patch set is going to export die topology via sysfs
> while the extended topology sub-leaf type could be one of followings:
> SMT/Core/Module/Tile/Die according to CPUID.1F from SDM.
>
> Why not choose to export module/tile topology as well?

Excellent question.  (and thank you for reading the SDM:-)

While it is true that there are shipping products with
software-visible CPU modules and tiles,
they shipped before this mechanism was available.  As a result, there
are currently zero
products that use this mechanism to enumerate modules and tiles.  If
future products
have software-visible modules and tiles, and they choose to use this mechanism,
we can add support for them.  But I do not advocate adding code to the kernel
"just in case".

In contrast, the need to support multi-die/package products as soon as
possible is quite clear.

thanks,
Len Brown, Intel Open Source Technology Center
