Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A135DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A41F20645
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfBVTI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:08:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33322 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfBVTI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:08:57 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gxGBm-0002db-KL; Fri, 22 Feb 2019 19:08:50 +0000
Date:   Fri, 22 Feb 2019 19:08:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH net] net: socket: set sock->sk to NULL after calling
 proto_ops::release()
Message-ID: <20190222190850.GF2217@ZenIV.linux.org.uk>
References: <20190221221356.173485-1-ebiggers@kernel.org>
 <e4d0f1e8-68ff-512e-ad69-480523ff300f@gmail.com>
 <20190222175743.GA163909@gmail.com>
 <0de89a50-6d5c-1d7b-19f5-9a13465bcebd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0de89a50-6d5c-1d7b-19f5-9a13465bcebd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:25:09AM -0800, Eric Dumazet wrote:
> 
> 
> On 02/22/2019 09:57 AM, Eric Biggers wrote:
> 
> > ->setattr() is called under inode_lock(), which __sock_release() also takes.  So
> > the uses of sock->sk are serialized.  See commit 6d8c50dcb029 ("socket: close
> > race condition between sock_close() and sockfs_setattr()").
> 
> Oh right, we added another inode_lock()/inode_unlock() for sock_close()

An interesting question is whether anything else will be confused by
	sock->sk && sock->sk->sk_socket != sock

I'd still like to figure out if we could simply make sock_orphan()
do something like
	if (likely(sk->sk_socket))
		sk->sk_socket->sk = NULL;
just before sk_set_socket(sk, NULL);

That would make for much easier rules; the question is whether anything
relies upon the windows when linkage between socket and sock is not
symmetrical...
