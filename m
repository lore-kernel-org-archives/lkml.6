Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B51ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B12220C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B12220C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbeGQNv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:51:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729671AbeGQNv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:51:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1947877885;
        Tue, 17 Jul 2018 13:18:49 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E06FB111C481;
        Tue, 17 Jul 2018 13:18:45 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     mhocko@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH] mm/page_alloc: Deprecate kernelcore=nn and movable_core=
Date:   Tue, 17 Jul 2018 21:18:37 +0800
Message-Id: <20180717131837.18411-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 17 Jul 2018 13:18:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 17 Jul 2018 13:18:49 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can still use 'kernelcore=mirror' or 'movable_node' for the usage
of hotplug and movable zone. If somebody shows up with a valid usecase
we can reconsider.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 mm/page_alloc.c                                 | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc7aa7a0670..1e22c49866a2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1855,6 +1855,7 @@
 	keepinitrd	[HW,ARM]
 
 	kernelcore=	[KNL,X86,IA-64,PPC]
+			[Usage of kernelcore=nn[KMGTPE] | nn% is deprecated]
 			Format: nn[KMGTPE] | nn% | "mirror"
 			This parameter specifies the amount of memory usable by
 			the kernel for non-movable allocations.  The requested
@@ -2395,6 +2396,7 @@
 			reporting absolute coordinates, such as tablets
 
 	movablecore=	[KNL,X86,IA-64,PPC]
+			[Deprecated]
 			Format: nn[KMGTPE] | nn%
 			This parameter is the complement to kernelcore=, it
 			specifies the amount of memory used for migratable
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100f1e63..86cf05f48b5f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6899,6 +6899,8 @@ static int __init cmdline_parse_kernelcore(char *p)
 		return 0;
 	}
 
+	pr_warn("Only kernelcore=mirror supported, "
+		"usage of kernelcore=nn[KMGTPE]|nn%% is deprecated.\n");
 	return cmdline_parse_core(p, &required_kernelcore,
 				  &required_kernelcore_percent);
 }
@@ -6909,6 +6911,7 @@ static int __init cmdline_parse_kernelcore(char *p)
  */
 static int __init cmdline_parse_movablecore(char *p)
 {
+	pr_warn("Option movablecore= is deprecated.\n");
 	return cmdline_parse_core(p, &required_movablecore,
 				  &required_movablecore_percent);
 }
-- 
2.13.6

