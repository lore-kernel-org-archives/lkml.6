Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483ABC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E212075B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E212075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933431AbeGIPtF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:49:05 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:39972 "EHLO
        7.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932686AbeGIPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:49:03 -0400
X-Greylist: delayed 4200 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 11:49:03 EDT
Received: from player715.ha.ovh.net (unknown [10.109.122.33])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 82814B757B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 16:29:31 +0200 (CEST)
Received: from bahia.lan (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player715.ha.ovh.net (Postfix) with ESMTPSA id AA9581C00E8;
        Mon,  9 Jul 2018 16:29:21 +0200 (CEST)
Date:   Mon, 9 Jul 2018 16:29:20 +0200
From:   Greg Kurz <groug@kaod.org>
To:     piaojun <piaojun@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        <ericvh@gmail.com>, <rminnich@sandia.gov>, <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [V9fs-developer] [PATCH] net/9p/client.c: put refcount of
 trans_mod in error case in parse_opts()
Message-ID: <20180709162920.2b94916f@bahia.lan>
In-Reply-To: <5B3F39A0.2030509@huawei.com>
References: <5B3F39A0.2030509@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8163618751270197734
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrgedvgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 17:42:56 +0800
piaojun <piaojun@huawei.com> wrote:

> From my test, the second mount will fail after umounting successfully.
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
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

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

