Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeBHUQZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:16:25 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:48942 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeBHUQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:16:23 -0500
Date: Thu, 08 Feb 2018 15:16:21 -0500 (EST)
Message-Id: <20180208.151621.581060088482890871.davem@davemloft.net>
To: keescook@chromium.org
Cc: syzbot+e2d6cfb305e9f3911dea@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ebiggers3@gmail.com, james.morse@arm.com, keun-o.park@darkmatter.ae,
        labbott@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH] net: Whitelist the skbuff_head_cache "cb" field
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180208014438.GA12186@beast>
References: <20180208014438.GA12186@beast>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Wed, 7 Feb 2018 17:44:38 -0800

> Most callers of put_cmsg() use a "sizeof(foo)" for the length argument.
> Within put_cmsg(), a copy_to_user() call is made with a dynamic size, as a
> result of the cmsg header calculations. This means that hardened usercopy
> will examine the copy, even though it was technically a fixed size and
> should be implicitly whitelisted. All the put_cmsg() calls being built
> from values in skbuff_head_cache are coming out of the protocol-defined
> "cb" field, so whitelist this field entirely instead of creating per-use
> bounce buffers, for which there are concerns about performance.
> 
> Original report was:
 ...
> Reported-by: syzbot+e2d6cfb305e9f3911dea@syzkaller.appspotmail.com
> Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> I tried the inlining, it was awful. Splitting put_cmsg() was awful. So,
> instead, whitelist the "cb" field as the least bad option if bounce
> buffers are unacceptable. Dave, do you want to take this through net, or
> should I take it through the usercopy tree?

Thanks Kees, I'll take this through my 'net' tree.
