Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5561AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2347021871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbeLSK5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:57:08 -0500
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:58465 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726725AbeLSK5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:57:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B6432180A8850;
        Wed, 19 Dec 2018 10:57:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: women89_3b8f63be8e5b
X-Filterd-Recvd-Size: 3844
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Dec 2018 10:57:05 +0000 (UTC)
Message-ID: <6ef8274c8fc7adb7903cf3874fbab1098881ed4c.camel@perches.com>
Subject: Re: [PATCH] cifs: check kzalloc return
From:   Joe Perches <joe@perches.com>
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Dec 2018 02:57:04 -0800
In-Reply-To: <20181219072250.GA18501@osadl.at>
References: <1545150439-26055-1-git-send-email-hofrat@osadl.org>
         <4db484684a6e9b096c7fdf57673fd208d1c4005a.camel@perches.com>
         <20181219072250.GA18501@osadl.at>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-19 at 08:22 +0100, Nicholas Mc Guire wrote:
> On Tue, Dec 18, 2018 at 09:33:58AM -0800, Joe Perches wrote:
> > On Tue, 2018-12-18 at 17:27 +0100, Nicholas Mc Guire wrote:
> > > kzalloc can return NULL so a check is needed. While there is a
> > > check for ret_buf there is no check for the allocation of
> > > ret_buf->crfid.fid - this check is thus added. Both call-sites
> > > of tconInfoAlloc() check for NULL return of tconInfoAlloc()
> > > so returning NULL on failure of kzalloc() here seems appropriate.
> > > As the kzalloc() is the only thing here that can fail it is
> > > moved to the beginning so as not to initialize other resources
> > > on failure of kzalloc.
> > > 
> > Perhaps use a more common style by returning early on the
> > first possible failure too so the block can be unindented.
[]
> > yup the restructured cleanup would be the better way to go
> 
> rather than making this two patches I guess it would be the
> best to just skip the intermediate kzalloc only cleanup -
> atleast I see little value in that intermediat step - so
> could you take care of the kzalloc() in your refactoring 
> please ?

I did that in the patch I proposed, which is trivial.
If you want to take it, please do.

If you want a sign-off:

Signed-off-by: Joe Perches <joe@perches.com>

> > diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
[]
> > @@ -111,21 +111,27 @@ struct cifs_tcon *
> >  tconInfoAlloc(void)
> >  {
> >  	struct cifs_tcon *ret_buf;
> > -	ret_buf = kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
> > -	if (ret_buf) {
> > -		atomic_inc(&tconInfoAllocCount);
> > -		ret_buf->tidStatus = CifsNew;
> > -		++ret_buf->tc_count;
> > -		INIT_LIST_HEAD(&ret_buf->openFileList);
> > -		INIT_LIST_HEAD(&ret_buf->tcon_list);
> > -		spin_lock_init(&ret_buf->open_file_lock);
> > -		mutex_init(&ret_buf->crfid.fid_mutex);
> > -		ret_buf->crfid.fid = kzalloc(sizeof(struct cifs_fid),
> > -					     GFP_KERNEL);
> > -		spin_lock_init(&ret_buf->stat_lock);
> > -		atomic_set(&ret_buf->num_local_opens, 0);
> > -		atomic_set(&ret_buf->num_remote_opens, 0);
> > +
> > +	ret_buf = kzalloc(sizeof(*ret_buf), GFP_KERNEL);
> > +	if (!ret_buf)
> > +		return NULL;
> > +	ret_buf->crfid.fid = kzalloc(sizeof(*ret_buf->crfid.fid), GFP_KERNEL);
> > +	if (!ret_buf->crfid.fid) {
> > +		kfree(ret_buf);
> > +		return NULL;
> >  	}
> > +
> > +	atomic_inc(&tconInfoAllocCount);
> > +	ret_buf->tidStatus = CifsNew;
> > +	++ret_buf->tc_count;
> > +	INIT_LIST_HEAD(&ret_buf->openFileList);
> > +	INIT_LIST_HEAD(&ret_buf->tcon_list);
> > +	spin_lock_init(&ret_buf->open_file_lock);
> > +	mutex_init(&ret_buf->crfid.fid_mutex);
> > +	spin_lock_init(&ret_buf->stat_lock);
> > +	atomic_set(&ret_buf->num_local_opens, 0);
> > +	atomic_set(&ret_buf->num_remote_opens, 0);
> > +
> >  	return ret_buf;
> >  }
> >  


