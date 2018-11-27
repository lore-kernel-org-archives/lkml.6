Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172CEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D098220873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jyhq4+Bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D098220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbeK0Uyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:54:39 -0500
Received: from m12-14.163.com ([220.181.12.14]:56603 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbeK0Uyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=ZnzyO
        cQyoiiHH6J4MMHT8p8+w3Fdx9yxY66n4oJl0S8=; b=jyhq4+BpKtkIPG9uMp7fU
        yI3W2QBIcCc2eQ1wIBFmQ5VnFWbpO61I3CFjsAiPjO5isma5hmsOL1hS/hmBFtau
        5eubxJCvJyoMRCmwENBCsOdApissmtiw6YjW4v0A7OtrFYm0UFZiCz+vOZzODMqK
        GQzlgga2ZdxbNv0T487KT8=
Received: from bp (unknown [106.120.213.96])
        by smtp10 (Coremail) with SMTP id DsCowABHlMz3FP1blOiUCA--.55858S2;
        Tue, 27 Nov 2018 17:57:11 +0800 (CST)
Date:   Tue, 27 Nov 2018 17:57:12 +0800
From:   PanBian <bianpan2016@163.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] namei: free new_dentry late
Message-ID: <20181127095712.GA32100@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1543104923-81192-1-git-send-email-bianpan2016@163.com>
 <20181127092551.GC16301@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127092551.GC16301@quack2.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: DsCowABHlMz3FP1blOiUCA--.55858S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWxWFWDKF43tFWrCF1rZwb_yoW8CrWDpF
        4rKay8tF4fWrW0kFn3ZFs5Z3W8Zr4Igw109r109ryxtr9aqry5tFs7Wr4kuFy3urWrur1U
        XF48KF15Xa13ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jypBfUUUUU=
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiDhcMclXlpnp-6wAAsf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:25:51AM +0100, Jan Kara wrote:
> On Sun 25-11-18 08:15:23, Pan Bian wrote:
> > After calling dput(new_dentry), new_dentry is passed to fsnotify_move.
> > This may result in a use-after-free bug. This patch moves the put
> > operation late.
> > 
> > Fixes: da1ce0670c14("vfs: add cross-rename")
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> 
> The code is actually fine AFAICT. One new_dentry reference is passed into
> vfs_rename() and another one is acquired directly inside vfs_rename(). That
> is the one dropped early but there's still the original reference passed in
> protecting new_dentry from freeing. Am I missing something?

I am not quite sure about the actual execution logic. But I guess new_dentry 
reference may be dropped outside vfs_rename in cocurrent executions.
Otherwise, there is no need to acquire & drop new_dentry reference as it
is always alive along vfs_rename.

Best regards,
Pan

> 
> 								Honza
> 
> > ---
> > V2: correct the fixes commit information
> > ---
> >  fs/namei.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 0cab649..8b104d9 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4498,7 +4498,6 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >  		unlock_two_nondirectories(source, target);
> >  	else if (target)
> >  		inode_unlock(target);
> > -	dput(new_dentry);
> >  	if (!error) {
> >  		fsnotify_move(old_dir, new_dir, old_name.name, is_dir,
> >  			      !(flags & RENAME_EXCHANGE) ? target : NULL, old_dentry);
> > @@ -4507,6 +4506,7 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >  				      new_is_dir, NULL, new_dentry);
> >  		}
> >  	}
> > +	dput(new_dentry);
> >  	release_dentry_name_snapshot(&old_name);
> >  
> >  	return error;
> > -- 
> > 2.7.4
> > 
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

