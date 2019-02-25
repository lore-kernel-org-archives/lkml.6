Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7911C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D72120652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfBYSl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:41:58 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43770 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBYSl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:41:58 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 14B2D14EE240E;
        Mon, 25 Feb 2019 10:41:57 -0800 (PST)
Date:   Mon, 25 Feb 2019 10:41:56 -0800 (PST)
Message-Id: <20190225.104156.1331861489514486019.davem@davemloft.net>
To:     ebiggers@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maowenan@huawei.com, xiyou.wangcong@gmail.com, lorenzo@google.com,
        penguin-kernel@i-love.sakura.ne.jp, viro@zeniv.linux.org.uk
Subject: Re: [PATCH net] net: socket: set sock->sk to NULL after calling
 proto_ops::release()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190221221356.173485-1-ebiggers@kernel.org>
References: <20190221221356.173485-1-ebiggers@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Feb 2019 10:41:57 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 21 Feb 2019 14:13:56 -0800

> From: Eric Biggers <ebiggers@google.com>
> 
> Commit 9060cb719e61 ("net: crypto set sk to NULL when af_alg_release.")
> fixed a use-after-free in sockfs_setattr() when an AF_ALG socket is
> closed concurrently with fchownat().  However, it ignored that many
> other proto_ops::release() methods don't set sock->sk to NULL and
> therefore allow the same use-after-free:
 ...
> Rather than fixing all these and relying on every socket type to get
> this right forever, just make __sock_release() set sock->sk to NULL
> itself after calling proto_ops::release().
> 
> Reproducer that produces the KASAN splat when any of these socket types
> are configured into the kernel:
 ...
> Fixes: 86741ec25462 ("net: core: Add a UID field to struct sock.")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied and queued up for -stable, thanks Eric.
