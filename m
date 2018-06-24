Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665E9C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C2524D80
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C2524D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeFXCCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 22:02:01 -0400
Received: from p3plsmtpa12-08.prod.phx3.secureserver.net ([68.178.252.237]:57491
        "EHLO p3plsmtpa12-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751596AbeFXCB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 22:01:59 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id WuLmfVYGYt60AWuLmfTqyQ; Sat, 23 Jun 2018 19:01:59 -0700
Subject: Re: [Patch v2 04/15] CIFS: Add support for direct pages in wdata
To:     longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-5-longli@linuxonhyperv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <4edad13c-e257-ff1c-223a-324f484a936a@talpey.com>
Date:   Sat, 23 Jun 2018 22:01:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530194807.31657-5-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJMN2HHnP5yumq/W4JpRyZMUo2iksKZsTKTvZXPpKU4TRlo/gvvUJWz6CwKTuUr6qToOGL1U+bXscPkpqhjdSG78tZMSoaWW/EpTB/MLf3C/zYij11NW
 3WiIM4Mv0haefEaTpr7hCpRbC9ovI4mcnhXmM+1q5ueBZeMgEqdv2P4ClHzUzy2I51EYbzlMjYMAwM2GQRH6hfWbbFvv9EW7Eufx2minBEjFa1BB9XsOS4+1
 hbXXiuPUsmpY46c8NV6WSUKOl4w5RzjEAGjIIRJEcGCBwSiQFKAf0AVgg9cp17DwoezPCyzXEobupPaqYCD9EQldY1eOg75xaOwh9MORUVBLo9M/Uxil6pLQ
 n06KffuY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2018 3:47 PM, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> Add a function to allocate wdata without allocating pages for data
> transfer. This gives the caller an option to pass a number of pages that
> point to the data buffer to write to.
> 
> wdata is reponsible for free those pages after it's done.

Same comment as for the earlier patch. "Caller" is responsible for
"freeing" those pages? Confusing, as worded.

> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>   fs/cifs/cifsglob.h  |  2 +-
>   fs/cifs/cifsproto.h |  2 ++
>   fs/cifs/cifssmb.c   | 17 ++++++++++++++---
>   3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index 56864a87..7f62c98 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -1205,7 +1205,7 @@ struct cifs_writedata {
>   	unsigned int			tailsz;
>   	unsigned int			credits;
>   	unsigned int			nr_pages;
> -	struct page			*pages[];
> +	struct page			**pages;

Also same comment as for earlier patch, these are syntactically
equivalent and maybe not needed to change.

>   };
>   
>   /*
> diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
> index 1f27d8e..7933c5f 100644
> --- a/fs/cifs/cifsproto.h
> +++ b/fs/cifs/cifsproto.h
> @@ -533,6 +533,8 @@ int cifs_async_writev(struct cifs_writedata *wdata,
>   void cifs_writev_complete(struct work_struct *work);
>   struct cifs_writedata *cifs_writedata_alloc(unsigned int nr_pages,
>   						work_func_t complete);
> +struct cifs_writedata *cifs_writedata_direct_alloc(struct page **pages,
> +						work_func_t complete);
>   void cifs_writedata_release(struct kref *refcount);
>   int cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
>   			  struct cifs_sb_info *cifs_sb,
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index c8e4278..5aca336 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -1952,6 +1952,7 @@ cifs_writedata_release(struct kref *refcount)
>   	if (wdata->cfile)
>   		cifsFileInfo_put(wdata->cfile);
>   
> +	kvfree(wdata->pages);
>   	kfree(wdata);
>   }
>   
> @@ -2075,12 +2076,22 @@ cifs_writev_complete(struct work_struct *work)
>   struct cifs_writedata *
>   cifs_writedata_alloc(unsigned int nr_pages, work_func_t complete)
>   {
> +	struct page **pages =
> +		kzalloc(sizeof(struct page *) * nr_pages, GFP_NOFS);

Why do you do a GFP_NOFS here but GFP_KERNEL in the earlier patch?

> +	if (pages)
> +		return cifs_writedata_direct_alloc(pages, complete);
> +
> +	return NULL;
> +}
> +
> +struct cifs_writedata *
> +cifs_writedata_direct_alloc(struct page **pages, work_func_t complete)
> +{
>   	struct cifs_writedata *wdata;
>   
> -	/* writedata + number of page pointers */
> -	wdata = kzalloc(sizeof(*wdata) +
> -			sizeof(struct page *) * nr_pages, GFP_NOFS);
> +	wdata = kzalloc(sizeof(*wdata), GFP_NOFS);
>   	if (wdata != NULL) {
> +		wdata->pages = pages;
>   		kref_init(&wdata->refcount);
>   		INIT_LIST_HEAD(&wdata->list);
>   		init_completion(&wdata->done);
> 
