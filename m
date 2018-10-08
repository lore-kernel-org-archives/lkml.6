Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A220C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7A92145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7A92145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wand.net.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeJIBhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:37:37 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:34369 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeJIBhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:37:37 -0400
Received: by mail-qt1-f171.google.com with SMTP id o17-v6so6047456qtr.1;
        Mon, 08 Oct 2018 11:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzYHC3xKOHawKbR+h1mRy77otqwJGD6Kk1BNMZe0X6s=;
        b=sbvLhGCgAYqa7MTLtJGtyrw94NWcEFYuLtCA0Y7n9vevL88+PBPU3c8twBaEcAq2rm
         zihzfsSWwwkMkN+Iwn5Bi2yKQLOWWU72w6F4VfGzm5ueQ27F+QMHcWY2zHE58erscg67
         mq4yD1HNuSWnjW3zkYEN43K6nk93qIGF7RwEZ3aRO6TeGNCI7OOmACWJgHpgYco8d3Lj
         sQVXFO55sBOgukUODv3Chkmog/iYtH36sJAVvLcvAtnl1+QgyUGznU0V6c1cNeCTS2UY
         vvE2W/EH9qB80t9Hd7KKWGDLctKHPHNiwEYy6RwIyGMnJOQQCZkahDsuP8LcGUsvKlm/
         sOQw==
X-Gm-Message-State: ABuFfojVkc5QnMMegNYy3Sesr4fb82Wuh3z7oQvPNnTGjGc90XnCb0Nt
        08fwh3M8QJgn1Bf4BEUxY3OKMKRt5sfCfzrTD8A=
X-Google-Smtp-Source: ACcGV63HEmN8UmAqsmX62ucfNW3XfCWIEBKHToFVTGfx7NhH/Eb02jC1OTamz7kkodaE93a8Cv/6RY51XO23gITDSJo=
X-Received: by 2002:a05:6214:114e:: with SMTP id b14mr19833457qvt.169.1539023077412;
 Mon, 08 Oct 2018 11:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181005161526.843924-1-arnd@arndb.de> <CAPhsuW7pg9Wp5am3Kc1t3UoAG1=EYzUeq8E2k7Pmv8yGu9JaEQ@mail.gmail.com>
 <c4b5f1af-075a-4166-4108-81acda663970@iogearbox.net> <9330215e-27bf-9913-f7f9-6b5b83542a27@iogearbox.net>
In-Reply-To: <9330215e-27bf-9913-f7f9-6b5b83542a27@iogearbox.net>
From:   Joe Stringer <joe@wand.net.nz>
Date:   Mon, 8 Oct 2018 11:24:25 -0700
Message-ID: <CAOftzPiEcj7HaqE0yXO_BjYqwT1_NYd69PCwbLBGx5hfJzO1mg@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix building without CONFIG_INET
To:     daniel@iogearbox.net
Cc:     liu.song.a23@gmail.com, arnd@arndb.de, ast@kernel.org,
        David Miller <davem@davemloft.net>,
        john fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        makita.toshiaki@lab.ntt.co.jp, brakmo@fb.com, rdna@fb.com,
        Jesper Brouer <brouer@redhat.com>,
        jakub.kicinski@netronome.com, m.xhonneux@gmail.com,
        dsahern@gmail.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 at 01:41, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 10/05/2018 09:07 PM, Daniel Borkmann wrote:
> > On 10/05/2018 09:02 PM, Song Liu wrote:
> > [...]
> >> BPF_CALL_x() has static already (before this patch). We should not
> >> need change that
> >> for all the BPF_CALL_?(). Joe's version looks better to me.
> >
> > My preference as well, thanks!
>
> ping, can someone send an updated patch?

I will send a fresh version shortly.
