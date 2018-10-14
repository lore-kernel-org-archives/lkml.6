Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D882DC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97D920645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97D920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbeJNXZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:25:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37030 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeJNXZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:25:07 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLx-0004co-Cp; Sun, 14 Oct 2018 16:30:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLU-0000Oj-FA; Sun, 14 Oct 2018 16:30:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Cong Wang" <xiyou.wangcong@gmail.com>,
        "kernel test robot" <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.629792153@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 190/366] llc: fix NULL pointer deref for SOCK_ZAPPED
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 3a04ce7130a7e5dad4e78d45d50313747f8c830f upstream.

For SOCK_ZAPPED socket, we don't need to care about llc->sap,
so we should just skip these refcount functions in this case.

Fixes: f7e43672683b ("llc: hold llc_sap before release_sock()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/llc/af_llc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -187,7 +187,6 @@ static int llc_ui_release(struct socket
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc;
-	struct llc_sap *sap;
 
 	if (unlikely(sk == NULL))
 		goto out;
@@ -198,15 +197,19 @@ static int llc_ui_release(struct socket
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, sk->sk_rcvtimeo);
-	sap = llc->sap;
-	/* Hold this for release_sock(), so that llc_backlog_rcv() could still
-	 * use it.
-	 */
-	llc_sap_hold(sap);
-	if (!sock_flag(sk, SOCK_ZAPPED))
+	if (!sock_flag(sk, SOCK_ZAPPED)) {
+		struct llc_sap *sap = llc->sap;
+
+		/* Hold this for release_sock(), so that llc_backlog_rcv()
+		 * could still use it.
+		 */
+		llc_sap_hold(sap);
 		llc_sap_remove_socket(llc->sap, sk);
-	release_sock(sk);
-	llc_sap_put(sap);
+		release_sock(sk);
+		llc_sap_put(sap);
+	} else {
+		release_sock(sk);
+	}
 	if (llc->dev)
 		dev_put(llc->dev);
 	sock_put(sk);

