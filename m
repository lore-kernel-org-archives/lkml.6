Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FC1ECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047D82147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047D82147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbeGMCS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 22:18:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387972AbeGMCS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 22:18:28 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 45585282D3412;
        Fri, 13 Jul 2018 10:05:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 10:05:51 +0800
Subject: Re: [V9fs-developer] [PATCH v2 3/6] 9p: Replace the fidlist with an
 IDR
To:     Matthew Wilcox <willy@infradead.org>,
        Dominique Martinet <asmadeus@codewreck.org>
References: <20180711210225.19730-1-willy@infradead.org>
 <20180711210225.19730-4-willy@infradead.org>
CC:     Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        <linux-kernel@vger.kernel.org>, Ron Minnich <rminnich@sandia.gov>,
        <linux-fsdevel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B4808FE.7010500@huawei.com>
Date:   Fri, 13 Jul 2018 10:05:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180711210225.19730-4-willy@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/12 5:02, Matthew Wilcox wrote:
> The p9_idpool being used to allocate the IDs uses an IDR to allocate
> the IDs ... which we then keep in a doubly-linked list, rather than in
> the IDR which allocated them.  We can use an IDR directly which saves
> two pointers per p9_fid, and a tiny memory allocation per p9_client.
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  include/net/9p/client.h |  9 +++------
>  net/9p/client.c         | 44 +++++++++++++++--------------------------
>  2 files changed, 19 insertions(+), 34 deletions(-)
> 
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index 7af9d769b97d..e405729cd1c7 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -27,6 +27,7 @@
>  #define NET_9P_CLIENT_H
>  
>  #include <linux/utsname.h>
> +#include <linux/idr.h>
>  
>  /* Number of requests per row */
>  #define P9_ROW_MAXTAG 255
> @@ -128,8 +129,7 @@ struct p9_req_t {
>   * @proto_version: 9P protocol version to use
>   * @trans_mod: module API instantiated with this client
>   * @trans: tranport instance state and API
> - * @fidpool: fid handle accounting for session
> - * @fidlist: List of active fid handles
> + * @fids: All active FID handles
>   * @tagpool - transaction id accounting for session
>   * @reqs - 2D array of requests
>   * @max_tag - current maximum tag id allocated
> @@ -169,8 +169,7 @@ struct p9_client {
>  		} tcp;
>  	} trans_opts;
>  
> -	struct p9_idpool *fidpool;
> -	struct list_head fidlist;
> +	struct idr fids;
>  
>  	struct p9_idpool *tagpool;
>  	struct p9_req_t *reqs[P9_ROW_MAXTAG];
> @@ -188,7 +187,6 @@ struct p9_client {
>   * @iounit: the server reported maximum transaction size for this file
>   * @uid: the numeric uid of the local user who owns this handle
>   * @rdir: readdir accounting structure (allocated on demand)
> - * @flist: per-client-instance fid tracking
>   * @dlist: per-dentry fid tracking
>   *
>   * TODO: This needs lots of explanation.
> @@ -204,7 +202,6 @@ struct p9_fid {
>  
>  	void *rdir;
>  
> -	struct list_head flist;
>  	struct hlist_node dlist;	/* list of all fids attached to a dentry */
>  };
>  
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 389a2904b7b3..b89c7298267c 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -908,30 +908,29 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
>  {
>  	int ret;
>  	struct p9_fid *fid;
> -	unsigned long flags;
>  
>  	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
>  	fid = kmalloc(sizeof(struct p9_fid), GFP_KERNEL);
>  	if (!fid)
>  		return NULL;
>  
> -	ret = p9_idpool_get(clnt->fidpool);
> -	if (ret < 0)
> -		goto error;
> -	fid->fid = ret;
> -
>  	memset(&fid->qid, 0, sizeof(struct p9_qid));
>  	fid->mode = -1;
>  	fid->uid = current_fsuid();
>  	fid->clnt = clnt;
>  	fid->rdir = NULL;
> -	spin_lock_irqsave(&clnt->lock, flags);
> -	list_add(&fid->flist, &clnt->fidlist);
> -	spin_unlock_irqrestore(&clnt->lock, flags);
> +	fid->fid = 0;
>  
> -	return fid;
> +	idr_preload(GFP_KERNEL);

It is best to use GFP_NOFS instead, or else it may cause some
unpredictable problem, because when out of memory it will
reclaim memory from v9fs.

> +	spin_lock_irq(&clnt->lock);
> +	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, P9_NOFID - 1,
> +			GFP_NOWAIT);
> +	spin_unlock_irq(&clnt->lock);

use spin_lock instead, clnt->lock is not used in irq context.

> +	idr_preload_end();
> +
> +	if (!ret)
> +		return fid;
>  
> -error:
>  	kfree(fid);
>  	return NULL;
>  }
> @@ -943,9 +942,8 @@ static void p9_fid_destroy(struct p9_fid *fid)
>  
>  	p9_debug(P9_DEBUG_FID, "fid %d\n", fid->fid);
>  	clnt = fid->clnt;
> -	p9_idpool_put(fid->fid, clnt->fidpool);
>  	spin_lock_irqsave(&clnt->lock, flags);
> -	list_del(&fid->flist);
> +	idr_remove(&clnt->fids, fid->fid);
>  	spin_unlock_irqrestore(&clnt->lock, flags);
>  	kfree(fid->rdir);
>  	kfree(fid);
> @@ -1028,7 +1026,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  	memcpy(clnt->name, client_id, strlen(client_id) + 1);
>  
>  	spin_lock_init(&clnt->lock);
> -	INIT_LIST_HEAD(&clnt->fidlist);
> +	idr_init(&clnt->fids);
>  
>  	err = p9_tag_init(clnt);
>  	if (err < 0)
> @@ -1048,18 +1046,12 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  		goto destroy_tagpool;
>  	}
>  
> -	clnt->fidpool = p9_idpool_create();
> -	if (IS_ERR(clnt->fidpool)) {
> -		err = PTR_ERR(clnt->fidpool);
> -		goto put_trans;
> -	}
> -
>  	p9_debug(P9_DEBUG_MUX, "clnt %p trans %p msize %d protocol %d\n",
>  		 clnt, clnt->trans_mod, clnt->msize, clnt->proto_version);
>  
>  	err = clnt->trans_mod->create(clnt, dev_name, options);
>  	if (err)
> -		goto destroy_fidpool;
> +		goto put_trans;
>  
>  	if (clnt->msize > clnt->trans_mod->maxsize)
>  		clnt->msize = clnt->trans_mod->maxsize;
> @@ -1072,8 +1064,6 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  
>  close_trans:
>  	clnt->trans_mod->close(clnt);
> -destroy_fidpool:
> -	p9_idpool_destroy(clnt->fidpool);
>  put_trans:
>  	v9fs_put_trans(clnt->trans_mod);
>  destroy_tagpool:
> @@ -1086,7 +1076,8 @@ EXPORT_SYMBOL(p9_client_create);
>  
>  void p9_client_destroy(struct p9_client *clnt)
>  {
> -	struct p9_fid *fid, *fidptr;
> +	struct p9_fid *fid;
> +	int id;
>  
>  	p9_debug(P9_DEBUG_MUX, "clnt %p\n", clnt);
>  
> @@ -1095,14 +1086,11 @@ void p9_client_destroy(struct p9_client *clnt)
>  
>  	v9fs_put_trans(clnt->trans_mod);
>  
> -	list_for_each_entry_safe(fid, fidptr, &clnt->fidlist, flist) {
> +	idr_for_each_entry(&clnt->fids, fid, id) {
>  		pr_info("Found fid %d not clunked\n", fid->fid);
>  		p9_fid_destroy(fid);
>  	}
>  
> -	if (clnt->fidpool)
> -		p9_idpool_destroy(clnt->fidpool);
> -

I suggest add idr_destroy in the end.

>  	p9_tag_cleanup(clnt);
>  
>  	kfree(clnt);
> 


