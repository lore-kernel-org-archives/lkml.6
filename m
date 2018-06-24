Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FDDC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAB524D80
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAB524D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeFXCHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 22:07:12 -0400
Received: from p3plsmtpa12-02.prod.phx3.secureserver.net ([68.178.252.231]:45015
        "EHLO p3plsmtpa12-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751597AbeFXCHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 22:07:10 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id WuQnf8yDKJu7xWuQnfl14O; Sat, 23 Jun 2018 19:07:10 -0700
Subject: Re: [Patch v2 05/15] CIFS: Calculate the correct request length based
 on page offset and tail size
To:     longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-6-longli@linuxonhyperv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <183b5cd5-b12b-de08-7867-c2addf29c974@talpey.com>
Date:   Sat, 23 Jun 2018 22:07:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530194807.31657-6-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFwHTur7dmMiHGS5K8pCdF8Ut/MxIREKvzm8azzB0ExS8/OzmBzDCUoz+WORJZ1NkKXAC7ADU81JDdVQAAxIkxA/sUV46EEtNsgXqANZ4wWgywjnhsmN
 IlHT2tkYAaj/AJBR8//U6w4/xM5i5BGLLRCqhab9TwhF4/CipWqEkUENoUCCcEebKchIExS+S8xWI5p3CIoILvNRvdwkU95bhPCf1A9A02yG7rT4Muq1OFkK
 W40okAFMWLoL3ij4Mba2WTqjfbKqcu2r6O5Ewbcz0ywvpusCsAr9iQcIuBtv/7tOVsSh8dxrok5FIAxQGP02+7Ez/BcNod8d6/CitBfB7Xuly7/HsdmQ6eho
 eXreT73f
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2018 3:47 PM, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> It's possible that the page offset is non-zero in the pages in a request,
> change the function to calculate the correct data buffer length.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>   fs/cifs/transport.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
> index 927226a..d6b5523 100644
> --- a/fs/cifs/transport.c
> +++ b/fs/cifs/transport.c
> @@ -212,10 +212,24 @@ rqst_len(struct smb_rqst *rqst)
>   	for (i = 0; i < rqst->rq_nvec; i++)
>   		buflen += iov[i].iov_len;
>   
> -	/* add in the page array if there is one */
> +	/*
> +	 * Add in the page array if there is one. The caller needs to make
> +	 * sure rq_offset and rq_tailsz are set correctly. If a buffer of
> +	 * multiple pages ends at page boundary, rq_tailsz needs to be set to
> +	 * PAGE_SIZE.
> +	 */
>   	if (rqst->rq_npages) {
> -		buflen += rqst->rq_pagesz * (rqst->rq_npages - 1);
> -		buflen += rqst->rq_tailsz;
> +		if (rqst->rq_npages == 1)
> +			buflen += rqst->rq_tailsz;
> +		else {
> +			/*
> +			 * If there is more than one page, calculate the
> +			 * buffer length based on rq_offset and rq_tailsz
> +			 */
> +			buflen += rqst->rq_pagesz * (rqst->rq_npages - 1) -
> +					rqst->rq_offset;
> +			buflen += rqst->rq_tailsz;
> +		}

Wouldn't it be simpler to keep the original code, but then just subtract
the rq_offset?

	buflen += rqst->rq_pagesz * (rqst->rq_npages - 1);
	buflen += rqst->rq_tailsz;
	buflen -= rqst->rq_offset;

It's kind of confusing as written. Also, what if it's just one page, but
has a non-zero offset? Is that somehow not possible? My suggested code
would take that into account, yours doesn't.

Tom.

>   	}
>   
>   	return buflen;
> 
