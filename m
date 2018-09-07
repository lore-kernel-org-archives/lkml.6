Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F417C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE4420645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE4420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeIHBXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:23:54 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43255 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeIHBXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:23:54 -0400
Received: by mail-qk1-f193.google.com with SMTP id 130-v6so10511036qkd.10;
        Fri, 07 Sep 2018 13:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3+TnzBzRjl/+q3WNfERb7eXELGhew0G/cSwLCGVnrc=;
        b=f3HIDzV0QaqPIeefgkKZNAlyz4iwtle7m9bMsZZKTPp9xDiUJueeTWJzstOrsdRb1x
         v7Ihseaw9wXsTdaNnX/Wl709WMCNIrq1BcKobLQX94ZFR8cOaz87WULWGiIcRJ/dbibf
         Oa5cTCmKw7Zuc0khS1Ji2bBtccr8xoutXBujxN4tJDkBt4OMCT2DwwLIt45u3CiV1hLp
         7gkWy1VpQvh0xOdcwaQdekdaJifDPOa3Y7yUbfpiw+ZqSjTjuHpkpiAX+5v2HiYrKaAa
         r+VCQYk+6AY+HsdpRVbsIhCMmxIac01H/upA1Tfiq6TAL7qhw8rNZqtJm6e7sND2eODc
         AuVQ==
X-Gm-Message-State: APzg51CV7jxgegaFZdfhsvG+Hom74HIRcFbqPUBssY83nFtXspOX36PT
        1AuUVvgURfqAUoh3vbNP1ATRu/EqyomdInAToBEM6FBI
X-Google-Smtp-Source: ANB0Vda691UUWZ0TClQaX6cLn6+3aUkN9+hg7S88ZUUBb/s9UadGLQ/o8gRnpf09K90Lu8DSgwgw91YMHzbIqo8HVNY=
X-Received: by 2002:a37:1b62:: with SMTP id b95-v6mr6955425qkb.343.1536352876079;
 Fri, 07 Sep 2018 13:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180907192119.4931-1-igor.stoppa@huawei.com>
In-Reply-To: <20180907192119.4931-1-igor.stoppa@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 7 Sep 2018 22:41:00 +0200
Message-ID: <CAK8P3a3u0z+Rkt0=UUG04o-uNC_K1+N=h+_Ucd23N-r2H=fTLg@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: bug: add unlikely() to BUG_ON()
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     igor.stoppa@huawei.com, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 9:21 PM Igor Stoppa <igor.stoppa@gmail.com> wrote:
>
> Add a hint to the compiler.
> If BUG_ON() is used instead of BUG(), it means that probably the
> preferred outcome is to not BUG().
>
> The optimization is disabled, in case CONFIG_PROFILE_ANNOTATED_BRANCHES
> is turned on.

This sounds like a good idea, as this is one of the more likely causes
of false-positive -Wmaybe-uninitialized warnings with
CONFIG_PROFILE_ANNOTATED_BRANCHES

Could you add a comment about -Wmaybe-uninitialized next to the definition?
Otherwise that is easily lost.

Also, I see that the file has two separate definitions of BUG_ON(), and the
other one does have an unlikely() in it already. Can you change both
to do the same thing with unlikely() or not unlikely()?

       Arnd
