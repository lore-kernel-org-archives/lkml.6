Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE56BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B032920869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpJPErif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B032920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbeKFWp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:45:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388434AbeKFWp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:45:56 -0500
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EE982085B;
        Tue,  6 Nov 2018 13:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541510445;
        bh=ICIOhIj5XnMiv5FVeXS3eCUhGB2hs3XIjh73cYGCY+8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kpJPErif8EV4oFiK722wbNqjbi4aQcHHN+h/7WEUk7KZFPFpJ1J+Q0HSkQzy4AJH4
         jywY1Q7CL3PSD+mLc+xmMDjCsPxFCc43L9EX+3/rruaOvETg5NLW29QEl4Q4GIBpvq
         g/5j1FcCoUGomxyUxpeSeqeGsIMO1R6YVWwOnmUc=
Message-ID: <60e81aebf4e76c6eafe90618a3e1f04a0ee3de87.camel@kernel.org>
Subject: Re: [PATCH 04/12] gfs2: properly initial file_lock used for unlock.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 08:20:42 -0500
In-Reply-To: <875zxbyo19.fsf@notabene.neil.brown.name>
References: <154138128401.31651.1381177427603557514.stgit@noble>
         <154138144777.31651.4516223215037533891.stgit@noble>
         <efbaeb736e4738bb7a0e2f8529bf1db8459bbe56.camel@kernel.org>
         <875zxbyo19.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-06 at 12:48 +1100, NeilBrown wrote:
> On Mon, Nov 05 2018, Jeff Layton wrote:
> 
> > On Mon, 2018-11-05 at 12:30 +1100, NeilBrown wrote:
> > > Rather than assuming all-zeros is sufficient, use the available API to
> > > initialize the file_lock structure use for unlock.
> > > VFS-level changes will soon make it important that the
> > > list_heads in file_lock are always properly initialized.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.com>
> > > ---
> > >  fs/gfs2/file.c |   10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> > > index 45a17b770d97..271f847705e3 100644
> > > --- a/fs/gfs2/file.c
> > > +++ b/fs/gfs2/file.c
> > > @@ -1199,13 +1199,13 @@ static int do_flock(struct file *file, int cmd, struct file_lock *fl)
> > >  	mutex_lock(&fp->f_fl_mutex);
> > >  
> > >  	if (gfs2_holder_initialized(fl_gh)) {
> > > +		struct file_lock request;
> > >  		if (fl_gh->gh_state == state)
> > >  			goto out;
> > > -		locks_lock_file_wait(file,
> > > -				     &(struct file_lock) {
> > > -					     .fl_type = F_UNLCK,
> > > -					     .fl_flags = FL_FLOCK
> > > -				     });
> > > +		locks_init_lock(&request);
> > > +		request.fl_type = F_UNLOCK;
> > 
> > F_UNLCK ?
> > 
> > The ocfs2 patch has the same bug.
> 
> Anyone would think that I hadn't even compile tested.....
> 
> This is true for OCFS2 :-( but I had actually compile-tested with GFS2
> enabled.
> But CONFIG_DLM *wasn't* enabled, so GFS2 was compiled without locking
> support.
> I guess there is a good reason that GFS2 doesn't require DLM.
> 

I think you can run GFS2 in a single-node configuration with local
locking.

> Do you want me to resend the series, to will you just update those
> patches.
> 
> Sorry about that,
> NeilBrown
> 

No worries. I'll just fix those patches up and note it in the
changelogs. Other than the build failure, this seems to be doing fine in
testing so far. I'll likely push them to linux-next later this week.


> > 
> > > +		request.fl_flags = FL_FLOCK;
> > > +		locks_lock_file_wait(file, &request);
> > >  		gfs2_glock_dq(fl_gh);
> > >  		gfs2_holder_reinit(state, flags, fl_gh);
> > >  	} else {
> > > 
> > > 

Thanks again!
-- 
Jeff Layton <jlayton@kernel.org>

