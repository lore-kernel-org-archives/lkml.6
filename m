Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F2CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F2820834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F2820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeJZAIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:08:30 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44732 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJZAI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:08:29 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gFhfB-0004eh-0S; Thu, 25 Oct 2018 17:35:09 +0200
Message-ID: <f7e631f3957f8e4d00b1b2dbf5b660d62d9e45e3.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] kernel/workqueue: Suppress a false positive lockdep
 complaint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "tytso@mit.edu" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 17:34:50 +0200
In-Reply-To: <20181025150540.259281-4-bvanassche@acm.org>
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-4-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 15:05 +0000, Bart Van Assche wrote:

> @@ -2889,7 +2893,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
>  	 * workqueues the deadlock happens when the rescuer stalls, blocking
>  	 * forward progress.
>  	 */
> -	if (!from_cancel &&
> +	if (!from_cancel && (pwq->wq->flags & __WQ_HAS_BEEN_USED) &&
>  	    (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer)) {
>  		lock_acquire_exclusive(&pwq->wq->lockdep_map, 0, 0, NULL,
>  				       _THIS_IP_);

This also doesn't seem right to me. You shouldn't really care whether or
not the workqueue has been used at this point, lockdep also doesn't do
this for locks.

Any dependency you cause at some point can - at a future time - be taken
into account when checking dependency cycles. Removing one arbitrarily
just because you haven't actually executed anything *yet* just removes
knowledge from lockdep. In the general case, this isn't right. Just
because you haven't executd anything here doesn't mean that it's
*impossible* to have executed something, right?

(Also, still trying to understand patch 2)

johannes

