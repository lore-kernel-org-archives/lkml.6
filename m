Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D35CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5E620834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="QUDBLCG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5E620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeJZANk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:13:40 -0400
Received: from imap.thunk.org ([74.207.234.97]:57300 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbeJZANk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=//ygogdN1tbhh7RbM60T5sXv4fskOMmTEjXlvuXrZX8=; b=QUDBLCG48hj9B7R/W60qVOggJA
        vfiA7us4R06Lk10nu3/S+9w0yDScUA+Q3LYCm0lOzIAhi4GwkXx8GJu5b9pfT+7I/GGhXKCI9L1uk
        avIgca6gKqCqDVuhB3PrFLVCVIKESWzWMCbhV1PQxS4uon6xeyI03w7i2RLEye1Fis58=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gFhjw-0001xD-06; Thu, 25 Oct 2018 15:40:04 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2EAF57A447E; Thu, 25 Oct 2018 11:40:03 -0400 (EDT)
Date:   Thu, 25 Oct 2018 11:40:03 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] kernel/workqueue: Suppress a false positive lockdep
 complaint
Message-ID: <20181025154003.GE4970@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20181025150540.259281-1-bvanassche@acm.org>
 <20181025150540.259281-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025150540.259281-4-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 08:05:40AM -0700, Bart Van Assche wrote:
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index fc9129d5909e..0ef275fe526c 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1383,6 +1383,10 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>  	if (unlikely(wq->flags & __WQ_DRAINING) &&
>  	    WARN_ON_ONCE(!is_chained_work(wq)))
>  		return;
> +
> +	if (!(wq->flags & __WQ_HAS_BEEN_USED))
> +		wq->flags |= __WQ_HAS_BEEN_USED;
> +
>  retry:
>  	if (req_cpu == WORK_CPU_UNBOUND)
>  		cpu = wq_select_unbound_cpu(raw_smp_processor_id());

I was looking to fix this problem as well, and I thought about doing
this, but I thought wq->mutex had to be taken in order to modify
wq->flags --- and that would destroy the scalability of the
add-to-work-to-queue functions.

We could switch all of wq->flags to use the {test,set,clear}_bits()
family of operations, but that seemed like a very large change.

Tejun seemed to be ok with creating a destroy_workqueue_no_drain()
function and using that instead of destroy_workqueue() for the losers
of the cmpxchg lockless initialization code in sb_init_dio_done_wq()
in fs/direct_io.c.

						- Ted
