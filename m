Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7839EECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0204921522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="icNzbWcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0204921522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbeITDot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:44:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34891 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbeITDos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:44:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so6190568edq.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WWj2L2WQXo7BL7l3DmKOuE0YLVjmMR3vjyM0Ya9gp60=;
        b=icNzbWcb8UfIHdfHEQAFD3YVOvuXgi1uJv+bgYLkN6nd2Isn6GqQnvOr9NUz3PAdZQ
         DJm9zRD1NtKu8txbyqMFedd3IQlDZ/ZpcM1mx5qEx2ABgXYmnW0qYejXY+K87aCNdy2O
         ye9GO6xLn8k2ngjjTnmAUPtfm/NYQNqy5wZ7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WWj2L2WQXo7BL7l3DmKOuE0YLVjmMR3vjyM0Ya9gp60=;
        b=GQY3S35Dq/uv75smaUycBOmdOzQtqxf80hQIF2Sy1f1I0SXMXG+3C5TgH/NPIojeZp
         Zq3vu3G/bLXFqS/K4+frj/wSGB3akoMtj8ycTYAndnpq2oQiWo+M72o4w+VVDtb+dOl2
         POhl35A97UG1ZVLyfDVFwQET4Fg/e20arTtZMUaNIMTR+SGc8cSOXch2dkrXcMH3JzHW
         ae4Rvl8X43H6Q8602m7mJ63oQ5UHRcrGMeDmr3t99LGz1XAsSB5ZfBp8FtMUFHFa8T7T
         8YMNJpJWMtfZkKJ3g0lnfn8FQabcX8ZeI1IUqjSyLCZAikBhrAAZjfMn5T3z4SuC45XK
         LJxw==
X-Gm-Message-State: APzg51B2bcuHC/JGUveeYMSMBdD8c6cLtj9cdYJVkLpyly3pwi/rj0V6
        1MBCRzgLEG1mA0Z6/mJJV5or1w==
X-Google-Smtp-Source: ANB0VdbdbNhiS6ro/yQl2J8IMflK6qxvybrRmg8nhXBrvos30+ZGYVDQpXiqZ+XvpSU/XZkCJHsGVw==
X-Received: by 2002:a50:b5e6:: with SMTP id a93-v6mr61288901ede.94.1537394690539;
        Wed, 19 Sep 2018 15:04:50 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:04:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 00/22] various dynamic_debug patches
Date:   Thu, 20 Sep 2018 00:04:22 +0200
Message-Id: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This started as an experiment to see how hard it would be to change
the four pointers in struct _ddebug into relative offsets, a la
CONFIG_GENERIC_BUG_RELATIVE_POINTERS, thus saving 16 bytes per
pr_debug site (and thus exactly making up for the extra space used by
the introduction of jump labels in 9049fc74). I stumbled on a few
things that are probably worth fixing regardless of whether the latter
half of this series is deemed worthwhile.

Patch relationships: 1-2, 3-4, 5-6 and 15-16 can be applied
individually, though 2, 4 and 6 probably makes most sense in the
context of the final goal of the series.

7-12 I believe make sense on their own. Patch 13 again only makes
sense if we go all the way, and 14 and 17 depend on 13.

18-21 are more preparatory patches, and finally 22 switch over x86-64
to use CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS. I've tested that the
end result boots under virtme and that the dynamic_debug control file
has the expected contents.

Rasmus Villemoes (22):
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
  x86: jump_label: introduce ASM_STATIC_KEY_INIT_{TRUE,FALSE}
  x86_64: use relative pointers with dynamic debug

 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/dynamic_debug.h |  35 +++++++++
 arch/x86/include/asm/jump_label.h    |  18 +++++
 fs/btrfs/ctree.h                     |  34 +++------
 include/linux/acpi.h                 |  11 +--
 include/linux/device.h               |   6 +-
 include/linux/dynamic_debug.h        | 126 +++++++++++++++++++--------------
 include/linux/jump_label.h           |   2 +
 include/linux/net.h                  |   6 +-
 include/linux/printk.h               |   6 +-
 kernel/module.c                      |   6 +-
 lib/Kconfig.debug                    |   3 +
 lib/dynamic_debug.c                  | 133 ++++++++++++++++++++++++-----------
 13 files changed, 251 insertions(+), 136 deletions(-)
 create mode 100644 arch/x86/include/asm/dynamic_debug.h

-- 
2.16.4

