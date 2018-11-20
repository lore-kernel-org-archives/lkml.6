Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD295C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0FD20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQDuDP+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0FD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbeKTVhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:37:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbeKTVhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:37:12 -0500
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1839120831;
        Tue, 20 Nov 2018 11:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542712117;
        bh=UV+yE0YogWqKDqfB/TSo7Crjtsx4uvvImF+ulT1Krwc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TQDuDP+MaC3Fun5xAurWyh4t2kg4s2F5RgxdUcpNH0dJiQDuFuXU9Rb7IxAMKvxIn
         LsJDXxaz69C9xNcTQ+Plg0XiWpuIxXv7K27uGt8cI99+jqkWJf2GUIaB0Px1i+jJ2w
         cAF2x+kfiViDwesnr/CytisMkLFF54XhZ0rgonoU=
Message-ID: <abb5d9ab502e37ff9fdbbd50ec770fda72e12117.camel@kernel.org>
Subject: Re: KASAN: use-after-free Read in locks_delete_block
From:   Jeff Layton <jlayton@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     NeilBrown <neilb@suse.com>,
        syzbot <syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 20 Nov 2018 06:08:34 -0500
In-Reply-To: <CACT4Y+ag3mJNGUkjHQSyikT9xMJSjuY3fhSJ-2QH0eL1bTPhYw@mail.gmail.com>
References: <000000000000222b58057a7d9f39@google.com>
         <9d9ad7f2781bf15af4bd6ccc9feee35c7cd17979.camel@kernel.org>
         <87bm6svhhl.fsf@notabene.neil.brown.name>
         <b49e02d54460c79c4e5472983f6b9390005881b8.camel@kernel.org>
         <CACT4Y+Z3zM0z9PScAKjyjspu35B-6OgTT_qEwc+AB_MFzJkL0A@mail.gmail.com>
         <87bm6pewnm.fsf@notabene.neil.brown.name>
         <CACT4Y+Ysn70kTSgp_KZ5aRGuiNK0wUcqbjAH8xBJ8MqV+mFyqQ@mail.gmail.com>
         <c76712278e2d7f5c4c8cfbab687a941bf493b0c6.camel@kernel.org>
         <20181117140356.GA29895@fieldses.org>
         <CACT4Y+ag3mJNGUkjHQSyikT9xMJSjuY3fhSJ-2QH0eL1bTPhYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-20 at 07:57 +0100, Dmitry Vyukov wrote:
> On Sat, Nov 17, 2018 at 3:03 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > On Sat, Nov 17, 2018 at 08:33:27AM -0500, Jeff Layton wrote:
> > > Thanks for the explanation, Dmitry. I've added the tag to the patch in
> > > my tree. It should show up in linux-next soon.
> > > 
> > > I still find it a little misleading to say that syzbot reported a bug
> > > when it actually found a bug inside an earlier version of the patch, but
> > > I'll just learn to get over it.
> > 
> > The usual tag for someone that found a bug in an earlier version of a
> > patch would be Reviewed-by:.  Is there any reason we can't use that
> > here?  The "syzbot+..." email should be enough on its own, I can't see a
> > reason why their scripts would need to require a particular tag.  Or
> > maybe we could use Tested-by:, or some other tag made up for this case?
> > 
> > I do worry that someone who sees "Reported-by:..." might for example
> > mistakenly assume that it would help to backport that patch if they see
> > a similar-looking oops.
> 
> I see. It may also be picked by scripts that detects patches that need
> to be backported to stable because of the "Reported-by: syzbot" tag.
> This is somewhat unfortunate.
> 
> There is no problem parsing another tag on syzbot side. Does Tested-by
> look good to you? If it found a bug in the patch and then it was
> fixed, Tested-by looks reasonable. And we also detect
> Reported-and-tested-by already because that's what syzbot suggests
> after it tested a proposed fix for a bug.
> 
> I am somewhat concerned how to spread this information across all
> kernel developers. There is effectively no way to do this. We can't
> expect people to read docs, they generally don't. I guess I just
> document this at "See https://goo.gl/tpsmEJ for more information" and
> then we can point other people there if/when this concern pops up
> again.

Tested-by sounds like it might be a reasonable fit. I'll change the
patch in my tree to read that way.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

