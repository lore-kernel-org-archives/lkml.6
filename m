Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A8DC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F2321731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F2321731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404429AbeHGVL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:11:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33872 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732347AbeHGVL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:11:59 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34F44D29;
        Tue,  7 Aug 2018 18:56:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org, Dmitry Safonov <dima@arista.com>
Subject: [PATCH 4.4 07/12] netlink: Dont shift on 64 for ngroups
Date:   Tue,  7 Aug 2018 20:52:11 +0200
Message-Id: <20180807172343.653995829@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172343.326201671@linuxfoundation.org>
References: <20180807172343.326201671@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Safonov <dima@arista.com>

commit 91874ecf32e41b5d86a4cb9d60e0bee50d828058 upstream.

It's legal to have 64 groups for netlink_sock.

As user-supplied nladdr->nl_groups is __u32, it's possible to subscribe
only to first 32 groups.

The check for correctness of .bind() userspace supplied parameter
is done by applying mask made from ngroups shift. Which broke Android
as they have 64 groups and the shift for mask resulted in an overflow.

Fixes: 61f4b23769f0 ("netlink: Don't shift with UB on nlk->ngroups")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Reported-and-Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netlink/af_netlink.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -988,8 +988,8 @@ static int netlink_bind(struct socket *s
 
 	if (nlk->ngroups == 0)
 		groups = 0;
-	else
-		groups &= (1ULL << nlk->ngroups) - 1;
+	else if (nlk->ngroups < 8*sizeof(groups))
+		groups &= (1UL << nlk->ngroups) - 1;
 
 	bound = nlk->bound;
 	if (bound) {


