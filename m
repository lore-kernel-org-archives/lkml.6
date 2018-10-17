Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6140BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3043320869
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3043320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJQW4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:56:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39548 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQW4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:56:18 -0400
Received: by mail-qk1-f193.google.com with SMTP id q5-v6so16655597qki.6;
        Wed, 17 Oct 2018 08:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5IcSosKhwmM1grupgmcgVGQMpGRKtdK3cJCENFmoENw=;
        b=p/rLMyVFH+sx1t3DsLOZOnKTyhvi6B7RSTdsp6w7AizZhN6MZutzEuCjb2mzkVuwgE
         fji4H5MDBwudD3nMxLpkP5ek8N+aKRWE/l8fLfEJKqPcDABdrW82r2XOJtXl5lI5qBiJ
         MxDZGyxvX8nP4ReVarXSIMk1pdCmXM34vXtF+3mmrexPTdMIfL2AFlh0wd2hzQ/w/haQ
         ukWfeYN250HTnO78OFF5Bu0v1qXqmcPtC4Q3mCkoNRas6AQ578KGMmEA7kF1Xd0RKx4V
         aE7XzQbV4DDjy1IWXgv+cn4kYNAlheF29wLsUuMkFLi6l3m3uFJ7jqVZstBX7EmHd2Ui
         Udbg==
X-Gm-Message-State: ABuFfoi6gDxCxMWEaDHRdmxGDWSSY9AMs8OG+IO8gbNUvrYed1vY2+/q
        PB8ba5gbv55c4RgLpfp9X6CBdZ/pWmhF8etEuso=
X-Google-Smtp-Source: ACcGV62S/nEczq9yZtoTJwcV0Y4St3aoK6LD4homh6edY8DmoAllBHg9DW+aTsK93Jq0Tkv1JyIs3S+6CNTLLGqJucA=
X-Received: by 2002:ae9:d801:: with SMTP id u1-v6mr24999280qkf.291.1539788412411;
 Wed, 17 Oct 2018 08:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <22dbcb592386b5f124b16a304315b70da70ed58d.1539655731.git.ren_guo@c-sky.com>
In-Reply-To: <22dbcb592386b5f124b16a304315b70da70ed58d.1539655731.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 16:59:56 +0200
Message-ID: <CAK8P3a3xf_s3s=EH-QTVEYo7yJm=GXVD1FEFC9wpxx4BFgP2Qg@mail.gmail.com>
Subject: Re: [PATCH V9 04/21] csky: Exception handling and mm-fault
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
> This patch adds exception handling code, cpuinfo and mm-fault code.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
