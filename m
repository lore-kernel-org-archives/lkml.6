Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BEFC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2127721547
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2127721547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeI1PiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:38:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32986 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeI1PiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:38:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id l19-v6so5179879ljb.0;
        Fri, 28 Sep 2018 02:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WcnF3F7yTbM6Ekv77va7TJO2UZb1XKRR5CK9FVW9+N4=;
        b=Y9W+zQTBFa9WOn354SFIHv7oHbbtjRD1T7J46DFea3CV9pfoXbHxsVEQHQxQwvoLBW
         xaywbzCzVRdUqJSNBlK15P+CNDytx/tnOWddtC98W4/NIsDSLsk2RPh5XR+o7kHtbYCg
         WJW9WlKKTJiMFSYGLIyMJDYeCaQnmXLYBl/gkCp4FdybXuhHYm61us0HiOd2RZCKYS/O
         75SL233cCKQ7+DQnblcnIn/rK9F9B2m4yEUydwVgFNkxPCgw8cSsH6EzKCjVl3YnWuOI
         CrXMJNzJ/k/BfaqcodvmGbrf7dF3beHSS9GSNz/22YCfjFomahs09scmR6CFPICckTJC
         aMsQ==
X-Gm-Message-State: ABuFfoglm30WcAybPhbgBjXs/hK0RwCY/HCgd00GpAoyjEN0DzbAyd10
        1P0OGbhO/4qnEKnmLQopUqNPgzO9ODSz/Ze+Ptc=
X-Google-Smtp-Source: ACcGV626odskDM/NcQeBjMN/IFbUqDSnmao35PrLCpIUc2cxHLGvwjgFE56nvYu6V01g5+oLn085zK+BFmPRSvKbLPk=
X-Received: by 2002:a2e:7109:: with SMTP id m9-v6mr3084816ljc.176.1538126133302;
 Fri, 28 Sep 2018 02:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180927101017.990471-1-arnd@arndb.de> <20180927162605.GB28301@ziepe.ca>
In-Reply-To: <20180927162605.GB28301@ziepe.ca>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Sep 2018 11:15:16 +0200
Message-ID: <CAK8P3a0m2WhWKZgMnJuarh5Y3uF-A3Ou228in-0wLg=9bTpMKA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/ucontext: fix building with CONFIG_MMU=n
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Matan Barak <matanb@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, xavier.huwei@huawei.com,
        huyn@mellanox.com, linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 6:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Sep 27, 2018 at 12:10:03PM +0200, Arnd Bergmann wrote:
> > The zap_vma_ptes() is declared but not defined on NOMMU kernels,
> > causing a link error for the newly added uverbs code:
> >
> > drivers/infiniband/core/uverbs_main.o: In function `uverbs_user_mmap_disassociate':
> > uverbs_main.c:(.text+0x114c): undefined reference to `zap_vma_ptes'
> > drivers/infiniband/core/uverbs_main.o: In function `rdma_umap_open':
> > uverbs_main.c:(.text+0x53c): undefined reference to `zap_vma_ptes'
>
> I'm a bit surprised by this - the code is not new, it just got moved
> out of the drivers, and I don't see any protections there against
> CONFIG_MMU ??

I think I just never hit those in my randconfig builds. Out of the three
drivers, one is 64-bit only, and the others depend on PCI. The nommu
configurations I'm testing in randconfig are all 32-bit without PCI.

> > To fix this, we can either make uverbs depend on CONFIG_MMU, or try
> > to build it anyway. Since this is the only compile-time dependency,
> > I decided to allow building it with an extra compile-time check for
> > CONFIG_MMU before calling the one function.
>
> Hrm. So this code doesn't work at all on NOMMU, it relies on
> remap_pfn_range, which always fails on those kernels,
>
> Due to this of this the entirety of INFINIBAND_USER_ACCESS is broken.
>
> I think a kconfig change is the better way to go?

Works for me. Can you just commit that yourself with 'Reported-by:
Arnd Bergmann <arnd@arndb.de>' then?

      Arnd
