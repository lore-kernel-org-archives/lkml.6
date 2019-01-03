Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA398C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC81217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfACUqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:46:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2151 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfACUqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:46:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 217A3935A9;
        Thu,  3 Jan 2019 20:46:23 +0000 (UTC)
Received: from epycfail.redhat.com (ovpn-200-16.brq.redhat.com [10.40.200.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B319A608DD;
        Thu,  3 Jan 2019 20:46:18 +0000 (UTC)
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
Subject: [PATCH net 1/2] fou: Prevent unbounded recursion in GUE error handler also with UDP-Lite
Date:   Thu,  3 Jan 2019 21:43:34 +0100
Message-Id: <8ac2d452133726dbd19ed4e814b6d2c13b0d52e9.1546547862.git.sbrivio@redhat.com>
In-Reply-To: <cover.1546547862.git.sbrivio@redhat.com>
References: <cover.1546547862.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 03 Jan 2019 20:46:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 11789039da53 ("fou: Prevent unbounded recursion in GUE error
handler"), I didn't take care of the case where UDP-Lite is encapsulated
into UDP or UDP-Lite with GUE. From a syzbot report about a possibly
similar issue with GUE on IPv6, I just realised the same thing might
happen with a UDP-Lite inner payload.

Also skip exception handling for inner UDP-Lite protocol.

Fixes: 11789039da53 ("fou: Prevent unbounded recursion in GUE error handler")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 net/ipv4/fou.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
index 0c9f171fb085..632863541082 100644
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -1065,7 +1065,8 @@ static int gue_err(struct sk_buff *skb, u32 info)
 	 * recursion. Besides, this kind of encapsulation can't even be
 	 * configured currently. Discard this.
 	 */
-	if (guehdr->proto_ctype == IPPROTO_UDP)
+	if (guehdr->proto_ctype == IPPROTO_UDP ||
+	    guehdr->proto_ctype == IPPROTO_UDPLITE)
 		return -EOPNOTSUPP;
 
 	skb_set_transport_header(skb, -(int)sizeof(struct icmphdr));
-- 
2.20.1

