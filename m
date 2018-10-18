Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADFCECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A512083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A512083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeJRKEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:04:54 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49103 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727307AbeJRKEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:04:54 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08180991|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l10423;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.D3i0F6V_1539828369;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D3i0F6V_1539828369)
          by smtp.aliyun-inc.com(10.147.41.121);
          Thu, 18 Oct 2018 10:06:09 +0800
Date:   Thu, 18 Oct 2018 10:05:54 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
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
Subject: Re: [PATCH V9 07/21] csky: MMU and page table management
Message-ID: <20181018020552.GB12027@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <783a90d35138634a1cb899e2c551c96f3b5178af.1539655731.git.ren_guo@c-sky.com>
 <CAK8P3a1ME=1Gb1d_q_+9zP4bLr9wJC7hmEv4KGCt5GN6dG5F8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1ME=1Gb1d_q_+9zP4bLr9wJC7hmEv4KGCt5GN6dG5F8g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 05:06:56PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > This patch adds files related to memory management and here is our
> > memory-layout:
> >
> >    Fixmap       : 0xffc02000 – 0xfffff000       (4 MB - 12KB)
> >    Pkmap        : 0xff800000 – 0xffc00000       (4 MB)
> >    Vmalloc      : 0xf0200000 – 0xff000000       (238 MB)
> >    Lowmem       : 0x80000000 – 0xc0000000       (1GB)
> >
> > abiv1 CPU (CK610) is VIPT cache and it doesn't support highmem.
> > abiv2 CPUs are all PIPT cache and they could support highmem.
> >
> > Lowmem is directly mapped by msa0 & msa1 reg, and we needn't setup
> > memory page table for it.
> >
> > Link:https://lore.kernel.org/lkml/20180518215548.GH17671@n2100.armlinux.org.uk/
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Christoph had all the useful comments on this one, I just checked that I didn't
> spot anything beyond that.
Yes, Christoph help a lot and find a critical bug of "sync_dma > 4K".

Best Regards
 Guo Ren
