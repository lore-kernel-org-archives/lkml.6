Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0ABC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F66206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F66206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeIFNMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:12:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:38938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727827AbeIFNMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:12:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 164DEAE39;
        Thu,  6 Sep 2018 08:38:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 983E21E3606; Thu,  6 Sep 2018 10:38:00 +0200 (CEST)
Date:   Thu, 6 Sep 2018 10:38:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com,
        ak@linux.intel.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        mgorman@techsingularity.net, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com, zwisler@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: linux-next test error
Message-ID: <20180906083800.GC19319@quack2.suse.cz>
References: <0000000000004f6b5805751a8189@google.com>
 <20180905085545.GD24902@quack2.suse.cz>
 <CAFqt6zZtjPFdfAGxp43oqN3=z9+vAGzdOvDcgFaU+05ffCGu7A@mail.gmail.com>
 <20180905133459.GF23909@thunk.org>
 <CAFqt6za5OvHgONOgpmhxS+YsYZyiXUhzpmOgZYyHWPHEO34QwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6za5OvHgONOgpmhxS+YsYZyiXUhzpmOgZYyHWPHEO34QwQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-09-18 00:54:50, Souptick Joarder wrote:
> On Wed, Sep 5, 2018 at 7:05 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Wed, Sep 05, 2018 at 03:20:16PM +0530, Souptick Joarder wrote:
> > >
> > > "fs: convert return type int to vm_fault_t" is still under
> > > review/discusson and not yet merge
> > > into linux-next. I am not seeing it into linux-next tree.Can you
> > > please share the commit id ?
> >
> > It's at: 83c0adddcc6ed128168e7b87eaed0c21eac908e4 in the Linux Next
> > branch.
> >
> > Dmitry, can you try reverting this commit and see if it makes the
> > problem go away?
> >
> > Souptick, can we just NACK this patch and completely drop it from all
> > trees?
> 
> Ok, I will correct it and post v3.
> 
> >
> > I think we need to be a *lot* more careful about this vm_fault_t patch
> > thing.  If you can't be bothered to run xfstests, we need to introduce
> > a new function which replaces block_page_mkwrite() --- and then let
> > each file system try to convert over to it at their own pace, after
> > they've done regression testing.
> >
> >                                                 - Ted
> 
> Chris has his opinion,
> 
> block_page_mkwrite is only called by ext4 and nilfs2 anyway, so
> converting both callers over should not be a problem, as long as
> it actually is done properly.
> 
> Matthew's opinion in other mail thread -
> 
> > +vm_fault_t block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
> > +                      get_block_t get_block, int *err)
> 
> I don't like returning both the errno and the vm_fault_t.  To me that's a
> sign we need to rethink this interface.
> 
> I have two suggestions.  First, we could allocate a new VM_FAULT_NOSPC
> bit.  Second, we could repurpose one of the existing bits, such as
> VM_FAULT_RETRY for this purpose.
> 
> > -int ext4_page_mkwrite(struct vm_fault *vmf)
> > +vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
> 
> I also think perhaps we could start by _not_ converting block_page_mkwrite().
> Just convert ext4_page_mkwrite(), and save converting block_page_mkwrite()
> for later.

Yes, I'd start with converting ext4_page_mkwrite() - that should be pretty
straightforward - and we can leave block_page_mkwrite() as is for now. I
don't think allocating other VM_FAULT_ codes is going to cut it as
generally the filesystem may need to communicate different error codes back
and you don't know in advance which are interesting.

One solution for passing error codes we could use with vm_fault_t is a
scheme similar to ERR_PTR. So we can store full error code in vm_fault_t
and still have a plenty of space for the special VM_FAULT_ return codes...
With that scheme converting block_page_mkwrite() would be trivial.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
