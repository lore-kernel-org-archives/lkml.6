Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A2BECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BDB20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BDB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389958AbeGTN3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:29:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388863AbeGTN3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:29:35 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 63A8CCCC;
        Fri, 20 Jul 2018 12:37:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Hurley <john.hurley@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 050/101] nfp: reject binding to shared blocks
Date:   Fri, 20 Jul 2018 14:13:56 +0200
Message-Id: <20180720121425.160187897@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Hurley <john.hurley@netronome.com>

[ Upstream commit 951a8ee6def39e25d0e60b9394e5a249ba8b2390 ]

TC shared blocks allow multiple qdiscs to be grouped together and filters
shared between them. Currently the chains of filters attached to a block
are only flushed when the block is removed. If a qdisc is removed from a
block but the block still exists, flow del messages are not passed to the
callback registered for that qdisc. For the NFP, this presents the
possibility of rules still existing in hw when they should be removed.

Prevent binding to shared blocks until the kernel can send per qdisc del
messages when block unbinds occur.

tcf_block_shared() was not used outside of the core until now, so also
add an empty implementation for builds with CONFIG_NET_CLS=n.

Fixes: 4861738775d7 ("net: sched: introduce shared filter blocks infrastructure")
Signed-off-by: John Hurley <john.hurley@netronome.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/bpf/main.c       |    3 +++
 drivers/net/ethernet/netronome/nfp/flower/offload.c |    3 +++
 include/net/pkt_cls.h                               |    5 +++++
 3 files changed, 11 insertions(+)

--- a/drivers/net/ethernet/netronome/nfp/bpf/main.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/main.c
@@ -194,6 +194,9 @@ static int nfp_bpf_setup_tc_block(struct
 	if (f->binder_type != TCF_BLOCK_BINDER_TYPE_CLSACT_INGRESS)
 		return -EOPNOTSUPP;
 
+	if (tcf_block_shared(f->block))
+		return -EOPNOTSUPP;
+
 	switch (f->command) {
 	case TC_BLOCK_BIND:
 		return tcf_block_cb_register(f->block,
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -601,6 +601,9 @@ static int nfp_flower_setup_tc_block(str
 	if (f->binder_type != TCF_BLOCK_BINDER_TYPE_CLSACT_INGRESS)
 		return -EOPNOTSUPP;
 
+	if (tcf_block_shared(f->block))
+		return -EOPNOTSUPP;
+
 	switch (f->command) {
 	case TC_BLOCK_BIND:
 		return tcf_block_cb_register(f->block,
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -111,6 +111,11 @@ void tcf_block_put_ext(struct tcf_block
 {
 }
 
+static inline bool tcf_block_shared(struct tcf_block *block)
+{
+	return false;
+}
+
 static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
 {
 	return NULL;


