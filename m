Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F9CC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D652080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D652080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeJ3SaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:30:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbeJ3SaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:30:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83A063001971;
        Tue, 30 Oct 2018 09:37:43 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB08619745;
        Tue, 30 Oct 2018 09:37:38 +0000 (UTC)
Date:   Tue, 30 Oct 2018 17:37:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Balbir Singh <sblbir@amzn.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add cmd_flags to print_req_error
Message-ID: <20181030093708.GC13582@ming.t460p>
References: <20181030024015.1092-1-sblbir@amzn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030024015.1092-1-sblbir@amzn.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 30 Oct 2018 09:37:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 02:40:15AM +0000, Balbir Singh wrote:
> I ran into a bug where after hibernation due to incompatible
> backends, the block driver returned BLK_STS_NOTSUPP, with the
> current message it's hard to find out what the command flags
> were. Adding req->cmd_flags help make the problem easier to
> diagnose.
> 
> Signed-off-by: Balbir Singh <sblbir@amzn.com>
> Reviewed-by: Eduardo Valentin <eduval@amazon.com>
> ---
> 
> Testing: Compile tested at my end
> 
> Changelog
>   - convert %llx to %x and remove casting to unsigned long long
> 
>  block/blk-core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index cdfabc5646da..0fd6104bb0d2 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -256,10 +256,11 @@ static void print_req_error(struct request *req, blk_status_t status)
>  	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
>  		return;
>  
> -	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu\n",
> -			   __func__, blk_errors[idx].name, req->rq_disk ?
> -			   req->rq_disk->disk_name : "?",
> -			   (unsigned long long)blk_rq_pos(req));
> +	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %x\n",
> +				__func__, blk_errors[idx].name,
> +				req->rq_disk ?  req->rq_disk->disk_name : "?",
> +				(unsigned long long)blk_rq_pos(req),
> +				req->cmd_flags);
>  }
>  
>  static void req_bio_endio(struct request *rq, struct bio *bio,
> -- 
> 2.16.2
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
