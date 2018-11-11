Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B772C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E11223C8
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPYPUe6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E11223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388023AbeKLITp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387972AbeKLITo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:44 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BE8E223CA;
        Sun, 11 Nov 2018 22:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975387;
        bh=dWr7q3B8DHhpzXTkHk5/7o38aWYLLCdmXonN1DVVnMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nPYPUe6tjcLPkLEKCAl0lf8RVRCQ73PTR/J8/g3PrBBKU1S+5yvtTHvT7enqZymeN
         J0R7gCtPg1y8FdmcAmM6nBXsaV2tQAYeC/VJUuQ47ASXQTJkFfD69GQ4i+7XcRLxRP
         s9psasHNZcI6QAkX3JE07CbyMaG77/0IN6Q4bcdw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 066/350] netfilter: xt_nat: fix DNAT target for shifted portmap ranges
Date:   Sun, 11 Nov 2018 14:18:50 -0800
Message-Id: <20181111221709.908879513@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/xt_nat.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/xt_nat.c
+++ b/net/netfilter/xt_nat.c
@@ -216,6 +216,8 @@ static struct xt_target xt_nat_target_re
 	{
 		.name		= "DNAT",
 		.revision	= 2,
+		.checkentry	= xt_nat_checkentry,
+		.destroy	= xt_nat_destroy,
 		.target		= xt_dnat_target_v2,
 		.targetsize	= sizeof(struct nf_nat_range2),
 		.table		= "nat",


