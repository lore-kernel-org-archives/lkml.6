Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3380C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A730721531
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kXgEQphB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A730721531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbeHBSqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:46:07 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37558 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbeHBSqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:46:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E907C8EE13D;
        Thu,  2 Aug 2018 09:54:08 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z_Lcw2Uqykj6; Thu,  2 Aug 2018 09:54:08 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 33C108EE0E4;
        Thu,  2 Aug 2018 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1533228848;
        bh=KR1OilPoffnqDJ8TvY/IhbwigcvVf3NpaTYyRobxsNU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kXgEQphB0mNUml6sR/FNFJzAlr5M41/dgAJq6wlBbiSBXWQ3Zji4YxEk9JdarBHyA
         RVjO2kA7s24FWaqL2TU9K+UphE+/sYviCxP/m2hGETZlAmxm/3DtOuTQz0Jk91AlGx
         TaqFsbBA8FxQSCwLUlNBSbcufFeDyah4AhnWchro=
Message-ID: <1533228846.3915.17.camel@HansenPartnership.com>
Subject: Re: [PATCH] blk-mq: fix blk_mq_tagset_busy_iter
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Aug 2018 09:54:06 -0700
In-Reply-To: <20180802164329.11900-1-ming.lei@redhat.com>
References: <20180802164329.11900-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 00:43 +0800, Ming Lei wrote:
> Commit d250bf4e776ff09d5("blk-mq: only iterate over inflight requests
> in blk_mq_tagset_busy_iter") uses 'blk_mq_rq_state(rq) ==
> MQ_RQ_IN_FLIGHT'
> to replace 'blk_mq_request_started(req)', this way is wrong, and
> causes
> lots of test system hang during booting.
> 
> Fix the issue by using blk_mq_request_started(req) inside
> bt_tags_iter().
> 
> Fixes: d250bf4e776ff09d5 ("blk-mq: only iterate over inflight
> requests in blk_mq_tagset_busy_iter")
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matt Hart <matthew.hart@linaro.org>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Hannes Reinecke <hare@suse.com>,
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
> Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
> Cc: linux-scsi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-tag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 09b2ee6694fb..3de0836163c2 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -271,7 +271,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap,
> unsigned int bitnr, void *data)
>  	 * test and set the bit before assining ->rqs[].
>  	 */
>  	rq = tags->rqs[bitnr];
> -	if (rq && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
> +	if (rq && blk_mq_request_started(rq))

So now we have dueling versions of this patch:

https://marc.info/?l=linux-scsi&m=153322802207688

Can we at least make sure we've root caused the problem and confirmed
we've got it fixed before we start the formal patch process?  When we
do start the formal patch process, please give appropriate credit to
the reporter(s) since this has been a royal pain for them to help us
track down.

James

