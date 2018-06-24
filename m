Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4306CC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 01:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E183824D7A
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 01:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E183824D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeFXB5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 21:57:40 -0400
Received: from p3plsmtpa12-08.prod.phx3.secureserver.net ([68.178.252.237]:56838
        "EHLO p3plsmtpa12-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751721AbeFXB5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 21:57:39 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id WuAWfVUlKt60AWuAWfTqFP; Sat, 23 Jun 2018 18:50:21 -0700
Subject: Re: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
To:     longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-3-longli@linuxonhyperv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <67b8afe7-f5e0-b36a-fcc1-87f1ae08eaa4@talpey.com>
Date:   Sat, 23 Jun 2018 21:50:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530194807.31657-3-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCLJ08a4oga1Jr5hglwit0EDmHzs9X6Zw+l5cgPdrOAE/xzJYkXX0PMZsyWIfjvYN66UkunqX8FoM8BuqJ5ShmCWQRtf9/BOsDqrf2F9hH5Fomwoopi6
 BnMLfaqUq3VJTASdGQ+f0Er3VLiP8gZgtlxwbvuIJSQmBN+yGcQHjAkRP9u94IaNWVdGigBoL9ae0lk4ot6ZOcO7kbVRqokNw+pzx4gWQJD6WU/qlm1qqqqR
 H1gB6NTotcCdvUCS4mvRenOHYfule/DfViu8aPRJN017ZDVCImX9D/fuRhDi8/tbzIy6vsqm1PnFuATtory4zGibBy06CxUKO6qEJyWRM6j1i13hnDfqskL+
 PWdfMcHm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2018 3:47 PM, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> Add a function to allocate rdata without allocating pages for data
> transfer. This gives the caller an option to pass a number of pages
> that point to the data buffer.
> 
> rdata is still reponsible for free those pages after it's done.

"Caller" is still responsible? Or is the rdata somehow freeing itself
via another mechanism?

> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>   fs/cifs/cifsglob.h |  2 +-
>   fs/cifs/file.c     | 23 ++++++++++++++++++++---
>   2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index 8d16c3e..56864a87 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -1179,7 +1179,7 @@ struct cifs_readdata {
>   	unsigned int			tailsz;
>   	unsigned int			credits;
>   	unsigned int			nr_pages;
> -	struct page			*pages[];
> +	struct page			**pages;

Technically speaking, these are syntactically equivalent. It may not
be worth changing this historic definition.

Tom.


>   };
>   
>   struct cifs_writedata;
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 23fd430..1c98293 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -2880,13 +2880,13 @@ cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from)
>   }
>   
>   static struct cifs_readdata *
> -cifs_readdata_alloc(unsigned int nr_pages, work_func_t complete)
> +cifs_readdata_direct_alloc(struct page **pages, work_func_t complete)
>   {
>   	struct cifs_readdata *rdata;
>   
> -	rdata = kzalloc(sizeof(*rdata) + (sizeof(struct page *) * nr_pages),
> -			GFP_KERNEL);
> +	rdata = kzalloc(sizeof(*rdata), GFP_KERNEL);
>   	if (rdata != NULL) {
> +		rdata->pages = pages;
>   		kref_init(&rdata->refcount);
>   		INIT_LIST_HEAD(&rdata->list);
>   		init_completion(&rdata->done);
> @@ -2896,6 +2896,22 @@ cifs_readdata_alloc(unsigned int nr_pages, work_func_t complete)
>   	return rdata;
>   }
>   
> +static struct cifs_readdata *
> +cifs_readdata_alloc(unsigned int nr_pages, work_func_t complete)
> +{
> +	struct page **pages =
> +		kzalloc(sizeof(struct page *) * nr_pages, GFP_KERNEL);
> +	struct cifs_readdata *ret = NULL;
> +
> +	if (pages) {
> +		ret = cifs_readdata_direct_alloc(pages, complete);
> +		if (!ret)
> +			kfree(pages);
> +	}
> +
> +	return ret;
> +}
> +
>   void
>   cifs_readdata_release(struct kref *refcount)
>   {
> @@ -2910,6 +2926,7 @@ cifs_readdata_release(struct kref *refcount)
>   	if (rdata->cfile)
>   		cifsFileInfo_put(rdata->cfile);
>   
> +	kvfree(rdata->pages);
>   	kfree(rdata);
>   }
>   
> 
