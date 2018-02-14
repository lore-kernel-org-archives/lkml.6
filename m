Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030820AbeBNO4w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:56:52 -0500
Received: from h2.hallyn.com ([78.46.35.8]:58830 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030382AbeBNO4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:56:51 -0500
Date: Wed, 14 Feb 2018 08:56:50 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Enrico Weigelt, metux IT consult" <metux@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] p9caps: add Plan9 capability devices
Message-ID: <20180214145650.GA2102@mail.hallyn.com>
References: <40d4c871-a16a-7b8f-2d4a-422a5a490693@infradead.org>
 <20180211215028.16210-1-metux@gmx.de>
 <20180211215028.16210-2-metux@gmx.de>
 <20180213071655.GA11240@mail.hallyn.com>
 <3a99edaf-0365-ec7e-4d2f-1e21dea007ac@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a99edaf-0365-ec7e-4d2f-1e21dea007ac@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Enrico Weigelt, metux IT consult (metux@gmx.de):
> On 13.02.2018 07:16, Serge E. Hallyn wrote:
> >>+	/* make sure only one instance per namespace can be opened */ > > ... at a time
> yeah, right.
> 
> >might be better to keep this state in the user_ns itself, would
> >avoid kzalloc below.
> 
> thought about, but hesitated to touch user_ns. might not be the best
> idea when having p9caps as module (OTOH, doesn't need to be a module)

If it's an out of tree module you'd have to do it this way, but if
it's in-tree, even as a module, adding a bit to the userns struct
would imo be ok.

> the whole thing might become a bit more complex when introducing
> plan9-like unprivileged mount operations. haven't sorted out how to
> do that yet.

I hope you'll have a discussion here about that first.

> >Would it be worth doing any privilege checking here?
> 
> Which ones should I check ?

Well, granting privileges to another task is extra-special, so
in the 2010 submission we created a new POSIX capability for
it (CAP_GRANT_ID).

Now speaking practically, I love the caphash idea, but it does
have issues with a modern login system.  There are privileged
things which login needs to do besides changing uid, including but
not limited to:
1. setting limits
2. setting loginuid,
3. mounting things (polyinstantiated /tmp, decrypted homedir, etc)
4. setting selinux context

These are probably all solvable, and don't need to be solved before
we solve this part, that would be silly, but they're worth thinking
about.  The ones which must be done on the current task are the hardest
to solve.

(and of course gplv3 as Al pointed out is a blocker)

-serge
