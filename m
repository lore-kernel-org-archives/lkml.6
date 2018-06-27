Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5C0C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B2225CAC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+ncVKpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B2225CAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935037AbeF0QGK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:06:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55293 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934916AbeF0QGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:06:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so6416125wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=d07Srbly/tt/fvCsX1MMBKhoekqXeQyhFpS+MSSA/fE=;
        b=h+ncVKpLgZIVoT/zoAtsE24msoiNglHONdMxZzbpI1BQ+XxcDh2PiyT/VO6D/Elplk
         8xQkHSC/UO5Wb/Yk4LNtTk8XucIlCfg1gDIqSote/nBy0xa92Wxxhlga02pBGLlYgCE8
         VyX5zPnwwOg1nWzwOBJG886N4/wWq+55K/A9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d07Srbly/tt/fvCsX1MMBKhoekqXeQyhFpS+MSSA/fE=;
        b=CsaCVOSxB+Bhifh6lfZS3hgEesWv8lW3pxt87OAjLvor/gtCaLPhFdGGB2yijoSnFY
         4X68pob26mVTCUYQIeptO6+Fcoi3cIbL0Kmi4JQjCf62Spqdd+/P+5dGna/xMnghy4iE
         uw5jZNpR5qZS0BqegwULMuozVWU3KIeGrPjP//Fg66/1C4F5Hw0lbFpKx+wm+7ORr01U
         KFvs07DQFVWUvVB5NEbYFKln7VgLVx63BBn9KyWmde5f+PP8FQhBiMr13Oof7qAdjUfb
         QtOeogbbSAguj5BYbfbM9tMsbzwAj7Ft6unZ836+Griu9/RUmdetxxD5ymPVBn8ZOhQt
         Hjgg==
X-Gm-Message-State: APt69E0y+/diDI3vNoIJDCRZMlZNvhMmdbPx2MbcnJUZQmMKDBVCKTz5
        1L2T9nmYu/TtujyqfwQlh9iPxr7oJTo=
X-Google-Smtp-Source: AAOMgpeSACZ0w/jO7ukwFwyslCNKlyGklCLyiHlq1CN/7rJn7MTFHJXmxzac97w0sNgLr1J3XGwX4g==
X-Received: by 2002:a1c:8010:: with SMTP id b16-v6mr1421618wmd.41.1530115567483;
        Wed, 27 Jun 2018 09:06:07 -0700 (PDT)
Received: from rev02.home ([2a01:cb1d:112:6f00:4d04:66e:dea8:5b23])
        by smtp.gmail.com with ESMTPSA id s2-v6sm7055000wrn.75.2018.06.27.09.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 09:06:06 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/5] add support for relative references in jump tables
Date:   Wed, 27 Jun 2018 18:05:59 +0200
Message-Id: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements support for emitting the data structures associated
with jump tables as 32-bit relative references instead of absolute
references, which take up more space on builds that target 64-bit
architectures, or implement self relocation [or both].

This series enables it for arm64 and x86, although other architectures
might benefit as well.

Patch #1 does some preparatory refactoring before patch #2 introduces the
generic pieces required for using relative references.

Patch #3 wires everything up for arm64.

For x86, patch #4 applies some preparatory changes for the arch specific
jump label C code, which is a lot more involved than on arm64, which is
why it is split off in this case. Patch #5 wires it up for x86 as well.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>

Ard Biesheuvel (5):
  kernel/jump_label: abstract jump_entry member accessors
  kernel/jump_label: implement generic support for relative references
  arm64/kernel: jump_label: switch to relative references
  x86: jump_label: switch to jump_entry accessors
  x86/kernel: jump_table: use relative references

 arch/Kconfig                        |  3 +
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/jump_label.h | 16 ++---
 arch/arm64/kernel/jump_label.c      |  6 +-
 arch/x86/Kconfig                    |  1 +
 arch/x86/include/asm/jump_label.h   | 28 +++------
 arch/x86/kernel/jump_label.c        | 43 +++++++------
 include/linux/jump_label.h          | 64 ++++++++++++++++++++
 kernel/jump_label.c                 | 56 ++++++++++-------
 tools/objtool/special.c             |  4 +-
 10 files changed, 145 insertions(+), 77 deletions(-)

-- 
2.11.0

