Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A71CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AA721765
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL8laP59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AA721765
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeHMO3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:29:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45207 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbeHMO3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:29:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id w16-v6so12284683ljh.12;
        Mon, 13 Aug 2018 04:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pahia6amLOqx1hKHDHSiaHxzeYozgIMnvs5yaJzlHpI=;
        b=JL8laP593Zxk78Xiyv6tDXY6ed2rCEzN4K8NxDtCAn5afSVOc81LATyK58uVITW3bA
         G1tGRlAI3cATnnZr/ZIC74yMLdhA2UZlPplLvc8Jx9Y6l7AjO34Po8jtKBsEqqlzSrQY
         sEmJQcFc4IkpqMAIZ7J40zwOK5jy0WQsFQQ8FzQUzPFYW4p/u1469t+EkdiYaDDgaLcL
         uuL35zU7jytYRDeF1/LdreO8/m6JEqQeVt73Cv3KGqk31pJXxczIugMoxl6e7kTW7/xS
         TzIixIDdomUAGIEcBb3Q2QIhAKWUnslt31q+gysizqMfoBxmgrjeQKelHcO4pwsYa9k1
         Qgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pahia6amLOqx1hKHDHSiaHxzeYozgIMnvs5yaJzlHpI=;
        b=V3IvvWYFgeb3tqUSbWBm+5Il6uSWnZgXF4ghELgjYTswkKV79FIqANAThCBpk+Qj95
         uKZH/7ATq6yxPZgQY9flCCzxptxLyrxZ9OF6HcNjNcrmvxr2y0VOS0r+nZzrx7DL3LvZ
         w1b1FkiP+rvGz9rBfD1rSalUVQPVPSWClcwEU44kYWG1/ebbuLWlGAN3v0pckCdhKpbk
         lkH3sMJQMmZvlOJXg1+hMIxqLsl1+KSWz8m8f/f4jSprQBwIrnY2WfMhtDBIbkrrYcnj
         hA7WkQmRjFgH7a1q9umgaN7KDbhxWR/kZhy7WtelhuWFVEOSR+gxjv69DqnO0vb6vtYH
         +MyQ==
X-Gm-Message-State: AOUpUlGZK4QPnBIKUzovWNLrcrZOop+Kkq6F0HAqskIrqexmxWHgZz+Z
        H7cf0XZ0tSTTdX8bGGzBG/tM1IPYe10A68/IdsLz0GaO
X-Google-Smtp-Source: AA+uWPzFiI3vRavvOvoKjEy8o9l8u6wGm0PfKAuUsZP0v8h1dsJcpO9xrfnqjfonWLoBQulg7MuDImu6C2CbIOekRfU=
X-Received: by 2002:a2e:534e:: with SMTP id t14-v6mr2899488ljd.26.1534160822642;
 Mon, 13 Aug 2018 04:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180806155025.8912-1-vasilyev@ispras.ru> <20180806155025.8912-2-vasilyev@ispras.ru>
In-Reply-To: <20180806155025.8912-2-vasilyev@ispras.ru>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 13 Aug 2018 12:46:35 +0100
Message-ID: <CA+V-a8tD1oYHX3XtN1kc4mHyXxsDZ-toLWiOZTBttrghh31LGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] media: davinci: vpif_display: remove duplicate check
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the patch.

On Mon, Aug 6, 2018 at 4:51 PM Anton Vasilyev <vasilyev@ispras.ru> wrote:
>
> The patch removes the duplicate platform_data check from vpif_probe().
>
> Fixes: 4a5f8ae50b66 ("[media] davinci: vpif_capture: get subdevs from DT when available")
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
> v2: divided the original patch into two and made stylistic fixes based
> on the Prabhakar's rewiev.
> ---
>  drivers/media/platform/davinci/vpif_display.c | 5 -----
>  1 file changed, 5 deletions(-)
>
Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
--Prabhakar Lad
