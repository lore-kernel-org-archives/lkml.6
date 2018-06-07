Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mRMNBA1ZGVuBBgAAmS7hNA
	; Thu, 07 Jun 2018 16:10:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A21706063F; Thu,  7 Jun 2018 16:10:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 119EA60115;
	Thu,  7 Jun 2018 16:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 119EA60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936082AbeFGQKv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:10:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39176 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932975AbeFGOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:01 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0005Zw-H8; Thu, 07 Jun 2018 15:08:59 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002hi-Nb; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        syzbot+f99ab3887ab65d70f816@syzkaller.appspotmail.com,
        "Alexey Kodanev" <alexey.kodanev@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.209117817@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 021/410] dccp: check sk for closed state in
 dccp_sendmsg()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>

commit 67f93df79aeefc3add4e4b31a752600f834236e2 upstream.

dccp_disconnect() sets 'dp->dccps_hc_tx_ccid' tx handler to NULL,
therefore if DCCP socket is disconnected and dccp_sendmsg() is
called after it, it will cause a NULL pointer dereference in
dccp_write_xmit().

This crash and the reproducer was reported by syzbot. Looks like
it is reproduced if commit 69c64866ce07 ("dccp: CVE-2017-8824:
use-after-free in DCCP code") is applied.

Reported-by: syzbot+f99ab3887ab65d70f816@syzkaller.appspotmail.com
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/dccp/proto.c | 5 +++++
 1 file changed, 5 insertions(+)

--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -785,6 +785,11 @@ int dccp_sendmsg(struct kiocb *iocb, str
 	if (skb == NULL)
 		goto out_release;
 
+	if (sk->sk_state == DCCP_CLOSED) {
+		rc = -ENOTCONN;
+		goto out_discard;
+	}
+
 	skb_reserve(skb, sk->sk_prot->max_header);
 	rc = memcpy_fromiovec(skb_put(skb, len), msg->msg_iov, len);
 	if (rc != 0)
