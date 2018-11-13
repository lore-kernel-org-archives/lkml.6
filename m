Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAC5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4622A22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synesis-ru.20150623.gappssmtp.com header.i=@synesis-ru.20150623.gappssmtp.com header.b="kWA3D28S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4622A22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synesis.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbeKMVYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:24:05 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43104 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732455AbeKMVYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:24:05 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so7307893otr.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synesis-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0JxXJBJ9eXeHdGZaFc5eR7bYT9jH1RMTyWBV9Ay5KnI=;
        b=kWA3D28SaUG/oXBPA/sBa0KMukm5sqWBGrd+KW3QriPAysXmScUmgocap5nRUa701f
         8G+A1GHtBTXXbPe10Hx03g8aGk8j1G4o53VIFwiQCatYD1trSTPb5Bt26k/bXL42XSZg
         rUbwf+PRA6M9g+1xFSpeMY0ZVVm+nGsmhYX5HYvoGhS0qa0CEDlsDn4wc8t0xGoryAo1
         fIUIx0BsCEtBXSnhRgP98cbCQCeYLMgU1Lh/A+XBcY64DHbfab83r1OFturnYtxAtjG3
         h/RQjsc9P9V8mUW4lrHubSz+Nt/hlkyJeO0AgKvDfgGuq4kjRs4c9Huu6G87iqBqLANz
         tYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0JxXJBJ9eXeHdGZaFc5eR7bYT9jH1RMTyWBV9Ay5KnI=;
        b=T/w8OonOjhMwySHZCBxJ6G6ALbqtKLMFnZlQbz/BPpR+M7SjgU/Yboe8U8J1vZT/O8
         0JHHK6+kt6rhrswxh8IekNKrCfG4Dd8rs0xQ+C5SLf6dPGrZQB/HtOYwJsF4EZGKsX61
         2sIXGzd/2qDM53twvgSDTkJXpH3F/a4SuEl6/7KBOmtc/nT/6MDcr8gCYMagAt4za8Qa
         YSdvV8xlVAs1JmPUUhj2L8LXw5coVVUFBfJ8xp3c/A7UBEmFcymd+bPgEFKgO0/V1fH+
         VKQBrJNxaHD6/JqR9Z9qgpjC69oUhZDfBdSmXRf+1EswZ9bCxqrFfJINY5YAWHWWbVyH
         13Sg==
X-Gm-Message-State: AGRZ1gIYHmPqXUqFMkIp4AXeiD7wtcERnk31QbHCnzdNgVlSZZcuDwys
        mq2GvFKcAI9xggNuuqTE5E8w4NCVpThoB9Vv
X-Google-Smtp-Source: AJdET5fKfml5xKY2juUeqHbg6Yrlt5qtwx6kBDpk8ti4ijOxhY7GzbxXN8doTp+X5B2B84AuCSJhqA==
X-Received: by 2002:a9d:42e1:: with SMTP id c30mr2660564otj.38.1542108383502;
        Tue, 13 Nov 2018 03:26:23 -0800 (PST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id r10-v6sm9871591oif.57.2018.11.13.03.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:26:22 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id a11so7307791otr.10;
        Tue, 13 Nov 2018 03:26:22 -0800 (PST)
X-Received: by 2002:a9d:3fcc:: with SMTP id i12mr3021824ote.82.1542108381598;
 Tue, 13 Nov 2018 03:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20181112231344.7161-1-timofey.titovets@synesis.ru> <20181113014928.GH21824@bombadil.infradead.org>
In-Reply-To: <20181113014928.GH21824@bombadil.infradead.org>
From:   Timofey Titovets <timofey.titovets@synesis.ru>
Date:   Tue, 13 Nov 2018 14:25:45 +0300
X-Gmail-Original-Message-ID: <CAGqmi76_ftDGtyowNRz7CCxRoJ6U3L747M=dWbRjh357w3=ZKA@mail.gmail.com>
Message-ID: <CAGqmi76_ftDGtyowNRz7CCxRoJ6U3L747M=dWbRjh357w3=ZKA@mail.gmail.com>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 04:49, Matth=
ew Wilcox <willy@infradead.org>:
>
> On Tue, Nov 13, 2018 at 02:13:44AM +0300, Timofey Titovets wrote:
> > Some numbers from different not madvised workloads.
> > Formulas:
> >   Percentage ratio =3D (pages_sharing - pages_shared)/pages_unshared
> >   Memory saved =3D (pages_sharing - pages_shared)*4/1024 MiB
> >   Memory used =3D free -h
> >
> >   * Name: My working laptop
> >     Description: Many different chrome/electron apps + KDE
> >     Ratio: 5%
> >     Saved: ~100  MiB
> >     Used:  ~2000 MiB
>
> Your _laptop_ saves 100MB of RAM?  That's extraordinary.  Essentially
> that's like getting an extra 100MB of page cache for free.  Is there
> any observable slowdown?  I could even see there being a speedup (due
> to your working set being allowed to be 5% larger)
>
> I am now a big fan of this patch and shall try to give it the review
> that it deserves.

I'm not sure if this is sarcasm,
anyway i try do my best to get that working.

On any x86 desktop with mixed load (browser, docs, games & etc)
You will always see something like 40-200 MiB of deduped pages,
based on type of load of course.

I'm just don't try use that numbers as reason to get general KSM
deduplication in kernel.
Because in current generation with several gigabytes of memory,
several saved MiB not looks serious for most of people.

Thanks!
