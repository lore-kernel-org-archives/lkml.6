Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57B7C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6502F22526
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wENKVCZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6502F22526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbeKMPta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733211AbeKMPta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:49:30 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3CA622507;
        Tue, 13 Nov 2018 05:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088382;
        bh=weim4VNF/C0H5P3/9xMGZYWf+JMRIgw+BbVRuoAmgXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wENKVCZxHQOv0nBNj9pncQ3qPQblUEs24IYK7LdX79xIqm/sbYVSMMM6NyzJIyOoY
         NGObJ2orZK1Ta4oyFHtNdGZzMX+5vlgTRb2jp/ESSXRFCL8Lue+x0YjJFt4t31TaGq
         tjrW5QbIXwbB7W1ny5xI/a2LrXoomolCkmMRnjaY=
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
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 3.18 8/9] mm/vmstat.c: assert that vmstat_text is in sync with stat_items_size
Date:   Tue, 13 Nov 2018 00:52:51 -0500
Message-Id: <20181113055252.79406-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055252.79406-1-sashal@kernel.org>
References: <20181113055252.79406-1-sashal@kernel.org>
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

