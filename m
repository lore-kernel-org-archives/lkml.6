Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB50C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5EE2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5EE2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeJCDnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:43:43 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40189 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeJCDnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:43:43 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N336J-1fjtXd3F7N-013Jow; Tue, 02 Oct 2018 22:58:12 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N336J-1fjtXd3F7N-013Jow; Tue, 02 Oct 2018 22:58:12 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Stephen Hemminger <stephen@networkplumber.org>,
        James Ettle <james@ettle.org.uk>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] SUNRPC: use cmpxchg64() in gss_seq_send64_fetch_and_inc()
Date:   Tue,  2 Oct 2018 22:57:46 +0200
Message-Id: <20181002205809.2300654-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:lNyES8Q4W/wdnZs89Ag72TAXAvvZEjO3c58E63gJn5ORXq5fJFl
 7q2VzekIUqco2jvxaLm6+ujxajDMqFjoc55sEVj5kODYVRvSMyZYYNitej4SS+e44GnAx1w
 8XoMiqcSiPIXUIA9ziMrcYcMVt5fo2cuX8Wenwy3dHgIKp3ZQCL4dRFFcCYIm5/muzWql7m
 jgwNYPEDutDD9yW2LWi9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mVHGP47/Cb0=:YOQWVq148YCWBGdaCEiTdX
 c4GEMvdhAvlpOIPciZLv7jszxefpOMMfr3TMXQgsqXV6kuKeh1VoBj/QNE2bMtHWB8Nmd4ZQz
 a0B0OeDuaZf2abKzNrVGiFjf4PdlPWWngGbyWkLvEWkgKdLQjJVYTN/Lv4D+OFawvNLoi8TPB
 MoSqG3/Q1GQL6Bft12LKivKdm7Z4+BCT5zXqGZqcUqaBVS86/l+L8r/rnjxlDe+6GD/DnqXWY
 PZRCBJICs+kAkxWKGvs596olN2C7XcQzArqjMNsMY4hoSzIET7hk61SL/F5gebcbJXxE4kjSg
 74FoaTdlRDUjrs7xQd8NyWn0prp/RHAB1SxItplrAhIs2ACGmIH8bZnEB5gvCY2rgqRg4eqUg
 9ZTdZdbcOx033f7LHZYa63EpF76xd1zF+V8Yy5vt1BSv+Iu2euKs2nCZGC0OIPh4t2R0vvKr3
 e5oyYO/DQccpZ2w4uGODab4BfKPGEEYptWTxqmdaRDnKBPqrx+nSxrimXPnMIJDXH9nnATYlp
 qYhfCie7rL7fLFyjC67mfGTkQhFhjjJEj6cwUiezFjGCrsFi93g1L1pdRLG2VPtQQXd2jM/vP
 pRA2GOls9LkLOiFl5KdN/0mptdp1V3IUZBYy1s3Ltg4ajpDFw4p0atLmoweP93rE61KShPw/x
 v9epkf5lGe/B35wt3TeNAIfl9+y8mtZ8FNOVU0Bwwkwp6VxG7uqCIeJjiFMvVH9tu40Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced gss_seq_send64_fetch_and_inc() fails to build on
32-bit architectures:

net/sunrpc/auth_gss/gss_krb5_seal.c:144:14: note: in expansion of macro 'cmpxchg'
   seq_send = cmpxchg(&ctx->seq_send64, old, old + 1);
              ^~~~~~~
arch/x86/include/asm/cmpxchg.h:128:3: error: call to '__cmpxchg_wrong_size' declared with attribute error: Bad argument size for cmpxchg
   __cmpxchg_wrong_size();     \

As the message tells us, cmpxchg() cannot be used on 64-bit arguments,
that's what cmpxchg64() does.

Fixes: 571ed1fd2390 ("SUNRPC: Replace krb5_seq_lock with a lockless scheme")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/sunrpc/auth_gss/gss_krb5_seal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_seal.c b/net/sunrpc/auth_gss/gss_krb5_seal.c
index 92594681d619..5775b9805bdc 100644
--- a/net/sunrpc/auth_gss/gss_krb5_seal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_seal.c
@@ -141,7 +141,7 @@ gss_seq_send64_fetch_and_inc(struct krb5_ctx *ctx)
 
 	do {
 		old = seq_send;
-		seq_send = cmpxchg(&ctx->seq_send64, old, old + 1);
+		seq_send = cmpxchg64(&ctx->seq_send64, old, old + 1);
 	} while (old != seq_send);
 	return seq_send;
 }
-- 
2.18.0

