Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DBAC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C772086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W7j4p7n6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C772086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbeKGKcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:32:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46211 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbeKGKcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:32:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id c13-v6so7036208plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdAdeS4sZQ8YU1vAJNV5eR8xeGN1ehQuodDt1kCsI6A=;
        b=W7j4p7n6cVnICxU3fNbrsRLIna/24le2c2DHgzKLMFf5CQnUYOE2mZUtt2Rw7cFgi6
         K1v0NjXfenWwuPfGX4TL/6/Henxpcn35IpbF7yXLn6/NLFzfnwdGwXNL7gL4KSJTVfu4
         3gwDRe5HZSKr3bULeqf4DdS9aSwrikmCeHVEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdAdeS4sZQ8YU1vAJNV5eR8xeGN1ehQuodDt1kCsI6A=;
        b=LG+YxXpqys1+QRkcYNVRHgUnViX0ZNLgcl4XOww5ghjLpVcyxEpSLM4V1B/a3mCIvk
         fM9CCmZP0Gt3HWg7p6Yg+mh/KGJi/brWrp1zj7f1a07wfodh6cTVkvHdkI1/QhHFEbHb
         kkE76+5/qTXn35s2Jx6VBHMEtK3RLGhEu8FFXFi3jQGLIlXjz8f/pst56qmXN1LRCqpB
         X25NgtFJpfs38FIgWhg4ZrLZ5Et7PCdAmEjHt/WoZ5moA+th/aalBmLdOi3yzgNvyOB5
         qMBokNzEnJvH2mQuYkM1ocoaaXMBvFL+cDCW+SmXa21n/eUtjQMJlcsKJ//NwcYrYAeQ
         OIKQ==
X-Gm-Message-State: AGRZ1gIdWnO7JUe4M7V3hrkyJfZt7QaqWguiBLO+PLXTuGh0C9ReJG+a
        JF6ENY8sMvZSc3rHX2aZCna39Q==
X-Google-Smtp-Source: AJdET5fgJULXvtUFPnFq52slokQNN7z81I0D9HZsdKxVHZdxgHrZEi4Cy7djJVVncN5rD1H9qJsdhA==
X-Received: by 2002:a17:902:2:: with SMTP id 2-v6mr29324872pla.178.1541552652131;
        Tue, 06 Nov 2018 17:04:12 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id v37sm30134695pgn.5.2018.11.06.17.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 17:04:11 -0800 (PST)
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
Subject: [PATCH v3 0/4] kgdb: Fix kgdb_roundup_cpus()
Date:   Tue,  6 Nov 2018 17:00:24 -0800
Message-Id: <20181107010028.184543-1-dianders@chromium.org>
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

Changes in v3:
- No separate init call.
- Don't round up the CPU that is doing the rounding up.
- Add "#ifdef CONFIG_SMP" to match the rest of the file.
- Updated desc saying we don't solve the "failed to roundup" case.
- Document the ignored parameter.
- Patch #3 and #4 are new.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (4):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
  kgdb: Don't round up a CPU that failed rounding up before
  kdb: Don't back trace on a cpu that didn't round up

 arch/arc/kernel/kgdb.c     | 10 ++-----
 arch/arm/kernel/kgdb.c     | 12 ---------
 arch/arm64/kernel/kgdb.c   | 12 ---------
 arch/hexagon/kernel/kgdb.c | 32 ----------------------
 arch/mips/kernel/kgdb.c    |  9 +------
 arch/powerpc/kernel/kgdb.c |  6 ++---
 arch/sh/kernel/kgdb.c      | 12 ---------
 arch/sparc/kernel/smp_64.c |  2 +-
 arch/x86/kernel/kgdb.c     |  9 ++-----
 include/linux/kgdb.h       | 22 +++++++++------
 kernel/debug/debug_core.c  | 55 +++++++++++++++++++++++++++++++++++++-
 kernel/debug/debug_core.h  |  1 +
 kernel/debug/kdb/kdb_bt.c  | 11 +++++++-
 13 files changed, 88 insertions(+), 105 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog

