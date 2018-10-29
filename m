Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8880FC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CAB2082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CAB2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeJ3IXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:23:38 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:39066 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJ3IXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:23:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6E933606C479;
        Tue, 30 Oct 2018 00:32:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id J746DFsO6ZnN; Tue, 30 Oct 2018 00:32:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2F4E5606C49E;
        Tue, 30 Oct 2018 00:32:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l9WdZMl7gpyZ; Tue, 30 Oct 2018 00:32:37 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id D4A00606C479;
        Tue, 30 Oct 2018 00:32:36 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Colin King <colin.king@canonical.com>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ubifs: authentication: fix memory leak on error exit path
Date:   Tue, 30 Oct 2018 00:32:36 +0100
Message-ID: <2101590.OYyDjomelk@blindfold>
In-Reply-To: <20181029232146.21262-1-colin.king@canonical.com>
References: <20181029232146.21262-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. Oktober 2018, 00:21:46 CET schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently a failure when calling ubifs_read_nnode results in a leak
> of desc and buf because of a direct return. Fix this by exiting via
> label 'out' that performs the necessary free'ing of the resources.
> 
> Fixes: a1dc58140f7e ("ubifs: authentication: Authenticate LPT")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
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

IMHO a better fix would be reading the root node before allocating these buffers.

Thanks,
//richard


