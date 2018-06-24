Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EF2C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1043B24D82
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1043B24D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeFXCJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 22:09:16 -0400
Received: from p3plsmtpa12-09.prod.phx3.secureserver.net ([68.178.252.238]:40977
        "EHLO p3plsmtpa12-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751599AbeFXCJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 22:09:15 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id WuSnfdVrA669vWuSofOVo5; Sat, 23 Jun 2018 19:09:14 -0700
Subject: Re: [Patch v2 06/15] CIFS: Introduce helper function to get page
 offset and length in smb_rqst
To:     longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-7-longli@linuxonhyperv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <a6613388-0dc5-7646-b71f-75b8bec4e4d9@talpey.com>
Date:   Sat, 23 Jun 2018 22:09:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530194807.31657-7-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAHToKcuGOpd1cmEjLTuyHQNdtb2EFs1LTH2/vCbg3ohKcf7RtlMxGTs4vfgvsowtv9ly+rfJrwDJvEMRw0s6JmzsrBQR/2pWRc0x7C+8JyTH3dG71eO
 FAJPZsk7XjTRtUawJFlgb4Civvx0jk6PemWAFgEkE/5Q5q+M9yg+JA5l7qWyaVvIhDwIp/u5+1AvtcFc8qoYSylpbQJrR5V6TvHHoPOwelf63PHZATmu+hsv
 7uYArM+9UlJNyS5Kfid6oqYXYaT+yv2RmZS39hHmFyygF4j6ZoPQyeQBpu5CHMPiNdMn1sujA5L8zp2ZnjAK/wk9gHqkjtzACdEIqBZ8t3Vr1EEyhB7/7kvq
 q/1YEVGY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2018 3:47 PM, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> Introduce a function rqst_page_get_length to return the page offset and
> length for a given page in smb_rqst. This function is to be used by
> following patches.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>   fs/cifs/cifsproto.h |  3 +++
>   fs/cifs/misc.c      | 17 +++++++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
> index 7933c5f..89dda14 100644
> --- a/fs/cifs/cifsproto.h
> +++ b/fs/cifs/cifsproto.h
> @@ -557,4 +557,7 @@ int cifs_alloc_hash(const char *name, struct crypto_shash **shash,
>   		    struct sdesc **sdesc);
>   void cifs_free_hash(struct crypto_shash **shash, struct sdesc **sdesc);
>   
> +extern void rqst_page_get_length(struct smb_rqst *rqst, unsigned int page,
> +				unsigned int *len, unsigned int *offset);
> +
>   #endif			/* _CIFSPROTO_H */
> diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
> index 96849b5..e951417 100644
> --- a/fs/cifs/misc.c
> +++ b/fs/cifs/misc.c
> @@ -905,3 +905,20 @@ cifs_free_hash(struct crypto_shash **shash, struct sdesc **sdesc)
>   		crypto_free_shash(*shash);
>   	*shash = NULL;
>   }
> +
> +/**
> + * rqst_page_get_length - obtain the length and offset for a page in smb_rqst
> + * Input: rqst - a smb_rqst, page - a page index for rqst
> + * Output: *len - the length for this page, *offset - the offset for this page
> + */
> +void rqst_page_get_length(struct smb_rqst *rqst, unsigned int page,
> +				unsigned int *len, unsigned int *offset)
> +{
> +	*len = rqst->rq_pagesz;
> +	*offset = (page == 0) ? rqst->rq_offset : 0;

Really? Page 0 always has a zero offset??

> +
> +	if (rqst->rq_npages == 1 || page == rqst->rq_npages-1)
> +		*len = rqst->rq_tailsz;
> +	else if (page == 0)
> +		*len = rqst->rq_pagesz - rqst->rq_offset;
> +}
> 

This subroutine does what patch 5 does inline. Why not push this patch
up in the sequence and use the helper?

Tom.
