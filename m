Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25338C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27AE2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZs3gne7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27AE2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbeJQBFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbeJQBFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785F02098A;
        Tue, 16 Oct 2018 17:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710062;
        bh=nhyIy7WogQgrhaMT5mJEcAkMyr1YghZrbwEsHARDhJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZs3gne7d7G9O0qiPvkHLMZKTh1tm6Ok8w8cGZQ8hkZT7Sy94aNF4PrZf81ydRkCz
         wFSrs0OxvXc69yk8cnoNoYFyhRsQe9LOh7vAVbeQaRS5Ik4udloKr07GVXZc4tW06A
         OaO/2apYQCludsdtfW4dAe9Yxo/3MNdQsOt+VKOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tushar Dave <tushar.n.dave@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 092/135] bpf: use __GFP_COMP while allocating page
Date:   Tue, 16 Oct 2018 19:05:22 +0200
Message-Id: <20181016170521.707793411@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/filter.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2334,7 +2334,8 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (unlikely(bytes_sg_total > copy))
 		return -EINVAL;
 
-	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC, get_order(copy));
+	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
+			   get_order(copy));
 	if (unlikely(!page))
 		return -ENOMEM;
 	p = page_address(page);


