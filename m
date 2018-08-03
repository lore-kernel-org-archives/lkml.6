Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D62C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F0A216FB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F0A216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeHCGRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 02:17:47 -0400
Received: from nautica.notk.org ([91.121.71.147]:34320 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbeHCGRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 02:17:47 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 3AE7DC009; Fri,  3 Aug 2018 06:23:23 +0200 (CEST)
Date:   Fri, 3 Aug 2018 06:23:08 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     jiangyiwen <jiangyiwen@huawei.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH] net/9p: Modify the problem of BUG_ON
 judgment
Message-ID: <20180803042308.GA4618@nautica>
References: <5B63D5F6.6080109@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B63D5F6.6080109@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jiangyiwen wrote on Fri, Aug 03, 2018:
> Because the value of limit is VIRTQUEUE_NUM, if index is equal to
> limit, it will cause sg array out of bounds, so correct the judgement
> of BUG_ON.
> 
> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>

I'm not sure you've acted on his mail or if you found this
independantly, but this was reported by Dan Carpenter on the list in
June.
Would you mind if I add a tag for him?
Reported-by: Dan Carpenter <dan.carpenter@oracle.com> 

That aside this looks good, I'll take it.

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

-- 
Dominique Martinet
