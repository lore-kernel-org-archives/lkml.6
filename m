Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1305DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52202184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549012038;
	bh=kyh+ZX96muNgl+zZcdEMfCN7M73nXnSWl3CBJFrylck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CCEWlvb16r0csfitypJ6PTYFZOqcDwC05zBM/k9HiI7xXUJ5YmqoknE7fogOsxkMk
	 7cLcyJnNU9wVbjXwfKtqE+gk0TAF0SquFEYO/cm5xan/jlCd9u9nCA3/c/WdSxu6DQ
	 7bElbi0c9nAF7of7xQEGI+0R6+LNCW7wufpuysvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfBAJHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfBAJHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:07:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A224520869;
        Fri,  1 Feb 2019 09:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549012036;
        bh=kyh+ZX96muNgl+zZcdEMfCN7M73nXnSWl3CBJFrylck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2HgwrgKlBxcNEaaQtgxe4Ozcj/t4sewITjDJtM/AYIT/Je/4Jx5cTuN9L4GmkRyyJ
         LnKf0kgJTaLcMy2PqnN87UJWmRvbVk43RfaD4eAWbdFWBkBasDprr7DCUukIiB/o1E
         mNdMKv3qqiIWKrQePHSPUTBTobsqvftBTRIeoojM=
Date:   Fri, 1 Feb 2019 10:07:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in relay_open_buf
Message-ID: <20190201090713.GA22796@kroah.com>
References: <00000000000074cbc30580b16bc3@google.com>
 <CAGXu5j+UzHKQk81RKsk39vx5WHi_CONzP4rU2fyuH-z_YB7CKw@mail.gmail.com>
 <20190131105152.GB13686@kroah.com>
 <20190201035748.GL2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201035748.GL2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 03:57:48AM +0000, Al Viro wrote:
> On Thu, Jan 31, 2019 at 11:51:52AM +0100, Greg KH wrote:
> > Can you test the patch below?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> > @@ -461,7 +463,7 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
> >  		dentry = chan->cb->create_buf_file(NULL, NULL,
> >  						   S_IRUSR, buf,
> >  						   &chan->is_global);
> > -		if (WARN_ON(dentry))
> > +		if (IS_ERR_OR_NULL(dentry))
> >  			goto free_buf;
> 
> Huh?  That makes no sense; is it IS_ERR on error or is it NULL
> on error, or what?

Some of the fuction pointers seem to do one, some the other.  I've
submitted patches to them to unify them now.  Will take bit for those to
wind through the merges.

> Besides, how did it work before?

Obviously it never did at all :(

thanks,

greg k-h
