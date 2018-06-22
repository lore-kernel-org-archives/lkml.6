Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71720C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C6D240D1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C6D240D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754137AbeFVLBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:01:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58880 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeFVLBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:01:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fWJob-0006SF-5C; Fri, 22 Jun 2018 11:01:17 +0000
Date:   Fri, 22 Jun 2018 12:01:17 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <xiaolong.ye@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Subject: Re: [lkp-robot] [fs] 3deb642f0d: will-it-scale.per_process_ops -8.8%
 regression
Message-ID: <20180622110117.GU30522@ZenIV.linux.org.uk>
References: <20180622082752.GX11011@yexl-desktop>
 <CA+55aFw5ghByk_zCN25G6rPPSAQma3Mh0t4s18CtLg=h6U9+Zg@mail.gmail.com>
 <20180622095608.GA12263@lst.de>
 <20180622100014.GA12425@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622100014.GA12425@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:00:14PM +0200, Christoph Hellwig wrote:
> And a version with select() also covered:

For fuck sake, if you want vfs_poll() inlined, *make* *it* *inlined*.
Is there any reason for not doing that other than EXPORT_SYMBOL_GPL
fetish?  Because if there isn't, I would like to draw your attention
to the fact that _this_ pwecious inchewlekshul pwopewty can be trivially
open-coded by out-of-tree shite even if it happens to be non-GPL one.

>  					mask = vfs_poll(f.file, wait);
> +					if (f.file->f_op->poll) {

... not to mention that here you forgot to remove the call itself while
expanding it.

Said that, you are not attacking the worst part of it - it's a static
branch, not the considerably more costly indirect ones.  Remember when
I asked you about the price of those?  Method calls are costly.

Another problem with with ->get_poll_head() calling conventions is
that originally you wanted to return ERR_PTR(-mask) as a way to report
not needing to call ->poll_mask(); that got shot down since quite
a few of those don't fit into 12 bits that ERR_PTR() gives us.

IIRC, the real reason for non-constant ->get_poll_head() was the sockets,
with

static struct wait_queue_head *sock_get_poll_head(struct file *file,
                __poll_t events)
{
        struct socket *sock = file->private_data;

        if (!sock->ops->poll_mask)
                return NULL;
        sock_poll_busy_loop(sock, events);
        return sk_sleep(sock->sk); 
}

The first part isn't a problem (it is constant).  The second is
static inline void sock_poll_busy_loop(struct socket *sock, __poll_t events)
{
        if (sk_can_busy_loop(sock->sk) &&
            events && (events & POLL_BUSY_LOOP)) {
                /* once, only if requested by syscall */
                sk_busy_loop(sock->sk, 1);
        }
} 

and the third -

static inline wait_queue_head_t *sk_sleep(struct sock *sk)
{
        BUILD_BUG_ON(offsetof(struct socket_wq, wait) != 0);
        return &rcu_dereference_raw(sk->sk_wq)->wait; 
} 

Now, ->sk_wq is modified only in sock_init_data() and sock_graft();
the latter, IIRC, is ->accept() helper.  Do we ever call either of
those on a sock of already opened file?  IOW, is there any real
reason for socket ->get_poll_head() not to be constant, other
than wanting to keep POLL_BUSY_LOOP handling out of ->poll_mask()?
I agree that POLL_BUSY_LOOP is ugly as hell, but you *still* have
sock_poll_mask() not free from it...
