Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24C8C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C1A2087B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C1A2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeHVKbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 06:31:06 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48686 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbeHVKbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 06:31:06 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fsNEn-0004W4-CS; Wed, 22 Aug 2018 09:07:29 +0200
Message-ID: <1534921643.25523.56.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] workqueue: skip lockdep wq dependency in
 cancel_work_sync()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        kernel-team@lge.com
Date:   Wed, 22 Aug 2018 09:07:23 +0200
In-Reply-To: <20180822054731.GB2414@X58A-UD3R>
References: <20180821120317.4115-1-johannes@sipsolutions.net>
         <20180821120317.4115-2-johannes@sipsolutions.net>
         <20180821160814.GP3978217@devbig004.ftw2.facebook.com>
         <1534871894.25523.34.camel@sipsolutions.net>
         <20180821172711.GR3978217@devbig004.ftw2.facebook.com>
         <1534872621.25523.39.camel@sipsolutions.net>
         <20180821175550.GS3978217@devbig004.ftw2.facebook.com>
         <1534879241.25523.44.camel@sipsolutions.net>
         <20180822024535.GA2414@X58A-UD3R>
         <1534910543.25523.50.camel@sipsolutions.net>
         <20180822054731.GB2414@X58A-UD3R>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-22 at 14:47 +0900, Byungchul Park wrote:
> On Wed, Aug 22, 2018 at 06:02:23AM +0200, Johannes Berg wrote:
> > On Wed, 2018-08-22 at 11:45 +0900, Byungchul Park wrote:
> > 
> > > That should've been adjusted as well when Ingo reverted Cross-release.
> > 
> > I can't really say.
> 
> What do you mean?

I haven't followed any of this, so I just don't know.

> > > It would be much easier to add each pair, acquire/release, before
> > > wait_for_completion() in both flush_workqueue() and flush_work() than
> > > reverting the whole commit.
> > 
> > The commit doesn't do much more than this though.
> 
> That also has named of lockdep_map for wq/work in a better way.

What do you mean?

> > > What's lacking is only lockdep annotations for wait_for_completion().
> > 
> > No, I disagree. Like I said before, we need the lockdep annotations on
> 
> You seem to be confused. I was talking about wait_for_completion() in
> both flush_workqueue() and flush_work(). Without
> the wait_for_completion()s, nothing matters wrt what you are concerning.

Yes and no.

You're basically saying if we don't get to do a wait_for_completion(),
then we don't need any lockdep annotation. I'm saying this isn't true.

Consider the following case:

work_function()
{
	mutex_lock(&mutex);
	mutex_unlock(&mutex);
}

other_function()
{
	queue_work(&my_wq, &work);

	if (common_case) {
		schedule_and_wait_for_something_that_takes_a_long_time()
	}

	mutex_lock(&mutex);
	flush_workqueue(&my_wq);
	mutex_unlock(&mutex);
}


Clearly this code is broken, right?

However, you'll almost never get lockdep to indicate that, because of
the "if (common_case)".

My argument basically is that the lockdep annotations in the workqueue
code should be entirely independent of the actual need to call
wait_for_completion().

Therefore, the commit should be reverted regardless of any cross-release 
work (that I neither know and thus don't understand right now), since it
makes workqueue code rely on lockdep for the completion, whereas we
really want to have annotations here even when we didn't actually need
to wait_for_completion().

johannes
