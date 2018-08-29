Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3081C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C462084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C462084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeH2SNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:13:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727444AbeH2SNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:13:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7AE65807A0D0;
        Wed, 29 Aug 2018 14:16:30 +0000 (UTC)
Received: from 192.168.1.2 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABB6F1007242;
        Wed, 29 Aug 2018 14:16:26 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] Add restrictions for kexec/kdump jumping between 5-level and 4-level kernel
Date:   Wed, 29 Aug 2018 22:16:21 +0800
Message-Id: <20180829141624.13985-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 29 Aug 2018 14:16:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 29 Aug 2018 14:16:30 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was suggested by Kirill several months ago, I worked out several
patches to fix, then interrupted by other issues. So sort them out
now and post for reviewing.

The current upstream kernel supports 5-level paging mode and supports
dynamically choosing paging mode during bootup according to kernel
image, hardware and kernel parameter setting. This flexibility brings
several issues for kexec/kdump:
1)
Switching between paging modes, requires changes into target kernel.
It means you cannot kexec() 4-level paging kernel from 5-level paging
kernel if 4-level paging kernel doesn't include changes. 

2)
Switching from 5-level paging to 4-level paging kernel would fail, if
kexec() put kernel image above 64TiB of memory.

3)
Kdump jumping has similar issue as 2). This require us to only
reserve crashkernel below 64TB, otherwise jumping from 5-level to
4-level kernel will fail.

4)
The current kexec_load interface will put kernel at the top of system
RAM. This also need be restricted to be under 64TB. However this is not
an issue for kexec_file_load interface since it puts kernel at the top
of lowest 4GB. I ever planned to unify these two's behavior to put
kernel at top of system RAM the reason is we have been using the old
kexec_load, and still more widely than kexec_file_load. Just the change
involves too mamy lines of code change, seems people don't like it. Now
I decide to give up the unifying thing, just leave with it, and add the
restriction for kexec_load in kexec_tools unitilies. The unifying
behaviour patches are:

[PATCH v7 0/4] resource: Use list_head to link sibling resource
http://lkml.kernel.org/r/20180718024944.577-1-bhe@redhat.com

Note:
The issues 1), 2) need be done in kernel for kexec_file_load interface.
Meanwhile, 1), 2), and 4) need be done in user space kexec_tools
utility. I will post patches later for user space fix. Issue 3) can only
be done in kernel.

Baoquan He (3):
  x86/boot: Add bit fields into xloadflags for 5-level kernel checking
  x86/kexec/64: Error out if try to jump to old 4-level kernel from
    5-level kernel
  x86/kdump/64: Change the upper limit of crashkernel reservation

 arch/x86/boot/header.S                | 12 +++++++++++-
 arch/x86/include/uapi/asm/bootparam.h |  2 ++
 arch/x86/kernel/kexec-bzimage64.c     |  5 +++++
 arch/x86/kernel/setup.c               | 18 ++++++++++++++----
 4 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.13.6

