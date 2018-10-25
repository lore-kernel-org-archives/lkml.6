Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E828C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C798120834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C798120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeJZAGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:06:18 -0400
Received: from opengridcomputing.com ([72.48.214.68]:41718 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727450AbeJZAGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:06:18 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2018 20:06:18 EDT
Received: from [10.10.0.239] (cody.ogc.int [10.10.0.239])
        by smtp.opengridcomputing.com (Postfix) with ESMTPSA id B32FA2264E;
        Thu, 25 Oct 2018 10:26:51 -0500 (CDT)
Reply-To: swise@chelsio.com
Subject: Re: [PATCH] RDMA/cxgb3: Fix unintended sign extension
To:     Colin King <colin.king@canonical.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181025143131.4048-1-colin.king@canonical.com>
From:   Steve Wise <swise@chelsio.com>
Message-ID: <34f7f28b-5f76-f6d0-d896-9a5550a8e3df@chelsio.com>
Date:   Thu, 25 Oct 2018 10:26:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025143131.4048-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2018 9:31 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the expression "utx_len << 28", utx_len starts as u8, but is promoted
> to a signed int, then sign-extended to u64.  If utx_len is 0xf8 or greater
> then the sign extension will set all the upper bits of utx_cmd which is
> probably not what was intended.  Cast to utx_len to u64  to avoid the sign
> extension.
> 
> Detected by CoverityScan, CID#138764 ("Unintended sign extension")
> 
> Fixes: b038ced7b370 ("RDMA/cxgb3: Add driver for Chelsio T3 RNIC")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/cxgb3/cxio_hal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.c b/drivers/infiniband/hw/cxgb3/cxio_hal.c
> index dcb4bba522ba..c5cb80ccc6d6 100644
> --- a/drivers/infiniband/hw/cxgb3/cxio_hal.c
> +++ b/drivers/infiniband/hw/cxgb3/cxio_hal.c
> @@ -647,7 +647,7 @@ static int cxio_hal_ctrl_qp_write_mem(struct cxio_rdev *rdev_p, u32 addr,
>  		wqe += (sizeof(struct t3_bypass_wr) >> 3);
>  		utx_cmd = (T3_UTX_MEM_WRITE << 28) | (addr + i * 3);
>  		utx_cmd <<= 32;
> -		utx_cmd |= (utx_len << 28) | ((utx_len << 2) + 1);
> +		utx_cmd |= ((u64)utx_len << 28) | ((utx_len << 2) + 1);
>  		*wqe = cpu_to_be64(utx_cmd);
>  		wqe++;
>  		copy_data = (u8 *) data + i * 96;
> 

Acked-by: Steve Wise <swise@chelsio.com>
