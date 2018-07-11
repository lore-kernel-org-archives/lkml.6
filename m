Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE5BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DB7208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DB7208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbeGKFuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:50:32 -0400
Received: from nautica.notk.org ([91.121.71.147]:55094 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbeGKFuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:50:32 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id AF7FBC009; Wed, 11 Jul 2018 07:47:55 +0200 (CEST)
Date:   Wed, 11 Jul 2018 14:47:40 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     piaojun <piaojun@huawei.com>, ericvh@gmail.com,
        rminnich@sandia.gov, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [V9fs-developer] [PATCH] net/9p/client.c: put refcount of
 trans_mod in error case in parse_opts()
Message-ID: <20180711054740.GA932@nautica>
References: <5B3F39A0.2030509@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B3F39A0.2030509@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

there seem to be some renew of interest in 9P lately, so if you'd like I
can take care of rounding these up and prepare a pull request for 4.19
(as we're already well into 4.18 release cycle, I believe most of the
patches can wait)

This patch however I consider important enough to take for 4.18 so could
you please grab it for now?

I've gathered the Review tags and added my own, feel free to change my
Reviewed-and-tested-by tag to Signed-off-by if it seems more appropriate
as I'm actively pushing for this patch.

piaojun wrote on Fri, Jul 06, 2018:
> >From my test, the second mount will fail after umounting successfully.
> The reason is that we put refcount of trans_mod in the correct case rather
> than the error case in parse_opts() at last. That will cause the refcount
> decrease to -1, and when we try to get trans_mod again in
> try_module_get(), we could only increase refcount to 0 which will cause
> failure as follows:
> parse_opts
>   v9fs_get_trans_by_name
>     try_module_get : return NULL to caller which cause error
> 
> So we should put refcount of trans_mod in error case.
> 
> Fixes: 9421c3e64137ec ("net/9p/client.c: fix potential refcnt problem of trans module")
> 
> Signed-off-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Yiwen Jiang <jiangyiwen@huawei.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-and-tested-by: Dominique Martinet <dominique.martinet@cea.fr>

> ---
>  net/9p/client.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 18c5271..5c13431 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -225,7 +225,8 @@ static int parse_opts(char *opts, struct p9_client *clnt)
>  	}
> 
>  free_and_return:
> -	v9fs_put_trans(clnt->trans_mod);
> +	if (ret)
> +		v9fs_put_trans(clnt->trans_mod);
>  	kfree(tmp_options);
>  	return ret;
>  }

Thanks,
-- 
Dominique Martinet
