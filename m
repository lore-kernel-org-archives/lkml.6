Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F90C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470EE2175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470EE2175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbeHNAuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:50:25 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:36329 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbeHNAuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:50:25 -0400
Received: by mail-qt0-f177.google.com with SMTP id t5-v6so19205002qtn.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 15:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtF1QubMFqNWaECATqGPj9SPzADQYaM49xGkyExDP0E=;
        b=Zdo38uYz3w8obNeSsPn1o72xR9QXVrO0tWGL8Ak9uywkDE/HQXopO/b+NGsqusvr5N
         TWXYAla81Xie/4TQT4mXUg6Vuo13S+LuqsZhyLIVDm8kq10hmEFuTpilEyIw6nrNA4nR
         EXq/Sk5LReJ2Z5X9GA91drhaASip2ZUfDYvFjkUl53j8XiJVxKp3SwnxZ8wbmnIBAYGx
         cewVEyNJRO6yd+MmiKfAKR7X3DV7vzg+lzwc1aCfCFPkfxfQvEHgcpApK67lV4XVo+Uw
         ZZY7owjIwc+ckKKJJsWBLklJhqQQetkO2RH3Xx/QR5zpw6KL5zrzabVvAkLU/xKdkenf
         57pw==
X-Gm-Message-State: AOUpUlGkAJrqZpsHH91d6EHC2VN2yqnjW4X56fvUhHMeaVIvw6na+o2j
        a3U4Fif7/x8N7UHr4wOJz349scQ7vpsKan9NM94=
X-Google-Smtp-Source: AA+uWPyFAhrR4dNOhp5OeETAuGqPUU8jrDQ9SiU8QxmtOAHiKRQqwoTSqHehyBI3gJZNXH1bhIcW0/treJ+2nr9Px3Q=
X-Received: by 2002:a0c:f804:: with SMTP id r4-v6mr16852150qvn.156.1534197976126;
 Mon, 13 Aug 2018 15:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180813215546.3828228-1-arnd@arndb.de> <CA+7y87rkaP5CAd4ionPLvOuoJDbnzbUL-C=E-FaSj7yjde8Lmw@mail.gmail.com>
In-Reply-To: <CA+7y87rkaP5CAd4ionPLvOuoJDbnzbUL-C=E-FaSj7yjde8Lmw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Aug 2018 00:05:59 +0200
Message-ID: <CAK8P3a1-GQr9PDVZ-qs0qH36TifUfrroiXcfOhRBe6e5k-+SZA@mail.gmail.com>
Subject: Re: [PATCH] cpumask: provide a dummy cpumask_next_wrap
To:     caraitto@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Willem de Bruijn <willemb@google.com>,
        David Miller <davem@davemloft.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, rakib.mullick@gmail.com,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        mhkelley@outlook.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 12:02 AM Caleb Raitto <caraitto@google.com> wrote:
>
> On Mon, Aug 13, 2018 at 2:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > The virtio_net driver has become the first one to call cpumask_next_wrap()
> > even if CONFIG_SMP is disabled, leading to a build error:
> >
> > drivers/net/virtio_net.c: In function 'virtnet_set_affinity':
> > drivers/net/virtio_net.c:1916:10: error: implicit declaration of function 'cpumask_next_wrap'; did you mean 'cpumask_next_and'? [-Werror=implicit-function-declaration]
> >     cpu = cpumask_next_wrap(cpu, cpu_online_mask,
> >
> > Add a stub function along the lines of cpumask_first(), cpumask_next() etc.
> > I'm not entirely sure what should be returned in this case, but at
> > least for virtio_net, anything should work.
>
> Sorry about the build break, I think this patch with a fix was already merged:
>
> cpumask: make cpumask_next_wrap available without smp
> https://patchwork.ozlabs.org/patch/956670/

Ok, that's also a better fix than mine I think.

Thanks,

        Arnd
