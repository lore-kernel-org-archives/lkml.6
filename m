Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7AFC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2622054F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0OAwwxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2622054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbeLGQ44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:56:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42124 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeLGQ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:56:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so4430416wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7watTlv8uPI6vne0oLCd0uWVz7uDe41Ke13XxtC1+00=;
        b=D0OAwwxPYZnTF1jNEGacZjfR1Khnqum0z7zCHnWbucUnpAQa1UR6RmP39Nu2v1iiwm
         PBbMaPcu+c4NCPpEb2hX8mGiABPoHp9VCRVoe5QyympDfgB/LEtTp2YT5n2VEt4Cr2Vx
         nF7hAm5lthi/OZv9oQfZ4BV6BVr2oNaPDdWS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7watTlv8uPI6vne0oLCd0uWVz7uDe41Ke13XxtC1+00=;
        b=UzyKrBPfoC+LnSdP+BHzLbWsdK927YxtWaOdmxqCgsGy/Ahf+2bjmtr2slB+Z3UAUK
         G9JJxawnDtbGPAO1/BDscMa0QuBKP6cKecKa3NpMm0ubLF3WL/bsjzMrqSFJ16rCSvuj
         Q2m3IKR9WxQ0UgnrQy3lYanBvZkLJg6nsai/DexvD4gXCUMk94i7tq36vR6wYmNLQR+H
         1BDN3TjGzyFH6ldWFpC5Y9HF7WZV7hLIBdeWeu+gfHnZU+4ceBGtr+ZnpmjZuyhXukd1
         iJeo4SaNwZ7Kt/9C3J6JOiTw/gF+IJSxymG1VGMglA5V2umqNms3hKzisCkVLlGxLOiN
         gzlw==
X-Gm-Message-State: AA+aEWYHsWAV4Yux+F37YLrQc5UoN+7I626u3H+gonLLJNf2imMRCq3J
        ROZ0AU5qR7wRJxPMwuIJS/2WFnirA2M3i0lYuXXXNw==
X-Google-Smtp-Source: AFSGD/WzJgHZ/S0RKM2Y0Vu676V3XQ2lfl3lgJEc5OisdXJTkxmbAdO4sOZZn0Y3oRuv9kneVMqhMNUnhqL3DHiMmuo=
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr2382418wrs.75.1544201814098;
 Fri, 07 Dec 2018 08:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20181207134824.300024-1-arnd@arndb.de> <20181207134824.300024-6-arnd@arndb.de>
In-Reply-To: <20181207134824.300024-6-arnd@arndb.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 7 Dec 2018 08:56:42 -0800
Message-ID: <CALAqxLUq7PF1b7B0toY8JfwD93CQeRez2PAoFL4Ja3JKNoz=hQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] timekeeping: remove unused {read,update}_persistent_clock
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
> After arch/sh has removed the last reference to these functions,
> we can remove them completely and just rely on the 64-bit time_t
> based versions. This cleans up a rather ugly use of __weak
> functions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/timekeeping32.h |  6 ------
>  kernel/time/ntp.c             | 10 +---------
>  kernel/time/timekeeping.c     | 12 ++----------
>  3 files changed, 3 insertions(+), 25 deletions(-)

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
