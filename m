Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDC1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6A4208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6A4208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeKPHvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 02:51:47 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:39040 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeKPHvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 02:51:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C1B4B608A381;
        Thu, 15 Nov 2018 22:42:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IsAyYCU2jRgk; Thu, 15 Nov 2018 22:42:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7B61E608A38E;
        Thu, 15 Nov 2018 22:42:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nAVEI7qlX_Qx; Thu, 15 Nov 2018 22:42:12 +0100 (CET)
Received: from blindfold.localnet (089144210006.atnat0019.highway.a1.net [89.144.210.6])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id F14D9608A381;
        Thu, 15 Nov 2018 22:42:11 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Garry McNulty <garrmcnu@gmail.com>
Cc:     linux-mtd@lists.infradead.org, dedekind1@gmail.com,
        adrian.hunter@intel.com, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, colin.king@canonical.com
Subject: Re: [PATCH] ubifs: fix memory leak on error condition
Date:   Thu, 15 Nov 2018 22:42:11 +0100
Message-ID: <2181429.CC2M8HkSot@blindfold>
In-Reply-To: <20181115203850.5774-1-garrmcnu@gmail.com>
References: <20181115203850.5774-1-garrmcnu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 15. November 2018, 21:38:50 CET schrieb Garry McNulty:
> If the call to ubifs_read_nnode() fails in ubifs_lpt_calc_hash() an
> error is returned without freeing the memory allocated to 'buf'.
> Jump to 'out' label to free allocated memory and return the error code.
> 
> Detected by CoverityScan, CID 1441025 ("Resource leak")
> 
> Signed-off-by: Garry McNulty <garrmcnu@gmail.com>
> ---
>  fs/ubifs/lpt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
> index d1d5e96350dd..c162459a1e02 100644
> --- a/fs/ubifs/lpt.c
> +++ b/fs/ubifs/lpt.c
> @@ -1688,7 +1688,7 @@ int ubifs_lpt_calc_hash(struct ubifs_info *c, u8 *hash)
>  	if (!c->nroot) {
>  		err = ubifs_read_nnode(c, NULL, 0);
>  		if (err)
> -			return err;
> +			goto out;
>  	}
>  
>  	cnode = (struct ubifs_cnode *)c->nroot;

Please see:
http://lists.infradead.org/pipermail/linux-mtd/2018-October/085081.html

If Colin won't send a v2, please do you so, then I'll take your v2.

Thanks,
//richard


