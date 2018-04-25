Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeDYG3H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:29:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeDYG3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:29:03 -0400
Date: Tue, 24 Apr 2018 23:28:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: add TCP_ZEROCOPY_RECEIVE support for
 zerocopy receive
Message-ID: <20180425062859.GA23914@infradead.org>
References: <20180425052722.73022-1-edumazet@google.com>
 <20180425052722.73022-2-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425052722.73022-2-edumazet@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 10:27:21PM -0700, Eric Dumazet wrote:
> When adding tcp mmap() implementation, I forgot that socket lock
> had to be taken before current->mm->mmap_sem. syzbot eventually caught
> the bug.
> 
> Since we can not lock the socket in tcp mmap() handler we have to
> split the operation in two phases.
> 
> 1) mmap() on a tcp socket simply reserves VMA space, and nothing else.
>   This operation does not involve any TCP locking.
> 
> 2) setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...) implements
>  the transfert of pages from skbs to one VMA.
>   This operation only uses down_read(&current->mm->mmap_sem) after
>   holding TCP lock, thus solving the lockdep issue.
> 
> This new implementation was suggested by Andy Lutomirski with great details.

Thanks, this looks much more sensible to me.
