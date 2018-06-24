Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3052CC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2A324D86
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2A324D86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeFXC2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 22:28:45 -0400
Received: from p3plsmtpa12-04.prod.phx3.secureserver.net ([68.178.252.233]:48811
        "EHLO p3plsmtpa12-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751894AbeFXC2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 22:28:43 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id WulefzNUAOIAfWulefWpjR; Sat, 23 Jun 2018 19:28:43 -0700
Subject: Re: [Patch v2 12/15] CIFS: Pass page offset for encrypting
To:     longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-13-longli@linuxonhyperv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <fd7d65d2-115d-c15b-816c-768e6600f803@talpey.com>
Date:   Sat, 23 Jun 2018 22:28:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530194807.31657-13-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfN/1pjsBskPaN8mkUyb1ViybTlmgjDtN3mekST9Kf81Ni6CO2y+DVxtsW5WR1eO76wsU3Lq+s0+R8b6XG+ySDAxzqiP8PCCR6Edvc4Kco5Kz/RL4touU
 xzO54HUaajrUAmvpVzYe3VFx6hbofDykuMTRqKQ878wMoSgdi31Z29ahN9JZlskLLC13vZTfOvuUmVRK0pRtX1W7CYfdU8R+9nd6Pm99CySAVUZ9TDq+4J6k
 xZ/mBnujjYIJSUI1rIw7WVXHreGrSK5vRlfIaLPBf0gR8yvOIWQnZEITsUQOYgVVySM0BCWvFwV4QJCNz+fyXoNfUmKS8NNwpVA+C0NUEnjxdcHgvLWoYfl0
 ZUxLzBYy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2018 3:48 PM, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> Encryption function needs to read data starting page offset from input
> buffer.
> 
> This doesn't affect decryption path since it allocates its own page
> buffers.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>   fs/cifs/smb2ops.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index 1fa1c29..38d19b6 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -2189,9 +2189,10 @@ init_sg(struct smb_rqst *rqst, u8 *sign)
>   		smb2_sg_set_buf(&sg[i], rqst->rq_iov[i].iov_base,
>   						rqst->rq_iov[i].iov_len);
>   	for (j = 0; i < sg_len - 1; i++, j++) {
> -		unsigned int len = (j < rqst->rq_npages - 1) ? rqst->rq_pagesz
> -							: rqst->rq_tailsz;
> -		sg_set_page(&sg[i], rqst->rq_pages[j], len, 0);
> +		unsigned int len, offset;
> +
> +		rqst_page_get_length(rqst, j, &len, &offset);
> +		sg_set_page(&sg[i], rqst->rq_pages[j], len, offset);
>   	}
>   	smb2_sg_set_buf(&sg[sg_len - 1], sign, SMB2_SIGNATURE_SIZE);
>   	return sg;
> @@ -2332,6 +2333,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, struct smb_rqst *new_rq,
>   		return rc;
>   
>   	new_rq->rq_pages = pages;
> +	new_rq->rq_offset = old_rq->rq_offset;
>   	new_rq->rq_npages = old_rq->rq_npages;
>   	new_rq->rq_pagesz = old_rq->rq_pagesz;
>   	new_rq->rq_tailsz = old_rq->rq_tailsz;
> @@ -2363,10 +2365,14 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, struct smb_rqst *new_rq,
>   
>   	/* copy pages form the old */
>   	for (i = 0; i < npages; i++) {
> -		char *dst = kmap(new_rq->rq_pages[i]);
> -		char *src = kmap(old_rq->rq_pages[i]);
> -		unsigned int len = (i < npages - 1) ? new_rq->rq_pagesz :
> -							new_rq->rq_tailsz;
> +		char *dst, *src;
> +		unsigned int offset, len;
> +
> +		rqst_page_get_length(new_rq, i, &len, &offset);
> +
> +		dst = (char *) kmap(new_rq->rq_pages[i]) + offset;
> +		src = (char *) kmap(old_rq->rq_pages[i]) + offset;

Ouch! TWO kmap/kunmaps per page of data? Is there not already a kva,
at least for the destination (message)?

Tom.


> +
>   		memcpy(dst, src, len);
>   		kunmap(new_rq->rq_pages[i]);
>   		kunmap(old_rq->rq_pages[i]);
> 
