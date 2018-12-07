Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1968C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7215120868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLo4Of48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7215120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbeLGQ5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:57:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52514 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeLGQ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:57:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so5009391wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P254SZhCsFsPq05K2VOl8ENrJIspRe+SgIAOSnzkAxM=;
        b=RLo4Of48s+KuJnPGIRk0cHYhC78yE6mt1tJUD/PNOHKwGRVzjbF9ppn5VaI2HBT64u
         fVA4QDZJSz7kQEWsxJPlWAbxwZMndVUgfioCB77D2Hwwk/LX55sEfc47n3tPPm2eKWgo
         9qLrZhw3i7mkaz6b/GvfznBRWs+K6QGt9e7yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P254SZhCsFsPq05K2VOl8ENrJIspRe+SgIAOSnzkAxM=;
        b=qeDcVCnXhKG5dhYaubpr7Dck/T/yDRG4XSEl/ac9Vcc+BjVIHw3Sqe3v/RK8nRdJM5
         JgLO5MgR01XvmQ8sPya/cwcdogdmfhtjYX6RAMTjPmpYKYSKbvh8fygJNqc9pxobN+As
         0Jrv4bMNUP/6/P3x5/Hp5JMN5bllB/bapkbPczsHm2ffwFc5mIj8ud2W+O0omXtTwP2o
         gPoR4lLRUu1/s/65yh1KJMTkuanwEE5JTbpbdkSHfgXVe7nNNqAx8FGtcGSwOz+SX1C5
         rvmEjnfmtoF09FJWnV6SkoATht4BLuFDmy/Vkg3wMlJ4OkMqH3PgIQlDmPG+nn/JvtEz
         hH2g==
X-Gm-Message-State: AA+aEWZYFdl+mdqxCPO9QOl4MxhOFapbD578vhkeHOJuaoz7ogO8z6uX
        6k0nvcwUi9RSyhUNupTL+YtbkOxGP4R+4BSKAuYd0Q==
X-Google-Smtp-Source: AFSGD/WY0X6LQB7TNl1pSL4AxLqS9HKYdlBvuhpqedT+dKNRRjv2Eg/u48e7TPc/milrmO/fWLvJ4q4Hjsz/+4OvB2Q=
X-Received: by 2002:a1c:b456:: with SMTP id d83mr3072784wmf.115.1544201850050;
 Fri, 07 Dec 2018 08:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20181207134824.300024-1-arnd@arndb.de> <20181207134824.300024-7-arnd@arndb.de>
In-Reply-To: <20181207134824.300024-7-arnd@arndb.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 7 Dec 2018 08:57:17 -0800
Message-ID: <CALAqxLXAvCO0RuNLgDVTdt9bcQs1593905ZPV=vmk3LkJZxx5A@mail.gmail.com>
Subject: Re: [PATCH 6/8] timekeeping: remove timespec_add/timespec_del
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-sh@vger.kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 5:49 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The last users were removed a while ago since everyone moved to ktime_t,
> so we can remove the two unused interfaces for old timespec structures.
>
> With those two gone, set_normalized_timespec() is also unused, so
> remove that as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/time32.h | 25 -------------------------
>  kernel/time/time.c     | 36 ------------------------------------
>  2 files changed, 61 deletions(-)

Acked-by: John Stultz <john.stultz@linaro.org>
