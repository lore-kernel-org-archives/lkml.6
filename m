Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935EAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58973223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBguShRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58973223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbeKNXk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:40:27 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33729 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbeKNXk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:40:26 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so11529809lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 05:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+GlFOd2kBh4I96SmNapQmNPP148th00LGr85VLOROg=;
        b=kBguShRR3Zkd9q3TgJ+bgzkQVeP2Z8y/qV7eLSoOutOI55ESLQU/6cCKIabvWRHg6W
         6FczbfBzA4jWCwTmLJxr6kx2ZwzWEqmRYrGoFWAZ/MThlL6lVTOXHHDq82VNl2CavX3S
         5rzzkkoLzK7kMzZZXROZBIxZKYhS7gWr1RNxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+GlFOd2kBh4I96SmNapQmNPP148th00LGr85VLOROg=;
        b=EQfRtMPDDAVcQomTDVJF/YPf09v0dbOl8whZEiM6tcwsD7ivuoFdQiiCdKjTK+VjuX
         0ayXFWdmwkh1W3c5HJcfJr/lVeXYmJOyQF30Yt4flAeWrtIPV0emor1leofwE9/IG1F7
         Nh0nUTjhGJf51xxPZDv8nzww/n42KkopoOAEoQN2JnqPhRZi+fMQmEf3pqPCsTN5KJg+
         pboMwojrqo12yww5Vjo2sH3+stjpc9vvXhrZV0jw/usR45hHreomxZUgRaBRvoUfSelx
         YQvRRFtygRSeUKSXdKk/jCf17I8erxZHbaU3F54byT2cpXdGZ5QPznmIY70tLJZahxot
         Ap2g==
X-Gm-Message-State: AGRZ1gKIuOBtc5cMt6czgax9KMJlnZwTGE5L1KnVpcTW7iHIMY2OC9wt
        kbPZ8J/Ilj+QthlucxrNat9Tz5RYiBZi0Z7RvT8Z/g==
X-Google-Smtp-Source: AJdET5f5UkCkVWSyDoGx2SfAI1kjVzmaWnotIiJIi7m6l5iK/GImqzdN17Ktsw+M87ReaV+OHbABiFRyHABUyU6Bn8E=
X-Received: by 2002:a19:5154:: with SMTP id f81mr1118808lfb.96.1542202627303;
 Wed, 14 Nov 2018 05:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20181106033348.27361-1-baijiaju1990@gmail.com>
In-Reply-To: <20181106033348.27361-1-baijiaju1990@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Nov 2018 14:36:55 +0100
Message-ID: <CACRpkdZRRqa6L9wws_5t7WC5Ekdx1NbWUbXdiM7rnHeZpb7Wrg@mail.gmail.com>
Subject: Re: [PATCH] dma: coh901318: Fix a double-lock bug
To:     baijiaju1990@gmail.com
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 4:33 AM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> The function coh901318_alloc_chan_resources() calls spin_lock_irqsave()
> before calling coh901318_config().
> But coh901318_config() calls spin_lock_irqsave() again in its
> definition, which may cause a double-lock bug.
>
> Because coh901318_config() is only called by
> coh901318_alloc_chan_resources(), the bug fix is to remove the
> calls to spin-lock and -unlock functions in coh901318_config().
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
