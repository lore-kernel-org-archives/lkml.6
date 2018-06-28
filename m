Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDED7C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B7F279D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DsARE4rB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B7F279D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935812AbeF1VMl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:12:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61392 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753435AbeF1VMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530220360; x=1561756360;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=eOZSZOs5sjxSuv8sMrGR0/p9uxUIPVJqS5W7Legm8+w=;
  b=DsARE4rB8dEjkBGRI1WuZYLnphwG8ZB6JJoy8kTwubtE3dQLcsNc+maF
   Ja4crTWIspohU/xJwh3n0CKpX6h5jx0ZeZJLwVuwWFKZyU6vCpppj9rvs
   GSLKe19AHymc9PJIFOEncPnb+g94YkU+PKxB3P9yKgiS8mKy0wFm/M932
   pQ/ahdbUyNPl2QN3wfK4ri2XUoK0iyxoUQeWrXDDRhm0uLLldpHDM7JBl
   pT+uCRx6Hg9ctOuRE7sb0u5boa6BcCcj6P9kin+yNBE5qMcnhmqZUkeDb
   buY+13HOnd0NCXCLG65H1Md+UuKJDMy3qR3xEJ76KqY0dHF2Qv0rN0d9i
   w==;
X-IronPort-AV: E=Sophos;i="5.51,284,1526313600"; 
   d="scan'208";a="185802252"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2018 05:12:39 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 28 Jun 2018 14:02:10 -0700
Received: from thinkpad-bart.sdcorp.global.sandisk.com (HELO [10.111.67.248]) ([10.111.67.248])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jun 2018 14:12:40 -0700
Subject: Re: [PATCH 1/5] blk-mq: add API to get hctx index from request
To:     Keith Busch <keith.busch@intel.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20180628205601.13742-1-keith.busch@intel.com>
From:   Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <57c119c3-5704-0dcb-96dd-fede99c49511@wdc.com>
Date:   Thu, 28 Jun 2018 14:12:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628205601.13742-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/18 14:03, Keith Busch wrote:
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>   block/blk-mq.c         | 6 ++++++
>   include/linux/blk-mq.h | 1 +
>   2 files changed, 7 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b429d515b568..c6478833464d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -466,6 +466,12 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
>   
> +unsigned int blk_mq_request_hctx_idx(struct request *rq)
> +{
> +	return blk_mq_map_queue(rq->q, rq->mq_ctx->cpu)->queue_num;
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_request_hctx_idx);
> +
>   static void __blk_mq_free_request(struct request *rq)
>   {
>   	struct request_queue *q = rq->q;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index e3147eb74222..af91b2d31a04 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -248,6 +248,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
>   }

When posting a patch series, please include a cover letter that explains 
the purpose of the patch series.

Regarding the above patch: have you considered to use the existing 
function blk_mq_unique_tag_to_hwq() instead of introducing this new 
function?

Thanks,

Bart.
