Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CBBC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0C520877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0C520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeJDSa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:30:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:46334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727183AbeJDSa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:30:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 358DDADF4;
        Thu,  4 Oct 2018 11:37:34 +0000 (UTC)
Date:   Thu, 4 Oct 2018 13:37:32 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] udp: Unbreak modules that rely on external __skb_recv_udp()
 availability
Message-ID: <nycvar.YFH.7.76.1810041335180.14430@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Commit 2276f58ac589 ("udp: use a separate rx queue for packet reception")
turned static inline __skb_recv_udp() from being a trivial helper around
__skb_recv_datagram() into a UDP specific implementaion, making it
EXPORT_SYMBOL_GPL() at the same time.

There are external modules that got broken by __skb_recv_udp() not being
visible to them. Let's unbreak them by making __skb_recv_udp EXPORT_SYMBOL().

Rationale (one of those) why this is actually "technically correct" thing 
to do: __skb_recv_udp() used to be an inline wrapper around 
__skb_recv_datagram(), which itself (still, and correctly so, I believe) 
is EXPORT_SYMBOL().

Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Fixes: 2276f58ac589 ("udp: use a separate rx queue for packet reception")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 net/ipv4/udp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 7d69dd6fa7e8..c32a4c16b7ff 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1627,7 +1627,7 @@ struct sk_buff *__skb_recv_udp(struct sock *sk, unsigned int flags,
 	*err = error;
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(__skb_recv_udp);
+EXPORT_SYMBOL(__skb_recv_udp);
 
 /*
  * 	This should be easy, if there is something there we

-- 
Jiri Kosina
SUSE Labs

