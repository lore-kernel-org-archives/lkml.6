Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D911C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D706520855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Cdtx45r3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D706520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeKJIxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:53:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41746 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJIxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:53:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so2964192ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPjpH8BD5tXsbeLiw4RR8hTDV7K4mxZhnb1hV0+Vj+U=;
        b=Cdtx45r3oFh/0Ysqb1UG2keFz4msRljIPU/DXGXsrjJZCxJlmitYmFYJrxXE4CLjvr
         8MdM2KyQzjAqXaBr73JPcmFr/7+4XwdZlo9Rjt3r00pllys2K30z4sIcQW3y+LUQd1qi
         fAn1NFXvvYIsJTKyrzMOqr41PnZwuCkQF1e4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPjpH8BD5tXsbeLiw4RR8hTDV7K4mxZhnb1hV0+Vj+U=;
        b=FXoZvMbYZnjDuokoX9IQUn1Cr/0EH5TGdnOeOo1raoW75wQacM2Z1oMldeiiThvipR
         GJxmKRbvj+OF70mxVlIVgPBXrnKP299Bh70Re5Ejd6iZcNZhKO5J1A2uAlEaJnYmotPM
         u6tVle7u3PkolfgChjMxXpI7QcGR4xhPskxOdkGyxFA0Ep8lIwlsl5taQMeCF4qUkShT
         pdzqlaoG72bNp6qi6S6zKp2NFfAt1v+ZvSTrz0y/SGfZNnh3tXkmMxncwRXnV4xQ5HLT
         61RJOhx+1xhTcr/FJlOz4ndTdFhVPFCmCoicg97ITvYWcWsrO+BSjAolCRKPK+hjcdI0
         xBjA==
X-Gm-Message-State: AGRZ1gKU2hMKnsYtY9DBpZ47EOnMc6zqlzWpBY00UMVmLFDrq2iglMMY
        UrdWI42XqFIUS07TZDoNvylQCQ==
X-Google-Smtp-Source: AJdET5fYEybtfZYsc5WszW/FPoGtD3Ct5Kkks1XOSCuSOWNRTu4qW8rsLQ9LS2QVTIX1ZvSyyFn5PQ==
X-Received: by 2002:a2e:8347:: with SMTP id l7-v6mr1863975ljh.140.1541805059753;
        Fri, 09 Nov 2018 15:10:59 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:10:59 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Sterba <dsterba@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-btrfs@vger.kernel.org,
        netdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v3 00/23] various dynamic_debug patches
Date:   Sat, 10 Nov 2018 00:09:58 +0100
Message-Id: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This started as an experiment to see how hard it would be to change
the four pointers in struct _ddebug into relative offsets, a la
CONFIG_GENERIC_BUG_RELATIVE_POINTERS, thus saving 16 bytes per
pr_debug site (and thus exactly making up for the extra space used by
the introduction of jump labels in 9049fc74). I stumbled on a few
things that are probably worth fixing regardless of whether that goal
is deemed worthwhile.

v2: Added various acks/reviews.

v3: Rebased on top of v4.20-rc1, and (consequently) reimplemented the
x86 part using Nadav's asm macro infrastructure. I've taken the
liberty of preserving acks/reviews for the first 20, since the rebase
was completely clean. OTOH, I've removed any acks/reviews from the
last three patches, since they are essentially completely new in this
version.

Since there are some interdependencies, it's simplest if these go
through the same tree. Andrew, can I get you to pick up patches 1
through 17? They should be ready for some time in -next. If and when
the last three (new) patches get ack'ed, I'll ask you to pick up the
last 6 (Jason has ack'ed 18-20, but they don't make much sense without
at least one arch opting in to use DYNAMIC_DEBUG_RELATIVE_POINTERS).

Rasmus Villemoes (23):
  linux/device.h: use DYNAMIC_DEBUG_BRANCH in dev_dbg_ratelimited
  linux/device.h: use unique identifier for each struct _ddebug
  linux/net.h: use DYNAMIC_DEBUG_BRANCH in net_dbg_ratelimited
  linux/net.h: use unique identifier for each struct _ddebug
  linux/printk.h: use DYNAMIC_DEBUG_BRANCH in pr_debug_ratelimited
  linux/printk.h: use unique identifier for each struct _ddebug
  dynamic_debug: consolidate DEFINE_DYNAMIC_DEBUG_METADATA definitions
  dynamic_debug: don't duplicate modname in ddebug_add_module
  dynamic_debug: use pointer comparison in ddebug_remove_module
  dynamic_debug: remove unused EXPORT_SYMBOLs
  dynamic_debug: move pr_err from module.c to ddebug_add_module
  dynamic_debug: add static inline stub for ddebug_add_module
  dynamic_debug: refactor dynamic_pr_debug and friends
  btrfs: implement btrfs_debug* in terms of helper macro
  ACPI: use proper DYNAMIC_DEBUG_BRANCH macro
  ACPI: remove unused __acpi_handle_debug macro
  ACPI: implement acpi_handle_debug in terms of _dynamic_func_call
  dynamic_debug: introduce accessors for string members of struct
    _ddebug
  dynamic_debug: drop use of bitfields in struct _ddebug
  dynamic_debug: introduce CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
  jump_label: move JUMP_TYPE_* constants to new asm-generic file
  x86: jump_label: introduce asm macros STATIC_KEY_INIT{,_TRUE,_FALSE}
  x86_64: use relative pointers with dynamic debug

 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/dynamic_debug.h |  58 ++++++++++++
 arch/x86/include/asm/jump_label.h    |  17 ++++
 arch/x86/kernel/macros.S             |   1 +
 fs/btrfs/ctree.h                     |  34 ++-----
 include/asm-generic/jump_label.h     |  11 +++
 include/linux/acpi.h                 |  11 +--
 include/linux/device.h               |   6 +-
 include/linux/dynamic_debug.h        | 126 +++++++++++++++----------
 include/linux/jump_label.h           |   6 +-
 include/linux/net.h                  |   6 +-
 include/linux/printk.h               |   6 +-
 kernel/module.c                      |   6 +-
 lib/Kconfig.debug                    |   3 +
 lib/dynamic_debug.c                  | 133 ++++++++++++++++++---------
 15 files changed, 284 insertions(+), 141 deletions(-)
 create mode 100644 arch/x86/include/asm/dynamic_debug.h
 create mode 100644 include/asm-generic/jump_label.h

-- 
2.19.1.6.gbde171bbf5

