Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0067C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B3B20844
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B3B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932412AbeGDIK6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:10:58 -0400
Received: from www.osadl.org ([62.245.132.105]:35225 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933594AbeGDIIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:08:36 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w64849u3023425;
        Wed, 4 Jul 2018 10:04:09 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] powerpc: icp-hv: fix missing of_node_put in success path
Date:   Wed,  4 Jul 2018 10:03:27 +0200
Message-Id: <1530691407-3991-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Both of_find_compatible_node() and of_find_node_by_type() will
return a refcounted node on success - thus for the success path
the node must be explicitly released with a of_node_put().

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 0b05ac6e2480 ("powerpc/xics: Rewrite XICS driver")
---
Problem found by experimental coccinelle script

Patch was compiletested with: ppc64_defconfig (implies
CONFIG_PPC_ICP_HV=y)
with sparse warnings though not related to the proposed change

Patch is against 4.18-rc3 (localversion-next is next-20180704)

 arch/powerpc/sysdev/xics/icp-hv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/xics/icp-hv.c b/arch/powerpc/sysdev/xics/icp-hv.c
index bbc839a..003deaa 100644
--- a/arch/powerpc/sysdev/xics/icp-hv.c
+++ b/arch/powerpc/sysdev/xics/icp-hv.c
@@ -179,6 +179,7 @@ int icp_hv_init(void)
 
 	icp_ops = &icp_hv_ops;
 
+	of_node_put(np);
 	return 0;
 }
 
-- 
2.1.4

