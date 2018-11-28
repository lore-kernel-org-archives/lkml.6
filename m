Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE46C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E580E205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E580E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeK1PIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:08:35 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49435 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeK1PIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:08:35 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wAS48K1P020178;
        Wed, 28 Nov 2018 05:08:20 +0100
Date:   Wed, 28 Nov 2018 05:08:20 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Yueyi Li <liyueyi@live.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "donb@securitymouse.com" <donb@securitymouse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lzo: fix ip overrun during compress.
Message-ID: <20181128040820.GC19711@1wt.eu>
References: <BLUPR13MB0289FB16D885625827E8DD27DFD00@BLUPR13MB0289.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLUPR13MB0289FB16D885625827E8DD27DFD00@BLUPR13MB0289.namprd13.prod.outlook.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yueyi,

On Tue, Nov 27, 2018 at 10:34:26AM +0000, Yueyi Li wrote:
> It`s possible ip overrun in lzo1x_1_do_compress() when compressed page is
> point to the end of memory and which virtual address is 0xfffffffffffff000.
> Leading to a NULL pointer access during the get_unaligned_le32(ip).

Thanks for this report.

(...)
> diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
> index 236eb21..a0265a6 100644
> --- a/lib/lzo/lzo1x_compress.c
> +++ b/lib/lzo/lzo1x_compress.c
> @@ -17,6 +17,9 @@
>  #include <linux/lzo.h>
>  #include "lzodefs.h"
>  
> +#define OVERFLOW_ADD_CHECK(a, b)  \
> +	((size_t)~0 - (size_t)(a) < (size_t)(b) ? true : false)
> +

I think the test would be easier to grasp this way :

#define OVERFLOW_ADD_CHECK(a, b)  \
	((size_t)(b) >= (size_t)((void*)0 - (void *)(a)))

But the following should be more efficient since we build with
-fno-strict-overflow :

#define OVERFLOW_ADD_CHECK(a, b)  \
	(((a) + (b)) < (a))

Could you please recheck ?

Thanks,
Willy
