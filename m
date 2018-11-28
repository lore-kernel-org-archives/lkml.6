Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26641C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43B42086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43B42086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeK1TmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:42:10 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37232 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbeK1TmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:42:10 -0500
Received: by mail-vk1-f194.google.com with SMTP id 197so5735910vkf.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 00:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCELMdJKg+ESCWK2WveeCs1j+dOk7bvy04zzovQJFPE=;
        b=ICIu8PLI/3md0z8sz780imdjbJvv4yJmw1zbUXToFfQfdU3DRQBnGGz0Fww69m5xMZ
         Y25W5n44Ydeznl9PK4hw/X+6vd/k5MrUsChsHDHvg+/UQYxfUj2T8F8LsmvO8n6ssDPt
         AjULilJiSr1sjkc2NawoHxzotY3s07v+oIYT0ARChutpRcRGQYkJHs+b1BcWhXmR7OGs
         hQbLdR6PlcDCtnQVgYl1urPVfpzIWZ1U3XV8Zh5s3CVtEqKCoIU+PIt24TNODlGH7aTG
         nWuVEgwGUrWCDOf7XUWyPGyMQS1JK0pc9bgIXHiOtDTob2EpALFZKTYJfwMH6k45y2lK
         ti/Q==
X-Gm-Message-State: AA+aEWbbq20cWbKzaV4pITPdjvABegEAwRkFcsTNXmzZcDcU2QUGimaU
        2kV3ZHS0DAZ2Q4hKMZoEf8UYQguaGZW7qkIe9qQ=
X-Google-Smtp-Source: AFSGD/U+pjUR2xuGE1KMF63j4auWbscT6Sz0joiyrh9whTc9c+XZaHvZuFtL+J2rL1fuK71k12OcyBCwPk8cshQOED8=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr14939751vkh.65.1543394479690;
 Wed, 28 Nov 2018 00:41:19 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181128080244eucas1p15d9478c4fdbb0609005a12d24703d6d8@eucas1p1.samsung.com>
 <1543392134-1443-1-git-send-email-huijin.park@samsung.com>
In-Reply-To: <1543392134-1443-1-git-send-email-huijin.park@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Nov 2018 09:41:07 +0100
Message-ID: <CAMuHMdV6nm7yBFD4G5gCPTZMCpddGVMwNDPd9x6DaSCaqmzt9Q@mail.gmail.com>
Subject: Re: [PATCH v3] mtd: spi-nor: cast to u64 to avoid uint overflows
To:     huijin.park@samsung.com
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bbanghj.park@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 9:03 AM Huijin Park <huijin.park@samsung.com> wrote:
> From: "huijin.park" <huijin.park@samsung.com>
>
> The "params->size" is defined as "u64".
> And "info->sector_size" and "info->n_sectors" are defined as
> unsigned int and u16.
> Thus, u64 data might have strange data(loss data) if the result
> overflows an unsigned int.
> This patch casts "info->sector_size" to an u64.
>
> Signed-off-by: huijin.park <huijin.park@samsung.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
