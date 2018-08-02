Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95519C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B54E21546
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B54E21546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbeHBTQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:16:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbeHBTQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:16:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 369787DAC3;
        Thu,  2 Aug 2018 17:24:05 +0000 (UTC)
Received: from ming.t460p (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3D4C2026D69;
        Thu,  2 Aug 2018 17:23:51 +0000 (UTC)
Date:   Fri, 3 Aug 2018 01:23:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix blk_mq_tagset_busy_iter
Message-ID: <20180802172345.GE8928@ming.t460p>
References: <20180802164329.11900-1-ming.lei@redhat.com>
 <1533228846.3915.17.camel@HansenPartnership.com>
 <20180802170601.GC8928@ming.t460p>
 <acd8de2a-4a24-385c-e76a-5f54c8dc09d7@kernel.dk>
 <1533230318.12916.2.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1533230318.12916.2.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 02 Aug 2018 17:24:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 02 Aug 2018 17:24:05 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 10:18:38AM -0700, James Bottomley wrote:
> On Thu, 2018-08-02 at 11:08 -0600, Jens Axboe wrote:
> > On 8/2/18 11:06 AM, Ming Lei wrote:
> > > On Thu, Aug 02, 2018 at 09:54:06AM -0700, James Bottomley wrote:
> > > > On Fri, 2018-08-03 at 00:43 +0800, Ming Lei wrote:
> > > > > Commit d250bf4e776ff09d5("blk-mq: only iterate over inflight
> > > > > requests
> > > > > in blk_mq_tagset_busy_iter") uses 'blk_mq_rq_state(rq) ==
> > > > > MQ_RQ_IN_FLIGHT' to replace 'blk_mq_request_started(req)', this
> > > > > way is wrong, and causes lots of test system hang during
> > > > > booting.
> > > > > 
> > > > > Fix the issue by using blk_mq_request_started(req) inside
> > > > > bt_tags_iter().
> > > > > 
> > > > > Fixes: d250bf4e776ff09d5 ("blk-mq: only iterate over inflight
> > > > > requests in blk_mq_tagset_busy_iter")
> > > > > Cc: Josef Bacik <josef@toxicpanda.com>
> > > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > > Cc: Mark Brown <broonie@kernel.org>
> > > > > Cc: Matt Hart <matthew.hart@linaro.org>
> > > > > Cc: Johannes Thumshirn <jthumshirn@suse.de>
> > > > > Cc: John Garry <john.garry@huawei.com>
> > > > > Cc: Hannes Reinecke <hare@suse.com>,
> > > > > Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
> > > > > Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
> > > > > Cc: linux-scsi@vger.kernel.org
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > ---
> > > > >  block/blk-mq-tag.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > > > > index 09b2ee6694fb..3de0836163c2 100644
> > > > > --- a/block/blk-mq-tag.c
> > > > > +++ b/block/blk-mq-tag.c
> > > > > @@ -271,7 +271,7 @@ static bool bt_tags_iter(struct sbitmap
> > > > > *bitmap,
> > > > > unsigned int bitnr, void *data)
> > > > >  	 * test and set the bit before assining ->rqs[].
> > > > >  	 */
> > > > >  	rq = tags->rqs[bitnr];
> > > > > -	if (rq && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
> > > > > +	if (rq && blk_mq_request_started(rq))
> > > > 
> > > > So now we have dueling versions of this patch:
> > > > 
> > > > https://marc.info/?l=linux-scsi&m=153322802207688
> > > > 
> > > > Can we at least make sure we've root caused the problem and
> > > > confirmed we've got it fixed before we start the formal patch
> > > > process?  When we
> > > 
> > > EH uses scsi_host_busy to check if the error handler needs to be
> > > waken up. And blk_mq_tagset_busy_iter() is used for implementing
> > > scsi_host_busy(), so causes EH not waken up, then this timed-out
> > > request can't be handled.
> 
> Yes, I know what the problem is and why this patch is necessary and
> that it is very likely the root cause.  However, can we confirm that it
> fixes the boot hang completely before we declare victory?

Frankly speaking, I can reproduce & verify it, but still suggest to wait
for ack from our report guys.

> 
> > > > do start the formal patch process, please give appropriate credit
> > > > to the reporter(s) since this has been a royal pain for them to
> > > > help us track down.
> > > 
> > > Sure.
> > > 
> > > Jens, could you add reported-by if you are fine with this version?
> > > Or please just let me know if new version is needed, then I can add
> > > it.
> > 
> > I'll add that, would also love a tested-by from the reporter. The
> > patch looks good to me, however.
> 
> Is there a reason why blk_mq_request_started() isn't a static inline? 
> It looks to be somewhat in the hot path.

Looks good idea, which should have been in header file, will do it in
V2.

Thanks,
Ming
