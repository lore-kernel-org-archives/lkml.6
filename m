Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeDHGAO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 02:00:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41968 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeDHGAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 02:00:13 -0400
Date: Sun, 8 Apr 2018 06:59:13 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in kmem_cache_free
Message-ID: <20180408055900.GH30522@ZenIV.linux.org.uk>
References: <001a114467482dbc4b05692df8f9@google.com>
 <CACT4Y+adiXih0-jfNGHgf1kEQ2=KLY5NdX-87BTDbrQgEAHc9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+adiXih0-jfNGHgf1kEQ2=KLY5NdX-87BTDbrQgEAHc9g@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 03:33:36PM +0200, Dmitry Vyukov wrote:

> Interesting type of bug, I think we see this for the first time.
> 
> Al, do you see how this can happen?

putname() on something that hasn't come from getname().  Short
of reproducer, I don't see what can be done - it can be any
kind of memory corruption.  We have
        return filename_lookup(dfd, getname_flags(name, flags, empty),
                               flags, path, NULL);
with filename_lookup() hitting
        putname(name);
        return retval;
on the way out (and seeing refcount 1, at that, so it hasn't ended
up in audit context).  And object it's trying to free is not something
getname_flags() has allocated.
