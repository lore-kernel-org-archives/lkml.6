Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D444ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F662082E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zcyL4woR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F662082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbeKAIIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbeKAIIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A4C20843;
        Wed, 31 Oct 2018 23:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027279;
        bh=dmTmDw5DWyZK6c8ksWdkiDh5kuStnoBoGKfBOtvHF6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcyL4woR6czLhJ/Cb8oKj9K3UMdS2ZSzXqpJkut4KxWAycaWCbpWmkCOEG+VvYZi0
         z1E/F8aGaXBmo1cLJ7Tvx3skJqIKjnOyk5YFSFo+evyncGd0bQZSwkm9U06V2Eo9RT
         PedFomxhw0wLyb+ZjHvqnQPUihFcBljr1ZmS9B5M=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 004/126] netfilter: xt_nat: fix DNAT target for shifted portmap ranges
Date:   Wed, 31 Oct 2018 19:05:52 -0400
Message-Id: <20181031230754.29029-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit cb20f2d2c0507d60d94ef896991e95708f051dd1 ]

The commit 2eb0f624b709 ("netfilter: add NAT support for shifted
portmap ranges") did not set the checkentry/destroy callbacks for
the newly added DNAT target. As a result, rulesets using only
such nat targets are not effective, as the relevant conntrack hooks
are not enabled.
The above affect also nft_compat rulesets.
Fix the issue adding the missing initializers.

Fixes: 2eb0f624b709 ("netfilter: add NAT support for shifted portmap ranges")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_nat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/xt_nat.c b/net/netfilter/xt_nat.c
index 8af9707f8789..ac91170fc8c8 100644
--- a/net/netfilter/xt_nat.c
+++ b/net/netfilter/xt_nat.c
@@ -216,6 +216,8 @@ static struct xt_target xt_nat_target_reg[] __read_mostly = {
 	{
 		.name		= "DNAT",
 		.revision	= 2,
+		.checkentry	= xt_nat_checkentry,
+		.destroy	= xt_nat_destroy,
 		.target		= xt_dnat_target_v2,
 		.targetsize	= sizeof(struct nf_nat_range2),
 		.table		= "nat",
-- 
2.17.1

