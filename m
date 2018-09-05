Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EADC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862F120659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862F120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeIEU0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:26:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbeIEU0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:26:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80D70400ADE6;
        Wed,  5 Sep 2018 15:55:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F036202706C;
        Wed,  5 Sep 2018 15:55:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/11] UAPI: netfilter: Fix symbol collision issues
From:   David Howells <dhowells@redhat.com>
To:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 05 Sep 2018 16:55:16 +0100
Message-ID: <153616291694.23468.3826354165095743891.stgit@warthog.procyon.org.uk>
In-Reply-To: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 15:55:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 15:55:18 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The netfilter UAPI headers have some symbol collision issues:

 (1) "enum nfnl_acct_msg_types" is defined twice, and each definition is
     completely different.

     Fix this by renaming the one in nfnetlink_cthelper.h to be "enum
     nfnl_cthelper_types" to be consistent with the other things in that
     file.

 (2) There's a disagreement between ipt_ECN.h and ipt_ecn.h over the
     definition of various IPT_ECN_* constants, leading to an error over
     IPT_ECN_IP_MASK being substituted when being defined as an enum value
     in ipt_ecn.h if ipt_ECN.h is #included first.

     Fix this by removing the conflicting constants from ipt_ECN.h and
     including ipt_ecn.h instead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: netfilter-devel@vger.kernel.org
cc: coreteam@netfilter.org
---

 include/uapi/linux/netfilter/nfnetlink_cthelper.h |    2 +-
 include/uapi/linux/netfilter_ipv4/ipt_ECN.h       |    9 +--------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/netfilter/nfnetlink_cthelper.h b/include/uapi/linux/netfilter/nfnetlink_cthelper.h
index a13137afc429..b9313ed0c313 100644
--- a/include/uapi/linux/netfilter/nfnetlink_cthelper.h
+++ b/include/uapi/linux/netfilter/nfnetlink_cthelper.h
@@ -5,7 +5,7 @@
 #define NFCT_HELPER_STATUS_DISABLED	0
 #define NFCT_HELPER_STATUS_ENABLED	1
 
-enum nfnl_acct_msg_types {
+enum nfnl_cthelper_types {
 	NFNL_MSG_CTHELPER_NEW,
 	NFNL_MSG_CTHELPER_GET,
 	NFNL_MSG_CTHELPER_DEL,
diff --git a/include/uapi/linux/netfilter_ipv4/ipt_ECN.h b/include/uapi/linux/netfilter_ipv4/ipt_ECN.h
index e3630fd045b8..d582119ad62a 100644
--- a/include/uapi/linux/netfilter_ipv4/ipt_ECN.h
+++ b/include/uapi/linux/netfilter_ipv4/ipt_ECN.h
@@ -12,14 +12,7 @@
 
 #include <linux/types.h>
 #include <linux/netfilter/xt_DSCP.h>
-
-#define IPT_ECN_IP_MASK	(~XT_DSCP_MASK)
-
-#define IPT_ECN_OP_SET_IP	0x01	/* set ECN bits of IPv4 header */
-#define IPT_ECN_OP_SET_ECE	0x10	/* set ECE bit of TCP header */
-#define IPT_ECN_OP_SET_CWR	0x20	/* set CWR bit of TCP header */
-
-#define IPT_ECN_OP_MASK		0xce
+#include <linux/netfilter_ipv4/ipt_ecn.h>
 
 struct ipt_ECN_info {
 	__u8 operation;	/* bitset of operations */

