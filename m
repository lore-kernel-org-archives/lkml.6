Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89982C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C38420874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQ11rQRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C38420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937586AbeFSKk2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756608AbeFSKk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:40:26 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68142075E;
        Tue, 19 Jun 2018 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529404825;
        bh=fyJeNmOKrZI9cShy89XOz/7PAwt5F5C5rUsrocv+I+8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FQ11rQRE+JbiX82L5jWx5f1REREB+d5Xs9/fRJli/au/QwSsigYWuKBiSzOPcNGo8
         Xs/7kQYMuqFUR1Ble2IGwkvq6M+V8H3y5t2MagXKFTLPkJ/R7I3atvNak1QYptmO3j
         xRzpgNQ4WoL9Gndx2Ze1f3LwQ12rBIVNe15/dq5s=
Message-ID: <0ddda59286e0be135cf133dc653da54f66c264a7.camel@kernel.org>
Subject: Re: [PATCH 2/5] buffer: record blockdev write errors in super_block
 that backs them
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@ZenIV.linux.org.uk, dhowells@redhat.com,
        Jens Axboe <axboe@fb.com>, David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, andres@anarazel.de, cmaiolino@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Tue, 19 Jun 2018 06:40:23 -0400
In-Reply-To: <81a365a631279f8b0ad0ed71b222c19817045704.camel@kernel.org>
References: <20180604180304.9662-1-jlayton@kernel.org>
         <20180604180304.9662-3-jlayton@kernel.org>
         <81a365a631279f8b0ad0ed71b222c19817045704.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-06 at 11:56 -0400, Jeff Layton wrote:
> On Mon, 2018-06-04 at 14:03 -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> > 
> > When syncing out a block device (a'la __sync_blockdev), any error
> > encountered will only be recorded in the bd_inode's mapping. When the
> > blockdev contains a filesystem however, we'd like to also record the
> > error in the super_block that's stored there.
> > 
> > Make mark_buffer_write_io_error also record the error in the
> > corresponding super_block when a writeback error occurs and the block
> > device contains a mounted superblock.
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> >  fs/buffer.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 249b83fafe48..dae2a857d5bc 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -1117,6 +1117,8 @@ void mark_buffer_write_io_error(struct buffer_head *bh)
> >  		mapping_set_error(bh->b_page->mapping, -EIO);
> >  	if (bh->b_assoc_map)
> >  		mapping_set_error(bh->b_assoc_map, -EIO);
> > +	if (bh->b_bdev->bd_super)
> > +		errseq_set(&bh->b_bdev->bd_super->s_wb_err, -EIO);
> >  }
> >  EXPORT_SYMBOL(mark_buffer_write_io_error);
> >  
> 
> (cc'ing linux-block and Jens)
> 
> I'm wondering whether this patch might turn out to be racy. For
> instance, could a call to __sync_blockdev race with an unmount in such
> a way that bd_super goes NULL after we check it but before errseq_set
> is called?
> 
> If so, what can we do to ensure that that doesn't happen? Any insight
> here would be appreciated.
> 
> Thanks,

Jens, ping? I never got a response on the above.

After looking over it some more, I suspect that this may be racy with
some filesystems. Some of them seem to just flush out data to the
bd_inode on unmount, and trust the system to take care of the rest.

One possible fix there might be to turn bd_super into an RCU managed
pointer. We already free super_blocks under RCU, so we could do
something there like:

rcu_read_lock();
sb = rcu_dereference(bh->b_bdev->bd_super);
if (sb)
	errseq_set(&sb->s_wb_err, -EIO);
rcu_read_unlock();

There aren't that many accessors of bd_super, so that seems like it'd be
fairly simple to do.

Still, I'd like someone to sanity check me here. Is there something that
would prevent the above race that I'm not seeing?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
