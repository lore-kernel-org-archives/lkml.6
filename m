Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5D8C04EB9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80242064A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80242064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbeLBDQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:16:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbeLBDQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:16:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C4EA356C4;
        Sun,  2 Dec 2018 03:08:54 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1C305D9C9;
        Sun,  2 Dec 2018 03:08:44 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, akpm@linux-foundation.org,
        bhe@redhat.com, dyoung@redhat.com
Subject: [PATCH 0/2 v2] kdump,vmcoreinfo: Export the value of sme mask to vmcoreinfo
Date:   Sun,  2 Dec 2018 11:08:37 +0800
Message-Id: <20181202030839.29945-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 02 Dec 2018 03:08:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset did two things:
a. add a new document for vmcoreinfo

This document lists some variables that export to vmcoreinfo, and briefly
describles what these variables indicate. It should be instructive for
many people who do not know the vmcoreinfo, and it also normalizes the
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

Lianbo Jiang (2):
  kdump: add the vmcoreinfo documentation
  kdump,vmcoreinfo: Export the value of sme mask to vmcoreinfo

 Documentation/kdump/vmcoreinfo.txt | 400 +++++++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_64.c |  14 +
 2 files changed, 414 insertions(+)
 create mode 100644 Documentation/kdump/vmcoreinfo.txt

-- 
2.17.1

