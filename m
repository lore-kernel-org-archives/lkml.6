Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20C4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E4E205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4zxizue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E4E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeJPMYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbeJPMBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2ED521477;
        Tue, 16 Oct 2018 04:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663160;
        bh=ZFe9oNIrZC23dlVBIOkaDmRtHgfTNTVvcYLWGY3cmHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4zxizue4vEn0UquZxqczhplJjnws+6FazFfFTX5QMhjKESh1seEbIz+9XXNCTTOa
         TCWWhBukHrgMfaQPwFlYpTFZCx3vnuTGJ35f2OzPCjEcY/z41IzToLCaD+1y0MVYNm
         A2p6qLsANR0cBhsiwgIeoJ11v9Fitt/+MLrbXfr4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhong jiang <zhongjiang@huawei.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 017/100] netfilter: conntrack: get rid of double sizeof
Date:   Tue, 16 Oct 2018 00:10:58 -0400
Message-Id: <20181016041221.135528-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

[ Upstream commit 346fa83d10934cf206e2fd0f514bf8ce186f08fe ]

sizeof(sizeof()) is quite strange and does not seem to be what
is wanted here.

The issue is detected with the help of Coccinelle.

Fixes: 39215846740a ("netfilter: conntrack: remove nlattr_size pointer from l4proto trackers")
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 8e67910185a0..1004fb5930de 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1239,8 +1239,8 @@ static const struct nla_policy tcp_nla_policy[CTA_PROTOINFO_TCP_MAX+1] = {
 #define TCP_NLATTR_SIZE	( \
 	NLA_ALIGN(NLA_HDRLEN + 1) + \
 	NLA_ALIGN(NLA_HDRLEN + 1) + \
-	NLA_ALIGN(NLA_HDRLEN + sizeof(sizeof(struct nf_ct_tcp_flags))) + \
-	NLA_ALIGN(NLA_HDRLEN + sizeof(sizeof(struct nf_ct_tcp_flags))))
+	NLA_ALIGN(NLA_HDRLEN + sizeof(struct nf_ct_tcp_flags)) + \
+	NLA_ALIGN(NLA_HDRLEN + sizeof(struct nf_ct_tcp_flags)))
 
 static int nlattr_to_tcp(struct nlattr *cda[], struct nf_conn *ct)
 {
-- 
2.17.1

