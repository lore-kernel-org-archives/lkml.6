Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F8DECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE242075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE242075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbeGRUyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:54:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40010 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730839AbeGRUyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:54:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1ffsr0-0004Yw-Dx; Wed, 18 Jul 2018 20:15:18 +0000
Date:   Wed, 18 Jul 2018 21:15:18 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] call_with_creds()
Message-ID: <20180718201518.GX30522@ZenIV.linux.org.uk>
References: <20180718132955.2bf185b7@canb.auug.org.au>
 <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
 <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
 <20180718124340.GS30522@ZenIV.linux.org.uk>
 <CAOssrKcS+kwK+S1aojhbW_4p8FJLPaafBDqDu89d=F14wT-0rw@mail.gmail.com>
 <20180718181252.GU30522@ZenIV.linux.org.uk>
 <CA+55aFxh62Yttq-W2Cr_YQQ5tAL1xjijjnaz1-zdZNqZPQFM0g@mail.gmail.com>
 <20180718194637.GV30522@ZenIV.linux.org.uk>
 <CA+55aFydd9ji2eJSNVK7Fjpziehvm6fO3b1eTeUAn0L1tk3GmQ@mail.gmail.com>
 <20180718200411.GW30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718200411.GW30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 09:04:11PM +0100, Al Viro wrote:
> On Wed, Jul 18, 2018 at 12:53:48PM -0700, Linus Torvalds wrote:
> > On Wed, Jul 18, 2018 at 12:46 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > Huh?  Nevermind ->write(), what about open()?
> > 
> > What about open?
> > 
> > At open time, file->f_cred is the same as current_cred().
> 
> int cachefiles_write_page(struct fscache_storage *op, struct page *page)
> {
> ...
>         file = dentry_open(&path, O_RDWR | O_LARGEFILE, cache->cache_cred);
> 
> 
> int ecryptfs_privileged_open(struct file **lower_file,
>                              struct dentry *lower_dentry,
>                              struct vfsmount *lower_mnt,
>                              const struct cred *cred)
> ...
>         (*lower_file) = dentry_open(&req.path, flags, cred);

Actually, scratch that one - in this case it is current_cred() (whether that's
the right value or not).

cachefile_write_page() case is for real, AFAICS.
