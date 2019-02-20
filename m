Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24E4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845172146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfBTVnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:43:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBTVns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:43:48 -0500
Received: from X1 (unknown [104.133.8.102])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91C742B01;
        Wed, 20 Feb 2019 21:43:47 +0000 (UTC)
Date:   Wed, 20 Feb 2019 13:43:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] mm: fix set but not used warning
Message-Id: <20190220134345.e39094996c111be4ffa0c976@linux-foundation.org>
In-Reply-To: <7425c8905127ddd078500d4c14a2147bd00422a0.camel@hpe.com>
References: <20190218135743.131904-1-yuehaibing@huawei.com>
        <7425c8905127ddd078500d4c14a2147bd00422a0.camel@hpe.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 18:28:30 +0000 "Kani, Toshi" <toshi.kani@hpe.com> wrote:

> On Mon, 2019-02-18 at 13:57 +0000, YueHaibing wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> > 
> > lib/ioremap.c: In function 'ioremap_page_range':
> > lib/ioremap.c:203:16: warning:
> >  variable 'start' set but not used [-Wunused-but-set-variable]
> > 
> > flush_cache_vmap may no need param, so add __maybe_unused fix this warning.
> 
> I think flush_cache_vmap should have a proper prototype with
> __maybe_unused for its args.  But, there are so many arch-specific
> definitions at glace, and I am not sure how manageable such change is,
> though...

This is one of the reasons why things like flush_cache_vmap() should
be implemented as static inline C functions, not as macros.  
