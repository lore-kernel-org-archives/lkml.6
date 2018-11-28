Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D2720660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8PEWkTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D2720660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeK1WoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:44:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35444 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeK1WoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:44:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so2258455wmh.0;
        Wed, 28 Nov 2018 03:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=fp5tLsA3PuDOSMQHxaiZuK21UgjorsL9TKSnZDW4Opc=;
        b=X8PEWkTkmxSwtEV7SvqUjPhO6fCwG+oFRT9cm4St2KBieiGPsUqoMdvmqHin7tZ1mi
         NFUQxrEzt2zAEPIYpqRoMtMoQoec9gKeBzmj7oE/xeX7R4JB8yFA9wxirvu0jJpBT3Kh
         1QMSaeFaEv+socu8nUt3U48gRuZZDoSTEhgOBSNQVPWlqR4Pt5/EAuLjftKT3FqcQsVl
         sbYAbmcmFHRmNQzbVl9JB+nOgxCSZdwAzvc4VEtdGgnb3SAwJn6+Hmf1I0gLiQCiaQle
         1VMYYdg7352qcc/6YW2EcJelu7L+Oe9m/oTSk3hBCDqwR3tc9+AFMVWcWnNLKL03Tih0
         OgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=fp5tLsA3PuDOSMQHxaiZuK21UgjorsL9TKSnZDW4Opc=;
        b=WZdk420UhBS83J75r2l3wLSIYlsnDlruJKgu3tMx/89QTxUGfOs+gg0qmme/12Pams
         e2zqy9Sjm8tSwbiLXyfgPE4/TSb3/17o3K7J/aK2bqVp3qd3a8e4bWYIGGNOYHcS0Uu8
         VyfX6DWClfR39BcOxf3FZSlHuSHfeiBDrJO+WxoJm2wp0/NrCX67uXrDrr5OkLH9iku0
         IshmwReL565U5gVYUwK7ZK8exs3EsPyRnMjBuEHT1M81HF9az1m/mNWrtMgEhy296vLz
         NXy22yPhO5tYQrq4phDox7DI1aZsSHp8dlBe+cdL1kZ4PHBDd8x9Z5GvQxncXaCTIe91
         3GIQ==
X-Gm-Message-State: AA+aEWbpIT8HpRNNKY0klEtu4sm3xIK7Rt9+XgIWLa1lpktF11KIns3R
        +qTBq6IN5cjR2IDlXnso7MrJuOYD
X-Google-Smtp-Source: AFSGD/UfB7BvE6UwXepBB5QBDQeTRT2ocp+46iYkmpTyQ/0xz8uwQoRiy6VVYBNppcoCLRaKXfdmtw==
X-Received: by 2002:a1c:c148:: with SMTP id r69mr918173wmf.147.1543405381844;
        Wed, 28 Nov 2018 03:43:01 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id k19sm7061740wre.5.2018.11.28.03.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 03:43:01 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v2 0/3] kvm: split retrieval and clearing of dirty log
Date:   Wed, 28 Nov 2018 12:42:56 +0100
Message-Id: <1543405379-21910-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two problems with KVM_GET_DIRTY_LOG.  First, and less important,
it can take kvm->mmu_lock for an extended period of time.  Second, its user
can actually see many false positives in some cases.  The latter is due
to a benign race like this:

  1. KVM_GET_DIRTY_LOG returns a set of dirty pages and write protects
     them.
  2. The guest modifies the pages, causing them to be marked ditry.
  3. Userspace actually copies the pages.
  4. KVM_GET_DIRTY_LOG returns those pages as dirty again, even though
     they were not written to since (3).

This is especially a problem for large guests, where the time between
(1) and (3) can be substantial.  This patch introduces a new
capability which, when enabled, makes KVM_GET_DIRTY_LOG not
write-protect the pages it returns.  Instead, userspace has to
explicitly clear the dirty log bits just before using the content
of the page.  The new KVM_CLEAR_DIRTY_LOG ioctl can operate on a
64-page granularity rather than requiring to sync a full memslot.
This way the mmu_lock is taken for small amounts of time, and
only a small amount of time will pass between write protection
of pages and the sending of their content.

This is entirely implemented in generic code, but only users of
kvm_get_dirty_log_protect get the support (that is x86_64, ARM and MIPS).

There are no code changes from v1, only documentation and comments.

v1->v2: fix documentation and comments to cover PML case [Junaid]
	fix parameter direction [Junaid]
	remark on userspace setting bits beyond the end of the memslot [Junaid]

Paolo Bonzini (3):
  kvm: make KVM_CAP_ENABLE_CAP_VM architecture agnostic
  kvm: rename last argument to kvm_get_dirty_log_protect
  kvm: introduce manual dirty log reprotect

 Documentation/virtual/kvm/api.txt                  |  80 ++++++++++-
 arch/mips/kvm/mips.c                               |  29 +++-
 arch/powerpc/kvm/powerpc.c                         |  14 +-
 arch/s390/kvm/kvm-s390.c                           |  11 +-
 arch/x86/kvm/x86.c                                 |  47 ++++--
 include/linux/kvm_host.h                           |   9 +-
 include/uapi/linux/kvm.h                           |  15 ++
 tools/testing/selftests/kvm/Makefile               |   2 +
 tools/testing/selftests/kvm/clear_dirty_log_test.c |   2 +
 tools/testing/selftests/kvm/dirty_log_test.c       |  19 +++
 tools/testing/selftests/kvm/include/kvm_util.h     |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c         |  13 ++
 virt/kvm/arm/arm.c                                 |  22 ++-
 virt/kvm/kvm_main.c                                | 159 ++++++++++++++++++---
 14 files changed, 358 insertions(+), 66 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/clear_dirty_log_test.c

-- 
1.8.3.1

