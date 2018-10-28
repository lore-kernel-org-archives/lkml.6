Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66F4C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA752054F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bkr93xnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA752054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeJ2FJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:09:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35404 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeJ2FJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:09:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id d7-v6so4499183lfi.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 13:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxiK7HUx0xOIU4ksodukkO7n2uIsxMXkxMd6lpzLm6A=;
        b=bkr93xnLDfzPKzfOC5llUaS9QC2WmMv83M/DK5ugF5dQBNNBT0+OlVkQVsj5ql7gC2
         iMCVksKYwXft8biZwcgV+mHKNcc6K+teGaDkVetZLYUCwe5UixqLjddtqTAobgRreqjE
         7ZVvcs3weP/E53hQc2iWt1kwy9ypyazXO+Fp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxiK7HUx0xOIU4ksodukkO7n2uIsxMXkxMd6lpzLm6A=;
        b=ViXn+nztukcZuX9QdMAEtFjSiDBGkBq5INFaoHjZb+MtNiXOtoDHJdpNnrNvHUTbji
         49mTJnvovIttM6LaP5puQVP61UQs4CrbKenDqX71abuuI0WmsC56lUCl+KEF4Bm5sXgY
         Q69BtFGcmGdhUo/+jdVPxkBnxDb2jv/614P+I261X5dK8xteTy9y2QVUeWrJMg8dveJy
         JvzViqUTGzlQY6ooRUWX9st33pxmwI1PXMNMB7nYROaHpuCF537H1YgYt9qPoyD6GNPB
         8IEmmiltpOHXAtpynRe1X9PQgubrXPPD9Zt/gvb1gvb3SeVfvox2htgYNRdDD43J9CZo
         10MA==
X-Gm-Message-State: AGRZ1gJHTwy23/Ypjw3kyXWbsnJwc8YN95O//cCYzYgDgZhlaboSaSwW
        Q4MFS+Q3cCdJpc2daVS+Hnu+wlkJIpU=
X-Google-Smtp-Source: AJdET5cfpyGB18fcJlky2vvOwa0LrbkBbHLCZ6WCjtwH7xRmNntTHw2KJ7ytfqSqZlKAmU6ACOlbZQ==
X-Received: by 2002:a19:9b50:: with SMTP id d77mr6745325lfe.137.1540758230874;
        Sun, 28 Oct 2018 13:23:50 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id s69-v6sm2832580lfs.92.2018.10.28.13.23.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 13:23:50 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id p86so2282197lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 13:23:50 -0700 (PDT)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr6864547lfg.117.1540758229587;
 Sun, 28 Oct 2018 13:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASZO0gOaLG2kmiAMaCQe3NYNsvW4FVm4sn5ESdRK5CDNA@mail.gmail.com>
In-Reply-To: <CAK7LNASZO0gOaLG2kmiAMaCQe3NYNsvW4FVm4sn5ESdRK5CDNA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 13:23:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg0NQUxPut0vw8JjM=ZAGc6cHjRcU0xwn+B6Wb47b1ag@mail.gmail.com>
Message-ID: <CAHk-=wgg0NQUxPut0vw8JjM=ZAGc6cHjRcU0xwn+B6Wb47b1ag@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v4.20
To:     yamada.masahiro@socionext.com
Cc:     linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 10:12 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Please pull Kbuild updates for v4.20

Pulled,

                      Linus
