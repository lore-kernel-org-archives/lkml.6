Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12177C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10F92089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/KsxI3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10F92089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbeJQBNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeJQBNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:13:31 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 737AB20866;
        Tue, 16 Oct 2018 17:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710526;
        bh=P13NySxIXzQ+Ok5Nf5C5MNtOeuvCyF7s3woxQ98MQfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/KsxI3WXoUEx/gVwz5tU7m01OmASsUtokvZgkrxXNrMG2A3dy6jNe7mR96Tf0glm
         4CkFsStUYghfiC8r7II4a3d68ezrUP5fltaYirNsaJsm7k2HQjUH7kH9/VP6Zsxywe
         Ex0PHqRymbGa72ouRkrci/Ed27pntd2XP47BIQR0=
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
Subject: [PATCH 4.14 080/109] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
Date:   Tue, 16 Oct 2018 19:05:48 +0200
Message-Id: <20181016170529.311166330@linuxfoundation.org>
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

commit eb59254608bc1d42c4c6afdcdce9c0d3ce02b318 upstream.

Patch series "indirectly reclaimable memory", v2.

This patchset introduces the concept of indirectly reclaimable memory
and applies it to fix the issue of when a big number of dentries with
external names can significantly affect the MemAvailable value.

This patch (of 3):

Introduce a concept of indirectly reclaimable memory and adds the
corresponding memory counter and /proc/vmstat item.

Indirectly reclaimable memory is any sort of memory, used by the kernel
(except of reclaimable slabs), which is actually reclaimable, i.e.  will
be released under memory pressure.

The counter is in bytes, as it's not always possible to count such
objects in pages.  The name contains BYTES by analogy to
NR_KERNEL_STACK_KB.

Link: http://lkml.kernel.org/r/20180305133743.12746-2-guro@fb.com
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
 include/linux/mmzone.h |    1 +
 mm/vmstat.c            |    1 +
 2 files changed, 2 insertions(+)

--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -180,6 +180,7 @@ enum node_stat_item {
 	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
 	NR_DIRTIED,		/* page dirtyings since bootup */
 	NR_WRITTEN,		/* page writings since bootup */
+	NR_INDIRECTLY_RECLAIMABLE_BYTES, /* measured in bytes */
 	NR_VM_NODE_STAT_ITEMS
 };
 
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1090,6 +1090,7 @@ const char * const vmstat_text[] = {
 	"nr_vmscan_immediate_reclaim",
 	"nr_dirtied",
 	"nr_written",
+	"nr_indirectly_reclaimable",
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",


