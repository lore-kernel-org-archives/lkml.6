Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D358C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D3820651
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfAJMT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:19:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48069 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbfAJMT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:19:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABCEF804F7;
        Thu, 10 Jan 2019 12:19:55 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 831155C72C;
        Thu, 10 Jan 2019 12:19:47 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, akpm@linux-foundation.org,
        bhe@redhat.com, dyoung@redhat.com, k-hagio@ab.jp.nec.com,
        anderson@redhat.com, linux-doc@vger.kernel.org
Subject: [PATCH 0/2 v6] kdump,vmcoreinfo: Export the value of sme mask to vmcoreinfo
Date:   Thu, 10 Jan 2019 20:19:42 +0800
Message-Id: <20190110121944.6050-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 10 Jan 2019 12:19:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset did two things:
a. add a new document for vmcoreinfo

This document lists some variables that export to vmcoreinfo, and briefly
describles what these variables indicate. It should be instructive for
many people who do not know the vmcoreinfo.

b. export the value of sme mask to vmcoreinfo

For AMD machine with SME feature, makedumpfile tools need to know whether
the crashed kernel was encrypted or not. If SME is enabled in the first
kernel, the crashed kernel's page table(pgd/pud/pmd/pte) contains the
memory encryption mask, so makedumpfile needs to remove the sme mask to
obtain the true physical address.

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

Changes since v4:
1. Remove a command that dumping the VMCOREINFO contents from this
   document.
2. Merge the 'PG_buddy' and 'PG_offline' into the PG_* flag in this
   document.
3. Correct some of the mistakes in this document.

Changes since v5:
1. Improve patch log.

Lianbo Jiang (2):
  kdump: add the vmcoreinfo documentation
  kdump,vmcoreinfo: Export the value of sme mask to vmcoreinfo

 Documentation/kdump/vmcoreinfo.txt | 500 +++++++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_64.c |   3 +
 2 files changed, 503 insertions(+)
 create mode 100644 Documentation/kdump/vmcoreinfo.txt

-- 
2.17.1

