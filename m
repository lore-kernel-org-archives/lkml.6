Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J7QIGHP3G1vdBQAAmS7hNA
	; Sat, 09 Jun 2018 15:51:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 50FB8608BF; Sat,  9 Jun 2018 15:51:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9A37B608B8;
	Sat,  9 Jun 2018 15:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A37B608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932650AbeFIPvM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:51:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44640 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeFIPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:51:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRg8y-0000Rr-6O; Sat, 09 Jun 2018 15:51:08 +0000
Date: Sat, 9 Jun 2018 16:51:08 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC][PATCHES] getting rid of int *open in ->atomic_open() and
 friends
Message-ID: <20180609155107.GH30522@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <CA+55aFz9cS3m=wZxqKbzrCLEjhPoPddKw5U2MDKNqbG79Wx6bw@mail.gmail.com>
 <20180609051051.GF30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609051051.GF30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 06:10:51AM +0100, Al Viro wrote:

> That leaves
> 	* anon_inode_getfile() - converts to similar form, at the price of
> ihold done slightly earlier, so that failure exit needs a (non-final, i.e.
> very cheap) iput() we currently avoid.  Not a problem.
> 	* do_shmat() and the second alloc_file() in create_pipe_files().
> Those are rather different - we *do* have an existing dentry/inode/mount
> there and all we want on cleanup is path_put() to undo the path_get()
> we'd done.
> 	* perfmon mess - _very_ different, and I wouldn't bet a dime on
> correctness of failure exits there.  One of the issues is that it simulates
> mmap as part of setup, so cleanup really is different.
> 
> AFAICS, there's a clear case for alloc_file() wrapper - 6 callers out of
> 10 get simpler with it, and the seventh is also a good candidate for the
> same treatment.  Any naming ideas for that thing ("something" in the above)
> would be welcome...
> 
> BTW, that's almost all callers of d_alloc_pseudo() - there is exactly one
> caller not of that form (in __ns_get_path()) right now.  perfmon should
> be another caller, but that might end up converted to the new wrapper...
> 
> As for put_filp()... the callers left in my local tree right now are
> 	* path_openat(), dentry_open(), file_clone_open() (all of the
> same form - "put_filp() if it doesn't have FMODE_OPENED, fput() otherwise)
> 	* perfmon mess.
> create_pipe_files() got converted to fput() with a bit of massage...

Untested followup along those lines pushed; helper called alloc_file_pseudo()
and all but 3 callers of alloc_file() got converted to it.  perfmon is not
touched and it's becoming more and more annoying ;-/  It's also sticking
its tender bits into mm/* a lot - what it tries to do, AFAICS, is a heavily
open-coded vmalloc-backed mmap() of sorts.  It feels like there ought to be
a more idiomatic way of doing that kind of stuff...

Stephane, could you comment on the situation in there?  I realize that you
hadn't touched that thing in more than a decade, but I've no idea who else
might be familiar with that thing and it's very inconveniently special...
