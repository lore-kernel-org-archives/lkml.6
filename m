Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08825C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DE020869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbeLTFkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 00:40:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbeLTFkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 00:40:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF9183D09;
        Thu, 20 Dec 2018 05:40:54 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6924D19745;
        Thu, 20 Dec 2018 05:40:47 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, akpm@linux-foundation.org,
        bhe@redhat.com, dyoung@redhat.com, linux-doc@vger.kernel.org
Subject: [PATCH 0/2 v4] kdump,vmcoreinfo: Export the value of sme mask to vmcoreinfo
Date:   Thu, 20 Dec 2018 13:40:42 +0800
Message-Id: <20181220054044.30738-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 20 Dec 2018 05:40:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset did two things:
a. add a new document for vmcoreinfo

This document lists some variables that export to vmcoreinfo, and briefly
describles what these variables indicate. It should be instructive for
many people who do not know the vmcoreinfo, and it also normalizes the
exported variable as a convention between kernel and use-space.

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

Changes since v3:
1. Still improve the vmcoreinfo document, and make it become more
clear and easy to read.
2. Move sme_mask comments in the code to the vmcoreinfo document.
3. Improve patch log.

Lianbo Jiang (2):
  kdump: add the vmcoreinfo documentation
  kdump,vmcoreinfo: Export the value of sme mask to vmcoreinfo

 Documentation/kdump/vmcoreinfo.txt | 513 +++++++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_64.c |   3 +
 2 files changed, 516 insertions(+)
 create mode 100644 Documentation/kdump/vmcoreinfo.txt

-- 
2.17.1

