Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF47ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8711020658
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8711020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJQXEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:04:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46314 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeJQXEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:04:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id q12-v6so16649937qkl.13;
        Wed, 17 Oct 2018 08:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oi+R2yoDz1QlzfJFv+rn3szB8dJAdsRW/VqTOYNFUH0=;
        b=OE7+uRaGGzuTVtBd6gMRgVHXUrM+I/dYlhjBDAPJMNd5bpCmsKs5W4wWQ2y0ERk+RM
         PvHd2EkoLJvAJznjKVrGkzzHQo3qe/jxVUCk8kPfVbXSibBqu8ePIQkJqLG3R99+AOX4
         +PvEF4M+plqDhkpDUwST9vcNxSdBRTyXWIBrIvz18/rZsXlIabXs82tygsCDxlLmNp1S
         4FLs873VLhmz0PPeF6+CaC/o1AyDdJzWGTelhbU0a2Dbc8oO+OrxP2mioVMNgTl8LJH1
         Z5F/zf+3PwZOjn9DMiygldi8A+AiiQZLuxx9+mF6XyWl7sLq/6Tf+Oya3S/AQ5wzXLWw
         RTgw==
X-Gm-Message-State: ABuFfoijeEm5c+Z8E4LzNLuhICv1UAqBbwgzgTay/pJ0UbKXcQ61MPUM
        5yreczm8QAaVkkOo9AvVDIBDdoi7MfvTKHpMfks=
X-Google-Smtp-Source: ACcGV63OE8vKLHbQOpGsBNmUl532n4g8rwx/+CPQGRQJLmnb6v7/7rkJyqsw9og+pdmU7+73uyyLaoe4xlG+d8+6l2A=
X-Received: by 2002:a37:2b66:: with SMTP id r99-v6mr2809463qkh.343.1539788922568;
 Wed, 17 Oct 2018 08:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <e078ec6a6ae8f116ac2ca381a92c81630e6b70f0.1539655731.git.ren_guo@c-sky.com>
In-Reply-To: <e078ec6a6ae8f116ac2ca381a92c81630e6b70f0.1539655731.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:08:26 +0200
Message-ID: <CAK8P3a2Wnq-nBaXjz=_YxN5+XPCEYqO6akPe-7KGOiBui69FaA@mail.gmail.com>
Subject: Re: [PATCH V9 06/21] csky: Cache and TLB routines
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds cache and tlb sync codes for abiv1 & abiv2.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
