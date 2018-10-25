Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F40C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4350520834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6FUuy3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4350520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbeJYWuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729812AbeJYWuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:51 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EF2320854;
        Thu, 25 Oct 2018 14:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477074;
        bh=ruMzW4sPCw9kmeWoEVdWj8+IqBrWgTSptD+mMoUUTUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6FUuy3Quys7jPvCQiryTsyQIhJVLqmlyRzfrzZnDZFQ9CdfuJs0TLoHkblFveGyR
         URnVn4j9HTc845bf06EPjjavfWxStD6PK/t/DPMI+aUJg2awkAgqTxb2E/1sgUqCPy
         o8CUbJ7zxokuNiakycJLt+ANDBo9rq1z9ImQPxVc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Basseri <misterikkit@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 28/65] xfrm: Clear sk_dst_cache when applying per-socket policy.
Date:   Thu, 25 Oct 2018 10:16:28 -0400
Message-Id: <20181025141705.213937-28-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Basseri <misterikkit@google.com>

[ Upstream commit 2b06cdf3e688b98fcc9945873b5d42792bd4eee0 ]

If a socket has a valid dst cache, then xfrm_lookup_route will get
skipped. However, the cache is not invalidated when applying policy to a
socket (i.e. IPV6_XFRM_POLICY). The result is that new policies are
sometimes ignored on those sockets. (Note: This was broken for IPv4 and
IPv6 at different times.)

This can be demonstrated like so,
1. Create UDP socket.
2. connect() the socket.
3. Apply an outbound XFRM policy to the socket. (setsockopt)
4. send() data on the socket.

Packets will continue to be sent in the clear instead of matching an
xfrm or returning a no-match error (EAGAIN). This affects calls to
send() and not sendto().

Invalidating the sk_dst_cache is necessary to correctly apply xfrm
policies. Since we do this in xfrm_user_policy(), the sk_lock was
already acquired in either do_ip_setsockopt() or do_ipv6_setsockopt(),
and we may call __sk_dst_reset().

Performance impact should be negligible, since this code is only called
when changing xfrm policy, and only affects the socket in question.

Fixes: 00bc0ef5880d ("ipv6: Skip XFRM lookup if dst_entry in socket cache is valid")
Tested: https://android-review.googlesource.com/517555
Tested: https://android-review.googlesource.com/418659
Signed-off-by: Jonathan Basseri <misterikkit@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index d6a11af0bab1..9b6e51450fc5 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1884,6 +1884,7 @@ int xfrm_user_policy(struct sock *sk, int optname, u8 __user *optval, int optlen
 	if (err >= 0) {
 		xfrm_sk_policy_insert(sk, err, pol);
 		xfrm_pol_put(pol);
+		__sk_dst_reset(sk);
 		err = 0;
 	}
 
-- 
2.17.1

