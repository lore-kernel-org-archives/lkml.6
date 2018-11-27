Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED4CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FDB2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="euCgN7jE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FDB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbeK1Eh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:37:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35425 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeK1Eh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:37:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so8744063pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btW4tSDgYVTZG1VgsidJSZkpnvOhOR1OVjsuNy9rgN8=;
        b=euCgN7jEgQj9BRFsLbvLccqvD7BMHe9oH/vw1fAfkRcsIDTG0H7atf+O3VJgHHf/Ib
         +0EeiF/ExR8JhzG0aAXqyKgdH6Nf5nT/7EVlTOI3Tc2bZhX3O47+u9FWkaY9wdccnh4z
         +aK0BhxRON+bYi7HxjEeHzb4905MbKY+2VSSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btW4tSDgYVTZG1VgsidJSZkpnvOhOR1OVjsuNy9rgN8=;
        b=MlC23rsC6RXNXHRxbs3sHlcrGII/vgAgvKTAMviL2Gma/KIju9HPV2UwkmbdQOtH/u
         5JatSi0WzuKuZQrZhvjA1l+SW6UoFQO5BRPPBS7wrQAbJoGDMl06Jqb93vNVKL2/0iWo
         +8/O1t/pKlxf2f+MuVL398hQ09zMABrtcGFVcC1jn3KXMzZJrQJG96SgoUdzGmzOvj5Y
         wPUQ5TW9AY208mxmB5flu+gzCPq9XJjt3PyTY/AfI7TGwepwl1ZgNlC8vBurN3kQ0biD
         kZGsXJsgvMzv1MCDp0bKcEG04jjzwFIWC7ibDCfmzZtmA5/KFWU1QqSovRZNwT60Wfoy
         8Dpw==
X-Gm-Message-State: AA+aEWb50c7AUVyeLN2wvqGypkYsHbnTOQqn4snoHbf2ibvLnt5iMnVw
        RDIIvzanGw4K9NHDs0dYpRVuVw==
X-Google-Smtp-Source: AFSGD/UVOvmhqSJQV7tD2XVnws13TlcYn7Y2nz8qJVewAZOL0PscKr9j/ccZFuITN4ISEaCxhdCosA==
X-Received: by 2002:a63:c141:: with SMTP id p1mr30084699pgi.424.1543340329654;
        Tue, 27 Nov 2018 09:38:49 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id b185sm4577547pga.85.2018.11.27.09.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 09:38:48 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Burton <paul.burton@mips.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Huang Ying <ying.huang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rich Felker <dalias@libc.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 0/4] kgdb: Fix kgdb_roundup_cpus()
Date:   Tue, 27 Nov 2018 09:38:35 -0800
Message-Id: <20181127173839.34328-1-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series was originally part of the series ("serial: Finish kgdb on
qcom_geni; fix many lockdep splats w/ kgdb") but it made sense to
split it up.

It's believed that dropping into kgdb should be more robust once these
patches are applied.

Changes in v6:
- Moved smp_call_function_single_async() error check to patch 3.

Changes in v5:
- Add a comment about get_irq_regs().
- get_cpu() => raw_smp_processor_id() in kgdb_roundup_cpus().
- for_each_cpu() => for_each_online_cpu()
- Error check smp_call_function_single_async()

Changes in v4:
- Removed smp_mb() calls.
- Also clear out .debuggerinfo.
- Also clear out .debuggerinfo and .task for the master.
- Remove clearing out in kdb_stub for offline CPUs; it's now redundant.

Changes in v3:
- No separate init call.
- Don't round up the CPU that is doing the rounding up.
- Add "#ifdef CONFIG_SMP" to match the rest of the file.
- Updated desc saying we don't solve the "failed to roundup" case.
- Document the ignored parameter.
- Don't round up a CPU that failed rounding up before new for v3.
- Don't back trace on a cpu that didn't round up new for v3.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (4):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
  kgdb: Don't round up a CPU that failed rounding up before
  kdb: Don't back trace on a cpu that didn't round up

 arch/arc/kernel/kgdb.c          | 10 +----
 arch/arm/kernel/kgdb.c          | 12 ------
 arch/arm64/kernel/kgdb.c        | 12 ------
 arch/hexagon/kernel/kgdb.c      | 32 ----------------
 arch/mips/kernel/kgdb.c         |  9 +----
 arch/powerpc/kernel/kgdb.c      |  6 +--
 arch/sh/kernel/kgdb.c           | 12 ------
 arch/sparc/kernel/smp_64.c      |  2 +-
 arch/x86/kernel/kgdb.c          |  9 +----
 include/linux/kgdb.h            | 22 +++++++----
 kernel/debug/debug_core.c       | 65 ++++++++++++++++++++++++++++++++-
 kernel/debug/debug_core.h       |  1 +
 kernel/debug/kdb/kdb_bt.c       | 11 +++++-
 kernel/debug/kdb/kdb_debugger.c |  7 ----
 14 files changed, 98 insertions(+), 112 deletions(-)

-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

