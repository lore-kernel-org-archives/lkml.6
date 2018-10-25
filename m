Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7166DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3550020834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3550020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJZAFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:05:06 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44694 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeJZAFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:05:06 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gFhbu-0004bB-9u; Thu, 25 Oct 2018 17:31:46 +0200
Message-ID: <986cb39001ee9eb11dd546b79de9e0b4b8463d19.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] kernel/workqueue: Remove lockdep annotation from
 __flush_work()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "tytso@mit.edu" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 17:31:27 +0200
In-Reply-To: <20181025150540.259281-2-bvanassche@acm.org>
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-2-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 15:05 +0000, Bart Van Assche wrote:
> As documented in a comment in start_flush_work(), calling flush_work()
> from a multi-threaded workqueue is safe if that workqueue is not
> equipped with a rescuer. Avoid that flush_work() calls from inside a
> work item executing on such a queue trigger a lockdep complaint.

So ... not sure I understand, do you happen to have an example (at least
conceptually) that shows the problem?

Something like

workqueue WQ, works W1, W2

W1 running on WQ -> flush_work(W2) also running on WQ?

I'm willing to believe that this is a corner case I missed with the
annotations since the rescuer things are tricky, but I don't think
removing them is the right thing to do.

> Remove
> the lockdep annotation from __flush_work() because start_flush_work()
> already has such an annotation.

This part at least isn't true, there's no annotation on the work
*struct*, only one on the work *queue*.

johannes

