Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C27DC282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF362083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfBDE0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 23:26:08 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46862 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfBDE0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 23:26:08 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8C3A614DF5FC5;
        Sun,  3 Feb 2019 20:26:07 -0800 (PST)
Date:   Sun, 03 Feb 2019 20:26:06 -0800 (PST)
Message-Id: <20190203.202606.1052226767975507689.davem@davemloft.net>
To:     sfr@canb.auug.org.au
Cc:     netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, deepa.kernel@gmail.com,
        gustavo@embeddedor.com, keescook@chromium.org
Subject: Re: linux-next: build warning after merge of the net-next tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190204104427.0c0da12d@canb.auug.org.au>
References: <20190204104427.0c0da12d@canb.auug.org.au>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Feb 2019 20:26:07 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 4 Feb 2019 10:44:27 +1100

> After merging the net-next tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> net/core/sock.c: In function 'sock_setsockopt':
> net/core/sock.c:914:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    sock_set_flag(sk, SOCK_TSTAMP_NEW);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/core/sock.c:915:2: note: here
>   case SO_TIMESTAMPING_OLD:
>   ^~~~
> 
> Introduced by commit
> 
>   9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")

Thanks, I just pushed the following:

====================
[PATCH] net: Fix fall through warning in y2038 tstamp changes.

net/core/sock.c: In function 'sock_setsockopt':
net/core/sock.c:914:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   sock_set_flag(sk, SOCK_TSTAMP_NEW);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/core/sock.c:915:2: note: here
  case SO_TIMESTAMPING_OLD:
  ^~~~

Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/core/sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index a8904ae40713..71ded4d8025c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -912,6 +912,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 
 	case SO_TIMESTAMPING_NEW:
 		sock_set_flag(sk, SOCK_TSTAMP_NEW);
+		/* fall through */
 	case SO_TIMESTAMPING_OLD:
 		if (val & ~SOF_TIMESTAMPING_MASK) {
 			ret = -EINVAL;
-- 
2.20.1

