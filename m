Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3F8C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525D92081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F5MtIjUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525D92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeJaHOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:14:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38692 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeJaHOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:14:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so6564245pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPVTCN7yB3EvcS3VgTBTPuwRPE6icIQDbNo/cFgw8x4=;
        b=F5MtIjUSmfPSLlRLUcvlxb8bgwO944Vzlwsrb+STW1m9SKp+FbIUnhKepFgX1d/6zY
         WFEsTME5GAO3fNxqCMjL5qf9DfZtUWW/0eu+pQx31M+moNIAPuITstIM3gP6+QCFd8p4
         spMZEp8n6pfvs7QIBWD5+GLOMia4bijBqXNww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPVTCN7yB3EvcS3VgTBTPuwRPE6icIQDbNo/cFgw8x4=;
        b=cL/aMZvHWHJZz80SZatbUg4njw/4yaIlhmExTFaJLfjitDfH/jbW/IRL58tOCgbNCo
         a6jFEmHs3iRDs0TPB0DlHzwnBN/h6c7dir8U+FBVWprTSiCBX86+dhLTdJXCpMk/+C2a
         IBzWaUHKaT5YY9C3mpgypSERV5ZX0OM4LKoob/q++eX6p2l0N0h/50PYIUzx9zywwYnT
         DheU+GVgPZbLNIlW7FXwT1xBhKK9OlGzbeAosxOpXTfsjK63HvdOoqWcsdU9/ZbvCuD7
         aYz4hUUxg7PekA4g3BfyTxz8KiiKSXSltNDuN6P5+R+uQR23U6ISIN1YuNUX5lKqRFFX
         F9rw==
X-Gm-Message-State: AGRZ1gLMWs1uR4M4Us2FxGfS33XPeo8qQKbu9e8rA8GCeMlN+woKGqxz
        9h8wct6MrT/zwtjuIcm76f14Ug==
X-Google-Smtp-Source: AJdET5c8VEq72Qy0GxQVPtDW46vA6aevXpwki6KHW4SNnqLPDwpMxBbEkvTAqWJGZKK3oeUkFc+Anw==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr521667pfb.209.1540937943074;
        Tue, 30 Oct 2018 15:19:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id c70-v6sm2889774pfe.93.2018.10.30.15.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 15:19:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Paul Burton <paul.burton@mips.com>, sparclinux@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Huang Ying <ying.huang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rich Felker <dalias@libc.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] kgdb: Fix kgdb_roundup_cpus()
Date:   Tue, 30 Oct 2018 15:18:41 -0700
Message-Id: <20181030221843.121254-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
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

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (2):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()

 arch/arc/kernel/kgdb.c     | 10 ++--------
 arch/arm/kernel/kgdb.c     | 12 ------------
 arch/arm64/kernel/kgdb.c   | 12 ------------
 arch/hexagon/kernel/kgdb.c | 32 --------------------------------
 arch/mips/kernel/kgdb.c    |  9 +--------
 arch/powerpc/kernel/kgdb.c |  6 +++---
 arch/sh/kernel/kgdb.c      | 12 ------------
 arch/sparc/kernel/smp_64.c |  2 +-
 arch/x86/kernel/kgdb.c     |  9 ++-------
 include/linux/kgdb.h       | 22 ++++++++++++++--------
 kernel/debug/debug_core.c  | 38 +++++++++++++++++++++++++++++++++++++-
 11 files changed, 60 insertions(+), 104 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog

