Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929D4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 00:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D7E2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 00:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D7E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbeIDEvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 00:51:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeIDEvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 00:51:19 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8C8222C;
        Tue,  4 Sep 2018 00:28:44 +0000 (UTC)
Date:   Mon, 3 Sep 2018 17:28:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nilfs <linux-nilfs@vger.kernel.org>
Subject: Re: [PATCH v2] fs: Convert return type int to vm_fault_t
Message-Id: <20180903172843.9bf312c738ce8a434dd9c242@linux-foundation.org>
In-Reply-To: <CAFqt6zZckYhLJuJr9TSw2KOZrt6qD25xDctuvbKfm0jyBoPycA@mail.gmail.com>
References: <20180830172547.GA4408@jordon-HP-15-Notebook-PC>
        <20180830163352.5a96cc721ce069bed95fdbe8@linux-foundation.org>
        <CAFqt6zZckYhLJuJr9TSw2KOZrt6qD25xDctuvbKfm0jyBoPycA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 11:33:48 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> > > Return type of block_page_mkwrite_return() is also changed
> > > to use new vm_fault_t type.
> > > --- a/fs/nilfs2/file.c
> > > +++ b/fs/nilfs2/file.c
> > > @@ -51,13 +51,14 @@ int nilfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> > >       return err;
> > >  }
> > >
> > > -static int nilfs_page_mkwrite(struct vm_fault *vmf)
> > > +static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
> >
> > nilfs_page_mkwrite() already has return type vm_fault_t in Linus's
> > kernel, due to the now-merged
> > fs-nilfs2-adding-new-return-type-vm_fault_t.patch.  Looks like a simple
> > fix.
> >
> > I'm beginning to feel vm_fault_t exhaustion.  Please remind me what
> > benefit we're going to get out of all this churn?
> 
> The problem and benefit of these changes was discussed under this mail
> thread when the first vm_fault_t patch was posted.
> 
> https://marc.info/?l=linux-mm&m=152054772413234&w=4

That tells us about the merging plans.  But not much about what actual
benefit anyone gets from this.

This?

: There's some interesting patterns and commonalities between drivers
: (not to mention a few outright bugs) that we've noticed, and this'll be
: a good time to clean them up.

That is terribly vague.
