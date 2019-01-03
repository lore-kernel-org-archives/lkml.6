Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E17C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7E0217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbfACUqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:46:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfACUq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:46:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB5C68CAF;
        Thu,  3 Jan 2019 20:46:26 +0000 (UTC)
Received: from epycfail.redhat.com (ovpn-200-16.brq.redhat.com [10.40.200.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5FAD608DD;
        Thu,  3 Jan 2019 20:46:23 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     syzbot <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net 2/2] fou6: Prevent unbounded recursion in GUE error handler
Date:   Thu,  3 Jan 2019 21:43:35 +0100
Message-Id: <016ff4ef04b7ac0654a71dc531cee985b472e2c5.1546547862.git.sbrivio@redhat.com>
In-Reply-To: <cover.1546547862.git.sbrivio@redhat.com>
References: <cover.1546547862.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 03 Jan 2019 20:46:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to deal with IPv6 in commit 11789039da53 ("fou: Prevent unbounded
recursion in GUE error handler").

Now syzbot reported what might be the same type of issue, caused by
gue6_err(), that is, handling exceptions for direct UDP encapsulation in
GUE (UDP-in-UDP) leads to unbounded recursion in the GUE exception
handler.

As it probably doesn't make sense to set up GUE this way, and it's
currently not even possible to configure this, skip exception handling for
UDP (or UDP-Lite) packets encapsulated in UDP (or UDP-Lite) packets with
GUE on IPv6.

Reported-by: syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com
Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Fixes: b8a51b38e4d4 ("fou, fou6: ICMP error handlers for FoU and GUE")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 net/ipv6/fou6.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/fou6.c b/net/ipv6/fou6.c
index bd675c61deb1..7da7bf3b7fe3 100644
--- a/net/ipv6/fou6.c
+++ b/net/ipv6/fou6.c
@@ -131,6 +131,14 @@ static int gue6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	if (validate_gue_flags(guehdr, optlen))
 		return -EINVAL;
 
+	/* Handling exceptions for direct UDP encapsulation in GUE would lead to
+	 * recursion. Besides, this kind of encapsulation can't even be
+	 * configured currently. Discard this.
+	 */
+	if (guehdr->proto_ctype == IPPROTO_UDP ||
+	    guehdr->proto_ctype == IPPROTO_UDPLITE)
+		return -EOPNOTSUPP;
+
 	skb_set_transport_header(skb, -(int)sizeof(struct icmp6hdr));
 	ret = gue6_err_proto_handler(guehdr->proto_ctype, skb,
 				     opt, type, code, offset, info);
-- 
2.20.1

