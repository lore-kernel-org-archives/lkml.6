Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D95C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CE32086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="aB0PRChr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CE32086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeIKBB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:01:28 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:34563 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbeIKBB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:01:28 -0400
Received: by mail-pl1-f181.google.com with SMTP id f6-v6so10245188plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OlHD2rrGBV6b0MGnrLFYcoHFj7xvql2uwUrV0URvZI4=;
        b=aB0PRChrYVT1hwRsnct4dFvPyD+MpiktEFU4WkIb95If5Bs5wQEY1e/p7H31/hMa+f
         j7mikckJ1qhkHMoPiGSUSEjttBw3EDXsTzHGnG9B31AlB+CGvdHfnr/+9UfZxnxJzGS3
         EM2dgLtcnk6rB4fDL6tkOF6SbwPQRwqZn3wFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OlHD2rrGBV6b0MGnrLFYcoHFj7xvql2uwUrV0URvZI4=;
        b=hf654+BKbP2b1LU2sVurfZbnmAkduIiCfO8ZO2lgTVkWJMHw5JedYpKVKRTrWaLb+H
         7ZRYhJPZ7/Hrzepd/v34Rjsqt8Sbs51WHVxLE3YkqUAol+Eb3AmWc9bSkUjXZDcjGRKq
         VwdV+0tSHgkvg9SSdH0q4Jo/azGJDoZ1XwmEIjuxVuRn8pTXeZ3GvkwhnkUiQ2l5lDhr
         tvwRxXjgP5mmpwI13/ppH91UlNgR887x/GzQIcmiLmjzevPN3Jbzq/WydZWkZexNdiij
         RYyrEKXWKvCjdvUo+Fl87Kj9V+4F0iUrUCdO1/tyBoEQVYR7QpJfSQC8UCD7K+RSPIZk
         4YGw==
X-Gm-Message-State: APzg51ALA+OL9xhZEW1+nyJazESGZMELg8fSDsnQnC2BP3uh7nKEp66c
        sw7uXoBgU6SaXpztRV92CFUgXw==
X-Google-Smtp-Source: ANB0VdbG6j7zXcsewpyyF1ug1vYUUclu9+K9G4Obk0JwaGdLDofCK94Po8tfx7o2s4yWPzVjkeB65A==
X-Received: by 2002:a17:902:7e06:: with SMTP id b6-v6mr24044011plm.230.1536609944613;
        Mon, 10 Sep 2018 13:05:44 -0700 (PDT)
Received: from ?IPv6:2600:1010:b01a:2c7b:2c15:2527:16b2:76b4? ([2600:1010:b01a:2c7b:2c15:2527:16b2:76b4])
        by smtp.gmail.com with ESMTPSA id h190-v6sm26477662pge.18.2018.09.10.13.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 13:05:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: How to handle PTE tables with non contiguous entries ?
From:   Dan Malek <dan.malek@konsulko.com>
In-Reply-To: <ddc3bb56-4da0-c093-256f-185d4a612b5c@c-s.fr>
Date:   Mon, 10 Sep 2018 13:05:41 -0700
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <98C61C92-0D24-41C6-B9DA-8335B34D3B07@konsulko.com>
References: <ddc3bb56-4da0-c093-256f-185d4a612b5c@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Cristophe.

> On Sep 10, 2018, at 7:34 AM, Christophe Leroy =
<christophe.leroy@c-s.fr> wrote:
>=20
> On the powerpc8xx, handling 16k size pages requires to have page =
tables with 4 identical entries.

Do you think a 16k page is useful?  Back in the day, the goal was to =
keep the fault handling and management overhead as simple and generic as =
possible, as you know this affects the system performance.  I understand =
there would be fewer page faults and more efficient use of the MMU =
resources with 16k, but if this comes at an overhead cost, is it really =
worth it?

In addition to the normal 4k mapping, I had thought about using 512k =
mapping, which could be easily detected at level 2 (PMD), with a single =
entry loaded into the MMU.  We would need an aux header or something =
from the executable/library to assist with knowing when this could be =
done.  I never got around to it. :)

The 8xx platforms tended to have smaller memory resources, so the 4k =
granularity was also useful in making better use of the available space.

> Would someone have an idea of an elegent way to handle that ?

My suggestion would be to not change the PTE table, but have the fault =
handler detect a 16k page and load any one of the four entries based =
upon miss offset.  Kinda use the same 4k miss hander, but with 16k =
knowledge.  You wouldn=E2=80=99t save any PTE table space, but the MMU =
efficiency may be worth it.  As I recall, the hardware may ignore/mask =
any LS bits, and there is PMD level information to utilize as well.

It=E2=80=99s been a long time since I=E2=80=99ve investigated how things =
have evolved, glad it=E2=80=99s still in use, and I hope you at least =
have some fun with the development :)

Thanks.

	=E2=80=94 Dan

