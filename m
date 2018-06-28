Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C647C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B0427372
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="MqPbS5xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B0427372
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965986AbeF1MrO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:47:14 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:52412 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965950AbeF1MrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1530190031; x=1561726031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=sbYzF1pgxtiq3kjYA7JO+gH4r7Zq4U4TR+mwdiux1q8=;
  b=MqPbS5xFnNGQ+WHZ5veselNFHyHW+6V213B3s1FgIYIx8sjErhGjTHTI
   Wo4NFW1bHW9w3b/tPmdP9grG0oILhP5em9OjX1fCBzj3bw7bcPYbXyccl
   da3/YS5sfj/+uuIt0miv85DFXauvqHmQgcdlXok1YV/Y0IUCI+bN9Pe2X
   U=;
X-IronPort-AV: E=Sophos;i="5.51,283,1526342400"; 
   d="scan'208";a="620006224"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Jun 2018 12:47:04 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5SCks71086785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 28 Jun 2018 12:46:59 GMT
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:49 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D02EUC001.ant.amazon.com (10.43.164.92) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:48 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.28.85.80) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 28 Jun 2018 12:46:46 +0000
From:   Norbert Manthey <nmanthey@amazon.de>
To:     Norbert Manthey <nmanthey@amazon.de>,
        <linux-kernel@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Tom Herbert <tom@quantonium.net>,
        Simon Horman <simon.horman@netronome.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        John Crispin <john@phrozen.org>,
        Sven Eckelmann <sven.eckelmann@openmesh.com>,
        WANG Cong <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>, <netdev@vger.kernel.org>
Subject: [less-CONFIG_NET v2 5/8] seccomp: cut off functions not required
Date:   Thu, 28 Jun 2018 14:45:33 +0200
Message-ID: <1530189936-25780-6-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530189936-25780-1-git-send-email-nmanthey@amazon.de>
References: <ef0fe0ef-3620-3628-2a7e-c8b73e466a21@amazon.de>
 <1530189936-25780-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index 61c24c9..410189c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1250,6 +1250,7 @@ void bpf_prog_destroy(struct bpf_prog *fp)
 }
 EXPORT_SYMBOL_GPL(bpf_prog_destroy);
 
+#if defined(CONFIG_NET)
 /**
  *	sk_filter_trim_cap - run a packet through a socket filter
  *	@sk: sock associated with &sk_buff
@@ -6823,3 +6824,4 @@ int sk_get_filter(struct sock *sk, struct sock_filter __user *ubuf,
 	release_sock(sk);
 	return ret;
 }
+#endif  // CONFIG_NET
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 76d0b23..f5ba8e9 100644
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

