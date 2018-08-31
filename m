Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12729C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F5320661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qrHL2/mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F5320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeHaSiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:38:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeHaSiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fMCemegQnyuRXe3rpJk0Tz/7i5F8/97y2iTDT7TwqEI=; b=qrHL2/mtkVyQ5+fM3HimAU9Wh
        zndRRMWqAPECe7OcJ12nNsLtpHIO+/241+5kUuNqmXxK4X/bOCJfwDlau9qe/s2DdkNc1In7J4YzU
        zWpflyxN0VGGT/LK+8pAK0QAqPdeRBAsf7N4CpYevm5XvWSbrgT7YbdCe8JDZ7jeS2O7PnGuVKO6r
        Qb8iVv7eiGtV/sNUiWyIYBFK9o19M/hXp+2YyRazhER01+qpmS8clz4ZrlExy+cs+y4l0JXRfQ6s6
        lUUly45zZMAQC987BB+42B6R5DwlRJfjUsuBLkZlrCAMJ3WyJaYlWGcylIzoTaeymRwiE4OI8BkKF
        iJwubyLUQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvkRx-00050N-2U; Fri, 31 Aug 2018 14:31:01 +0000
Date:   Fri, 31 Aug 2018 07:31:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Waiman Long <longman@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/2] fs/dcache: Track & report number of negative dentries
Message-ID: <20180831143100.GA6379@bombadil.infradead.org>
References: <1535476780-5773-1-git-send-email-longman@redhat.com>
 <1535476780-5773-2-git-send-email-longman@redhat.com>
 <20180829001153.GD1572@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829001153.GD1572@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:11:53AM +1000, Dave Chinner wrote:
> > +++ b/Documentation/sysctl/fs.txt
> > @@ -63,19 +63,26 @@ struct {
> >          int nr_unused;
> >          int age_limit;         /* age in seconds */
> >          int want_pages;        /* pages requested by system */
> > -        int dummy[2];
> > +        int nr_negative;       /* # of unused negative dentries */
> > +        int dummy;
> >  } dentry_stat = {0, 0, 45, 0,};
> 
> That's not a backwards compatible ABI change. Those dummy fields
> used to represent some metric we no longer calculate, and there are
> probably still monitoring apps out there that think they still have
> the old meaning. i.e. they are still visible to userspace:

I believe you are incorrect.  dentry_stat was introduced in 2.1.60 with
this hunk:

+struct {
+       int nr_dentry;
+       int nr_unused;
+       int age_limit;          /* age in seconds */
+       int want_pages;         /* pages requested by system */
+       int dummy[2];
+} dentry_stat = {0, 0, 45, 0,};
+

Looking through the rest of the dentry_stat changes in the 2.1.60 release,
it's not replacing anything, it's adding new information.
