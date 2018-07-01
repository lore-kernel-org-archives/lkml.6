Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29290C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50B625B7A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50B625B7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeGASwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:52:15 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:47114
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752328AbeGASwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 14:52:13 -0400
X-IronPort-AV: E=Sophos;i="5.51,295,1526335200"; 
   d="scan'208";a="271085121"
Received: from 89-157-201-3.rev.numericable.fr (HELO [192.168.0.15]) ([89.157.201.3])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2018 20:51:55 +0200
Date:   Sun, 1 Jul 2018 20:51:55 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     linux-usb@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 0/3] cast sizeof to int for comparison
In-Reply-To: <653914f26dc8433a3f682b5e7eb850ab94bd431d.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1807012050530.2494@hadrien>
References: <1530466325-1678-1-git-send-email-Julia.Lawall@lip6.fr> <653914f26dc8433a3f682b5e7eb850ab94bd431d.camel@perches.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 1 Jul 2018, Joe Perches wrote:

> On Sun, 2018-07-01 at 19:32 +0200, Julia Lawall wrote:
> > Comparing an int to a size, which is unsigned, causes the int to become
> > unsigned, giving the wrong result.
> >
> > The semantic match that finds this problem is as follows:
> > (http://coccinelle.lip6.fr/)
>
> Great, thanks.
>
> But what about the ones in net/smc like:
>
> > net/smc/smc_clc.c:
> >
> >         len = kernel_sendmsg(smc->clcsock, &msg, &vec, 1,
> >                              sizeof(struct smc_clc_msg_decline));
> >         if (len < sizeof(struct smc_clc_msg_decline))
>
> Are those detected by the semantic match and ignored?

I wasn't sure how to justify that kernel_sendmsg returns a negative value.
If it is the case, I can send the patch.  I only found this in one file,
but there were multiple occurrences.

julia
