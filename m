Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FF0C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE4420875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4FWuavE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE4420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754519AbeGIITy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:19:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36414 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754317AbeGIITx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:19:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id m19-v6so1109099pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IRmPMz0TmA2vDu3JkkIdBynxc1uxa8LE7LMBTdPBUi4=;
        b=p4FWuavE7R2KCZgG32tDMZ3rTPAba91I60Zt35tjYVKLH8C9QlRW6N5uJlxNZk93+2
         Te2Pg8FVCocjWMy9PWnD5QTnabsk8E1MdCdtFDbIs+7CdROcy78MoasY22s/lVSFW+ht
         grgUx5eZ8SGvmcIoJGs6BqbhMC9aIF5LtsoYUalBRmFSqYU2fHHxhkMFuoOPU+OjcA1U
         fjV6D19TWw2tvcoS9QEKyE+F6TM4wBoKTMzJ6sqmUEPIvXHldtQ93lvy8SoBkTFyMsEU
         nTtwTMcgXJ8lwbLnHskGlOtQy/JcbJDfjO4WjWV2IzWppW8o8RMeACd6LY/ltZsSm25r
         TqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IRmPMz0TmA2vDu3JkkIdBynxc1uxa8LE7LMBTdPBUi4=;
        b=BBduOiK/ZGkO7biw47XzMHAut0D/rw7oHviXzCBQtyo/EXzKGhe2vzWErQY5wLREkv
         2pdUHXSsTRZam+LnoSmnERyM2enub+BmQIk5laH0DxQGswnae/8bDurKTJIXA9LnLKri
         CysKAn3qWK8k7I/TvbDoYwJ2+FtS7bBuYLQxMukDPYvJ/tjcdfBmqbEv5k7YTEYgAx4A
         5z/EFjrprT8pJbC949/kNxpS1/4OHYUu+sbFcTMaWStaS1oLclb+NV2VuGWPVW6FcK1o
         t4QhJnAk+zQM8fq65peKYXEzIXJgtAhR3FBZixkK5/Gcx4HtC33BxvWYgOH11MUauLTa
         Hb5w==
X-Gm-Message-State: APt69E0PRh7OTUSBze4EUlZm4rGTFjHoye0IjZAft5elDmvoLeGMIbEb
        /AsNzr1y6xOSDIFpJgz0K/M=
X-Google-Smtp-Source: AAOMgpfVW/6UZ1n28kzlvbYf6ZrTNLiFnpPJ54sg6oWK99Pp3gJi0IyHtZxE0I3RTIRXf+leG6ewKg==
X-Received: by 2002:a63:4e5f:: with SMTP id o31-v6mr16347061pgl.256.1531124392670;
        Mon, 09 Jul 2018 01:19:52 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id h16-v6sm22145058pfn.80.2018.07.09.01.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:19:52 -0700 (PDT)
From:   Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To:     greentime@andestech.com, linux-kernel@vger.kernel.org
Cc:     green.hu@gmail.com
Subject: [GIT PULL] nds32 fixes for 4.18
Date:   Mon,  9 Jul 2018 16:19:28 +0800
Message-Id: <cover.1531124135.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git tags/nds32-for-linus-4.18

for you to fetch changes up to 987553894f0ce8c1d83578136603a89009f42d35:

  nds32: fix build error "relocation truncated to fit: R_NDS32_25_PCREL_RELA" when make allyesconfig (2018-07-05 16:13:47 +0800)

----------------------------------------------------------------
nds32 patches for 4.18

Here is the nds32 patch set based on 4.18-rc1.
Contained in here are the bug fixes and building error fixes for nds32.

These are the LTP20170427 testing results.

Total Tests: 1902
Total Skipped Tests: 593
Total Failures: 418
Kernel Version: 4.18.0-rc1-00006-g987553894f0c-dirty
Machine Architecture: nds32

Signed-off-by: Greentime Hu <greentime@andestech.com>

----------------------------------------------------------------

Greentime Hu (4):
  nds32: To implement these icache invalidation APIs since nds32 cores
    don't snoop data cache. This issue is found by Guo Ren. Based on the
    Documentation/core-api/cachetlb.rst and it says:
  nds32: Fix the dts pointer is not passed correctly issue.
  nds32: To simplify the implementation of update_mmu_cache()
  nds32: fix build error "relocation truncated to fit:
    R_NDS32_25_PCREL_RELA" when make allyesconfig

Guenter Roeck (1):
  nds32: Fix build error caused by configuration flag rename

Luc Van Oostenryck (1):
  nds32: define __NDS32_E[BL]__ for sparse

 arch/nds32/Kconfig                  |  12 ++---
 arch/nds32/Makefile                 |   2 +
 arch/nds32/include/asm/cacheflush.h |   9 +++-
 arch/nds32/include/asm/futex.h      |   2 +-
 arch/nds32/kernel/setup.c           |   3 +-
 arch/nds32/mm/cacheflush.c          | 100 +++++++++++++++---------------------
 6 files changed, 58 insertions(+), 70 deletions(-)

-- 
2.16.2

