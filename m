Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467C0ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 17:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24A020871
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 17:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24A020871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeGNRzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 13:55:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40930 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbeGNRzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 13:55:13 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AFCB680541; Sat, 14 Jul 2018 19:35:26 +0200 (CEST)
Date:   Sat, 14 Jul 2018 19:35:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
Message-ID: <20180714173516.uumlhs4wgfgrlc32@devuan>
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
 <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
 <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org>
 <1530570880.3179.9.camel@HansenPartnership.com>
 <20180702161925.1c717283dd2bd4a221bc987c@linux-foundation.org>
 <20180703091821.oiywpdxd6rhtxl4p@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703091821.oiywpdxd6rhtxl4p@quack2.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes, "should be".  I could understand that the presence of huge
> > nunmbers of -ve dentries could result in undesirable reclaim of
> > pagecache, etc.  Triggering oom-killings is very bad, and presumably
> > has the same cause.
> > 
> > Before we go and add a large amount of code to do the shrinker's job
> > for it, we should get a full understanding of what's going wrong.  Is
> > it because the dentry_lru had a mixture of +ve and -ve dentries? 
> > Should we have a separate LRU for -ve dentries?  Are we appropriately
> > aging the various dentries?  etc.
> > 
> > It could be that tuning/fixing the current code will fix whatever
> > problems inspired this patchset.
> 
> What I think is contributing to the problems and could lead to reclaim
> oddities is the internal fragmentation of dentry slab cache. Dentries are
> relatively small, you get 21 per page on my system, so if trivial to
> reclaim negative dentries get mixed with a small amount of unreclaimable
> positive dentries, you can get a lot of pages in dentry slab cache that are
> unreclaimable.

Could we allocate -ve entries from separate slab?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
