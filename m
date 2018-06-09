Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EYe8HgDyG1snXAAAmS7hNA
	; Sat, 09 Jun 2018 15:32:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 54AE1608C9; Sat,  9 Jun 2018 15:32:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYAK9Sac"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CE94A602FC;
	Sat,  9 Jun 2018 15:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE94A602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932498AbeFIPc0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932466AbeFIPcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:32:22 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 127C7204EC;
        Sat,  9 Jun 2018 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558341;
        bh=QQVI3o16oCSC+wP+rl+vKWJXbhK12n+gzQHPrbtTqmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYAK9SacLCXEo2+EmXr+cjjIQrICVJVszVigEfklUltoOGnYQA+6+sSUGz7f0N2AD
         bslZ2SZaGrCnNW5bGXLio77YQ+1AiIscUJKqq11EAGsf0fieGeYbggdAe7BTi8XzQU
         8hnSPyclEEXBvaF1jHv6z5adlqm/8seoqOeUJGCE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 10/48] ip6mr: only set ip6mr_table from setsockopt when ip6mr_new_table succeeds
Date: Sat,  9 Jun 2018 17:29:22 +0200
Message-Id: <20180609145948.320828502@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1800,7 +1800,8 @@ int ip6_mroute_setsockopt(struct sock *s
 		ret = 0;
 		if (!ip6mr_new_table(net, v))
 			ret = -ENOMEM;
-		raw6_sk(sk)->ip6mr_table = v;
+		else
+			raw6_sk(sk)->ip6mr_table = v;
 		rtnl_unlock();
 		return ret;
 	}
