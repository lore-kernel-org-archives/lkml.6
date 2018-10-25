Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D247EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F232083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="vj6uCYS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F232083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeJZEzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:55:47 -0400
Received: from imap.thunk.org ([74.207.234.97]:58214 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeJZEzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GC1CXFCLg8YckOGqzyKDRUaEHw2hDZGANFjAiHS7KtI=; b=vj6uCYS89Nl7ISQKnDIYW0ijY6
        6+afbBaepj+O5icbS1nuHe38g+hDMcO/SU+uXLwzz+8Ewex75vHTR+le3W3mdZxYtb/HmaZ5ZIojL
        NW1KW3enUjYEdVX+AYEGwFNeJCG29bw5qMtLZNbEVDWFCx7K+Xt0WKlwsonVUDIIUpiw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gFm8E-00047d-JS; Thu, 25 Oct 2018 20:21:26 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A15DB7A447E; Thu, 25 Oct 2018 16:21:25 -0400 (EDT)
Date:   Thu, 25 Oct 2018 16:21:25 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] kernel/workqueue: Suppress a false positive lockdep
 complaint
Message-ID: <20181025202125.GA25649@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20181025150540.259281-1-bvanassche@acm.org>
 <20181025150540.259281-4-bvanassche@acm.org>
 <f7e631f3957f8e4d00b1b2dbf5b660d62d9e45e3.camel@sipsolutions.net>
 <1540482948.66186.21.camel@acm.org>
 <ea0342ec3d6b9b3504e1110cf1e0d3b1af28d877.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0342ec3d6b9b3504e1110cf1e0d3b1af28d877.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 09:59:38PM +0200, Johannes Berg wrote:
> > So, thinking about this more, can you guarantee (somehow) that the
> > workqueue is empty at this point?
> 
> (I hadn't looked at the code then - obviously that's guaranteed)

We can guarantee it from someone who is looking at the code path.  In
dio_set_defer_completion:

	if (!sb->s_dio_done_wq)
		return sb_init_dio_done_wq(sb);

And then sb_init_dio_done_wq:

int sb_init_dio_done_wq(struct super_block *sb)
{
	struct workqueue_struct *old;
	struct workqueue_struct *wq = alloc_workqueue("dio/%s",
						      WQ_MEM_RECLAIM, 0,
						      sb->s_id);
	if (!wq)
		return -ENOMEM;
	/*
	 * This has to be atomic as more DIOs can race to create the workqueue
	 */
	old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);
	/* Someone created workqueue before us? Free ours... */
	if (old)
		destroy_workqueue(wq);
	return 0;
}

The race found in the syzbot reproducer has multiple threads all
running DIO writes at the same time.  So we have multiple threads
calling sb_init_dio_done_wq, but all but one will lose the race, and
then call destry_workqueue on the freshly created (but never used)
workqueue.

We could replace the destroy_workqueue(wq) with a
"I_solemnly_swear_this_workqueue_has_never_been_used_please_destroy(wq)".

Or, as Tejun suggested, "destroy_workqueue_skip_drain(wq)", but there is
no way for the workqueue code to know whether the caller was using the
interface correctly.  So this basically becomes a philosophical
question about whether or not we trust the caller to be correct or
not.

I don't see an obvious way that we can test to make sure the workqueue
is never used without actually taking a performance.  Am I correct
that we would need to take the wq->mutex before we can mess with the
wq->flags field?

					- Ted
