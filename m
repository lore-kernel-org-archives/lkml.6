Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D98C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680B32064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E2XQtiza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680B32064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeKAHc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:32:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42458 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeKAHc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:32:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id f3-v6so16345672ljk.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=que0oEiW0QIIpCTPTezg2E6tTKzZ2VS0d3tUb7oFAls=;
        b=E2XQtizaumfjsp0cBi1b8LY+czsQPAsXu90Ow/Zrp3+K/k6l9A9pnC11RpDdi/Uv4U
         QToynlqn7Z5Km6vhgge3DrHZDhoatuV8UqpjsMZ5rG2/+GYBOCB+eMLAwkYax/IhQm4v
         w6ctfZEeCNrH6nFdeUGyRlHOaasRk2UGUtC1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=que0oEiW0QIIpCTPTezg2E6tTKzZ2VS0d3tUb7oFAls=;
        b=QUahMqB3N+LMMHnjGslG4BcFKKvwLxVsikdvL5MF7iXXI7CNXTX8ipxpoouR7Bn1SG
         yDZBiLas/nMSXCc5dUl9RQH6q7d8+CNDxIOHoVGLMJLpJBMvId7wAoZTXPntzw0kcHof
         Qp4iqjL5oX8zLVLHJ1pbfvOwpoOehTlDcFRIZlW2+euKCbdHSO7OL6gKmxnAe739untH
         F5aNyP/96KbKqH4wWqOdoPaQ+zSPkgC+pzIDNdNKI8ORHO1xLHM5Eoolm08TKmpGd4U/
         xyZb8fcHG7cXuuflNEv+cGqCnOnFypZ/TXhhuzLGHJjXN3R0ZDdc96Nva43dTObCcn8y
         msgg==
X-Gm-Message-State: AGRZ1gIeCnCCSSa1A9f3k55oNA85Mb6MkoIZeaNsqFvS5Hc75ccxikOo
        OQQO0a7BPZDHgjt66ir4hXzr5cWmqmnMNw==
X-Google-Smtp-Source: AJdET5eEUjr/5mRFUWUVDH04OjLLNDdHm2iONhMouoal+4wRHsVC4kG+gHW/wLClxokHkn6V1Ow+eA==
X-Received: by 2002:a2e:12c1:: with SMTP id 62-v6mr3564866ljs.74.1541025141581;
        Wed, 31 Oct 2018 15:32:21 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a63-v6sm4579905ljf.54.2018.10.31.15.32.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 15:32:20 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id p86so10676125lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 15:32:19 -0700 (PDT)
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr3169767lfo.124.1541025139241;
 Wed, 31 Oct 2018 15:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181030105328.0667ec68@coco.lan> <CAHk-=whQKCA18MEi7FT=10c0HVa=kxSyYBJeAQH-C2mA5gBhbg@mail.gmail.com>
In-Reply-To: <CAHk-=whQKCA18MEi7FT=10c0HVa=kxSyYBJeAQH-C2mA5gBhbg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 15:32:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5wkZtwZQfjVudLtS-Ej9pvaqu6=xM1msoBF8sMuTc_A@mail.gmail.com>
Message-ID: <CAHk-=wi5wkZtwZQfjVudLtS-Ej9pvaqu6=xM1msoBF8sMuTc_A@mail.gmail.com>
Subject: Re: [GIT PULL for v4.20-rc1] new experimental media request API
To:     mchehab+samsung@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 11:05 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But pulled,

I have no idea how I missed this during the actual test compile after
the pull (and yes, I'm sure I did one), but after doing a couple of
more pulls I finally did notice.

After the media pull I get this warning:

  ./usr/include/linux/v4l2-controls.h:1105: found __[us]{8,16,32,64}
type without #include <linux/types.h>

and sure enough, the recent changes to

  include/uapi/linux/v4l2-controls.h

add those new structures use the "__uXY" types without including the
header to define them.

It's harmless in the short term and the kernel build itself obviously
doesn't care apart from the warning, but please fix it.

                     Linus
