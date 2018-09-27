Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475C1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011E2216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oadP9o8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011E2216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeI0WIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:08:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0WIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qbl3MZG426+uGw66PUdG8bAVafzssb1PzEQKj8BNjHM=; b=oadP9o8wQXoIsYKBOEQ7pF+Cn
        2sYCOkzs7dOhLBQM+RnHzyFvrEFMwd5oHovv9mIuJsKgEm6sWDHS7/SeKtScm71E7JHlO8yE6Apap
        8r+t7NNfZsnUJ+Wj2Xdw4meJVdq8/rMH5c4/HMK2lj6uyKLXeosEtopICcXUeeuol1VxXN16osMTi
        lMtSRZ4+4VKumiXXEEgYbcJ7Faj0XxuoNp3EDsKzszWBRggIx8ViOqrknMGlV069SL7a12i7FZPtX
        veO4P225FcoGOhNxPOcSgNaB9Le+QHCf5E2XYsfWL1cIKq0WH1jq9xuXv5z/gKTATq1osihQgzTJa
        69kOB57kg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5YXX-0006j5-03; Thu, 27 Sep 2018 15:49:19 +0000
Date:   Thu, 27 Sep 2018 08:49:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com
Subject: Re: [PATCH V6 10/33] csky: IRQ handling
Message-ID: <20180927154918.GB15985@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <fbb4e798d1588e9df2da16818932747430068baf.1538058840.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb4e798d1588e9df2da16818932747430068baf.1538058840.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- /dev/null
> +++ b/arch/csky/include/asm/irq.h
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#ifndef __ASM_CSKY_IRQ_H
> +#define __ASM_CSKY_IRQ_H
> +
> +#include <asm-generic/irq.h>
> +
> +#endif /* __ASM_CSKY_IRQ_H */

Just wire this up using generic-y in the Kbuild file instead of
creating a wrapper.  (Same for any other header which is a trivial
asm-generic wrapper).
