Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3321CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02652245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eXr6js0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02652245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbeKMEVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:21:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38946 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeKMEVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:21:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so4431357pgv.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 10:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+fNEzOvGtu7UZFhCEIQ8uoVjOxFwpPILN5pzazqNYk=;
        b=eXr6js0mdxBQXDsYoP+dpGM05tDLjEqyHTGRhiOIULp8cnhmCXXktIgW8uezqg9ePK
         wVabda9zlcNHOXnd4xrUL7y/qGPvD3LORin0hioaX/oYI39lrop8fAjEQALwFCK9UNaM
         Enw29nwR5bw1mTGJXMldXQvFe9C5yvoDao0KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+fNEzOvGtu7UZFhCEIQ8uoVjOxFwpPILN5pzazqNYk=;
        b=dz8gFCwxRfX3PStVm1cwIPh9pSPdSTyB75TNz3XdvJHLqQh5+5BSmXijMTv2hnf7la
         HLtBdrl1w4NEMri+zTUeU/2KCwG9oPeG0Bhaxhyyyjk+zl+t8iMPjG19TOxxI5zgXfy6
         7ShVSIhze4rAqSUCVYfJtG7SLo4OHErNTT1WEzubCfKqtaqXX6lw2s+gne22uha9jUlr
         wG3+fCZZUomz4m3b5Ao74nMW0COpZPc2fFJNdF7hKStcpHZntZjfq7aQLfwWFPge7rSM
         Cm+GgtLdB6MQoOnzgk0gBdYql86erSI6yAmMZ7VmJeCcKQq2Eiw0eSaVQy0fSIC4ez4w
         IkYQ==
X-Gm-Message-State: AGRZ1gItZWM69t39GIJWbYNPKLYDB0pONz7egX8ENrHuVPXn1kONSNn9
        inkuB3Exs+RNC4ZAoTbQ5pagJA==
X-Google-Smtp-Source: AJdET5e5/WkAuI8mTOdhvf1T6zEObtJHy7y0EHk3Q6guTcO9BgOxiHnQib5SZuhWLZjVMV7KN5Oidg==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr1679288pgk.406.1542047236123;
        Mon, 12 Nov 2018 10:27:16 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id o86-v6sm18813100pfk.8.2018.11.12.10.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 10:27:15 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
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
        Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>,
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
Subject: [PATCH v4 0/4] kgdb: Fix kgdb_roundup_cpus()
Date:   Mon, 12 Nov 2018 10:26:54 -0800
Message-Id: <20181112182659.245726-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
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

 arch/arc/kernel/kgdb.c          | 10 ++----
 arch/arm/kernel/kgdb.c          | 12 -------
 arch/arm64/kernel/kgdb.c        | 12 -------
 arch/hexagon/kernel/kgdb.c      | 32 -------------------
 arch/mips/kernel/kgdb.c         |  9 +-----
 arch/powerpc/kernel/kgdb.c      |  6 ++--
 arch/sh/kernel/kgdb.c           | 12 -------
 arch/sparc/kernel/smp_64.c      |  2 +-
 arch/x86/kernel/kgdb.c          |  9 ++----
 include/linux/kgdb.h            | 22 ++++++++-----
 kernel/debug/debug_core.c       | 56 ++++++++++++++++++++++++++++++++-
 kernel/debug/debug_core.h       |  1 +
 kernel/debug/kdb/kdb_bt.c       | 11 ++++++-
 kernel/debug/kdb/kdb_debugger.c |  7 -----
 14 files changed, 89 insertions(+), 112 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog

