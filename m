Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095EEC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A432175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ruoiiz3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBGXDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:03:15 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:36544 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGXDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:03:14 -0500
Received: by mail-ot1-f46.google.com with SMTP id k98so2872114otk.3;
        Thu, 07 Feb 2019 15:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VWQmC4F35xJ38pomul1qzGug7X9Rcu6zXI5Pq20qDs=;
        b=Ruoiiz3V+HB/GC8cjTHmuGlzzGPG2QcVq2iW23BXtp2njpIeAuPJI+tBX+1iqy4uBT
         6JsNSMXoVDduM9qWFWBIG0hdbw566O1qFuCIiHKzgKz3Veo1WXIKbfnTVFfYAsUesMFz
         5RgoGXC9Igf7Ys5cpE2FmxOby0pXTNcE0an7aaf4/BuD6qoFNSo1ra7DCB1H6rf6Eisy
         gHmiivyNv5knpwg3++saGJCU5dROPTZc2gncETddoe1MU7VS6KLxKgU/0K9bUVelfLw9
         WV4fgkT31Ml9v5xplorJifvK1dnXqDDauAfn6Etv2zjb3G8wZOrJGl7JTpdlcoy0fKsD
         ADdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VWQmC4F35xJ38pomul1qzGug7X9Rcu6zXI5Pq20qDs=;
        b=ksMpISCnDmDhOsNJRMrj6ro7gvj6KKxC0B6Zz+bAPteGWPCS7EXLwd1wrcAiDzeKC8
         CQfTfsTRu7gvGPf6or11LqChmeEkaQKwhuQr6CNvbunXMr6RixaQDgyMuwrshTDMVc+y
         LMS1T37GLrVb/oEI+gtLPYbVxtIIx6Ono7xj3H7YtWEwZ1sbEbqPPSxVwECFDtXKTYt8
         ArJ14PvQ97GCxs81cWbD/LDetbuRvt8FwDEYYpJEx6ehrczrGg9oW6PG7c2TAiEkOclw
         rJu1Y8ATk2MxD02Z/S2nJIwJTZ5Qbfrz1McAL26bdUv5Hwyvb+QqBQ/2oElc+HVLL7YM
         2Wmg==
X-Gm-Message-State: AHQUAuZb4YMqvftCHBHOh9dxKXag6ydm1pxp6IQ0bCD/TjhZ8TR1HGaI
        6Qy0UGiAwXDS1xsv3cPGUD6w5paIk8TsPg3i56nxng==
X-Google-Smtp-Source: AHgI3IYGOhXasxOJ+PYk5r9kqxsu/sDex35+QigkJj7NKw8K2IP0voINfEH/vYQM2frOS3Xr2eNLht/9UydNi4uyvKE=
X-Received: by 2002:a54:4005:: with SMTP id x5mr308237oie.124.1549580594016;
 Thu, 07 Feb 2019 15:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20190207222740.GA38612@dtor-ws>
In-Reply-To: <20190207222740.GA38612@dtor-ws>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 7 Feb 2019 18:03:03 -0500
Message-ID: <CAGngYiWzC92Lw+Z-BAtPfEHgys0vcQOxdxo7g_JHKHF36-Hm7Q@mail.gmail.com>
Subject: Re: [PATCH] Input: ps2-gpio - flush TX work when closing port
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 5:27 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> +       flush_work(&drvdata->tx_work.work);

Would cancel_work_sync() be better than flush_work() ?
