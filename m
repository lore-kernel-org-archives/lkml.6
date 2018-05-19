Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeESBJ3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 21:09:29 -0400
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:43923
        "EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752149AbeESBJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 21:09:20 -0400
Subject: Re: [RFC PATCH 05/09] Change RDMA send to regonize page offset in the
 1st page
To: longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20180518002214.5657-1-longli@linuxonhyperv.com>
 <20180518002214.5657-6-longli@linuxonhyperv.com>
From: Tom Talpey <tom@talpey.com>
Message-ID: <8a32557a-684a-bf6b-bb1d-3f1f0d5c32c9@talpey.com>
Date: Fri, 18 May 2018 18:09:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518002214.5657-6-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEd2p4S7676tCKvhTN39jaJ3a11L5vhloYJCVfhalXQuVYI1A2K9hZtWp6ahRsZcg+/qLCpS4rO9PPwK/ANzKKiyTZZJmp0dDx418xgn9NGYK9Va3sdM
 W4jgXQG1nqs2jh4/gTPdg+LlAjCR7qEXvkG1JE+g/DnZ/dZC+jebG54BKRxRQfJwHds9ei0mIxSGCO5XGY3pDB6aVQMm3U+BKDb3eZR58KBcOVsGjbLOvwpS
 RSqt4KQpURMwPxp364Qx5IjDejtFDrFDoy2h5L7mlTj4SdMtkTW+5OdrxPjC0soos0xCV0FshPRNP8IrPVHCvHu32IQYPvpi4hWNfwUB1lV/FQYUUWqpliwH
 KDj83ucT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/2018 5:22 PM, Long Li wrote:
> From: Long Li <longli@microsoft.com>

There's a typo "recognize" in the patch title


> When doing RDMA send, the offset needs to be checked as data may start in an offset
> in the 1st page.

Doesn't this patch alter the generic smb2pdu.c code too? I think this
should note "any" send, not just RDMA?

Tom.

> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>   fs/cifs/smb2pdu.c   |  3 ++-
>   fs/cifs/smbdirect.c | 25 +++++++++++++++++++------
>   2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 5097f28..fdcf97e 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -3015,7 +3015,8 @@ smb2_async_writev(struct cifs_writedata *wdata,
>   
>   	rqst.rq_iov = iov;
>   	rqst.rq_nvec = 2;
> -	rqst.rq_pages = wdata->pages;
> +	rqst.rq_pages = wdata->direct_pages ? wdata->direct_pages : wdata->pages;
> +	rqst.rq_offset = wdata->page_offset;
>   	rqst.rq_npages = wdata->nr_pages;
>   	rqst.rq_pagesz = wdata->pagesz;
>   	rqst.rq_tailsz = wdata->tailsz;
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index b0a1955..b46586d 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -2084,8 +2084,10 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
>   
>   	/* add in the page array if there is one */
>   	if (rqst->rq_npages) {
> -		buflen += rqst->rq_pagesz * (rqst->rq_npages - 1);
> -		buflen += rqst->rq_tailsz;
> +		if (rqst->rq_npages == 1)
> +			buflen += rqst->rq_tailsz;
> +		else
> +			buflen += rqst->rq_pagesz * (rqst->rq_npages - 1) - rqst->rq_offset + rqst->rq_tailsz;
>   	}
>   
>   	if (buflen + sizeof(struct smbd_data_transfer) >
> @@ -2182,8 +2184,19 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
>   
>   	/* now sending pages if there are any */
>   	for (i = 0; i < rqst->rq_npages; i++) {
> -		buflen = (i == rqst->rq_npages-1) ?
> -			rqst->rq_tailsz : rqst->rq_pagesz;
> +		unsigned int offset = 0;
> +		if (i == 0)
> +			offset = rqst->rq_offset;
> +		if (rqst->rq_npages == 1 || i == rqst->rq_npages-1)
> +			buflen = rqst->rq_tailsz;
> +		else {
> +			/* We have at least two pages, and this is not the last page */
> +			if (i == 0)
> +				buflen = rqst->rq_pagesz - rqst->rq_offset;
> +			else
> +				buflen = rqst->rq_pagesz;
> +		}
> +
>   		nvecs = (buflen + max_iov_size - 1) / max_iov_size;
>   		log_write(INFO, "sending pages buflen=%d nvecs=%d\n",
>   			buflen, nvecs);
> @@ -2194,9 +2207,9 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
>   			remaining_data_length -= size;
>   			log_write(INFO, "sending pages i=%d offset=%d size=%d"
>   				" remaining_data_length=%d\n",
> -				i, j*max_iov_size, size, remaining_data_length);
> +				i, j*max_iov_size+offset, size, remaining_data_length);
>   			rc = smbd_post_send_page(
> -				info, rqst->rq_pages[i], j*max_iov_size,
> +				info, rqst->rq_pages[i], j*max_iov_size + offset,
>   				size, remaining_data_length);
>   			if (rc)
>   				goto done;
> 
