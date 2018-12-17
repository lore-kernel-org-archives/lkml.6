Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E8CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC6821783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeLQXOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:14:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbeLQXOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:14:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5A1F7FDE8;
        Mon, 17 Dec 2018 23:14:50 +0000 (UTC)
Received: from epycfail.redhat.com (ovpn-200-20.brq.redhat.com [10.40.200.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC4F5D6A6;
        Mon, 17 Dec 2018 23:14:46 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     syzbot <syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net-next] fou: Prevent unbounded recursion in GUE error handler
Date:   Tue, 18 Dec 2018 00:13:17 +0100
Message-Id: <4d5bd8cb8d2b22cd6332a71428278eea6a091326.1545088026.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 17 Dec 2018 23:14:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handling exceptions for direct UDP encapsulation in GUE (that is,
UDP-in-UDP) leads to unbounded recursion in the GUE exception handler,
syzbot reported.

While draft-ietf-intarea-gue-06 doesn't explicitly forbid direct
encapsulation of UDP in GUE, it probably doesn't make sense to set up GUE
this way, and it's currently not even possible to configure this.

Skip exception handling if the GUE proto/ctype field is set to the UDP
protocol number. Should we need to handle exceptions for UDP-in-GUE one
day, we might need to either explicitly set a bound for recursion, or
implement a special iterative handling for these cases.

Reported-and-tested-by: syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com
Fixes: b8a51b38e4d4 ("fou, fou6: ICMP error handlers for FoU and GUE")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 net/ipv4/fou.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
index 0d0ad19ecb87..0c9f171fb085 100644
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -1061,6 +1061,13 @@ static int gue_err(struct sk_buff *skb, u32 info)
 	if (validate_gue_flags(guehdr, optlen))
 		return -EINVAL;
 
+	/* Handling exceptions for direct UDP encapsulation in GUE would lead to
+	 * recursion. Besides, this kind of encapsulation can't even be
+	 * configured currently. Discard this.
+	 */
+	if (guehdr->proto_ctype == IPPROTO_UDP)
+		return -EOPNOTSUPP;
+
 	skb_set_transport_header(skb, -(int)sizeof(struct icmphdr));
 	ret = gue_err_proto_handler(guehdr->proto_ctype, skb, info);
 
-- 
2.19.2

