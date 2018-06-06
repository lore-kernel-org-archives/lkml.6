Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="XfjmKS6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFD35607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeFFNyv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:54:51 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:59629 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbeFFNys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:54:48 -0400
X-IronPort-AV: E=Sophos;i="5.49,483,1520899200";
   d="scan'208";a="346935036"
From: Norbert Manthey <nmanthey@amazon.de>
CC: Norbert Manthey <nmanthey@amazon.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        John Crispin <john@phrozen.org>,
        Simon Horman <simon.horman@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Tom Herbert <tom@quantonium.net>,
        Eric Dumazet <edumazet@google.com>,
        "Sven Eckelmann" <sven.eckelmann@openmesh.com>,
        WANG Cong <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [less-CONFIG_NET 5/7] seccomp: cut off functions not required
Date: Wed, 6 Jun 2018 15:53:24 +0200
Message-ID: <1528293206-24298-5-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
References: <1528293127-23825-1-git-send-email-nmanthey@amazon.de>
 <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using CONFIG_SECCOMP_FILTER, not all functions of filter.c and
flow_dissector.c are required. To not pull in more dependencies,
guard the functions that are not required with CONFIG_NET defines.
This way, these functions are enabled in case the file is compiled
because of CONFIG_NET, but they are not present when the file is
compiled because of other configurations.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
---
 net/core/filter.c         | 2 ++
 net/core/flow_dissector.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0d980e9..4ddacb7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1063,6 +1063,7 @@ void bpf_prog_destroy(struct bpf_prog *fp)
 }
 EXPORT_SYMBOL_GPL(bpf_prog_destroy);
 
+#if defined(CONFIG_NET)
 /**
  *	sk_filter_trim_cap - run a packet through a socket filter
  *	@sk: sock associated with &sk_buff
@@ -5657,3 +5658,4 @@ int sk_get_filter(struct sock *sk, struct sock_filter __user *ubuf,
 	release_sock(sk);
 	return ret;
 }
+#endif  // CONFIG_NET
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 70e0679..0903444 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1219,6 +1219,7 @@ u32 skb_get_poff(const struct sk_buff *skb)
 	return __skb_get_poff(skb, skb->data, &keys, skb_headlen(skb));
 }
 
+#if defined(CONFIG_NET)
 __be32 flow_get_u32_src(const struct flow_keys *flow)
 {
 	switch (flow->control.addr_type) {
@@ -1340,6 +1341,7 @@ __u32 __get_hash_from_flowi6(const struct flowi6 *fl6, struct flow_keys *keys)
 	return flow_hash_from_keys(keys);
 }
 EXPORT_SYMBOL(__get_hash_from_flowi6);
+#endif  // CONFIG_NET
 
 static const struct flow_dissector_key flow_keys_dissector_keys[] = {
 	{
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
