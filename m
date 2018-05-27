Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936409AbeE0LJ1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 07:09:27 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:32947 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936373AbeE0LJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 07:09:25 -0400
X-Google-Smtp-Source: AB8JxZqRwZpUmZnBCo1UMHFxxartOzn3RNTuoyOM3kA9AhSPb27HBdcAJq3i1Baq+QCJ3dCI2kynrZ9n6eskDTdYfbw=
MIME-Version: 1.0
References: <CAKEZqKJhZNoF-29ymEmAjiYfVn64q5mHrMY9sC2NZ=EDqTHjeA@mail.gmail.com>
 <20180526171206.GP30522@ZenIV.linux.org.uk>
In-Reply-To: <20180526171206.GP30522@ZenIV.linux.org.uk>
From: Lei Chen <losemyheaven@gmail.com>
Date: Sun, 27 May 2018 19:09:14 +0800
Message-ID: <CAKEZqK+x7MLBRFnez-XzTi3GPxoEr9p+1w25d3hkr5JLrWW2Lw@mail.gmail.com>
Subject: Re: Why does d_splice_alias need to check IS_ROOT?
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4RB9hCG026049

Al Viro <viro@zeniv.linux.org.uk> 于2018年5月27日周日 上午1:12写道：

> On Sun, May 27, 2018 at 12:33:40AM +0800, Lei Chen wrote:
> > Hello list,
> >
> > I'm insteresting in how hard link and denry lookup work and their
> > implementation.
> >
> > I know that this interface tries to connect an inode to a dentry, but
> > why does it need
> > to check whether the inode alias IS_ROOT if the inode represents a
directory?
> > And the code process in different way according to check result.  What
> > occasions
> > are they used for?

> If it's disconnected (and not an ancestor of the place where we want it),
> we can just move it in place, no questions asked.  If it is *NOT*
> disconnected, the only thing we can do is to detach it from where it
> is and move it over.  Which takes a lot more care wrt locking.

Thanks for your reply.

But why does it mean "disconnected" if IS_ROOT returns true??
Why not use hlist_unhashed(&entry->d_u.d_alias) or d_is_negative to
determine whether a dentry is connected to an inode??

I found that when we allocate a new dentry struct, its parent is not
always itself.
