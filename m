Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D777C04E85
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108AB2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108AB2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbeHWMGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:06:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49044 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731204AbeHWMGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:06:35 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0D812C74;
        Thu, 23 Aug 2018 08:37:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 208/217] net/smc: no shutdown in state SMC_LISTEN
Date:   Thu, 23 Aug 2018 09:55:21 +0200
Message-Id: <20180823075515.060713209@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ursula Braun <ubraun@linux.ibm.com>

commit caa21e19e08d7a1445116a93f7ab4e187ebbbadb upstream.

Invoking shutdown for a socket in state SMC_LISTEN does not make
sense. Nevertheless programs like syzbot fuzzing the kernel may
try to do this. For SMC this means a socket refcounting problem.
This patch makes sure a shutdown call for an SMC socket in state
SMC_LISTEN simply returns with -ENOTCONN.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/smc/af_smc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1180,8 +1180,7 @@ static int smc_shutdown(struct socket *s
 	lock_sock(sk);
 
 	rc = -ENOTCONN;
-	if ((sk->sk_state != SMC_LISTEN) &&
-	    (sk->sk_state != SMC_ACTIVE) &&
+	if ((sk->sk_state != SMC_ACTIVE) &&
 	    (sk->sk_state != SMC_PEERCLOSEWAIT1) &&
 	    (sk->sk_state != SMC_PEERCLOSEWAIT2) &&
 	    (sk->sk_state != SMC_APPCLOSEWAIT1) &&


