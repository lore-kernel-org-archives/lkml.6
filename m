Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C863FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D213420892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D213420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeG3O1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:27:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:48926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729460AbeG3O1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:27:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B07F8AF42;
        Mon, 30 Jul 2018 12:52:47 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 5FB3BA0BE8; Mon, 30 Jul 2018 14:52:47 +0200 (CEST)
Message-Id: <1b860198a5b775d24bb4eba2c917d2c87120ac9e.1532953989.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532953989.git.mkubecek@suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v2 01/17] netlink: introduce nla_put_bitfield32()
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:52:47 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other data types, this helper puts NLA_BITFIELD32 attribute into
a netlink message. It takes separate value and selector arguments, if you
already have struct nla_bitfield32, you can use nla_put().

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 include/net/netlink.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 0c154f98e987..6d4eb6bd9235 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1064,6 +1064,21 @@ static inline int nla_put_in6_addr(struct sk_buff *skb, int attrtype,
 	return nla_put(skb, attrtype, sizeof(*addr), addr);
 }
 
+/**
+ * nla_put_bitfield32 - Add a bitfield32 value/selector attribute to
+ * a socket buffer
+ * @skb: socket buffer to add attribute to
+ * @value: 32-bit value bitmap
+ * @selector: 32-bit selector bitmap
+ */
+static inline int nla_put_bitfield32(struct sk_buff *skb, int attrtype,
+				     u32 value, u32 selector)
+{
+	struct nla_bitfield32 tmp = { .value = value, .selector = selector };
+
+	return nla_put(skb, attrtype, sizeof(tmp), &tmp);
+}
+
 /**
  * nla_get_u32 - return payload of u32 attribute
  * @nla: u32 netlink attribute
-- 
2.18.0

