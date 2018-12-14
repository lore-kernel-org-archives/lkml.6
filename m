Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1A9C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B58214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789449;
	bh=EZ5bYAlZLIdpSp5aTmFRB/IfRz9bAjevKFA94y30NtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hGqJpxJ+zuVQdqsL7lflSY302bCR6aZwL0fNcPFf5FNPFxzovZohPcxahFiUPWbjn
	 U5da3xjQlPG51RT9S82QnQ+oBjjgifFPmhi/0okrFvYtM3qYVZ73wItPqey6orLrWT
	 +d+ZO7TxCtRGLfh15pDZG35fs3FVMTpllsHwlP8w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B58214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbeLNMKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:10:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731599AbeLNMKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F7D02133F;
        Fri, 14 Dec 2018 12:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789444;
        bh=EZ5bYAlZLIdpSp5aTmFRB/IfRz9bAjevKFA94y30NtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xgTneqoeSNSM5AumWLe6k5akZCY6A1rEYmB2LCfQYqCnTurBotesFVWWS7bToo5kg
         9ldkCwBD3iufB7Ib1vwSC8/+CPjSXhMZgdbB04aCmEemZBTDnwGKLR6bews4ncxtje
         Cw68/VDfJilbfexyzrWx5/DRl26Y+sB75AH5u+54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 84/89] lib/rbtree-test: lower default params
Date:   Fri, 14 Dec 2018 13:00:37 +0100
Message-Id: <20181214115733.843134086@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

commit 0b548e33e6cb2bff240fdaf1783783be15c29080 upstream.

Fengguang reported soft lockups while running the rbtree and interval
tree test modules.  The logic for these tests all occur in init phase,
and we currently are pounding with the default values for number of
nodes and number of iterations of each test.  Reduce the latter by two
orders of magnitude.  This does not influence the value of the tests in
that one thousand times by default is enough to get the picture.

Link: http://lkml.kernel.org/r/20171109161715.xai2dtwqw2frhkcm@linux-n805
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/interval_tree_test.c |    4 ++--
 lib/rbtree_test.c        |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/lib/interval_tree_test.c
+++ b/lib/interval_tree_test.c
@@ -11,10 +11,10 @@
 	MODULE_PARM_DESC(name, msg);
 
 __param(int, nnodes, 100, "Number of nodes in the interval tree");
-__param(int, perf_loops, 100000, "Number of iterations modifying the tree");
+__param(int, perf_loops, 1000, "Number of iterations modifying the tree");
 
 __param(int, nsearches, 100, "Number of searches to the interval tree");
-__param(int, search_loops, 10000, "Number of iterations searching the tree");
+__param(int, search_loops, 1000, "Number of iterations searching the tree");
 __param(bool, search_all, false, "Searches will iterate all nodes in the tree");
 
 __param(uint, max_endpoint, ~0, "Largest value for the interval's endpoint");
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -11,7 +11,7 @@
 	MODULE_PARM_DESC(name, msg);
 
 __param(int, nnodes, 100, "Number of nodes in the rb-tree");
-__param(int, perf_loops, 100000, "Number of iterations modifying the rb-tree");
+__param(int, perf_loops, 1000, "Number of iterations modifying the rb-tree");
 __param(int, check_loops, 100, "Number of iterations modifying and verifying the rb-tree");
 
 struct test_node {


