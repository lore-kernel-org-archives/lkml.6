Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E359ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFFA20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFFA20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388688AbeGWN2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:28:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbeGWN2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:28:43 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AB402BB3;
        Mon, 23 Jul 2018 12:27:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f0d9d7cba052f9344b03@syzkaller.appspotmail.com,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 53/63] sctp: fix the issue that pathmtu may be set lower than MINSEGMENT
Date:   Mon, 23 Jul 2018 14:24:59 +0200
Message-Id: <20180723122448.365212840@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit a65925475571953da12a9bc2082aec29d4e2c0e7 ]

After commit b6c5734db070 ("sctp: fix the handling of ICMP Frag Needed
for too small MTUs"), sctp_transport_update_pmtu would refetch pathmtu
from the dst and set it to transport's pathmtu without any check.

The new pathmtu may be lower than MINSEGMENT if the dst is obsolete and
updated by .get_dst() in sctp_transport_update_pmtu. In this case, it
could have a smaller MTU as well, and thus we should validate it
against MINSEGMENT instead.

Syzbot reported a warning in sctp_mtu_payload caused by this.

This patch refetches the pathmtu by calling sctp_dst_mtu where it does
the check against MINSEGMENT.

v1->v2:
  - refetch the pathmtu by calling sctp_dst_mtu instead as Marcelo's
    suggestion.

Fixes: b6c5734db070 ("sctp: fix the handling of ICMP Frag Needed for too small MTUs")
Reported-by: syzbot+f0d9d7cba052f9344b03@syzkaller.appspotmail.com
Suggested-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -273,7 +273,7 @@ bool sctp_transport_update_pmtu(struct s
 
 	if (dst) {
 		/* Re-fetch, as under layers may have a higher minimum size */
-		pmtu = SCTP_TRUNC4(dst_mtu(dst));
+		pmtu = sctp_dst_mtu(dst);
 		change = t->pathmtu != pmtu;
 	}
 	t->pathmtu = pmtu;


