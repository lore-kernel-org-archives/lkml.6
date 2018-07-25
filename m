Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDE6C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0277A20856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0277A20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeGYEl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 00:41:56 -0400
Received: from nautica.notk.org ([91.121.71.147]:51309 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbeGYElz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 00:41:55 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 87AC8C009; Wed, 25 Jul 2018 05:32:15 +0200 (CEST)
Date:   Wed, 25 Jul 2018 05:32:00 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net, groug@kaod.org
Subject: Re: [PATCH] fs/9p/xattr.c: catch the error of p9_client_clunk when
 setting xattr failed
Message-ID: <20180725033200.GA29865@nautica>
References: <5B57EACC.2060900@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B57EACC.2060900@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Wed, Jul 25, 2018:
> In my testing, v9fs_fid_xattr_set will return successfully even if the
> backend ext4 filesystem has no space to store xattr key-value. That will
> cause inconsistent behavior between front end and back end. The reason is
> that lsetxattr will be triggered by p9_client_clunk, and unfortunately we
> did not catch the error. This patch will catch the error to notify upper
> caller.
> 
> p9_client_clunk (in 9p)
>   p9_client_rpc(clnt, P9_TCLUNK, "d", fid->fid);
>     v9fs_clunk (in qemu)
>       put_fid
>         free_fid
>           v9fs_xattr_fid_clunk
>             v9fs_co_lsetxattr
>               s->ops->lsetxattr
>                 ext4_xattr_user_set (in host ext4 filesystem)
> 
> Signed-off-by: Jun Piao <piaojun@huawei.com>

Good catch!

LGTM on its own but see comment below for further error checking.
Please let me know if you want to do this in a v2 or submit a separate
patch altogether, I can pick this one up as it is.

> ---
>  fs/9p/xattr.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
> index f329eee..352abc3 100644
> --- a/fs/9p/xattr.c
> +++ b/fs/9p/xattr.c
> @@ -105,7 +105,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
>  {
>  	struct kvec kvec = {.iov_base = (void *)value, .iov_len = value_len};
>  	struct iov_iter from;
> -	int retval;
> +	int retval, err;
> 
>  	iov_iter_kvec(&from, WRITE | ITER_KVEC, &kvec, 1, value_len);
> 
> @@ -126,7 +126,9 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
>  			 retval);
>  	else
>  		p9_client_write(fid, 0, &from, &retval);

I'm not sure what to do about this but it's also possible for
p9_client_write to not write the full length without setting and error.

We should probably compare the return value of p9_client_write and
value_len to detect short writes and return an error in this case.

> -	p9_client_clunk(fid);
> +	err = p9_client_clunk(fid);
> +	if (!retval && err)
> +		retval = err;
>  	return retval;
>  }
> 
> -- 
