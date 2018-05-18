Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeERTKw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:10:52 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38345 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeERTKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:10:45 -0400
X-Google-Smtp-Source: AB8JxZr9WewopHhFMQWfobsFF7aDRHnp8/9vtho2fgbZo/SXdTbpvqV7L5Tc0PYk65kMvvQiWddSFg==
Date: Fri, 18 May 2018 15:10:40 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: Re: [PATCH 10/10] Dynamic fault injection
Message-ID: <20180518191040.GG31737@kmo-pixel>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-21-kent.overstreet@gmail.com>
 <905DA1CC-63F8-4020-A1D7-1F59ABDF3448@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905DA1CC-63F8-4020-A1D7-1F59ABDF3448@dilger.ca>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 01:05:20PM -0600, Andreas Dilger wrote:
> On May 18, 2018, at 1:49 AM, Kent Overstreet <kent.overstreet@gmail.com> wrote:
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> 
> I agree with Christoph that even if there was some explanation in the cover
> letter, there should be something at least as good in the patch itself.  The
> cover letter is not saved, but the commit stays around forever, and should
> explain how this should be added to code, and how to use it from userspace.
> 
> 
> That said, I think this is a useful functionality.  We have something similar
> in Lustre (OBD_FAIL_CHECK() and friends) that is necessary for being able to
> test a distributed filesystem, which is just a CPP macro with an unlikely()
> branch, while this looks more sophisticated.  This looks like it has some
> added functionality like having more than one fault enabled at a time.
> If this lands we could likely switch our code over to using this.

This is pretty much what I was looking for, I just wanted to know if this patch
was interesting enough to anyone that I should spend more time on it or just
drop it :) Agreed on documentation. I think it's also worth factoring out the
functionality for the elf section trick that dynamic debug uses too.

> Some things that are missing from this patch that is in our code:
> 
> - in addition to the basic "enabled" and "oneshot" mechanisms, we have:
>   - timeout: sleep for N msec to simulate network/disk/locking delays
>   - race: wait with one thread until a second thread hits matching check
> 
> We also have a "fail_val" that allows making the check conditional (e.g.
> only operation on server "N" should fail, only RPC opcode "N", etc).

Those all sound like good ideas... fail_val especially, I think with that we'd
have all the functionality the existing fault injection framework has (which is
way to heavyweight to actually get used, imo)
