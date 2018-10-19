Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23784ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D3021476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D3021476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeJTE6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:58:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:44517 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbeJTE6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:58:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 13:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,401,1534834800"; 
   d="scan'208";a="100971840"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.168])
  by orsmga001.jf.intel.com with ESMTP; 19 Oct 2018 13:50:51 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        keescook@chromium.org, catalin.marinas@arm.com,
        will.deacon@arm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, arnd@arndb.de,
        jeyu@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        jannh@google.com
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC v3 0/3] Rlimit for module space
Date:   Fri, 19 Oct 2018 13:47:20 -0700
Message-Id: <20181019204723.3903-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If BPF JIT is on, there is no effective limit to prevent filling the entire
module space with JITed e/BPF filters. For classic BPF filters attached with
setsockopt SO_ATTACH_FILTER, there is no memlock rlimit check to limit the
number of insertions like there is for the bpf syscall.

This patch adds a per user rlimit for module space, as well as a system wide
limit for BPF JIT. In a previously reviewed patchset, Jann Horn pointed out the
problem that in some cases a user can get access to 65536 UIDs, so the effective
limit cannot be set low enough to stop an attacker and be useful for the general
case. A discussed alternative solution was a system wide limit for BPF JIT
filters. This much more simply resolves the problem of exhaustion and
de-randomizing in the case of non-CONFIG_BPF_JIT_ALWAYS_ON. If
CONFIG_BPF_JIT_ALWAYS_ON is on however, BPF insertions will fail if another user
exhausts the BPF JIT limit. In this case a per user limit is still needed. If
the subuid facility is disabled for normal users, this should still be ok
because the higher limit will not be able to be worked around that way.

The new BPF JIT limit can be set like this:
echo 5000000 > /proc/sys/net/core/bpf_jit_limit

So I *think* this patchset should resolve that issue except for the
configuration of CONFIG_BPF_JIT_ALWAYS_ON and subuid allowed for normal users.
Better module space KASLR is another way to resolve the de-randomizing issue,
and so then you would just be left with the BPF DOS in that configuration.

Jann also pointed out how, with purposely fragmenting the module space, you
could make the effective module space blockage area much larger. This is also
somewhat un-resolved. The impact would depend on how big of a space you are
trying to allocate. The limit has been lowered on x86_64 so that at least
typical sized BPF filters cannot be blocked.

If anyone with more experience with subuid/user namespaces has any suggestions
I'd be glad to hear. On an Ubuntu machine it didn't seem like a un-privileged
user could do this. I am going to keep working on this and see if I can find a
better solution.

Changes since v2:
 - System wide BPF JIT limit (discussion with Jann Horn)
 - Holding reference to user correctly (Jann)
 - Having arch versions of modulde_alloc (Dave Hansen, Jessica Yu)
 - Shrinking of default limits, to help prevent the limit being worked around
   with fragmentation (Jann)

Changes since v1:
 - Plug in for non-x86
 - Arch specific default values


Rick Edgecombe (3):
  modules: Create arch versions of module alloc/free
  modules: Create rlimit for module space
  bpf: Add system wide BPF JIT limit

 arch/arm/kernel/module.c                |   2 +-
 arch/arm64/kernel/module.c              |   2 +-
 arch/mips/kernel/module.c               |   2 +-
 arch/nds32/kernel/module.c              |   2 +-
 arch/nios2/kernel/module.c              |   4 +-
 arch/parisc/kernel/module.c             |   2 +-
 arch/s390/kernel/module.c               |   2 +-
 arch/sparc/kernel/module.c              |   2 +-
 arch/unicore32/kernel/module.c          |   2 +-
 arch/x86/include/asm/pgtable_32_types.h |   3 +
 arch/x86/include/asm/pgtable_64_types.h |   2 +
 arch/x86/kernel/module.c                |   2 +-
 fs/proc/base.c                          |   1 +
 include/asm-generic/resource.h          |   8 ++
 include/linux/bpf.h                     |   7 ++
 include/linux/filter.h                  |   1 +
 include/linux/sched/user.h              |   4 +
 include/uapi/asm-generic/resource.h     |   3 +-
 kernel/bpf/core.c                       |  22 +++-
 kernel/bpf/inode.c                      |  16 +++
 kernel/module.c                         | 152 +++++++++++++++++++++++-
 net/core/sysctl_net_core.c              |   7 ++
 22 files changed, 233 insertions(+), 15 deletions(-)

-- 
2.17.1

