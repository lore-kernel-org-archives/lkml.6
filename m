Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7872824F77
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7872824F77
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeGCCyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:54:04 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49160 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753805AbeGCCyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:54:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07979855|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CLXqNEC_1530586430;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CLXqNEC_1530586430)
          by smtp.aliyun-inc.com(10.147.42.16);
          Tue, 03 Jul 2018 10:53:51 +0800
Date:   Tue, 3 Jul 2018 10:53:50 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 07/19] csky: MMU and page table management
Message-ID: <20180703025348.GA32371@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <d07f919cb41ebb500c2e6f6defa6ea5760c22dc5.1530465326.git.ren_guo@c-sky.com>
 <20180702132915.GA6578@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180702132915.GA6578@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 06:29:15AM -0700, Christoph Hellwig wrote:
> This commit is missing an explanation.
 The patch is for abiv1 & abiv2 CPU series' MMU support.
  - abiv1 CPU (CK610) is VIPT cache and it doesn't support highmem.
  - abiv2 CPUs are all PIPT cache and they could support highmem.
 We seperate abiv1 and abiv2 into two direcotries for coding convention. 

> For the dma-mapping code please use the generic kernel/dma/noncoherent.c
> code instead of duplicating it.
 Thx for the tips and I think you mean the lib/dma-noncoherent.c in the
 lastest kernel source and not in linux-4.16.2.

 I'll rebase on the newest RC version of linux in next version patch and
 reuse the code in lib/dma-noncoherent.c.

 Current csky_dma_alloc implementation is not good, it use 512MB uncached
 area to mirror the Normal cachable-512MB area. In next version patch,
 we will increase the max-Normal memory zone to (1GB + 768MB).
 In csky_dma_alloc we will seperate the atomic_dma and non-atomic_dma
 and reserve the area in fixmap area.

 Here is my memory layout plan in next version patch:
   Fixmap	: 0xffc02000 – 0xfffff000       (4 MB - 12KB) kmap_atomic, dma_atomic ...
   Pkmap	: 0xff800000 – 0xffc00000	(4 MB)        PTR_PER_PTE = 1024
   Vmalloc	: 0xf0200000 – 0xff000000       (238 MB)      max: 238MB + 256MB + 1GB
   Lowmem	: 0x80000000 – 0xf0000000	(1G + 768 MB)

 Guo Ren
