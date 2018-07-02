Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F966C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335B420855
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335B420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754506AbeGBJNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:13:35 -0400
Received: from www.osadl.org ([62.245.132.105]:49950 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753352AbeGBJNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:13:32 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6298nfC013944;
        Mon, 2 Jul 2018 11:08:50 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Michael Ellerman <michael@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] powerpc: hwrng; fix missing of_node_put()
Date:   Mon,  2 Jul 2018 11:08:16 +0200
Message-Id: <1530522496-14816-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The call to of_find_compatible_node() returns a node pointer with refcount
incremented thus it must be explicitly decremented here before returning.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit a489043f4626 ("powerpc/pseries: Implement arch_get_random_long() based on H_RANDOM")
---
Problem found with experimental coccinelle script

Patch was compiletested with: ppc64_defconfig (implies CONFIG_PPC_PSERIES=y)
with some unrelated sparse warnings (which I did not understand)
./arch/powerpc/include/asm/head-64.h:13:36: warning: Unknown escape '('
./arch/powerpc/include/asm/head-64.h:16:36: warning: Unknown escape '('
./arch/powerpc/include/asm/head-64.h:19:36: warning: Unknown escape '('

Patch is aginst 4.18-rc2 (localversion-next is next-20180702)

 arch/powerpc/platforms/pseries/rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/rng.c b/arch/powerpc/platforms/pseries/rng.c
index 31ca557..262b8c5 100644
--- a/arch/powerpc/platforms/pseries/rng.c
+++ b/arch/powerpc/platforms/pseries/rng.c
@@ -40,6 +40,7 @@ static __init int rng_init(void)
 
 	ppc_md.get_random_seed = pseries_get_random_long;
 
+	of_node_put(dn);
 	return 0;
 }
 machine_subsys_initcall(pseries, rng_init);
-- 
2.1.4

