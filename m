Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B064ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2C2214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2C2214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbeIRE1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:27:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47332 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeIRE1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:27:17 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E170CC7D;
        Mon, 17 Sep 2018 22:57:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 10/70] IB/rxe: do not copy extra stack memory to skb
Date:   Tue, 18 Sep 2018 00:41:43 +0200
Message-Id: <20180917211650.034412121@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 4c93496f18ce5044d78e4f7f9e018682a4f44b3d upstream.

This fixes a over-read condition detected by FORTIFY_SOURCE for this
line:

	memcpy(SKB_TO_PKT(skb), &ack_pkt, sizeof(skb->cb));

The error was:

  In file included from ./include/linux/bitmap.h:8:0,
                   from ./include/linux/cpumask.h:11,
                   from ./include/linux/mm_types_task.h:13,
                   from ./include/linux/mm_types.h:4,
                   from ./include/linux/kmemcheck.h:4,
                   from ./include/linux/skbuff.h:18,
                   from drivers/infiniband/sw/rxe/rxe_resp.c:34:
  In function 'memcpy',
      inlined from 'send_atomic_ack.constprop' at drivers/infiniband/sw/rxe/rxe_resp.c:998:2,
      inlined from 'acknowledge' at drivers/infiniband/sw/rxe/rxe_resp.c:1026:3,
      inlined from 'rxe_responder' at drivers/infiniband/sw/rxe/rxe_resp.c:1286:10:
  ./include/linux/string.h:309:4: error: call to '__read_overflow2' declared with attribute error: detected read beyond size of object passed as 2nd parameter
      __read_overflow2();

Daniel Micay noted that struct rxe_pkt_info is 32 bytes on 32-bit
architectures, but skb->cb is still 64.  The memcpy() over-reads 32
bytes.  This fixes it by zeroing the unused bytes in skb->cb.

Link: http://lkml.kernel.org/r/1497903987-21002-5-git-send-email-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Moni Shoua <monis@mellanox.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Sean Hefty <sean.hefty@intel.com>
Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/rxe/rxe_resp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -978,7 +978,9 @@ static int send_atomic_ack(struct rxe_qp
 	free_rd_atomic_resource(qp, res);
 	rxe_advance_resp_resource(qp);
 
-	memcpy(SKB_TO_PKT(skb), &ack_pkt, sizeof(skb->cb));
+	memcpy(SKB_TO_PKT(skb), &ack_pkt, sizeof(ack_pkt));
+	memset((unsigned char *)SKB_TO_PKT(skb) + sizeof(ack_pkt), 0,
+	       sizeof(skb->cb) - sizeof(ack_pkt));
 
 	res->type = RXE_ATOMIC_MASK;
 	res->atomic.skb = skb;


