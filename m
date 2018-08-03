Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1139CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33FB21711
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33FB21711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeHCIOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:14:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10618 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727226AbeHCIOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:14:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3FAC6620A7B4;
        Fri,  3 Aug 2018 14:19:19 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Fri, 3 Aug 2018
 14:19:14 +0800
Subject: Re: [V9fs-developer] [PATCH] net/9p: Modify the problem of BUG_ON
 judgment
To:     jiangyiwen <jiangyiwen@huawei.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
References: <5B63D5F6.6080109@huawei.com>
CC:     <v9fs-developer@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B63F3D1.3020408@huawei.com>
Date:   Fri, 3 Aug 2018 14:18:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <5B63D5F6.6080109@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM

On 2018/8/3 12:11, jiangyiwen wrote:
> Because the value of limit is VIRTQUEUE_NUM, if index is equal to
> limit, it will cause sg array out of bounds, so correct the judgement
> of BUG_ON.
> 
> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
Acked-by: Jun Piao <piaojun@huawei.com>
> ---
>  net/9p/trans_virtio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 6265d1d..08264ba 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -191,7 +191,7 @@ static int pack_sg_list(struct scatterlist *sg, int start,
>  		s = rest_of_page(data);
>  		if (s > count)
>  			s = count;
> -		BUG_ON(index > limit);
> +		BUG_ON(index >= limit);
>  		/* Make sure we don't terminate early. */
>  		sg_unmark_end(&sg[index]);
>  		sg_set_buf(&sg[index++], data, s);
> @@ -236,6 +236,7 @@ static int p9_virtio_cancel(struct p9_client *client, struct p9_req_t *req)
>  		s = PAGE_SIZE - data_off;
>  		if (s > count)
>  			s = count;
> +		BUG_ON(index >= limit);
>  		/* Make sure we don't terminate early. */
>  		sg_unmark_end(&sg[index]);
>  		sg_set_page(&sg[index++], pdata[i++], s, data_off);
> 
