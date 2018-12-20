Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6694BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B6820811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ5Sby/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeLTJv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:51:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35099 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbeLTJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:51:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so637389plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 01:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TzK/offuMiftcp8zdhetLLgTPbF5oMiPcKmIl7aXSqs=;
        b=ZZ5Sby/EbDZxJq5f8tEKiQXeJ3J+mgYGawoOSTjOqgDokHbe87vYBeNjo26rvurFaH
         u3zyMw8brzZW1JMc9FjAOrm4Aj/eCAyMVOZ+o/HrnUx6CdhsglE5aND0oCD2+FCKLRHg
         AMRuF+da/oCmYx8zey98h3O8QieoawwVMlJx8f9LNVqnOOy6Iu4fvIFg/4gmx75BhE61
         fgAlr6TBOTxYrqpZxnaIER6Z+ERYvDmAQ7v6Ar/6dPfQSwRPJepnwqBw/bOO4t8teuvH
         qKy7ibtg29/9AnICPYBinuXDq223N45klFHNLiK7+CQYyaGDGMmJlCB6UlUmOoqT7BX9
         SLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TzK/offuMiftcp8zdhetLLgTPbF5oMiPcKmIl7aXSqs=;
        b=iPsVhGs4D5Uez3IV3D6QFZt+w8D2FkDheX6IIlsxdXLnu2EcrulBSdheSqaQdN7orP
         D4dInWUuDviSrztpnKRKj6s+RQ1qWzTdYzbEX4WVy91X/qVPK1Dq9hw1siOskTXDW+iB
         eD9Iep0xBM9M+O0iCGT0dICREcduONQjPas5pVFWKvAwgFbSuqgU8+G7TKSXvpgX4N6a
         nHxTNMcPPc3r4ZmPVPxnnjmQ/+JBz0ASWUBo0M6DDwsWcPctxsoOywO4BnurzEF7cSvW
         AuiqvHjNSONY64AvoDmqcQ2ph7x8EYSFo7AoHK8jpEOhBWLpSUDx6I9+5mqCBTcUzTkG
         jsKg==
X-Gm-Message-State: AA+aEWYfMcOGFG1cY3HcjISJX+3+nhaK7zs0rpduSGEg5+rJFcRRiRV4
        MnE1o61HJ1lrl0CBaeLm3Q==
X-Google-Smtp-Source: AFSGD/W+peKcgU2gsTb6UnoUotPkHL3GAnOzUnutuIhsRU+AXYQggUTAl5j7u1dOBpTeYLPbe+s5fw==
X-Received: by 2002:a17:902:622:: with SMTP id 31mr23030237plg.171.1545299485120;
        Thu, 20 Dec 2018 01:51:25 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 125sm33355206pfx.159.2018.12.20.01.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 01:51:24 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCHv2 3/3] powerpc/numa: make all possible node be instanced against NULL reference in node_zonelist()
Date:   Thu, 20 Dec 2018 17:50:39 +0800
Message-Id: <1545299439-31370-4-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
References: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to resolve a bug rooted at mm when using nr_cpus. It was
reported at [1]. The root cause is: device->numa_node info is used as
preferred_nid param for __alloc_pages_nodemask(), which causes NULL
reference when ac->zonelist = node_zonelist(preferred_nid, gfp_mask), due to
the preferred_nid is not online and not instanced. Hence the bug affects
all archs if a machine having a memory less numa-node, but a device on the
node is used and provide numa_node info to __alloc_pages_nodemask().
This patch makes all possible node online for ppc.

[1]: https://lore.kernel.org/patchwork/patch/1020838/

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
Note:
[1-2/3] implements one way to fix the bug, while this patch tries another way.
Hence using this patch when [1-2/3] is not acceptable.

 arch/powerpc/mm/numa.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index ce28ae5..31d81a4 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -864,10 +864,19 @@ void __init initmem_init(void)
 
 	memblock_dump_all();
 
-	for_each_online_node(nid) {
+	/* Instance all possible nodes to overcome potential NULL reference
+	 * issue on node_zonelist() when using nr_cpus
+	 */
+	for_each_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
-		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		if (node_online(nid))
+			get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		else {
+			start_pfn = end_pfn = 0;
+			/* online it, so later zonelists[] will be built */
+			node_set_online(nid);
+		}
 		setup_node_data(nid, start_pfn, end_pfn);
 		sparse_memory_present_with_active_regions(nid);
 	}
-- 
2.7.4

