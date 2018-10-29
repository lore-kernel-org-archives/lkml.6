Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F84CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE522082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab7KCGrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE522082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeJ2ThZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:37:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53064 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbeJ2ThY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:37:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so7693117wmw.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 03:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VxaIDmDKvxD8zCA2Wo/jH/VQ0KsaOQA2tHEfNNJ/B98=;
        b=ab7KCGrXY0SNzGLsTBF5QA6SsWR7BsSAeq8Q2qgfilrIpG6kG8LXidEmQCYkp6eqKv
         ZSlcqn8bDU4YSr4eP7sx0a/E/YEf4xjGQd4oEuHtkxpDnnHk2FDp+fUDn7yWnqpQ/nPY
         mJ1/WjlAsh32F0aBJjRa/tfUGkdJ+UWkzV3njgUcLEosuGQff8Qsmhfb7vK74gO3OsZl
         SYoBdidjXjzDBjCXl6BDrkzn1q60gLhjX+oIt9ohDskLTaZWDi28bp3Gfx/WN9FRD99H
         rH6jnzVL5Gvdr3M4djCnBqP5JskMccvkWMy0HwfaiZIQi3VH1G5vfN623/sydmhdxCpW
         CBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VxaIDmDKvxD8zCA2Wo/jH/VQ0KsaOQA2tHEfNNJ/B98=;
        b=VMeY2ZsFiQVa8GBMOY+odnxXZhAOPAJaN0/DTEdc/K6EeLSAWlHDyXsb5G559PeGfk
         bPe/a7w2BKqteyT8gVI+lpEaoH717ku77Lcue4kCjuPdLEOENoXC1/dsZa3wfKnSElpy
         Bm97+trHhKGvioQ+amP6KJRClql7ghdldv7SUhjv5C1oYSYr+/8qNJoSzZjjkFR0LJ60
         V2BI9DFQ06QS1lJO/XSRgoADkTmE/gad3TFfY8OnSfQhXcMN7n/OtulNY5JqoPoVS4kl
         GjibQcrMjsjDkDZSacH5sfV2GcwJEHcmVz5KWMw6vdMyY4NjQbXSH3MXGDECyUg0QC3m
         a5CA==
X-Gm-Message-State: AGRZ1gLVnrPkfPUxcVmWNQibe3nYO1hAlICbGaIS9l9o6PMD47g9e5Ir
        bm+fPY/Ji6+uvDoXkL2nanY=
X-Google-Smtp-Source: AJdET5ffCOZUi1i7jn75YGuW7Ap+v1xwv6E7UlC8mMt2ckkjWo402h3XC0g7E/6xXYo4IcdClLFq6w==
X-Received: by 2002:a1c:770a:: with SMTP id t10-v6mr1732171wmi.149.1540810155060;
        Mon, 29 Oct 2018 03:49:15 -0700 (PDT)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id l70-v6sm36360609wma.0.2018.10.29.03.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 03:49:14 -0700 (PDT)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH 0/2] riscv: add audit support
Date:   Mon, 29 Oct 2018 11:48:52 +0100
Message-Id: <20181029104854.17432-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds system call audit support on riscv (riscv32 &
riscv64).

The pachset was prepared on top of v4.19 tag.

audit-userspace changes were submitted. See:
https://github.com/linux-audit/audit-userspace/pull/73

Tested the following manually:
- auditctl (checked several different example rules from internet)
- aulast
- aulastlog
- ausearch
- ausyscall
- aureport
- autrace (compared some syscalls to strace: order and return 
  value/input arguments seem to be correct)
- /proc/self/loginuid (required by DNF [package manager])

I looked into audit-testsuite and with some adjustments results are:

Failed 4/14 test programs. 19/88 subtests failed.

The failing tests were due to missing CONFIG_IP_NF_MANGLE, 'id -Z' not 
printing categories (don't know why), not having loadable kernel module
support enablled and syscall_socketcall not being relevant for new arches.

audit-testsuite with adjustments:
https://github.com/davidlt/audit-testsuite/tree/riscv64

Depends on:
[PATCH 1/2] Move EM_RISCV into elf-em.h
http://lists.infradead.org/pipermail/linux-riscv/2018-October/001885.html

This should solve DNF issues in Fedora 29/RISCV.

David Abdurachmanov (2):
  riscv: add audit support
  riscv: audit: add audit hook in do_syscall_trace_enter/exit()

 arch/riscv/Kconfig                   |  1 +
 arch/riscv/include/asm/ptrace.h      |  5 +++++
 arch/riscv/include/asm/syscall.h     | 10 ++++++++++
 arch/riscv/include/asm/thread_info.h |  6 ++++++
 arch/riscv/kernel/entry.S            |  4 ++--
 arch/riscv/kernel/ptrace.c           |  5 +++++
 include/uapi/linux/audit.h           |  2 ++
 7 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.17.2

