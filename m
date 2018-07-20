Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB99ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D870A20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D870A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeGTWcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:32:07 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45964 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeGTWcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:32:07 -0400
Received: by mail-qk0-f195.google.com with SMTP id c192-v6so7035744qkg.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 14:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=/mIYvgBgVnR3zMDpjtUG0E3aztEbX+HkQu1AxZy8yMA=;
        b=ICMM6YCSGatM+44yu/D2a7p+WUtY37DjANlOJuzm+a4ojQPdIEAuMGBp1kiBwBvG8W
         KjCSgIbK8IMw/kl3yE1Bjx7NTCygHIytjF+Xbrf0liZW84/djmwuDZseJsoT4Qrc1+N0
         JsEQ7HWma4capCEAIN12QieDlyB3i4dlIBBSAcFfbH0rop9Ynxz3qsa6e+Pbbsn8W2GW
         yEnT7J91BvdK1Xq1ICTtOzHidxfMexVUgfMWQZI32k34tySw2CM/MFuUNVKKj0m+Woi9
         uXr9w8OjRnfITQfq5Dntro90z367ulUN5CgtQfhpMb0mV4rkdUyw5z3g64806O/WQi1J
         fAmw==
X-Gm-Message-State: AOUpUlEhsJx3rMnjscN7x2d78d3xeGYQ7SaFnr4Evri25oUCDTuBQjWZ
        +dxqqpLKiTWkwm2A07b2HiOAmA==
X-Google-Smtp-Source: AAOMgpdbjMDdxajc3/Tc0YCCtwN0y4UNujhMu6w7XWomxs3FNFhulGYwPc6w32tuwc8IM2VyfF2vyg==
X-Received: by 2002:a37:8ac5:: with SMTP id m188-v6mr3329536qkd.297.1532122919627;
        Fri, 20 Jul 2018 14:41:59 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id r4-v6sm1617385qtm.10.2018.07.20.14.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 14:41:58 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCHv3 0/2] Stackleak for arm64
Date:   Fri, 20 Jul 2018 14:41:52 -0700
Message-Id: <20180720214154.2940-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1531341400-12077-1-git-send-email-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the version of stackleak for arm64, hopefully ready for queueing

Laura Abbott (2):
  arm64: Add stack information to on_accessible_stack
  arm64: Add support for STACKLEAK gcc plugin

 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/processor.h    | 15 ++++++
 arch/arm64/include/asm/sdei.h         |  9 ++--
 arch/arm64/include/asm/stacktrace.h   | 73 ++++++++++++++++++++++-----
 arch/arm64/kernel/entry.S             |  7 +++
 arch/arm64/kernel/process.c           | 22 ++++++++
 arch/arm64/kernel/ptrace.c            |  2 +-
 arch/arm64/kernel/sdei.c              | 51 ++++++++++++++++---
 arch/arm64/kernel/stacktrace.c        |  2 +-
 arch/arm64/kvm/hyp/Makefile           |  3 +-
 drivers/firmware/efi/libstub/Makefile |  3 +-
 11 files changed, 161 insertions(+), 27 deletions(-)

-- 
2.17.1

