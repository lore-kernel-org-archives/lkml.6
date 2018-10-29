Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41EEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8882F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZUHrIWbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8882F20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJ3BJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:09:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46048 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeJ3BJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:09:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id c24-v6so6493747lfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smeDYgWhLGQQbVorwLNZ3sikO5j5ffwxmgJXEdz2xF8=;
        b=ZUHrIWbiSjkCRGwA44QLHbMFzB4uqKSJk7YR48e0COKaVYalFFF0Oxr7iT5TEKTnjY
         ZKRwsC7nHgK6Tq9583SJYJXMALxl4wCn3oC6Onj/cFur5UrQTAB5r5c8LTgaTxvPYGpa
         I68pgIDFE0pcoNwfYVSydTZlpf0p+t5w6MXoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smeDYgWhLGQQbVorwLNZ3sikO5j5ffwxmgJXEdz2xF8=;
        b=Xht6c0j3IlzT7fQteivdW9EaLnlhfyYtl5WORioNTfanKXP84EfX1hDGAkpu0/S3Yj
         HRWYBKBJ1RU+BzJcdZn7vizogl9CYQVVQQff3TJAa8QfLvDJ9wrUDSpDHd4XfntUbbRy
         oplCU5dktCvBRFU401EVM4KCUqe8e9RF3fhXL0iOMGZw/Gd+OQ8tqmecqo+zZj+Ibp2x
         KUp/QrkATrQ7wQsU3xs9FsnYJhtMIKyXD7WvwRLkY93va2js5V8AEKpPGEtztQqbR30G
         qUsl22ysMTaPnDtYW+zdyLIRivjevQpujicAqUhS7ITbZwI/WMWW3ABQFHYm6vbyVvP6
         0+bQ==
X-Gm-Message-State: AGRZ1gJEM/rIS4MLKOAX9kDGez8cbxCDgawErwzUuhm4hzyivXvCSR1c
        MYMejomrKflHK6PKmuvLJJnp3iF7P/FWxA==
X-Google-Smtp-Source: AJdET5fBEVtDWyq9yVgjtVa+Nn0kEQJVj22C1dznfmbqjVX3ZrAJGlwE/ShPfjCcwamnRxCaP6pcXg==
X-Received: by 2002:a19:d908:: with SMTP id q8mr8436996lfg.88.1540829999322;
        Mon, 29 Oct 2018 09:19:59 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id t73-v6sm2812645lje.23.2018.10.29.09.19.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:19:58 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c16so6506699lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:19:58 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr8347128lfi.138.1540829997829;
 Mon, 29 Oct 2018 09:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181029012924.GA31433@nautica>
In-Reply-To: <20181029012924.GA31433@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 09:19:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsvys7pqn8YSCToypNTk_m533_ESpXy=o16DvzkkR6rw@mail.gmail.com>
Message-ID: <CAHk-=wjsvys7pqn8YSCToypNTk_m533_ESpXy=o16DvzkkR6rw@mail.gmail.com>
Subject: Re: [GIT PULL] 9p updates for 4.20
To:     asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 6:29 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Highlights this time around are the end of Matthew's work to remove the
> custom 9p request cache and use a slab directly for requests, with some
> extra patches on my end to not degrade performance, but it's a very good
> cleanup.
> Tomas and I fixed a few more syzkaller bugs (refcount is the big one),
> and I had a go at the coverity bugs and at some of the bugzilla reports
> we had open for a while.

Pulled,

                    Linus
