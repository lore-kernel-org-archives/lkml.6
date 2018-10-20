Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D061C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1D221528
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gloKypAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1D221528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeJTV3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 17:29:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40690 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbeJTV3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 17:29:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id z204-v6so6099777wmc.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ip2zVKfon4Vayu2LyUug3Z+GLvQNpozzy8b48n6dtxQ=;
        b=gloKypAWMmT8H2ZuMtjp/ZgKeg21n3GM/2UnTqsIP4+6q4N81/l4XcrIfFy1YJXnmu
         l/VRqnayLWuezWQ0mNLf7TG+YXtKwNihAOrqACqryUT1g1IqhKIGcsTEPoVgJGEKgPGB
         pmpW/EEs8nt7lX+oxcpzhH4ZfJ0mWB7IfHjWuE9nxKD4EMYJ/KWquMuwXw5rr+lB6H+D
         4Da5Ur5IYWMOmmIzH9rwRql7oaw+kqLO0Jecc8TJMNAvVOBHZonleAMT+ccZydW5GLT8
         3NsTnTv2OSztK+QwBJu1AzggNjOD2P6MBQbCeuuODv8L20BNlRVSBu856OxTVJZstx5I
         BZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ip2zVKfon4Vayu2LyUug3Z+GLvQNpozzy8b48n6dtxQ=;
        b=uJoZzs//BuH9a4nKKl2OsJRs0G02l+FB/lNUYit3wyiXbnDT1YHB+M+rSIjOMyLlD+
         zscubZoKrsvBfqAKxxSu48Y7wfNKjnwWLhky2WYWN+PzeP1I5RVenaNR7avDg/O4Jn1E
         Nf8bgMQLik1SPNsskbd0++FvieXBXjILZDJvleM1klPgntdeWWci6qeg95oAm0i855Xa
         Avx463nyO8I5J+A/oO0mTAorrmlcHxXMEY8OTbe7GwdJnoPzEaFZ5XUj+1zmYb1k4Gj3
         Qpko+7jYzZSqwdh4SpMR+7QX4JF7EkHmyEup7t8rAQbPDOPA7C4N51k5s1/bI5yHq4dS
         uKow==
X-Gm-Message-State: ABuFfogEMxgiR4m2t1jFnLxBdSBG/2O/p7h35U4cvWyJat/aeInusvBD
        FqLoTbrMWWReBw8SsnjS46nSjaBStgNevA==
X-Google-Smtp-Source: ACcGV63A7nZvUw3I+oca4CWdzLP4qpzD0atIBwBp5bwKtBOOdcVpL8xxDGD9+cpOPd6vYMpbjL2YFA==
X-Received: by 2002:a1c:845:: with SMTP id 66-v6mr9449278wmi.61.1540041566619;
        Sat, 20 Oct 2018 06:19:26 -0700 (PDT)
Received: from viisi.sifive.com ([37.152.39.96])
        by smtp.gmail.com with ESMTPSA id 5-v6sm11394568wra.48.2018.10.20.06.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 06:19:25 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Jim Wilson <jimw@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 0/2] modpost: skip section mismatch warnings on ELF local symbols by default
Date:   Sat, 20 Oct 2018 06:19:10 -0700
Message-Id: <20181020131911.22443-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modpost: skip section mismatch warnings on ELF local symbols by default

modpost, by default, reports section mismatch warnings on ELF local
symbols.  This caused false positive warnings to be reported for a
local symbol name that would otherwise be elided by matching against a
name pattern.  This was observed using a RISC-V toolchain that generates
section anchors.

To avoid this noise in the common case, this patch series disables
section mismatch warnings on ELF local symbols by default.  It also
adds a modpost command line switch to re-enable these warnings, since
I wasn't able to convince myself that section mismatch warnings on ELF
local symbols were completely useless; just mostly useless :-)

I'm neither a modpost nor an ELF expert, so careful review of this
series is appreciated.

This modpost series can also be found at:

https://github.com/sifive/riscv-linux/tree/dev/paulw/modpost-elf-local-symbols-v4.19-rc7

The series was tested on a RISC-V build of the SiFive UART serial
driver, at:

https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v4.19-rc7

Paul Walmsley (2):
  modpost: add switch to skip symbol exclusions likely to generate false
    positives
  modpost: skip ELF local symbols by default during section mismatch
    check

 scripts/mod/modpost.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

Cc: Russell King <linux@armlinux.org.uk>
Cc: Jim Wilson <jimw@sifive.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

-- 
2.19.1

