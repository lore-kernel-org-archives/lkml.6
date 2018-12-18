Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7067EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1F1218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545173035;
	bh=IpVhtu/8/2gLvbXbuhee1XPy+QwPKBd0P/aV9bYpKzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y4fNhb1PgeexDvqtkKpkk4JSjtDz84DIzigOHBZAte80192X+Amn7vPrwz8cM4FKc
	 K7JFcMdz1qUVMeXTpFnKaMGyVUaZkLgUFGYpMans9mzMHofIXut8lIU9tOe1LS1gsJ
	 U1V/6amRy8EaCawvb3W+R3/xG5g9YEvC8O8CAhVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeLRWnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:43:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbeLRWnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:43:53 -0500
Received: from localhost (unknown [104.132.0.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A7D721871;
        Tue, 18 Dec 2018 22:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545173032;
        bh=IpVhtu/8/2gLvbXbuhee1XPy+QwPKBd0P/aV9bYpKzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4/G4+uKA4IANdbciUUJgA9NduYi2zZUTZ5zgfqvDnfbCjY72mErDuvNQmVS4Njz/
         HDQWQuBV6umLNEMvUcE966/lOx63R6KwwyOtFSce+PIy8DMFzh+DNwf740OsKEP3Mq
         xLIpmwfLg2iushcyMYDj9HHK7ejhOkhw3hu5qPgc=
Date:   Tue, 18 Dec 2018 14:43:51 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: flush stale issued discard
 candidates
Message-ID: <20181218224351.GC31062@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181214050127.45025-1-jaegeuk@kernel.org>
 <20181214050127.45025-3-jaegeuk@kernel.org>
 <639940cc-f7a8-e679-3b28-3b3b2485652b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <639940cc-f7a8-e679-3b28-3b3b2485652b@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18, Chao Yu wrote:
> On 2018/12/14 13:01, Jaegeuk Kim wrote:
> > Sometimes, I could observe # of issuing_discard to be 1 which blocks background
> > jobs due to is_idle()=false.
> > The only way to get out of it was to trigger gc_urgent. This patch avoids that
> > by checking any candidates as done in the list.
> 
> Well, as below code, once we issued discard commands, we will wait all
> queued discard end their IO, so do you know what flow can cause such
> condition...?

It's very subtle, and I suspect somehow race condition not from here.

> 
> 		issued = __issue_discard_cmd(sbi, &dpolicy);
> 		if (issued > 0) {
> 			__wait_all_discard_cmd(sbi, &dpolicy);
> 
> Or, I doubt that 'issued' statistical info could be wrong.

No, it simply came back to 0 with this patch. So, something is pending
in the queue even if it is done.

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/segment.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 49ea9009ab5a..acbbc924e518 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1651,6 +1651,10 @@ static int issue_discard_thread(void *data)
> >  		if (dcc->discard_wake)
> >  			dcc->discard_wake = 0;
> >  
> > +		/* clean up pending candidates before going to sleep */
> > +		if (atomic_read(&dcc->queued_discard))
> > +			__wait_all_discard_cmd(sbi, NULL);
> > +
> >  		if (try_to_freeze())
> >  			continue;
> >  		if (f2fs_readonly(sbi->sb))
> > 
