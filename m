Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970334AbeEXOFK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:05:10 -0400
Received: from zimbra.alphalink.fr ([217.15.80.77]:44468 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970312AbeEXOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:04:58 -0400
Date: Thu, 24 May 2018 16:04:49 +0200
From: Guillaume Nault <g.nault@alphalink.fr>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: linux-ppp@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2] ppp: remove the PPPIOCDETACH ioctl
Message-ID: <20180524140449.GA1389@alphalink.fr>
References: <20180523035952.25768-1-ebiggers3@gmail.com>
 <20180523213738.146911-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523213738.146911-1-ebiggers3@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 02:37:38PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The PPPIOCDETACH ioctl effectively tries to "close" the given ppp file
> before f_count has reached 0, which is fundamentally a bad idea.  It
> does check 'f_count < 2', which excludes concurrent operations on the
> file since they would only be possible with a shared fd table, in which
> case each fdget() would take a file reference.  However, it fails to
> account for the fact that even with 'f_count == 1' the file can still be
> linked into epoll instances.  As reported by syzbot, this can trivially
> be used to cause a use-after-free.
> 
> Yet, the only known user of PPPIOCDETACH is pppd versions older than
> ppp-2.4.2, which was released almost 15 years ago (November 2003).
> Also, PPPIOCDETACH apparently stopped working reliably at around the
> same time, when the f_count check was added to the kernel, e.g. see
> https://lkml.org/lkml/2002/12/31/83.  Also, the current 'f_count < 2'
> check makes PPPIOCDETACH only work in single-threaded applications; it
> always fails if called from a multithreaded application.
> 
> All pppd versions released in the last 15 years just close() the file
> descriptor instead.
> 
> Therefore, instead of hacking around this bug by exporting epoll
> internals to modules, and probably missing other related bugs, just
> remove the PPPIOCDETACH ioctl and see if anyone actually notices.  Leave
> a stub in place that prints a one-time warning and returns EINVAL.
> 
> Reported-by: syzbot+16363c99d4134717c05b@syzkaller.appspotmail.com
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v2: leave a stub in place, rather than removing the ioctl completely.
> 
Thanks a lot for your help on this matter.

BTW, netdev has its own rules wrt. stable backports. You didn't need to
CC: stable@. David handles -stable submissions himself.
Using a 'PATCH net' subject prefix would have made it clear that this
patch was fixing some released code and should be considered for -stable
backport.

Reviewed-by: Guillaume Nault <g.nault@alphalink.fr>
Tested-by: Guillaume Nault <g.nault@alphalink.fr>
