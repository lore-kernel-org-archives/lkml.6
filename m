Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295B8C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EA52082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278844;
	bh=atUog+SaGDJeiLUwrVuBQdymFoZmqbYQ9GJDBfA64kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q6EEvwTFvjWHjwhAAEFbi/bNfUv2baIvVwQxuWdh6DANFplC8cMWN2xqQAbEnBEHv
	 SkwkCq6BTDmsvvR355RxaCZzrOXe+UFtTyxzTqESsvPF43hb6N8Bp5f6wp4MKOVZ40
	 Dl4eiHWEnLUNM9vPnhYcYcaNvGfKiaiMXbVzHPdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfBDLOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:14:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfBDLOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:14:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A19D9207E0;
        Mon,  4 Feb 2019 11:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549278841;
        bh=atUog+SaGDJeiLUwrVuBQdymFoZmqbYQ9GJDBfA64kI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsxTFGxDwjj2VpLyFc9VKV9FNpMqzTAC46UEzIDH9bp6iI4nMrtYHSh7cv71K4Wt+
         NuTZrWLHioEhwhniTEooUWcpKTt1LgWFEzzfFAsR5A4nGk1tWwlBe+85ku8j0uZ0JI
         FeE0ELjf/otJFRA5QY90/5oqwMEdQlgYe0GrDZxw=
Date:   Mon, 4 Feb 2019 12:03:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 4.9 30/30] fanotify: fix handling of events on child
 sub-directory
Message-ID: <20190204110339.GA19811@kroah.com>
References: <20190204103605.271746870@linuxfoundation.org>
 <20190204103610.774179167@linuxfoundation.org>
 <CAOQ4uxhwxgpuzebDdqV61f2ENCVa44XiuKZmLfbnEOYZWvXrLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhwxgpuzebDdqV61f2ENCVa44XiuKZmLfbnEOYZWvXrLA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 12:48:00PM +0200, Amir Goldstein wrote:
> On Mon, Feb 4, 2019 at 12:44 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > commit b469e7e47c8a075cc08bcd1e85d4365134bdcdd5 upstream.
> >
> > When an event is reported on a sub-directory and the parent inode has
> > a mark mask with FS_EVENT_ON_CHILD|FS_ISDIR, the event will be sent to
> > fsnotify() even if the event type is not in the parent mark mask
> > (e.g. FS_OPEN).
> >
> > Further more, if that event happened on a mount or a filesystem with
> > a mount/sb mark that does have that event type in their mask, the "on
> > child" event will be reported on the mount/sb mark.  That is not
> > desired, because user will get a duplicate event for the same action.
> >
> > Note that the event reported on the victim inode is never merged with
> > the event reported on the parent inode, because of the check in
> > should_merge(): old_fsn->inode == new_fsn->inode.
> >
> > Fix this by looking for a match of an actual event type (i.e. not just
> > FS_ISDIR) in parent's inode mark mask and by not reporting an "on child"
> > event to group if event type is only found on mount/sb marks.
> >
> > [backport hint: The bug seems to have always been in fanotify, but this
> >                 patch will only apply cleanly to v4.19.y]
> >
> 
> Same comment about this backport hint being misleading in the
> context of the backport patch.

I try to leave the text in the changelog identical to what is upstream
to make it easier to track things.

thanks,

greg k-h
