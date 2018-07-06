Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3DDC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED69521EF9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED69521EF9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934573AbeGFTKr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:10:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55833 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932999AbeGFTKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:10:45 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbW7q-0003d0-4j; Fri, 06 Jul 2018 21:10:38 +0200
Date:   Fri, 6 Jul 2018 21:10:37 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arch@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] devres: Really align data field to unsigned long long
In-Reply-To: <20180706171504.10265-1-abrodkin@synopsys.com>
Message-ID: <alpine.DEB.2.21.1807062109370.1592@nanos.tec.linutronix.de>
References: <20180706171504.10265-1-abrodkin@synopsys.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018, Alexey Brodkin wrote:

> It looks like on most of architectures "data" member of devres struture
> gets aligned to 8-byte "unsigned long long" boundary as one may expect:
> if we don't explicitly pack a structure then natural alignment
> (which matches each member data type) is used.
> 
> But at least on 32-bit ARC architecture ABI requires "long long" types
> to be aligned by normal 32-bit word. This makes "data" field aligned to
> 12 bytes. This is still OK as long as we use 32-bit data only.
> 
> But once we want to use native atomic64_t type (i.e. when we use special
> instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> misaligned access exception.
> 
> That's because even on CPUs capable of non-aligned data access LL/SC
> instructions require strict alignment.
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/base/devres.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index f98a097e73f2..35ddc8b66bc9 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -25,7 +25,7 @@ struct devres_node {
>  struct devres {
>  	struct devres_node		node;
>  	/* -- 3 pointers */
> -	unsigned long long		data[];	/* guarantee ull alignment */

Pretty please put a big fat comment here so that the innocent reader does
not start to wonder.

> +	unsigned long long		data[] __aligned(sizeof(unsigned long long));
>  };

Thanks,

	tglx
