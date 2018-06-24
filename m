Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFF2C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B7624D84
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B7624D84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeFXCLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 22:11:41 -0400
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net ([68.178.252.232]:47958
        "EHLO p3plsmtpa12-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751758AbeFXCLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 22:11:39 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id WuV8fapL045IEWuV8ffGt4; Sat, 23 Jun 2018 19:11:39 -0700
Subject: Re: [Patch v2 08/15] CIFS: SMBD: Support page offset in RDMA send
To:     longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-9-longli@linuxonhyperv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <ad9b2249-7e26-be0d-997c-c1cc128f70d6@talpey.com>
Date:   Sat, 23 Jun 2018 22:11:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530194807.31657-9-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMB4nppXOlMxwAwp4rCQD5vgCUnVwLuG3VKpKeIjlpwLSRfQfLA7ai5SBtG0XtgPI6zxdZ8MYvi26OwNDNQ+Faoj3tnHbAZLr9X8GCoBj+hYdPNI0iM8
 Etz7w9XGh8BKaLvUd/pYpFqYPxctmqThqsmP5dQEoHtf1pOKh03DPXgvioXqj8KJYA99j7qFMQT2Osp2ZvnQel+o8AlEeH229RfWjwWPgCt1RO7yQJ3ZT02N
 Npb6uO9IfuE3/9LoveM0M0213xbn9XjMUsLoih3M6l52xU3Sq/cL43DuX2D/+wBBx9YXNgg78CT0nc2AKUE+/DhbUN+4msTjn81FiJAyzStXA4tQEciGRsHx
 NhLWiK3b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2018 3:48 PM, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> The RDMA send function needs to look at offset in the request pages, and
> send data starting from there.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>   fs/cifs/smbdirect.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index c62f7c9..6141e3c 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -17,6 +17,7 @@
>   #include <linux/highmem.h>
>   #include "smbdirect.h"
>   #include "cifs_debug.h"
> +#include "cifsproto.h"
>   
>   static struct smbd_response *get_empty_queue_buffer(
>   		struct smbd_connection *info);
> @@ -2082,7 +2083,7 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
>   	struct kvec vec;
>   	int nvecs;
>   	int size;
> -	int buflen = 0, remaining_data_length;
> +	unsigned int buflen = 0, remaining_data_length;
>   	int start, i, j;
>   	int max_iov_size =
>   		info->max_send_size - sizeof(struct smbd_data_transfer);
> @@ -2113,10 +2114,17 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
>   		buflen += iov[i].iov_len;
>   	}
>   
> -	/* add in the page array if there is one */
> +	/*
> +	 * Add in the page array if there is one. The caller needs to set
> +	 * rq_tailsz to PAGE_SIZE when the buffer has multiple pages and
> +	 * ends at page boundary
> +	 */
>   	if (rqst->rq_npages) {
> -		buflen += rqst->rq_pagesz * (rqst->rq_npages - 1);
> -		buflen += rqst->rq_tailsz;
> +		if (rqst->rq_npages == 1)
> +			buflen += rqst->rq_tailsz;
> +		else
> +			buflen += rqst->rq_pagesz * (rqst->rq_npages - 1) -
> +					rqst->rq_offset + rqst->rq_tailsz;
>   	}

This code is really confusing and redundant. It tests npages > 0,
then tests npages == 1, then does an else. Why not call the helper
like the following smbd_send()?

Tom.

>   
>   	if (buflen + sizeof(struct smbd_data_transfer) >
> @@ -2213,8 +2221,9 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
>   
>   	/* now sending pages if there are any */
>   	for (i = 0; i < rqst->rq_npages; i++) {
> -		buflen = (i == rqst->rq_npages-1) ?
> -			rqst->rq_tailsz : rqst->rq_pagesz;
> +		unsigned int offset;
> +
> +		rqst_page_get_length(rqst, i, &buflen, &offset);
>   		nvecs = (buflen + max_iov_size - 1) / max_iov_size;
>   		log_write(INFO, "sending pages buflen=%d nvecs=%d\n",
>   			buflen, nvecs);
> @@ -2225,9 +2234,11 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
>   			remaining_data_length -= size;
>   			log_write(INFO, "sending pages i=%d offset=%d size=%d"
>   				" remaining_data_length=%d\n",
> -				i, j*max_iov_size, size, remaining_data_length);
> +				i, j*max_iov_size+offset, size,
> +				remaining_data_length);
>   			rc = smbd_post_send_page(
> -				info, rqst->rq_pages[i], j*max_iov_size,
> +				info, rqst->rq_pages[i],
> +				j*max_iov_size + offset,
>   				size, remaining_data_length);
>   			if (rc)
>   				goto done;
> 
