Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78532C64EAE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A31206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A31206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeI3E3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:29:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51655 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728043AbeI3ESY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:24 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N63-0000H1-A6; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006yg-Ka; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "H . Peter Anvin" <hpa@zytor.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Dave Hansen" <dave.hansen@intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.505139971@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 122/131] x86/speculation/l1tf: Suggest what to do on
 systems with too much RAM
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vlastimil Babka <vbabka@suse.cz>

commit 6a012288d6906fee1dbc244050ade1dafe4a9c8d upstream.

Two users have reported [1] that they have an "extremely unlikely" system
with more than MAX_PA/2 memory and L1TF mitigation is not effective.

Make the warning more helpful by suggesting the proper mem=X kernel boot
parameter to make it effective and a link to the L1TF document to help
decide if the mitigation is worth the unusable RAM.

[1] https://bugzilla.suse.com/show_bug.cgi?id=1105536

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Link: https://lkml.kernel.org/r/966571f0-9d7f-43dc-92c6-a10eec7a1254@suse.cz
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -717,6 +717,10 @@ static void __init l1tf_select_mitigatio
 	half_pa = (u64)l1tf_pfn_limit() << PAGE_SHIFT;
 	if (e820_any_mapped(half_pa, ULLONG_MAX - half_pa, E820_RAM)) {
 		pr_warn("System has more than MAX_PA/2 memory. L1TF mitigation not effective.\n");
+		pr_info("You may make it effective by booting the kernel with mem=%llu parameter.\n",
+				half_pa);
+		pr_info("However, doing so will make a part of your RAM unusable.\n");
+		pr_info("Reading https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html might help you decide.\n");
 		return;
 	}
 

