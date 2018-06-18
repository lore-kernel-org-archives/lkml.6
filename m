Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E4CC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C3A20671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C3A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937104AbeFRX7o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:59:44 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49085 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936119AbeFRX7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:59:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T2yK.Jw_1529366358;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T2yK.Jw_1529366358)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Jun 2018 07:59:24 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     tytso@mit.edu, nborisov@suse.com, corbet@lwn.net,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] doc: add description to dirtytime_expire_seconds
Date:   Tue, 19 Jun 2018 07:59:18 +0800
Message-Id: <1529366358-67312-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1efff914afac8a965ad63817ecf8861a927c2ace ("fs: add
dirtytime_expire_seconds sysctl") introduced dirtytime_expire_seconds
knob, but there is not description about it in
Documentation/sysctl/vm.txt.

Add the description for it.

Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v1 --> v2: Rephrased the description per Nikolay Borisov's comment

I didn't dig into the old review discussion about why the description
was not added at the first place. I'm supposed every knob under /proc/sys
should have a brief description.

 Documentation/sysctl/vm.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
index 17256f2..b078baf 100644
--- a/Documentation/sysctl/vm.txt
+++ b/Documentation/sysctl/vm.txt
@@ -27,6 +27,7 @@ Currently, these files are in /proc/sys/vm:
 - dirty_bytes
 - dirty_expire_centisecs
 - dirty_ratio
+- dirtytime_expire_seconds
 - dirty_writeback_centisecs
 - drop_caches
 - extfrag_threshold
@@ -178,6 +179,18 @@ The total available memory is not equal to total system memory.
 
 ==============================================================
 
+dirtytime_expire_seconds
+
+When a lazytime inode is constantly having its pages dirtied, the inode with
+an updated timestamp will never get chance to be written out.  And, if the
+only thing that has happened on the file system is a dirtytime inode caused
+by an atime update, a worker will be scheduled to make sure that inode
+eventually gets pushed out to disk.  This tunable is used to define when dirty
+inode is old enough to be eligible for writeback by the kernel flusher threads.
+And, it is also used as the interval to wakeup dirtytime_writeback thread.
+
+==============================================================
+
 dirty_writeback_centisecs
 
 The kernel flusher threads will periodically wake up and write `old' data
-- 
1.8.3.1

