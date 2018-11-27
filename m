Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01903C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE65720989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SstBiiGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE65720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeK0OsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:48:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38192 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbeK0OsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:48:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so7673293pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 19:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckFwfWrXDG7mbBgtIA9ywF+G24oiGIeq/mDuQRgaBZM=;
        b=SstBiiGWzw5dBJG/3tQu6dyCWZzwOYkKa8t0/fa0w5gcDTZaE47UUcy03dPrz4/uvH
         mFYss26Ji3dfFsBbZtXM9Fkiw7fyvNZFThjXOqmer3sdiz1pAVn1Ulbd0owmzDDRP5vg
         d+8ef2cthPwUtXBypN4pDgp8cmiqJR5m56fcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckFwfWrXDG7mbBgtIA9ywF+G24oiGIeq/mDuQRgaBZM=;
        b=pgjCYVBwywD/yvNX38lBoiKsyAn4zro5Q/r1bGikdMZBRaYpghnZu0Ai4LPtf2iC0i
         Mr3kR2eUIfhccKRS6cPCJiXIxYonaizxj6MSv6w/vSKq6eSdFPdjBJ9mQLU7beUmmlNq
         58U45YjhKsRFvOHUdEvcBEV8PHen/miF7fuiV2hWSvLffc/kPQx2ocM5MCOD73coidxL
         OWWGpLzjT6fup+WV/cjIOzXl5P2FkgICaFFxpxeNWoT0llIWtaSOfuUyHYruEVQscYXs
         8OjONjxPtrEYKeUePlIHTwHVa2R14sNMCiL3LiWA+OjYqsIQlNRN5bV6eZhf5+IaXvrY
         9OMQ==
X-Gm-Message-State: AA+aEWZ6XTQaZUtuZmXUWemr45/wF1JF5edMiaJ/ZbCtH965mDWYW8pB
        gS2QwEAVR3kPVJl+4Z77ZZ+umg==
X-Google-Smtp-Source: AFSGD/V3wZAxhlYGm/KNcJbxWJViWYHfJeGL3B2UeBIJOeAl5ZlvisN4Y0oJyigojv6bCfo+1dgibw==
X-Received: by 2002:a63:2946:: with SMTP id p67mr28146422pgp.317.1543290705498;
        Mon, 26 Nov 2018 19:51:45 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id i4sm2690112pfj.82.2018.11.26.19.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 19:51:44 -0800 (PST)
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
Subject: [PATCH v5 0/4] kgdb: Fix kgdb_roundup_cpus()
Date:   Mon, 26 Nov 2018 19:51:29 -0800
Message-Id: <20181127035133.225592-1-dianders@chromium.org>
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

