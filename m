Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeEQSzl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeEQSzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:55:39 -0400
Message-ID: <49934b3d13263360fbf26bc56de2914db0b3513a.camel@kernel.org>
Subject: Re: [PATCH v2] vfs: avoid dereferencing pointers in iterate_supers
 callbacks
From: Jeff Layton <jlayton@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lurodriguez@suse.de
Date: Thu, 17 May 2018 14:55:36 -0400
In-Reply-To: <20180517182638.GD26718@bombadil.infradead.org>
References: <20180517154646.18751-1-jlayton@kernel.org>
         <20180517174336.18529-1-jlayton@kernel.org>
         <20180517182638.GD26718@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-17 at 11:26 -0700, Matthew Wilcox wrote:
> On Thu, May 17, 2018 at 01:43:36PM -0400, Jeff Layton wrote:
> > @@ -107,12 +109,10 @@ static void fdatawait_one_bdev(struct block_device *bdev, void *arg)
> >   */
> >  void ksys_sync(void)
> >  {
> > -	int nowait = 0, wait = 1;
> > -
> >  	wakeup_flusher_threads(WB_REASON_SYNC);
> >  	iterate_supers(sync_inodes_one_sb, NULL);
> > -	iterate_supers(sync_fs_one_sb, &nowait);
> > -	iterate_supers(sync_fs_one_sb, &wait);
> > +	iterate_supers(sync_fs_one_sb, NULL);
> > +	iterate_supers(sync_fs_one_sb, (void *)1UL);
> 
> I think this is actually less clear.  How about:
> 
> 	void *wait = (void *)1UL;
> 
> 	iterate_supers(sync_fs_one_sb, !wait);
> 	iterate_supers(sync_fs_one_sb, wait);
> 

Sure, I could do that. We could also keep the wait/nowait vars too, I
guess.
