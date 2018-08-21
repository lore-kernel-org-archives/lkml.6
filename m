Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC231C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618692170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618692170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeHUNcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:32:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726580AbeHUNcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:32:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DE5A68802;
        Tue, 21 Aug 2018 10:12:35 +0000 (UTC)
Received: from localhost (ovpn-116-132.ams2.redhat.com [10.36.116.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B11C2166BA1;
        Tue, 21 Aug 2018 10:12:34 +0000 (UTC)
Date:   Tue, 21 Aug 2018 12:12:33 +0200
From:   Niels de Vos <ndevos@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcin Sulikowski <marcin.k.sulikowski@gmail.com>
Subject: Re: [PATCH v3] fuse: add support for copy_file_range()
Message-ID: <20180821101233.GD2650@ndevos-x270>
References: <20180629121630.GS2345@ndevos-x270>
 <20180629125341.30466-1-ndevos@redhat.com>
 <CAJfpegstirk9AymSO3GHixNWCd_wNwvXRKj0zyVNDX3ftMqkHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegstirk9AymSO3GHixNWCd_wNwvXRKj0zyVNDX3ftMqkHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 21 Aug 2018 10:12:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 21 Aug 2018 10:12:35 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ndevos@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 02:02:35PM +0200, Miklos Szeredi wrote:
> On Fri, Jun 29, 2018 at 2:53 PM, Niels de Vos <ndevos@redhat.com> wrote:
> > There are several FUSE filesystems that can implement server-side copy
> > or other efficient copy/duplication/clone methods. The copy_file_range()
> > syscall is the standard interface that users have access to while not
> > depending on external libraries that bypass FUSE.
> >
> > Signed-off-by: Niels de Vos <ndevos@redhat.com>
> >
> > ---
> > v2: return ssize_t instead of long
> > v3: add nodeid_out to fuse_copy_file_range_in for libfuse expectations
> > ---
> >  fs/fuse/file.c            |  66 +++++++++++++++++++++++
> >  fs/fuse/fuse_i.h          |   3 ++
> >  include/uapi/linux/fuse.h | 107 ++++++++++++++++++++++----------------
> >  3 files changed, 132 insertions(+), 44 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 67648ccbdd43..864939a1215d 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -3009,6 +3009,71 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
> >         return err;
> >  }
> >
> > +static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
> > +                                   struct file *file_out, loff_t pos_out,
> > +                                   size_t len, unsigned int flags)
> > +{
> > +       struct fuse_file *ff_in = file_in->private_data;
> > +       struct fuse_file *ff_out = file_out->private_data;
> > +       struct inode *inode_out = file_inode(file_out);
> > +       struct fuse_inode *fi_out = get_fuse_inode(inode_out);
> > +       struct fuse_conn *fc = ff_in->fc;
> > +       FUSE_ARGS(args);
> > +       struct fuse_copy_file_range_in inarg = {
> > +               .fh_in = ff_in->fh,
> > +               .off_in = pos_in,
> > +               .nodeid_out = ff_out->nodeid,
> > +               .fh_out = ff_out->fh,
> > +               .off_out = pos_out,
> > +               .len = len,
> > +               .flags = flags
> > +       };
> > +       struct fuse_copy_file_range_out outarg;
> > +       ssize_t err;
> > +
> > +       if (fc->no_copy_file_range)
> > +               return -EOPNOTSUPP;
> > +
> > +       inode_lock(inode_out);
> > +       set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
> 
> This one is only needed in the non-writeback-cache case and only if
> the operations is size extending.
> 
> Here's how the writeback-cache is supposed to work: the kernel buffers
> writes, just like a normal filesystem, as well as buffering related
> metadata updates (size & [cm]time), again, just like a normal
> filesystem.  This means we just don't care about i_size being updated
> in userspace, any such change will be overwritten when the metadata is
> flushed out.
> 
> In writeback-cache mode, when we do any other data modification, we
> need to first flush out the cache so that the order of writes is not
> mixed up.  See fallocate() for example.  We could be selective and
> only flush the range covered by [pos, pos+len], but just flushing
> everything is okay.

Thanks! I think I understood what you mean and I'll be sending an
updated version soon.

> I could add these, but you already have a test for this set up, so, I
> wouldn't mind if you post a new version.

No problem. I got something ready and tested on my side.


...
> > +       FUSE_POLL            = 40,
> > +       FUSE_NOTIFY_REPLY    = 41,
> > +       FUSE_BATCH_FORGET    = 42,
> > +       FUSE_FALLOCATE       = 43,
> > +       FUSE_READDIRPLUS     = 44,
> > +       FUSE_RENAME2         = 45,
> > +       FUSE_LSEEK           = 46,
> > +       FUSE_COPY_FILE_RANGE = 47,
> 
> Nit: please do tabulation with tabs instead of spaces.

Will do.


> >
> >         /* CUSE specific operations */
> >         CUSE_INIT          = 4096,
> > @@ -792,4 +796,19 @@ struct fuse_lseek_out {
> >         uint64_t        offset;
> >  };
> >
> > +struct fuse_copy_file_range_in {
> > +       uint64_t        fh_in;
> > +       uint64_t        off_in;
> > +       uint64_t        nodeid_out;
> > +       uint64_t        fh_out;
> > +       uint64_t        off_out;
> > +       uint64_t        len;
> > +       uint32_t        flags;
> 
> Why not uint64_t for flags?

Everything else uses uint32_t for flags in this file. I'll make it
uint64_t in the next update.


> > +};
> > +
> > +struct fuse_copy_file_range_out {
> > +       uint32_t        size;
> > +       uint32_t        padding;
> > +};
> 
> Could reuse "struct fuse_write_out" for this.   Helps with the
> userspace interface as well, since the same fuse_reply_write()
> function can be used.

I considered that before as well. In case the interface changes an
updated struct fuse_copy_file_range_out can always be added later. And
hopefully there is no reason to change it at all.

At the moment I am running a few more test to verify an updated patch,
and will send it out later today.

Niels
