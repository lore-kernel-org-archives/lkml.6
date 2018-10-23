Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA1EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4249920813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4249920813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeJXEPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:15:45 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44388 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJXEPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:15:45 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gF2hX-0004JE-1c; Tue, 23 Oct 2018 21:50:51 +0200
Message-ID: <dc47992cfd3300884aab8885caebe1072ddd6c71.camel@sipsolutions.net>
Subject: Re: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme @ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>
Date:   Tue, 23 Oct 2018 21:50:32 +0200
In-Reply-To: <8d1a9c8c-fddb-7fb9-4bba-377bc6d51829@acm.org> (sfid-20181023_031737_471584_691D2EF3)
References: <20181022151818.135163-1-bvanassche@acm.org>
         <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
         <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
         <1540241646.128590.16.camel@acm.org>
         <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
         <8d1a9c8c-fddb-7fb9-4bba-377bc6d51829@acm.org>
         (sfid-20181023_031737_471584_691D2EF3)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 18:17 -0700, Bart Van Assche wrote:

> It seems to me that the inode lock has been annotated correctly as an 
> rwsem. It's not clear to me however why lockdep complains about a 
> deadlock for the direct I/O code. I hope someone has the time to go to 
> the bottom of this.

I think the explanation I just sent should help clarify this.

The reason for the report is that with the workqueue annotations, we've
added new links to the chains that lockdep sees. I _think_ those
annotations are correct and only create links in the chain when they are
actually present, but since those links are between *classes* not
*instances* these new links may cause false positives.

I don't think the issue is the annotations of the inode lock per se, but
that the new links in the class chain cause these locks to cycle back to
themselves, which indicates a potential deadlock to lockdep.

Of course now we need to go in and tell lockdep that it shouldn't
consider these classes the same, but somebody who actually understands
why it's _fine_ that this ends up linking back to itself should do that.
I'm willing to help, but I'd have to have somebody on the phone who
knows about all these locks and workqueues and how they interact to be
able to do something useful.

Like I said in the other email though, I don't think arbitrarily
removing links from the lockdep chain is the right thing to do. Why
arbitrarily? Well, you might just as well remove the inode sem
annotations, and that would also break the chain, right? Yes, those have
been present longer, but for this particular instance it'd be
equivalent, you'd just get different reports in other places than if you
remove the workqueue annotations again.

johannes

