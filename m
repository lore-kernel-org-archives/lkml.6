Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE12AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B7F20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B7F20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403922AbeHATDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:03:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403824AbeHATDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:31 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B54F112EF;
        Wed,  1 Aug 2018 17:11:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <rong.a.chen@intel.com>,
        Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 328/336] netlink: Dont shift with UB on nlk->ngroups
Date:   Wed,  1 Aug 2018 18:51:03 +0200
Message-Id: <20180801165041.591409494@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Dmitry Safonov <dima@arista.com>

[ Upstream commit 61f4b23769f0cc72ae62c9a81cf08f0397d40da8 ]

On i386 nlk->ngroups might be 32 or 0. Which leads to UB, resulting in
hang during boot.
Check for 0 ngroups and use (unsigned long long) as a type to shift.

Fixes: 7acf9d4237c4 ("netlink: Do not subscribe to non-existent groups").
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/af_netlink.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1008,7 +1008,11 @@ static int netlink_bind(struct socket *s
 		if (err)
 			return err;
 	}
-	groups &= (1UL << nlk->ngroups) - 1;
+
+	if (nlk->ngroups == 0)
+		groups = 0;
+	else
+		groups &= (1ULL << nlk->ngroups) - 1;
 
 	bound = nlk->bound;
 	if (bound) {


