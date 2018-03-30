Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeC3Nyo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 09:54:44 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59238 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeC3Nyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 09:54:41 -0400
Date: Fri, 30 Mar 2018 09:54:39 -0400 (EDT)
Message-Id: <20180330.095439.156028039710999285.davem@davemloft.net>
To: arnd@arndb.de
Cc: jon.maloy@ericsson.com, ying.xue@windriver.com,
        parthasarathy.bhuvaragan@ericsson.com, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tipc: avoid possible string overflow
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180328140302.2594031-1-arnd@arndb.de>
References: <20180328140302.2594031-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Mar 2018 16:02:04 +0200

> gcc points out that the combined length of the fixed-length inputs to
> l->name is larger than the destination buffer size:
> 
> net/tipc/link.c: In function 'tipc_link_create':
> net/tipc/link.c:465:26: error: '%s' directive writing up to 32 bytes into a region of size between 26 and 58 [-Werror=format-overflow=]
>   sprintf(l->name, "%s:%s-%s:unknown", self_str, if_name, peer_str);
>                           ^~                              ~~~~~~~~
> net/tipc/link.c:465:2: note: 'sprintf' output 11 or more bytes (assuming 75) into a destination of size 60
>   sprintf(l->name, "%s:%s-%s:unknown", self_str, if_name, peer_str);
> 
> Using snprintf() ensures that the destination is still a nul-terminated
> string in all cases. It's still theoretically possible that the string
> gets trunctated though, so this patch should be carefully reviewed to
> ensure that either truncation is impossible in practice, or that we're
> ok with the truncation.
> 
> Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Based upon the discussion here, it looks like Jon will fix this in a different
way by increasing the destination buffer size.
