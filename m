Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898F3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2290120843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2290120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeIDIj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 04:39:59 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:34060 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeIDIj7 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 4 Sep 2018 04:39:59 -0400
Received: from Beta.suse.asia (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (NOT encrypted); Mon, 03 Sep 2018 22:16:40 -0600
From:   Larry Chen <lchen@suse.com>
To:     mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
Subject: [PATCH 0/2] fix cluster leakage in ocfs2_defrag_extent
Date:   Tue,  4 Sep 2018 12:16:19 +0800
Message-Id: <20180904041621.16874-1-lchen@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ocfs2_defrag_extent might leak clusters allocated.
When file system has no enough space, the number of claimed clusters
might less than the caller wants. If that happens, the original code
might directly commit trans without returning clusters.

This patch refered a lot to ocfs2_add_clusters_in_btree.

Larry Chen (2):
  add declaration of ocfs2_free_local_alloc_bits
  fix clusters leak in ocfs2_defrag_extent

 fs/ocfs2/alloc.h        |  6 ++++++
 fs/ocfs2/move_extents.c | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

-- 
2.13.7

