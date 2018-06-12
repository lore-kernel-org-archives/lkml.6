Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2E63AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8838208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO9lg6Mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8838208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935080AbeFLQww (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934968AbeFLQws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:52:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E5C208B4;
        Tue, 12 Jun 2018 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822367;
        bh=r87PFb0bx4Gd283S1V03+FAqiuxt9TYUdldeb4YLTj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZO9lg6MxExW1anz9lTjSVnSHzA6JGN7ubf3DWg+vaEF+LzvLQvF0cZgaptIjxHICj
         pboIdWVldkZUeV13sMJxTQyAPpxqija0mWvjIR2mdvg/3ttJyfG4x8saK7b30FhBvM
         c3A/U/uT3Rvri/iR/OYQzQ4fq+62zWPXjV/kNsRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 12/24] ip6mr: only set ip6mr_table from setsockopt when ip6mr_new_table succeeds
Date:   Tue, 12 Jun 2018 18:51:56 +0200
Message-Id: <20180612164817.181262749@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164816.587001852@linuxfoundation.org>
References: <20180612164816.587001852@linuxfoundation.org>
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

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 848235edb5c93ed086700584c8ff64f6d7fc778d ]

Currently, raw6_sk(sk)->ip6mr_table is set unconditionally during
ip6_mroute_setsockopt(MRT6_TABLE). A subsequent attempt at the same
setsockopt will fail with -ENOENT, since we haven't actually created
that table.

A similar fix for ipv4 was included in commit 5e1859fbcc3c ("ipv4: ipmr:
various fixes and cleanups").

Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6mr.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1787,7 +1787,8 @@ int ip6_mroute_setsockopt(struct sock *s
 		ret = 0;
 		if (!ip6mr_new_table(net, v))
 			ret = -ENOMEM;
-		raw6_sk(sk)->ip6mr_table = v;
+		else
+			raw6_sk(sk)->ip6mr_table = v;
 		rtnl_unlock();
 		return ret;
 	}


