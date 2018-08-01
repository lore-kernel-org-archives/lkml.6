Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A35C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7D520894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7D520894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbeHAOqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:46:07 -0400
Received: from fieldses.org ([173.255.197.46]:33652 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389240AbeHAOqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:46:07 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 8C5D923D2; Wed,  1 Aug 2018 09:00:26 -0400 (EDT)
Date:   Wed, 1 Aug 2018 09:00:26 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, jlayton@kernel.org, ebiggers@google.com,
        chuck.lever@oracle.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc: remove redundant variables
 'checksumlen','blocksize' and 'data'
Message-ID: <20180801130026.GA16651@fieldses.org>
References: <20180801062810.19752-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180801062810.19752-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applying (assuming Chuck's got no objection to the svc_rdma
part).

--b.

On Wed, Aug 01, 2018 at 02:28:10PM +0800, YueHaibing wrote:
> Variables 'checksumlen','blocksize' and 'data' are being assigned,
> but are never used,hence they are redundant and can be removed.
> 
> fix fllowing warning:
> 
> net/sunrpc/auth_gss/gss_krb5_wrap.c:443:7: warning: variable ‘blocksize’ set but not used [-Wunused-but-set-variable]
> net/sunrpc/auth_gss/gss_krb5_crypto.c:376:15: warning: variable ‘checksumlen’ set but not used [-Wunused-but-set-variable]
> net/sunrpc/xprtrdma/svc_rdma.c:97:9: warning: variable ‘data’ set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/sunrpc/auth_gss/gss_krb5_crypto.c | 2 --
>  net/sunrpc/auth_gss/gss_krb5_wrap.c   | 2 --
>  net/sunrpc/xprtrdma/svc_rdma.c        | 2 --
>  3 files changed, 6 deletions(-)
> 
> diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> index 8654494..84a16fd 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> @@ -373,7 +373,6 @@ make_checksum_v2(struct krb5_ctx *kctx, char *header, int hdrlen,
>  	struct scatterlist sg[1];
>  	int err = -1;
>  	u8 *checksumdata;
> -	unsigned int checksumlen;
>  
>  	if (kctx->gk5e->keyed_cksum == 0) {
>  		dprintk("%s: expected keyed hash for %s\n",
> @@ -393,7 +392,6 @@ make_checksum_v2(struct krb5_ctx *kctx, char *header, int hdrlen,
>  	tfm = crypto_alloc_ahash(kctx->gk5e->cksum_name, 0, CRYPTO_ALG_ASYNC);
>  	if (IS_ERR(tfm))
>  		goto out_free_cksum;
> -	checksumlen = crypto_ahash_digestsize(tfm);
>  
>  	req = ahash_request_alloc(tfm, GFP_NOFS);
>  	if (!req)
> diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
> index a737c2d..9a1347f 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
> @@ -440,7 +440,6 @@ static u32
>  gss_wrap_kerberos_v2(struct krb5_ctx *kctx, u32 offset,
>  		     struct xdr_buf *buf, struct page **pages)
>  {
> -	int		blocksize;
>  	u8		*ptr, *plainhdr;
>  	s32		now;
>  	u8		flags = 0x00;
> @@ -473,7 +472,6 @@ gss_wrap_kerberos_v2(struct krb5_ctx *kctx, u32 offset,
>  	*ptr++ = 0xff;
>  	be16ptr = (__be16 *)ptr;
>  
> -	blocksize = crypto_skcipher_blocksize(kctx->acceptor_enc);
>  	*be16ptr++ = 0;
>  	/* "inner" token header always uses 0 for RRC */
>  	*be16ptr++ = 0;
> diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
> index 357ba90..134bef6a 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma.c
> @@ -94,7 +94,6 @@ static int read_reset_stat(struct ctl_table *table, int write,
>  		atomic_set(stat, 0);
>  	else {
>  		char str_buf[32];
> -		char *data;
>  		int len = snprintf(str_buf, 32, "%d\n", atomic_read(stat));
>  		if (len >= 32)
>  			return -EFAULT;
> @@ -103,7 +102,6 @@ static int read_reset_stat(struct ctl_table *table, int write,
>  			*lenp = 0;
>  			return 0;
>  		}
> -		data = &str_buf[*ppos];
>  		len -= *ppos;
>  		if (len > *lenp)
>  			len = *lenp;
> -- 
> 2.7.0
> 
