Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E83EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA0E2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550858269;
	bh=2w9JZxOztHsXZz0yCb5s/OeJ+7k7QKfz7EpL6etK7vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XWHUsedVFexqQmMQV0sID8I5nsqbPy5bKJU7oFTdGx1T9VRyQ9+vsUqF8ldoM6f6p
	 V/6AkdW2N1/yMmVNCQt0iJrRCek9BzMlwjj9N4CehSp2G+MBa1JB8WFtqlwqptSqzr
	 ecOrlN2sNiyIYLqLwRaAx58TCPQztLtqOurpdz/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfBVR5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:57:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBVR5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:57:47 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AC2A2070B;
        Fri, 22 Feb 2019 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550858266;
        bh=2w9JZxOztHsXZz0yCb5s/OeJ+7k7QKfz7EpL6etK7vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwCDu2nJeJc30vU6YPenfE8oOlpIHZ6mjuQn6h7UcT+FIxwXM6+KBA9pjPBYXy6Hx
         PsUI845IDo9NFZsOQ1SnLCSFPonJEEaxGL1iy043LLUFHg/8jY5QeIdKnm24kPoCaB
         jaJwmS0Bb4kVN1yrc7M1ShT/8LVeqIk4uXxqrSBw=
Date:   Fri, 22 Feb 2019 09:57:44 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net] net: socket: set sock->sk to NULL after calling
 proto_ops::release()
Message-ID: <20190222175743.GA163909@gmail.com>
References: <20190221221356.173485-1-ebiggers@kernel.org>
 <e4d0f1e8-68ff-512e-ad69-480523ff300f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d0f1e8-68ff-512e-ad69-480523ff300f@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Fri, Feb 22, 2019 at 09:45:35AM -0800, Eric Dumazet wrote:
> 
> 
> On 02/21/2019 02:13 PM, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Commit 9060cb719e61 ("net: crypto set sk to NULL when af_alg_release.")
> > fixed a use-after-free in sockfs_setattr() when an AF_ALG socket is
> > closed concurrently with fchownat().  However, it ignored that many
> > other proto_ops::release() methods don't set sock->sk to NULL and
> > therefore allow the same use-after-free:
> > 
> 
> I fail to see how setting a pointer to NULL can avoid races.
> 
> 
> We lack some kind of protection, rcu or something, if another thread can change sock->sk at anytime
> while sockfs_setattr() is used.
> 
> sockfs_setattr()
> ...
>      if (sock->sk)
> 
> // even if sock->sk was not NULL for the if (...).
> 
> // it can be NULL right now, compiler could read sock->sk a second time and catch a NULL.
> 
>         sock->sk->sk_uid = iattr->ia_uid;
> 
> 

->setattr() is called under inode_lock(), which __sock_release() also takes.  So
the uses of sock->sk are serialized.  See commit 6d8c50dcb029 ("socket: close
race condition between sock_close() and sockfs_setattr()").

The issue now is that if ->setattr() happens *after* __sock_release() (which is
possible if fchownat() gets the reference to the file's 'struct path', then the
file is close()d by another thread, then fchownat() continues), it will see
stale sock->sk because for many socket types it wasn't set to NULL earlier.

- Eric
