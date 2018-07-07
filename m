Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E157C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A079622469
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A079622469
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeGGG5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 02:57:14 -0400
Received: from www.osadl.org ([62.245.132.105]:43912 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752784AbeGGG5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 02:57:13 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w676riMM028512;
        Sat, 7 Jul 2018 08:53:44 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     "Author: Paul Mackerras" <paulus@ozlabs.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] KVM: PPC: Book3S HV: add of_node_put() in success path
Date:   Sat,  7 Jul 2018 08:53:07 +0200
Message-Id: <1530946387-6607-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The call to of_find_compatible_node() is returning a pointer with
incremented refcount so it must be explicitly decremented after the
last use. As here it is only being used for checking of node presence
but the result is not actually used in the success path it can be
dropped immediately.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit f725758b899f ("KVM: PPC: Book3S HV: Use OPAL XICS emulation on POWER9")
---
Problem found by experimental coccinelle script

Patch was compiletested with: ppc64_defconfig (implies CONFIG_KVM=y,
CONFIG_KVM_BOOK3S_64_HV=m)
with many sparse warnings though not related to the proposed change

Patch is against 4.18-rc3 (localversion-next is next-20180705)

 arch/powerpc/kvm/book3s_hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ee4a885..8680fb9 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4561,6 +4561,8 @@ static int kvmppc_book3s_init_hv(void)
 			pr_err("KVM-HV: Cannot determine method for accessing XICS\n");
 			return -ENODEV;
 		}
+		/* presence of intc confirmed - node can be dropped again */
+		of_node_put(np);
 	}
 #endif
 
-- 
2.1.4

