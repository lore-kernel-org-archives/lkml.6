Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD1AC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFBF2147E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8I9UDIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFBF2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeJPMD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbeJPMDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:03:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A0C2214C4;
        Tue, 16 Oct 2018 04:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663302;
        bh=wZC9oNwBAGiQe2rv4Hzyd44nWUHaiUFbiJF4k0cUIhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8I9UDIAow3prsjXgwgGfMRcArd+ISHQM6V51WOGrptuiFQaLZERqjYMix8K0n2Eq
         yEkMPbCFcf4cF2t4YAHc1sGU7iiDoL9Yr8qIpvosT8iyN5OGqmlK3Osr3+0/i/qt/2
         +gobPwNbavjKmlsR8t1Lj/viLAHKT/peK8VMpfRo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Christoph Lameter <clameter@sgi.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 61/61] mm/vmstat.c: fix outdated vmstat_text
Date:   Tue, 16 Oct 2018 00:14:03 -0400
Message-Id: <20181016041403.135678-61-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

[ Upstream commit 28e2c4bb99aa40f9d5f07ac130cbc4da0ea93079 ]

7a9cdebdcc17 ("mm: get rid of vmacache_flush_all() entirely") removed the
VMACACHE_FULL_FLUSHES statistics, but didn't remove the corresponding
entry in vmstat_text.  This causes an out-of-bounds access in
vmstat_show().

Luckily this only affects kernels with CONFIG_DEBUG_VM_VMACACHE=y, which
is probably very rare.

Link: http://lkml.kernel.org/r/20181001143138.95119-1-jannh@google.com
Fixes: 7a9cdebdcc17 ("mm: get rid of vmacache_flush_all() entirely")
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Roman Gushchin <guro@fb.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Christoph Lameter <clameter@sgi.com>
Cc: Kemi Wang <kemi.wang@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vmstat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 2bdc962b2dfe..50b4c11fb612 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1214,7 +1214,6 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_DEBUG_VM_VMACACHE
 	"vmacache_find_calls",
 	"vmacache_find_hits",
-	"vmacache_full_flushes",
 #endif
 #ifdef CONFIG_SWAP
 	"swap_ra",
-- 
2.17.1

