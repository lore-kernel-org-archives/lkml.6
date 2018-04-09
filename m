Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeDIKxn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:53:43 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54211 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeDIKxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:53:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: fix CONFIG_NF_REJECT_IPV6=m link error
Date: Mon,  9 Apr 2018 12:53:12 +0200
Message-Id: <20180409105322.2247296-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:btH1Cdz37R37KARWxeqWNXXIwjLcCfPVVNqoAo+99UtIK86Xh7j
 nOoKME0F4akaLyLbkHkC1zl5NMcadcX0wup1EwL9sSoDD2GLz/04cGAZ+ERLmzQJ8B87N1K
 Luvkjoa2gLsGv3SQ9+feOd/OeeqPtbNTWbEYegBGJoAtfo1OxQvTTC1pZYo3AeeZSGAqAPR
 xeU+D4v+inykUHj01hfVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CCsT0xQQrY8=:3C6niA5EehETLpYu3ajn+m
 ON2SVz445B3n6a6cAKLgg+luXX6UNmFjzgVKne3LKWtYqc2v8I5J/CXjzS3HCvBw8Lu+mpjDn
 aeXZX5nNxK0oDnYBr8dRmDxXwhdnRoZ6a4j2XNllO4NXV/HaEC79GYybLezG2dejJNkPlXAQj
 Mw3T2gckXYOplBUIzqSgFqg5cxNkg5uYjkePX4kk/zzqrZssoIEWGXYc2izmEiWU0HkthtWnl
 RRmLdswlCel8B7jlHVzJMICWW7RUR1G+x5rJfBJJLzAjZFZhcUt75fEuyt/VHATiVfWv9Iw6t
 9qBVWY530vdwwI5gVd6Y2ANPH9yftc5UV9tQuFkuwNbyemmdtlyrZChrZ3qaZcJSzsO0IX7UF
 82RnhLBDnP2VBobZuiQlKxFYyy1JXND6c0qPRgtfoxadBxp52VbmIJ0mbUKyQMl4BYqgVq37D
 aCptaeIvmIYtRPjx4J58amhEdxuDqM+IH9sT7GTFfE/KIfbLPkGyd03Me6i9PL+/bkMKCjjiA
 pw1mlWWxh7XoPdy5oWQXwuV7HTf3BTFVfbV+G4l2Pq5luyH9QwTjD3SFshp8u4xtxt9syDsxN
 p1Tdr+ES3shUoV7cZ70w+ZhQzv6+ZUQEh+7CE6Z1j2zrrxt2jM7GsugnGDW1L3RCT2PotCV4R
 u/SaPfPqvWG18ClHgrs0ZmlT10ZGPxXZ6yJUZWFZcPTY6xZ/V8Pk469a1AIOmoVr/rxW6uPGa
 MjqckEPgVJV1Rx1iRHVXqd5sBJQr1i5WYHjr+Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a new link error with CONFIG_NFT_REJECT_INET=y and CONFIG_NF_REJECT_IPV6=m
after larger parts of the nftables modules are linked together:

net/netfilter/nft_reject_inet.o: In function `nft_reject_inet_eval':
nft_reject_inet.c:(.text+0x17c): undefined reference to `nf_send_unreach6'
nft_reject_inet.c:(.text+0x190): undefined reference to `nf_send_reset6'

The problem is that with NF_TABLES_INET set, we implicitly try to use
the ipv6 version as well for NFT_REJECT, but when CONFIG_IPV6 is set to
a loadable module, it's impossible to reach that.

The best workaround I found is to express the above as a Kconfig
dependency, forcing NFT_REJECT itself to be 'm' in that particular
configuration.

Fixes: 02c7b25e5f54 ("netfilter: nf_tables: build-in filter chain type")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/netfilter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 704b3832dbad..44d8a55e9721 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -594,6 +594,7 @@ config NFT_QUOTA
 config NFT_REJECT
 	default m if NETFILTER_ADVANCED=n
 	tristate "Netfilter nf_tables reject support"
+	depends on !NF_TABLES_INET || (IPV6!=m || m)
 	help
 	  This option adds the "reject" expression that you can use to
 	  explicitly deny and notify via TCP reset/ICMP informational errors
-- 
2.9.0
