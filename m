Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935595AbeEIUCi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 16:02:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45451 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935036AbeEIUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 16:02:36 -0400
X-Google-Smtp-Source: AB8JxZoE4e21/O/9xCirU4eu1of1QjCcyQBHzlnji0tnWJohv4PLQy+uyDwUzjz3XLa0AP/s29bDWw==
From: Kees Cook <keescook@chromium.org>
To: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: [PATCH v2 0/6] Provide saturating helpers for allocation
Date: Wed,  9 May 2018 13:02:17 -0700
Message-Id: <20180509200223.22451-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a stab at providing three new helpers for allocation size
calculation:

struct_size(), array_size(), and array3_size().

These are implemented on top of Rasmus's overflow checking functions. The
existing allocators are adjusted to use the more efficient overflow
checks as well.

I have left out the 8 tree-wide conversion patches of open-coded
multiplications into the new helpers, as those are largely
unchanged from v1. Everything can be seen here, though:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/overflow/array_size

The question remains for what to do with the *calloc() and *_array*()
API. They could be entirely removed in favor of using the new helpers:

kcalloc(n, size, gfp)        ->  kzalloc(array_size(n, size), gfp)
kmalloc_array(n, size, gfp)  ->  kmalloc(array_size(n, size), gfp)

Changes from v1:
- use explicit overflow helpers instead of array_size() helpers.
- drop early-checks for SIZE_MAX.
- protect devm_kmalloc()-family from addition overflow.
- added missing overflow.h includes.
- fixed 0-day issues in a few treewide manual conversions

-Kees
