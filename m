Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbeCPIq5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:46:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbeCPIqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:46:55 -0400
Date: Fri, 16 Mar 2018 01:46:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 14/36] fs: add ksys_mount() helper; remove in-kernel
 calls to sys_mount()
Message-ID: <20180316084653.GC4151@infradead.org>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-15-linux@dominikbrodowski.net>
 <CAK8P3a2H=LoW5apWNxbqda+JAa33R=tqc7RK=2Uv7J_Xpy+bgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2H=LoW5apWNxbqda+JAa33R=tqc7RK=2Uv7J_Xpy+bgg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 09:11:27PM +0100, Arnd Bergmann wrote:
> Shouldn't the callers of sys_mount just call do_mount() instead?
> 
> As I understand it, sys_mount is already a wrapper around do_mount()
> that copies its arguments from user space, but we don't need that
> when called from inside the kernel.

In general yes.  do_mount.c has some really strange calling context
where it tries to operate on kernel and user pointers interchangably,
but even with that just switching to do_mount seems like the right thing
to me.  In fact once we do that and take care or chdir/chdoot we could
probably get rid of the sparse disable hack in favour of a few __force
casts in change_floppy and sort this mess out as well.
