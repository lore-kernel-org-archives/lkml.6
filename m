Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E74BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB1621486
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yoH+YeF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB1621486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbeJEXOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbeJEXOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F019A21480;
        Fri,  5 Oct 2018 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756092;
        bh=ijiNmXsiS4+yPTgR4m1PKdJJsMmi3HEvpXPk9nx08s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yoH+YeF138phhSZoR6SNZ5NxMpaJzeIDLRe+Seu5Fe9DNdSAZhQiqiFQW0lcztTbS
         cNcVUzJuWiUjInQRbyrIIq1a6B4BjjwWLY9PlXPIGWC0KQe3tXhzRhmhb+z27phIQk
         11Z3V62oth6wKwFw/0wd3JwzZxqIr2QY59nPdTbY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tushar Dave <tushar.n.dave@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 30/48] bpf: use __GFP_COMP while allocating page
Date:   Fri,  5 Oct 2018 12:14:06 -0400
Message-Id: <20181005161424.20521-30-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tushar Dave <tushar.n.dave@oracle.com>

[ Upstream commit 4c3d795cb012a378855543a775408fba1ccff6f2 ]

Helper bpg_msg_pull_data() can allocate multiple pages while
linearizing multiple scatterlist elements into one shared page.
However, if the shared page has size > PAGE_SIZE, using
copy_page_to_iter() causes below warning.

e.g.
[ 6367.019832] WARNING: CPU: 2 PID: 7410 at lib/iov_iter.c:825
page_copy_sane.part.8+0x0/0x8

To avoid above warning, use __GFP_COMP while allocating multiple
contiguous pages.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9dfd145eedcc..e361583e2378 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2328,7 +2328,8 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (unlikely(copy < end - start))
 		return -EINVAL;
 
-	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC, get_order(copy));
+	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
+			   get_order(copy));
 	if (unlikely(!page))
 		return -ENOMEM;
 	p = page_address(page);
-- 
2.17.1

