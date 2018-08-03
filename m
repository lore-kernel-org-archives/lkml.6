Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58994C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8022174B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8022174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbeHCLsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:48:22 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:53230
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728122AbeHCLsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:48:22 -0400
X-IronPort-AV: E=Sophos;i="5.51,438,1526335200"; 
   d="scan'208";a="274881484"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 11:52:48 +0200
Date:   Fri, 3 Aug 2018 11:52:45 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Finn Thain <fthain@telegraphics.com.au>,
        zhong jiang <zhongjiang@huawei.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi:NCR5380: remove same check condition in
 NCR5380_select
In-Reply-To: <CAHp75Vc8tWKUpKS8yY52CdJ=mU-iqcrUCz32ZSSJixLA1bM0tQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1808031146090.3871@hadrien>
References: <1533179408-20631-1-git-send-email-zhongjiang@huawei.com> <alpine.LNX.2.21.1808031156350.16@nippy.intranet> <CAHp75Vc8tWKUpKS8yY52CdJ=mU-iqcrUCz32ZSSJixLA1bM0tQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2018, Andy Shevchenko wrote:

> On Fri, Aug 3, 2018 at 5:24 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> > On Thu, 2 Aug 2018, zhong jiang wrote:
> >
> >> The same check condition is redundant, so remove one of them.
> >>
> >
> > If you are trying to find redundant code, your coccinelle script is
> > dangerously flawed.
>
> These days too many coccinelle helpers make people think they are
> doing right "clean ups" when in the practice they bring the
> regressions.
>
> Julia, is possible by coccinelle to distinguish memory accesses versus
> I/O? At least it would increase robustness in some cases.

With make coccicheck, the semantic patch should already emit the warning:

//# A common source of false positives is when the argument performs a side
//# effect.

I can modify the rule so that it doesn't report on code that involves
function calls.  It could lose some desirable warnings, where the function
call is just a wrapper for eg extracting some field, but it is probably
safer in practice.

julia
