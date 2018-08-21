Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03801C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AAE20685
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mbj8hduM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AAE20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeHUT3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:29:02 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:43478 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeHUT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:29:02 -0400
Received: by mail-yb0-f193.google.com with SMTP id k5-v6so3116607ybo.10;
        Tue, 21 Aug 2018 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0dhg3KXcuFBSrlqPXQo0vgMhZCz/rSgxsEuuCH8IslY=;
        b=Mbj8hduMydTQHsiERlXYLgKbf0mr4OoDvEO+sfoqqj8qmBVZAgstS7F7jv7WKEAxMi
         skJd82wvS0hNpccOWJZlrW3s9QnptqdFMw8/W79J84BiXyhAjuzdxJL3gAhjSZI+VHM5
         mqU2r+xi8tZ+UiZuGyR55KjVFsDPFRAKA4skck9daFVIJMa17kKSwPdbg80uTybr1qsU
         B2DP0GVcXHKxTwqnYk16Q3ONMPpGDUGxI9bAlYUbyIkQmFZ4TK30M3/0rE+r5fnateG6
         +jKa9JR9KW2OUghT6ecvBzvhqPTwPakTx79mnwyyc2e8IZFP54exzkUjpNUcvfo2do51
         bw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0dhg3KXcuFBSrlqPXQo0vgMhZCz/rSgxsEuuCH8IslY=;
        b=rqSIGi9zXMb2zCEalsakbwhEhpnKfKTa9QBhPtgqTw8yDcXdG3GXQhihpa4oHch4hT
         7r2cW49ZCpiOoBDui60vAys/APzkbqWjwyOOj93zJCRFypV9is7WLGlA0Cs4r+GvRLmd
         pzg05acb1/OzYRuN6WZTvApNfZAhFkWIrlMD+Pd+HsvBuMk7gLPBIvnq8IC+HkmT7v05
         ci4g2/dwz92Fcam8wl8DquIDO/V3zlARpjFpcQTvEVtI4NJ+/465do4qbfr8wG1VzfFi
         G+OaE0M/RNJ++LFXQWlu1gW4/ncf4sh7pbbxQ5ytgHISqA+4SitYXucu8sP6Uw7GmCMQ
         AWFw==
X-Gm-Message-State: AOUpUlGDi1TahaGtv1jwwKKhSPTtW5VrLNt8XsxFTBhgg35bLUUmVVbb
        zQBfvjF0LQItNaN5rktObyH185/U
X-Google-Smtp-Source: AA+uWPzTpdfWAvf2UFogY8zLug7ndlWO1SO2G6Xnly8mfRJY8LxOPtuJ0OgIe+AEJZS9HfgfFc7lqg==
X-Received: by 2002:a25:348f:: with SMTP id b137-v6mr18743167yba.29.1534867697258;
        Tue, 21 Aug 2018 09:08:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:9c5d])
        by smtp.gmail.com with ESMTPSA id w6-v6sm982293ywg.3.2018.08.21.09.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 09:08:16 -0700 (PDT)
Date:   Tue, 21 Aug 2018 09:08:14 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 1/2] workqueue: skip lockdep wq dependency in
 cancel_work_sync()
Message-ID: <20180821160814.GP3978217@devbig004.ftw2.facebook.com>
References: <20180821120317.4115-1-johannes@sipsolutions.net>
 <20180821120317.4115-2-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821120317.4115-2-johannes@sipsolutions.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 02:03:16PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> In cancel_work_sync(), we can only have one of two cases, even
> with an ordered workqueue:
>  * the work isn't running, just cancelled before it started
>  * the work is running, but then nothing else can be on the
>    workqueue before it
> 
> Thus, we need to skip the lockdep workqueue dependency handling,
> otherwise we get false positive reports from lockdep saying that
> we have a potential deadlock when the workqueue also has other
> work items with locking, e.g.
> 
>   work1_function() { mutex_lock(&mutex); ... }
>   work2_function() { /* nothing */ }
> 
>   other_function() {
>     queue_work(ordered_wq, &work1);
>     queue_work(ordered_wq, &work2);
>     mutex_lock(&mutex);
>     cancel_work_sync(&work2);
>   }
> 
> As described above, this isn't a problem, but lockdep will
> currently flag it as if cancel_work_sync() was flush_work(),
> which *is* a problem.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  kernel/workqueue.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 78b192071ef7..a6c2b823f348 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2843,7 +2843,8 @@ void drain_workqueue(struct workqueue_struct *wq)
>  }
>  EXPORT_SYMBOL_GPL(drain_workqueue);
>  
> -static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr)
> +static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
> +			     bool from_cancel)
>  {
>  	struct worker *worker = NULL;
>  	struct worker_pool *pool;
> @@ -2885,7 +2886,8 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr)
>  	 * workqueues the deadlock happens when the rescuer stalls, blocking
>  	 * forward progress.
>  	 */
> -	if (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer) {
> +	if (!from_cancel &&
> +	    (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer)) {
>  		lock_map_acquire(&pwq->wq->lockdep_map);
>  		lock_map_release(&pwq->wq->lockdep_map);
>  	}

But this can lead to a deadlock.  I'd much rather err on the side of
discouraging complex lock dancing around ordered workqueues, no?

Thanks.

-- 
tejun
