Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E2F222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406681AbfBNKmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:42:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:55020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438495AbfBNKmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:42:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5949AFD4;
        Thu, 14 Feb 2019 10:42:43 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-mm@kvack.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 0/2] x86: respect memory size limits
Date:   Thu, 14 Feb 2019 11:42:38 +0100
Message-Id: <20190214104240.24428-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a customer system running Xen a boot problem was observed due to
the kernel not respecting the memory size limit imposed by the Xen
hypervisor.

During analysis I found the same problem should be able to occur on
bare metal in case the memory would be limited via the "mem=" boot
parameter.

The system this problem has been observed on has tons of memory
added via PCI. So while in the E820 map the not to be used memory has
been wiped out the additional PCI memory is detected during ACPI scan
and it is added via __add_memory().

This small series tries to repair the issue by testing the imposed
memory limit during the memory hotplug process and refusing to add it
in case the limit is being violated.

I've chosen to refuse adding the complete memory chunk in case the
limit is reached instead of adding only some of the memory, as I
thought this would result in less problems (e.g. avoiding to add
only parts of a 128MB memory bar which might be difficult to remove
later).

Changes in V3:
- patch 2: remember possible max_mem_size value from kernel parameters
- patch 2: set allowed size to end of local E820 map's RAM

Changes in V2:
- patch 1: set initial allowed size to U64_MAX instead -1
- patch 2: set initial allowed size to end of E820 RAM

Juergen Gross (2):
  x86: respect memory size limiting via mem= parameter
  x86/xen: dont add memory above max allowed allocation

 arch/x86/kernel/e820.c         |  5 +++++
 arch/x86/xen/setup.c           | 13 +++++++++++++
 drivers/xen/xen-balloon.c      | 11 +++++++++++
 include/linux/memory_hotplug.h |  2 ++
 include/xen/xen.h              |  4 ++++
 mm/memory_hotplug.c            |  6 ++++++
 6 files changed, 41 insertions(+)

-- 
2.16.4

