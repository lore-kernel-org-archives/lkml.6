Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28882C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5301208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tMFqpweL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5301208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeIZSY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:24:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48386 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeIZSY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:24:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180926121215euoutp0100b81d445fc677a56e62e6ba7787d8fc~X8gzuidpR2978529785euoutp01k;
        Wed, 26 Sep 2018 12:12:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180926121215euoutp0100b81d445fc677a56e62e6ba7787d8fc~X8gzuidpR2978529785euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537963935;
        bh=SN8LOFxs6pauT07D446T30foui6JZh3qnIQv4ys4UDc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tMFqpweL1thgLifs/KVctjCz1eZ+F1NHfn5gukoGFnfEu7Jb/0GJSinndmhJR2iNl
         3+q2EyRduE0wpBMHtObseHsP2REmKpHIAVHlMFEaehOHzovTEROs0vt070Rw/S8qd8
         vh6hdoe6RKRS0q+u430Nvom6HNZqgMsppQ247Tp8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180926121214eucas1p1e0a23bc71cedd89542abd7c7b0f88b43~X8gzGljli0454904549eucas1p1u;
        Wed, 26 Sep 2018 12:12:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DE.21.04294.E977BAB5; Wed, 26
        Sep 2018 13:12:14 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180926121213eucas1p1e85f71d1187eb6b50c320377e5ea907f~X8gyJr0Qw0454904549eucas1p1r;
        Wed, 26 Sep 2018 12:12:13 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-78-5bab779e5496
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D6.0B.04128.D977BAB5; Wed, 26
        Sep 2018 13:12:13 +0100 (BST)
Received: from AMDC3482.DIGITAL.local ([106.120.51.30]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PFN0028YWK7Q120@eusync4.samsung.com>;
        Wed, 26 Sep 2018 13:12:13 +0100 (BST)
From:   Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
        m.slodczyk2@partner.samsung.com
Subject: [PATCH v2 0/7] arm64: uprobes - ARM32 instruction probing
Date:   Wed, 26 Sep 2018 14:11:58 +0200
Message-id: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7djP87rzyldHG/ydwWbRdW8Hm0XHppms
        FhtnrGe1eL+sh9Hi6Nm/TBaNn+YyW2x6fI3V4vKuOWwWh6buZbTY07+azWLtkbvsFpcOLGCy
        aFq2lcVi6/5WRovjvQeYLF5+PMHiIOCxZt4aRo/L1y4ye2xeoeWxaVUnm8e8k4Eem5fUexx8
        t4fJ4/2+q2wefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlTFlTQ9jQa9SxdGnqxkbGPdJdDFy
        ckgImEgc/7ycrYuRi0NIYAWjxLNT/6Ccz4wS1yZeYoWpaul9wg6RWMYoMf1SBwuE859RYun2
        KywgVWwC5hLbj7aA2SICbhI3GjuYQIqYBS4zSVw+0c0EkhAWcJK43dLCDGKzCKhKHGj5CWbz
        CvhL7D+xgglinZzEzXOdzBD2ZTaJN2ftIGwXibt/TzBC2MISr45vYYewZSQuT+5mgbDLJXaf
        uAl2qoRAC6PE1MYDUEOtJf6smsgGYjML8ElM2jYdaAEHUJxXoqNNCML0kHiynA+kQkggVuL0
        9h1sExglFjAyrGIUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAiM9tP/jn/ZwbjrT9IhRgEO
        RiUeXg7bVdFCrIllxZW5hxglOJiVRHi5y1ZHC/GmJFZWpRblxxeV5qQWH2KU5mBREufl00qL
        FhJITyxJzU5NLUgtgskycXBKNTAu/lT5oMhG/GpynUHVTNaStdLv13moS279tMb+SfYvIWOv
        QBFlfa0I7rPhZXxuP2sW9Bx9sMGuaFK8ZM7rQ3/WM0gfOqhi8tb707VdM7ckvZlT85jpegG/
        jMTckHmPG89eE9ps4T/fWN8pUVMz+DcvZ9rS2SflzZr061bkeOqYOn/qiYmJY1JiKc5INNRi
        LipOBABeH1xy8gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsVy+t/xa7pzy1dHG5yZKmnRdW8Hm0XHppms
        FhtnrGe1eL+sh9Hi6Nm/TBaNn+YyW2x6fI3V4vKuOWwWh6buZbTY07+azWLtkbvsFpcOLGCy
        aFq2lcVi6/5WRovjvQeYLF5+PMHiIOCxZt4aRo/L1y4ye2xeoeWxaVUnm8e8k4Eem5fUexx8
        t4fJ4/2+q2wefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlTFlTQ9jQa9SxdGnqxkbGPdJdDFy
        ckgImEi09D5h72Lk4hASWMIoMX/2BxYIp5FJ4ubJvewgVWwC5hLbj7awgNgiAm4SNxo7mECK
        mAUuM0l8XrCXFSQhLOAkcbulhRnEZhFQlTjQ8hPM5hXwl9h/YgUTxDo5iZvnOpknMHItYGRY
        xSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERiU24793LKDsetd8CFGAQ5GJR5eDttV0UKsiWXF
        lbmHGCU4mJVEeLnLVkcL8aYkVlalFuXHF5XmpBYfYpTmYFES5z1vUBklJJCeWJKanZpakFoE
        k2Xi4JRqYBTw0mPQYVvPIChUfL6J0eHj7NMzcw7yyhu5n3u84oPe8/ksFkmTFzdMuMz25vzR
        gPnPN8buW/is+fgp22Nr9l+0UItLlX/0nU3nYoKGbv1c3pvivP8PT1y/KD9s+sfkpe65WW7J
        AU9cLf+kOn198sx72qLsK8uz1r+wKqvhiLbdefn80yPh+bpKLMUZiYZazEXFiQBpAuZORgIA
        AA==
X-CMS-MailID: 20180926121213eucas1p1e85f71d1187eb6b50c320377e5ea907f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180926121213eucas1p1e85f71d1187eb6b50c320377e5ea907f
References: <CGME20180926121213eucas1p1e85f71d1187eb6b50c320377e5ea907f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uprobe feature on ARM64 kernel does not support ARM A32 instruction
probing, making 32 bit apps running on 64 bit kernel unprobeable.

This patchset utilizes ARM32 uprobe code in ARM64 tree with following
modifications:
- moves ARM32 uprobes code form arch/arm to lib/uprobes/arm to be reused
by ARM64 code
- makes adjustments in api so that it suits the one used by ARM64 kernel, e.g.
struct pt_regs, register numbers
- takes into account differences between 32 and 64 bit ARM architectures.
A64 instruction handling is left unchanged.

Detect what kind of instruction is being probed and depending on the result:
- if an A64 instruction handle it the old way, using existing A64 instructions
probing code,
- if an A32 instruction decode it and handle using the new code, moved from
32 bit arm kernel tree.

Currently following test cases have been carried out with positive results:
- simulation-able instructions, like: STM, LDM, BLX, BL
- xol-able instructions, like: STR, LDR, ADD, CMN, CMP
- branching
- uretprobes.

This patchset does not implement T32 (Thumb) instructions probing (which is
also unsupported on "native" ARM32 arch).

v2:
- Rebased on 4.19-rc4 and tested against it
- Fixed build errors reported by kbuild test robot

Maciej Slodczyk (7):
  arm64: move arm uprobes code to be reused by arm64
  arm64: uprobes - fix checkpatch issues
  arm64: introduce get_swbp_insn() instead of static assignment
  arm64: change arm64 probes handler prototype
  arm64: make arm uprobes code reusable by arm64
  arm64: change arm_probe_decode_insn() function name
  arm64: uprobes - ARM32 instruction probing

 arch/arm/include/asm/probes.h                      |   8 ++
 arch/arm/include/asm/ptrace.h                      |  32 +++++
 arch/arm/include/asm/uprobes.h                     |   2 +-
 arch/arm/probes/Makefile                           |   8 +-
 arch/arm/probes/kprobes/actions-arm.c              |   2 +-
 arch/arm/probes/kprobes/checkers-arm.c             |   4 +-
 arch/arm/probes/kprobes/checkers-common.c          |   4 +-
 arch/arm/probes/kprobes/checkers-thumb.c           |   2 +-
 arch/arm/probes/kprobes/checkers.h                 |   2 +-
 arch/arm/probes/kprobes/core.c                     |   2 +-
 arch/arm/probes/kprobes/core.h                     |   2 +-
 arch/arm/probes/kprobes/test-core.c                |   2 +-
 arch/arm/probes/uprobes/Makefile                   |   2 +-
 arch/arm/probes/uprobes/core.c                     |  10 +-
 arch/arm64/include/asm/probes.h                    |  24 +++-
 arch/arm64/include/asm/ptrace.h                    |  21 +++
 arch/arm64/include/asm/uprobes.h                   |  21 ++-
 arch/arm64/kernel/debug-monitors.c                 |   8 ++
 arch/arm64/kernel/probes/Makefile                  |   2 +
 arch/arm64/kernel/probes/decode-insn.c             |  30 ++--
 arch/arm64/kernel/probes/decode-insn.h             |  15 +-
 arch/arm64/kernel/probes/kprobes.c                 |   4 +-
 arch/arm64/kernel/probes/simulate-insn.c           |  32 +++--
 arch/arm64/kernel/probes/simulate-insn.h           |  24 ++--
 arch/arm64/kernel/probes/uprobes.c                 | 122 ++++++++++++++--
 include/linux/uprobes.h                            |   1 +
 kernel/events/uprobes.c                            |  12 +-
 lib/Makefile                                       |   2 +
 lib/probes/Makefile                                |   2 +
 lib/probes/arm/Makefile                            |  11 ++
 .../uprobes => lib/probes/arm}/actions-arm.c       | 153 ++++++++++++++++++---
 {arch/arm/probes => lib/probes/arm}/decode-arm.c   |  58 +++++---
 {arch/arm/probes => lib/probes/arm}/decode-arm.h   |   4 +-
 {arch/arm/probes => lib/probes/arm}/decode.c       |  18 ++-
 {arch/arm/probes => lib/probes/arm}/decode.h       |  48 ++++---
 35 files changed, 552 insertions(+), 142 deletions(-)
 create mode 100644 lib/probes/Makefile
 create mode 100644 lib/probes/arm/Makefile
 rename {arch/arm/probes/uprobes => lib/probes/arm}/actions-arm.c (61%)
 rename {arch/arm/probes => lib/probes/arm}/decode-arm.c (95%)
 rename {arch/arm/probes => lib/probes/arm}/decode-arm.h (94%)
 rename {arch/arm/probes => lib/probes/arm}/decode.c (98%)
 rename {arch/arm/probes => lib/probes/arm}/decode.h (94%)

-- 
2.7.4

