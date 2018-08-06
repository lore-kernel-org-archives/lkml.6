Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5776C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7500B21A67
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AjNi6Kpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7500B21A67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbeHFSye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:54:34 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:37060 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeHFSyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:54:33 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id ED94D24E058D;
        Mon,  6 Aug 2018 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533573878; bh=knN/abJGsjdg7sgOehcHLn36pMRzOAIZnen4sArnVzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjNi6KpogeQZzh7CNVm6D1H0yRhy5N6efm8DrcBmWS9fkD4qU4XSpcQUepvtN6Pki
         qshxKMkP3/GWOIqy6TqFRfpLpqBqaw+ciTKQ0GDvgrRyGWRTlsx1vRUwnd2p6ZI/qy
         IFgM7SzhU30tR4OXuNsvtpAXQ9tDRmNdwG43AO5dQkoXFUZKOdsuDTbZcSylqiFsB0
         OzSzW0AqoS7F9612YMmDSWBEz8AjebvnaEP0lRTqcookmh6YNLtIiP5+e1x72fqm3A
         zI6hyNeyh3F2K3aQUKDU3LXD37DbDjwzCQzU7A9bIAW5W2yAyah1glQCN+6ZEAy7rr
         TJoG/XbvAPRPg==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 36E1B522D;
        Mon,  6 Aug 2018 09:44:36 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/2] ARC: show_faulting_vma: check file_path for error
Date:   Mon,  6 Aug 2018 19:44:24 +0300
Message-Id: <20180806164424.32439-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180806164424.32439-1-Eugeniy.Paltsev@synopsys.com>
References: <20180806164424.32439-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return value of file_path() should be validated with
IS_ERR() macro.

Generic print_vma_addr() implementation was used as an example.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/troubleshoot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index f7330a3a1c4d..e8d9fb452346 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -98,6 +98,8 @@ static void show_faulting_vma(unsigned long address, char *buf)
 	if (vma && (vma->vm_start <= address)) {
 		if (vma->vm_file) {
 			nm = file_path(vma->vm_file, buf, PAGE_SIZE - 1);
+			if (IS_ERR(nm))
+				nm = "?";
 		}
 		pr_info("    @off 0x%lx in [%s]\n"
 			"    VMA: 0x%08lx to 0x%08lx\n",
-- 
2.14.4

