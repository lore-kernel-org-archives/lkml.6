Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5C9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520C920865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBiioxk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520C920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeK0Ds7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:48:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34404 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeK0Ds6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:48:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so12965639wmd.1;
        Mon, 26 Nov 2018 08:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=BrcxsdJ3uoMc8L1c1HR2XDoK1sSigEoPDyD1UbnjIVs=;
        b=dBiioxk3ERXqQz5M/t3NPjC0SwLKFeYR5ufEJNf43nseghKQo2vUReAJ7CkcvAhooz
         Y4XMD8Vr7q+1yoqZYejQVzT89udqhGdQYVkgIAVJ/GgCDm3q9PEGfChrY/Hqt6d0uN6w
         IZ7mApXk17nd1lJxCZHe+fAzuGBVJaknDulNEKCc2tUDIMkTXf19781f67VcX+Ph9w5C
         o6z41/0MWAdVltUNh6YAci/rNRyXdrqlFbA70OCTncr2rHSv+c7334fU97Pvs4Z/ckSz
         rCwCQCR4EVDO0ffB31PaYIJdiDikzqOc31kyELB0Xt9a+Jwwl1cbcPmE4M05PB6eIpB0
         nAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=BrcxsdJ3uoMc8L1c1HR2XDoK1sSigEoPDyD1UbnjIVs=;
        b=WcK4PheOUDI20tBWOtBfGVk9i9Hjtrgqlepo7YzHdmVjBn7jka0OTPbatTh9oT6Mif
         dkN2t/N1I3pSoYA9lt6UIKBSOSqY2hNvKYQyzGIJULYYq+trIAGFgwlnrAmI4hLqqgd9
         AyvyJMWE+2V1BPF+ViuJAxdTUlGiTSgy2IvIfyTs9BvGyQLaz3W65ntiQ6qrg+nDrDNI
         y8NQZl27TGZX9NwPsEAhQERHP4tDhGFWOqPwzjk6ZFA9Juj+94MNLHe+ON/GKpw71xyQ
         4y336DFUwR7R0MsfYyDuXFP0Qsq1oby7Pcyw78EcNNbSFv7bdIJNcZbVG/QSmjcwwrwi
         /PCQ==
X-Gm-Message-State: AA+aEWa/JCEGFTBhLbDpWWURdO214uFWJAyon80Ny9NpmyoQO4plpbxi
        Obc/5/g77fcZ8XQgIIkZsBHFD2fd
X-Google-Smtp-Source: AFSGD/VWXnZeZeWO/tUnE8Zq1Jgyk7G6/35fH0PSCEYDF2/ytr3TINST/5jMKKD+Ya2Dqh56+layMw==
X-Received: by 2002:a1c:b47:: with SMTP id 68mr12183398wml.148.1543251255512;
        Mon, 26 Nov 2018 08:54:15 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id w8sm979240wrv.7.2018.11.26.08.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:54:14 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Junaid Shahid <junaids@google.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: [PATCH 0/3] kvm: split retrieval and clearing of dirty log
Date:   Mon, 26 Nov 2018 17:54:10 +0100
Message-Id: <1543251253-24762-1-git-send-email-pbonzini@redhat.com>
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
kvm_get_dirty_log_protect get the support (that is x86_64 and ARM).

Paolo Bonzini (3):
  kvm: make KVM_CAP_ENABLE_CAP_VM architecture agnostic
  kvm: rename last argument to kvm_get_dirty_log_protect
  kvm: introduce manual dirty log reprotect

 Documentation/virtual/kvm/api.txt                  |  78 ++++++++++-
 arch/mips/kvm/mips.c                               |  29 +++-
 arch/powerpc/kvm/powerpc.c                         |  14 +-
 arch/s390/kvm/kvm-s390.c                           |  11 +-
 arch/x86/kvm/x86.c                                 |  47 ++++---
 include/linux/kvm_host.h                           |   9 +-
 include/uapi/linux/kvm.h                           |  15 +++
 tools/testing/selftests/kvm/Makefile               |   2 +
 tools/testing/selftests/kvm/clear_dirty_log_test.c |   2 +
 tools/testing/selftests/kvm/dirty_log_test.c       |  19 +++
 tools/testing/selftests/kvm/include/kvm_util.h     |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c         |  13 ++
 virt/kvm/arm/arm.c                                 |  22 ++-
 virt/kvm/kvm_main.c                                | 147 ++++++++++++++++++---
 14 files changed, 345 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/clear_dirty_log_test.c

-- 
1.8.3.1

