Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D43C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DF2214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LG6Rvt1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DF2214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeJJM1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 08:27:07 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50993 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbeJJM1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 08:27:07 -0400
Received: by mail-it1-f195.google.com with SMTP id k206-v6so122119ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 22:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptzZzGwT+jK3720mDdBk6zd7IF2Q4iN5sitThOLqStw=;
        b=LG6Rvt1plqjqD+iZAsKiU0loQmaTm7jK9IzWWXyG6SrZTAFlHz1GmZjSsfFGpH3Hnu
         X2JCOSRHzBCTffJPUfVcOUTPjhhhZAT+TadXmqK9klFSLeSQpGLAMZ50rD+s1sZpFAcd
         l2GHqakq4qoIwSoasBixqzaO6aSASltuPbw3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptzZzGwT+jK3720mDdBk6zd7IF2Q4iN5sitThOLqStw=;
        b=eKAJ70iozeP88lLkPR/QtNl0SCsNa+aMQSNfIyhz08E33l2rHQfRDv0n+ua9snUyGQ
         rx+Dq5YfJsNeU04YF8KHtJx89cu1EsOjG5zTq3oR/NCvM4f5VWP32Tgns2PThw2yAZg/
         7rHnUHzrgCd62sxMPRSzzNPS/mSlhtkh3tLqXaZ6tXzOZNouBCHUunhBhTm5AtNa9+bf
         1Pv8k5KZ7uScfMLEqdboqzAMGZ3JCPnoPWtM2KJ0w5ZA2PzS+H8PpI6DOcBUq/zbQYYw
         wS0BaKgp5yVNXr0GT7UAjJ/eUnjlLDp3TY2/upMsbIqWy1MStR9eT7iu4TuEghZorapD
         u0Yw==
X-Gm-Message-State: ABuFfojztscRuQKOv6wUw92Zn/5mHZvjdBzjSWEJ78srY38do4fNAozq
        vChKwh40DbUfVJQI2NCEpQ82tEwmJUjxYU1wo5Bm3Q==
X-Google-Smtp-Source: ACcGV629v33euHNxyNt4USuZKHVvVPAzPm4ib+nDfLg/Y1vQhEEaeoUNShGzZ0IWYgVJ130Z9m61L5r/PGzKXhurfms=
X-Received: by 2002:a24:fdc4:: with SMTP id m187-v6mr3972142ith.117.1539148004981;
 Tue, 09 Oct 2018 22:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <13bda116-5766-1340-81e1-48ca899ff41a@baylibre.com> <20181003184318.856-1-jekarlson@gmail.com>
In-Reply-To: <20181003184318.856-1-jekarlson@gmail.com>
From:   Benson Leung <bleung@chromium.org>
Date:   Tue, 9 Oct 2018 22:06:33 -0700
Message-ID: <CANLzEkucw1KPOw+oRO-7NoxODhnj4BJsGgp4A+aQ7fTRPtxmhQ@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: cros-ec: copy the whole event in get_next_event_xfer
To:     Emil Karlson <jekarlson@gmail.com>
Cc:     kernel@esmil.dk, Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,
On Wed, Oct 3, 2018 at 11:43 AM Emil Karlson <jekarlson@gmail.com> wrote:
>
> Commit 57e94c8b974db2d83c60e1139c89a70806abbea0 caused cros-ec keyboard events
> be truncated on many chromebooks so that Left and Right keys on Column 12 were
> always 0. Use ret as memcpy len to fix this.
>
> The old code was using ec_dev->event_size, which is the event payload/data size
> excluding event_type header, for the length of the memcpy operation. Use ret
> as memcpy length to avoid the off by one and copy the whole msg->data.
>
> Fixes: 57e94c8b974d ("mfd: cros-ec: Increase maximum mkbp event size")
>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Emil Karlson <jekarlson@gmail.com>

Applied. Sent to Greg for rc8, hopefully.



-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
