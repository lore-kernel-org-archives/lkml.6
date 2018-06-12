Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0D9F3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2F72089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ASARBvjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2F72089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbeFLMiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:38:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40631 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754261AbeFLMio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:38:44 -0400
Received: by mail-wr0-f196.google.com with SMTP id l41-v6so23911890wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8igkeC3p6qSl34fnjLhJQIXQpx3GsS8f57ROFqW3Q4I=;
        b=ASARBvjVC2PSZ9wKuGixE7F524qq43uF4VLBwOFVLOo5U6hdoQ0Rij5SHJQAmFGsWc
         9qWP1Z9K16Tf/tpFLyQOB4m1YWTiLIj+/qSiqFLd89xorvzLq64TQI1xzUyr8n9QGjbs
         b4P2uh4VjxymYY8mpJJuRYTQObnwW5IuPwnz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8igkeC3p6qSl34fnjLhJQIXQpx3GsS8f57ROFqW3Q4I=;
        b=FG5f3FtjJZHH3tet6/XOhcEDrtbLVIjx0rb/+degDHkgTCi+eLcLrC/Sgu5/JdBJNc
         8MEcE/px8mNBR5XrZTeavEJlIqB1NNsDmdurtI8b59a1G9QObhMb4OVodN95AnuGub+H
         c6PYz7ZKN/SvIfpY1wAMKZlXJsCpj+4b/UZxcZ0qsRrwez59fsdPFhmivbTgGoK1yzOi
         4S87LcH8EIagzk32U0Q0aJl0UOsS5WD9fS7KC7jxNk/0kzcgd7gURzeK9CfM9dB7LzqR
         Y33jK+uBUDG3cdMpbVAUGfXeLXidzaGsyN3jDsr5jIGU1Y7QzkXo1b3XJXuBaAdIsXVt
         EyPA==
X-Gm-Message-State: APt69E3iP3xfFDWqfWYPhwP4+MJ7jzoj7ezGavkNRUtJEY11QKOc2LDL
        m/4VQjSFWz/lhHiXHhloKsgCdg==
X-Google-Smtp-Source: ADUXVKKC+PSxMVuoZiik5A+bdj5FolT8TWhwmhT747KGuN5HscNfMQ6vxJjSTHPF63Z5gJslUsfXWQ==
X-Received: by 2002:adf:87d0:: with SMTP id c16-v6mr170166wrc.246.1528807123413;
        Tue, 12 Jun 2018 05:38:43 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-176-63-54-97.catv.broadband.hu. [176.63.54.97])
        by smtp.gmail.com with ESMTPSA id u15-v6sm548094wma.37.2018.06.12.05.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 05:38:42 -0700 (PDT)
Date:   Tue, 12 Jun 2018 14:38:40 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] vfs: factor out inode_insert5()
Message-ID: <20180612123840.GJ23785@veci.piliscsaba.redhat.com>
References: <20180529144143.16378-1-mszeredi@redhat.com>
 <20180529144143.16378-10-mszeredi@redhat.com>
 <20180610054902.GQ30522@ZenIV.linux.org.uk>
 <20180610060159.GS30522@ZenIV.linux.org.uk>
 <CAJfpegt5guR3zJeATw4-N41Ad2n9pcB5mQoLmSLOfocnEoodVg@mail.gmail.com>
 <20180611113230.GI23785@veci.piliscsaba.redhat.com>
 <20180611164355.GV30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611164355.GV30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 05:43:55PM +0100, Al Viro wrote:
> On Mon, Jun 11, 2018 at 01:32:30PM +0200, Miklos Szeredi wrote:
> 
> > Incremental follows.  I think it's cleaner to initialize i_state and i_sb_list
> > up front (hence the use of new_inode()), but could just as well add to sb list
> > afterwards.
> 
> > ---
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 0df41bb77e0f..03c0d7c1296f 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1098,8 +1098,10 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
> >  
> >  		if (new) {
> >  			inode = inode_insert5(new, hashval, test, set, data);
> > -			if (unlikely(inode != new))
> > -				iput(new);
> > +			if (unlikely(inode != new)) {
> > +				inode_sb_list_del(inode);
> > +				destroy_inode(new);
> > +			}
> 
> The thing is, until you put it into the list, it's invisible to everyone other
> than iget5_locked() - no references in any shared data structures.  Which
> outweighs the "it's somewhat irregular in not being on the list" considerably,
> as far as the complexity of analysis goes, especially since there are inodes
> that never get on that list and it's not something exotic - all sockets and
> pipes are that way, for starters.  So IMO that should be dealt with in
> inode_insert5().

Not sure I understand.

We can put inode_sb_list_add() into inode_insert5().  Then what about users of
new_inode() + insert_inode_locked4()?  Those supply an inode that is already on
the sb list.

What about adding to the list after inode_insert5() in the new inode case.

This should be equivalent to what we do currently, AFAICS.

---
diff --git a/fs/inode.c b/fs/inode.c
index 0df41bb77e0f..ad03d4abc600 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1094,12 +1094,14 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
 	struct inode *inode = ilookup5(sb, hashval, test, data);
 
 	if (!inode) {
-		struct inode *new = new_inode(sb);
+		struct inode *new = new_inode_pseudo(sb);
 
 		if (new) {
 			inode = inode_insert5(new, hashval, test, set, data);
 			if (unlikely(inode != new))
-				iput(new);
+				destroy_inode(new);
+			else
+				inode_sb_list_add(inode);
 		}
 	}
 	return inode;
