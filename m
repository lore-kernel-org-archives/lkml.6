Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BDDC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CF9217B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CF9217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeHUS6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:58:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:50300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727353AbeHUS6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:58:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14B02AD4D;
        Tue, 21 Aug 2018 15:38:04 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 0/2] x86/xen: avoid 32-bit writes to PTEs in PV PAE guests
Date:   Tue, 21 Aug 2018 17:37:53 +0200
Message-Id: <20180821153755.30462-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the hypervisor emulates plain writes to PTEs happily, this is
much slower than issuing a hypercall for PTE modifcations. And writing
a PTE via two 32-bit write instructions (especially when clearing the
PTE) will result in an intermediate L1TF vulnerable PTE.

Writes to PAE PTEs should always be done with 64-bit writes or via
hypercalls.

Juergen Gross (2):
  x86/xen: don't write ptes directly in 32-bit PV guests
  x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear

 arch/x86/include/asm/pgtable-3level.h | 7 +++----
 arch/x86/xen/mmu_pv.c                 | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.13.7

