Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5277B214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synesis-ru.20150623.gappssmtp.com header.i=@synesis-ru.20150623.gappssmtp.com header.b="ttpyN6FJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5277B214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synesis.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbeKNERh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:17:37 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34516 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKNERh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:17:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id a202-v6so3057420oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synesis-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5IfNSoiM7rcywtksB3ASPv0sLv4kO68L9YLZ+gQ6DJM=;
        b=ttpyN6FJE5rxVf4tFN+vHfXmBMBmLTIVrZVsBm9HfvTscdyoLoiME6yAh1G/C42c7W
         XfS+Ofg8hQyGAHxVWjVUAs5XhbXbdwnj4o73ei1UBsISr9dLs9uEhzLHf4vTG9A/xd+w
         AHuR9TUzwqyJw/GNePO7kyF1owMsLIdheWKP1AtaElgLrHyqbAyqwIy1X7Thk3X/gSxa
         1ilFBBD0r/DHaYb3nfYIZ4OVv9J1qWeeZqIG9oRCtOgI6sVsndZ0NcVqR5fquIyxZazC
         k3aqaYj4RmsdKkTILJCGXlkxDO7YVVaiZ8O9QZyX/D2GUBgKihrUjK0+NMb3iGPIB7dc
         hPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5IfNSoiM7rcywtksB3ASPv0sLv4kO68L9YLZ+gQ6DJM=;
        b=YTPUI+GVOrWC4/q8OSGChKgLzv+69mChFghWMWb/ARElyoip4e68+UuKwSKacI+WPH
         kAS9ISwvailsbJn3MflmSxR2NKpRsHYh3eg/dit6JiLx+mn5+Yy63W66pbVqmIOrgreq
         Hq9uz+hkAClfUAnhHi0YDMIhWK8I7r5xyKXsVMHTROp7YeZXFrE2ioCoJ6ntBKQUmFfU
         8z/9j2C4S09PK82SdQ3rRnRetPU4m/wOlN3a8SsWdWB8aQ8BD2XGAJAlmnBn3Uld2DvV
         xX3QtIhDNzbvAutv7SWUUJgANgwoyVl1xQduy0X53edEYzIMlzLkVf0fWR3KvCsWMNAC
         0hRA==
X-Gm-Message-State: AGRZ1gJoe6WhZCximFJLMhbkjvRnIxF7B80I3npN6E2p2j984N80pqxJ
        WN5TybFho7Gu8S4U3CG8Odbs2qmShCCwPK3y
X-Google-Smtp-Source: AJdET5dj3JthqS22OBmrNmZ8kSO/uE8Qvi9AxZGrfV+66EmzJYjQZfR5gITy80ikG8LTt2jIu0XSxA==
X-Received: by 2002:aca:5a41:: with SMTP id o62-v6mr3460238oib.323.1542133101730;
        Tue, 13 Nov 2018 10:18:21 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id p189-v6sm1297901oif.19.2018.11.13.10.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:18:20 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 192-v6so11194148oii.6;
        Tue, 13 Nov 2018 10:18:19 -0800 (PST)
X-Received: by 2002:aca:4dd4:: with SMTP id a203-v6mr3769165oib.168.1542133099027;
 Tue, 13 Nov 2018 10:18:19 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez0ZprqUYGZFxcrY6U3Dnwt77q1NJXzzpsn1XNkRuXVppw@mail.gmail.com>
 <d43da6ad1a3c164aa03e0f22f065591a@natalenko.name> <20181113175930.3g65rlhbaimstq7g@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
In-Reply-To: <20181113175930.3g65rlhbaimstq7g@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
From:   Timofey Titovets <timofey.titovets@synesis.ru>
Date:   Tue, 13 Nov 2018 21:17:42 +0300
X-Gmail-Original-Message-ID: <CAGqmi74gpvJv8=B-3pVSMrDssu-aYMxW9xM7mt1WNQjGLjMZqA@mail.gmail.com>
Message-ID: <CAGqmi74gpvJv8=B-3pVSMrDssu-aYMxW9xM7mt1WNQjGLjMZqA@mail.gmail.com>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
To:     pasha.tatashin@soleen.com
Cc:     oleksandr@natalenko.name, Jann Horn <jannh@google.com>,
        linux-doc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 20:59, Pavel=
 Tatashin <pasha.tatashin@soleen.com>:
>
> On 18-11-13 15:23:50, Oleksandr Natalenko wrote:
> > Hi.
> >
> > > Yep. However, so far, it requires an application to explicitly opt in
> > > to this behavior, so it's not all that bad. Your patch would remove
> > > the requirement for application opt-in, which, in my opinion, makes
> > > this way worse and reduces the number of applications for which this
> > > is acceptable.
> >
> > The default is to maintain the old behaviour, so unless the explicit
> > decision is made by the administrator, no extra risk is imposed.
>
> The new interface would be more tolerable if it honored MADV_UNMERGEABLE:
>
> KSM default on: merge everything except when MADV_UNMERGEABLE is
> excplicitly set.
>
> KSM default off: merge only when MADV_MERGEABLE is set.
>
> The proposed change won't honor MADV_UNMERGEABLE, meaning that
> application programmers won't have a way to prevent sensitive data to be
> every merged. So, I think, we should keep allow an explicit opt-out
> option for applications.
>

We just did not have VM/Madvise flag for that currently.
Same as THP.
Because all logic written with assumption, what we have exactly 2 states.
Allow/Disallow (More like not allow).

And if we try to add, that must be something like:
MADV_FORBID_* to disallow something completely.

And same for THP
(because currently apps just refuse to start if THP enabled, because of no =
way
to forbid thp).

Thanks.

> >
> > > As far as I know, basically nobody is using KSM at this point. There
> > > are blog posts from several cloud providers about these security risk=
s
> > > that explicitly state that they're not using memory deduplication.
> >
> > I tend to disagree here. Based on both what my company does and what UK=
SM
> > users do, memory dedup is a desired option (note "option" word here, no=
t the
> > default choice).
>
> Lightweight containers is a use case for KSM: when many VMs share the
> same small kernel. KSM is used in production by large cloud vendors.
>
> Thank you,
> Pasha
>
