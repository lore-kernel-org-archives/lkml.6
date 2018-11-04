Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24394C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E262220868
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6tpVDMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E262220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbeKDXJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:09:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbeKDXJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:09:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02E5B2085A;
        Sun,  4 Nov 2018 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339676;
        bh=weim4VNF/C0H5P3/9xMGZYWf+JMRIgw+BbVRuoAmgXk=;
        h=From:To:Cc:Subject:Date:From;
        b=p6tpVDMxl/VKKyJum4bNpP5Z0B4ZnJivoqfpsx8VWfTMQNyPr3D2fJ3oweDgnl4/B
         ZdYjjhDWRAxwB772tI8HQPx4R/Hd1TratNU4+1PYMv4YAt1F4ygEY58LHiJ60B18xN
         43SSCwj48iJ95GXTiP2smHYAigV14pyj4FbnNxAI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Christoph Lameter <clameter@sgi.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 01/13] mm/vmstat.c: assert that vmstat_text is in sync with stat_items_size
Date:   Sun,  4 Nov 2018 08:54:21 -0500
Message-Id: <20181104135433.88734-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

[ Upstream commit f0ecf25a093fc0589f0a6bc4c1ea068bbb67d220 ]

Having two gigantic arrays that must manually be kept in sync, including
ifdefs, isn't exactly robust.  To make it easier to catch such issues in
the future, add a BUILD_BUG_ON().

Link: http://lkml.kernel.org/r/20181001143138.95119-3-jannh@google.com
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Christoph Lameter <clameter@sgi.com>
Cc: Kemi Wang <kemi.wang@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vmstat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4590aa42b6cd..792374f7088f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1189,6 +1189,8 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 	stat_items_size += sizeof(struct vm_event_state);
 #endif
 
+	BUILD_BUG_ON(stat_items_size !=
+		     ARRAY_SIZE(vmstat_text) * sizeof(unsigned long));
 	v = kmalloc(stat_items_size, GFP_KERNEL);
 	m->private = v;
 	if (!v)
-- 
2.17.1

