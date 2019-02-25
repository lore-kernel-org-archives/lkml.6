Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCE5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9136021841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130502;
	bh=MXDR318khDe5phUV0zcyWudAKtBeL6baOeQVKc+u0Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iGRXVI6g8bKpSODdH5Hwsz/eSuN213J1k5GJuNvzPRM2WdCVR6v8km5UpLON3KQCH
	 ByCyUyO1w4NFCVxFW4A4K5mAFzQ8kgQOwMxldS9iZkEWXUlBCtYC0PX+JFCHUjfPP3
	 abigtgqPYSd3CFsEzCgR8nEpGRO+tlQwAEAqNOQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbfBYVfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:35:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732894AbfBYVe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:34:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4DFB21841;
        Mon, 25 Feb 2019 21:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130498;
        bh=MXDR318khDe5phUV0zcyWudAKtBeL6baOeQVKc+u0Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBAQSmOZSdypT9rDGhGMy1Ar7dlw8Lm4CXabnyyGvvTUbiHgmfYPkJXpLQJ0GDX/L
         3KVjvMmVFdONTMmySnhPEZiF6P4NKRegMqxOBb5/ZXNOdeNVJf9nt9codRmqOviP96
         3oFAoDM8dfOMJyHEa2888xio7zo3pizaaucf2nvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 138/183] geneve: should not call rt6_lookup() when ipv6 was disabled
Date:   Mon, 25 Feb 2019 22:11:51 +0100
Message-Id: <20190225195118.166886226@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit c0a47e44c0980b3b23ee31fa7936d70ea5dce491 ]

When we add a new GENEVE device with IPv6 remote, checking only for
IS_ENABLED(CONFIG_IPV6) is not enough as we may disable IPv6 in the
kernel command line (ipv6.disable=1), and calling rt6_lookup() would
cause a NULL pointer dereference.

v2:
- don't mix declarations and code (reported by Stefano Brivio, Eric Dumazet)
- there's no need to use in6_dev_get() as we only need to check that
  idev exists (reported by David Ahern). This is under RTNL, so we can
  simply use __in6_dev_get() instead (Stefano, Eric).

Reported-by: Jianlin Shi <jishi@redhat.com>
Fixes: c40e89fd358e9 ("geneve: configure MTU based on a lower device")
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/geneve.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1426,9 +1426,13 @@ static void geneve_link_config(struct ne
 	}
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6: {
-		struct rt6_info *rt = rt6_lookup(geneve->net,
-						 &info->key.u.ipv6.dst, NULL, 0,
-						 NULL, 0);
+		struct rt6_info *rt;
+
+		if (!__in6_dev_get(dev))
+			break;
+
+		rt = rt6_lookup(geneve->net, &info->key.u.ipv6.dst, NULL, 0,
+				NULL, 0);
 
 		if (rt && rt->dst.dev)
 			ldev_mtu = rt->dst.dev->mtu - GENEVE_IPV6_HLEN;


