Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9AFC5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDF02083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="vhjM9V1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDF02083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755295AbeFSURn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:17:43 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:45017 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757228AbeFSURj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:17:39 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 182e06ba
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jun 2018 20:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=fEj4HqSui3qOP1cUbOyKtmCt/MA=; b=vhjM9V
        1wI7qQkFZ9yDT9P+WojCdmnAvGtaXw5sBrmjZAyvScaytFJLhAx63wK310WY8KUe
        KJZB31+TiDpn98jeuBFI/nzeGDIbz4tXVB20RLoz7kkkeLKFocvSIcI6KrjgioWW
        5Ixi1Jy8bgrHUTPBQTTdIbs02/oEA/BQE1xAxNNYVgHB2Bsejpt9fENx8fOPIShp
        WhDPQvV+C7BNZ4PejzKxwkIFlmNuhI/BCxjKpUAn4euzf+L+4epGYMcPDuVnlBpB
        tg098HNeIvhPVWJ+jeBAYlAvA5byyaBCNxtdUdjfwbo8yI6xuNSP/lD2d6waeKYE
        Nr8idXV1yadZTQTA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e8c41eb3 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jun 2018 20:11:43 +0000 (UTC)
Received: by mail-ot0-f181.google.com with SMTP id a5-v6so1118012otf.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:17:37 -0700 (PDT)
X-Gm-Message-State: APt69E3m0/doioaa4lvhCWkj8Ann/7srA2rwCaGs9ffavktGr+8rW0Gf
        qzyprT0vxjGqdvl1vrlzKs75Y4i2JybkEQimf8s=
X-Google-Smtp-Source: ADUXVKJPP0JkcM2yOIxIkRFo3cF1ECIVKp75CpEBmKPIur4YKZidOR0pv4pE9Y5W3An+s6gylIxxs+P1B99LhzVezS8=
X-Received: by 2002:a9d:59ed:: with SMTP id u45-v6mr11826490otg.320.1529439456834;
 Tue, 19 Jun 2018 13:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
 <46ca5661-4bd1-6733-0140-d6e6dea1ab33@virtuozzo.com>
In-Reply-To: <46ca5661-4bd1-6733-0140-d6e6dea1ab33@virtuozzo.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 19 Jun 2018 22:17:25 +0200
X-Gmail-Original-Message-ID: <CAHmME9qqsgz2faVP8FTbJvKTzX-5qQU1aHGbkzT6b05PZ4nkuw@mail.gmail.com>
Message-ID: <CAHmME9qqsgz2faVP8FTbJvKTzX-5qQU1aHGbkzT6b05PZ4nkuw@mail.gmail.com>
Subject: Re: Possible regression in "slab, slub: skip unnecessary kasan_cache_shutdown()"
To:     aryabinin@virtuozzo.com
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Tue, Jun 19, 2018 at 7:33 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> What's the status of CONFIG_SLUB_DEBUG in your config?
>
> AFAICS __kmem_cache_empty() is broken for CONFIG_SLUB_DEBUG=n. We use slabs_node() there
> which is always 0 for CONFIG_SLUB_DEBUG=n.
>
> The problem seems not limited to __kmem_cache_empty(), __kmem_cache_shutdown() and __kmem_cache_shrink()
> are also rely on correctness of the slabs_node(). Presumably this might cause some problems while
> destroying memcg kmem caches.

CONFIG_SLUB_DEBUG is not set in the crash I sent.

Enabling it "fixes" the problem! This either means that KASAN+SLUB
should enable SLUB_DEBUG, or the extra overhead from SLUB_DEBUG is
just making the bug more rare but not actually eliminating it.

Jason
