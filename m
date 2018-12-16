Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE37C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C771217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeLPNQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:16:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbeLPNQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:16:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A27885D61D;
        Sun, 16 Dec 2018 13:16:28 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-64.pek2.redhat.com [10.72.12.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2326B608E6;
        Sun, 16 Dec 2018 13:16:20 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
        dyoung@redhat.com, linux-doc@vger.kernel.org
Subject: [PATCH 0/2 v3] kdump,vmcoreinfo: Export the value of sme mask to vmcoreinfo
Date:   Sun, 16 Dec 2018 21:16:15 +0800
Message-Id: <20181216131617.2612-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 16 Dec 2018 13:16:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset did two things:
a. add a new document for vmcoreinfo

This document lists some variables that export to vmcoreinfo, and briefly
describles what these variables indicate. It should be instructive for
many people who do not know the vmcoreinfo, and it would normalize the
exported variable as a standard ABI between kernel and use-space.

b. export the value of sme mask to vmcoreinfo

For AMD machine with SME feature, makedumpfile tools need to know whether
the crash kernel was encrypted or not. If SME is enabled in the first
kernel, the crash kernel's page table(pgd/pud/pmd/pte) contains the
memory encryption mask, so need to remove the sme mask to obtain the true
physical address.

Changes since v1:
1. No need to export a kernel-internal mask to userspace, so copy the
value of sme_me_mask to a local variable 'sme_mask' and write the value
of sme_mask to vmcoreinfo.
2. Add comment for the code.
3. Improve the patch log.
4. Add the vmcoreinfo documentation.

Changes since v2:
1. Improve the vmcoreinfo document, add more descripts for these
variables exported.
2. Fix spelling errors in the document.

Lianbo Jiang (2):
  kdump: add the vmcoreinfo documentation
  kdump,vmcoreinfo: Export the value of sme mask to vmcoreinfo

 Documentation/kdump/vmcoreinfo.txt | 456 +++++++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_64.c |  14 +
 2 files changed, 470 insertions(+)
 create mode 100644 Documentation/kdump/vmcoreinfo.txt

-- 
2.17.1

