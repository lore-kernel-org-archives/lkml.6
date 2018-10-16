Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD97EC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AA621477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6EZ719l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AA621477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbeJQBNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeJQBNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:13:43 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C757820866;
        Tue, 16 Oct 2018 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710538;
        bh=2lMrwMsPrH+IT+VUKx0RD3qKL7tE4VxMFik0MfdgV9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6EZ719leR1Bio0GjYeQ/Dc4prEI/N3Amc5jLzRdT4LtLhrhpESuTyhwB7NYgvVc+
         OPUexlXfVg8g6qKOE6c+vAdra9X2o/9FbNNAIIeLzPA71GPe5J4wx/r5Ak3CGuFjBB
         FPKqq4NEIXDNLMB4jxUzmLHYg0mgvhnijNIavFAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 081/109] mm: treat indirectly reclaimable memory as available in MemAvailable
Date:   Tue, 16 Oct 2018 19:05:49 +0200
Message-Id: <20181016170529.403692597@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Gushchin <guro@fb.com>

commit 034ebf65c3c21d85b963d39f992258a64a85e3a9 upstream.

Adjust /proc/meminfo MemAvailable calculation by adding the amount of
indirectly reclaimable memory (rounded to the PAGE_SIZE).

Link: http://lkml.kernel.org/r/20180305133743.12746-4-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_alloc.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4557,6 +4557,13 @@ long si_mem_available(void)
 		     min(global_node_page_state(NR_SLAB_RECLAIMABLE) / 2,
 			 wmark_low);
 
+	/*
+	 * Part of the kernel memory, which can be released under memory
+	 * pressure.
+	 */
+	available += global_node_page_state(NR_INDIRECTLY_RECLAIMABLE_BYTES) >>
+		PAGE_SHIFT;
+
 	if (available < 0)
 		available = 0;
 	return available;


