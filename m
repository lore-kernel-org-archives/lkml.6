Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeENE26 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 00:28:58 -0400
Received: from gandharva.secretlabs.de ([5.9.72.18]:18545 "EHLO
        gandharva.secretlabs.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeENE2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 00:28:09 -0400
From: Holger Freyther <automatic+kernel@freyther.de>
To: linux-kernel@vger.kernel.org
Cc: Holger Hans Peter Freyther <holgar+kernel@google.com>
Subject: [RFC 0/6] perf probe: Attempt to improve C++ probing
Date: Mon, 14 May 2018 12:19:34 +0800
Message-Id: <20180514041940.96126-1-automatic+kernel@freyther.de>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holger Hans Peter Freyther <holgar+kernel@google.com>

Currently perf probe -x app --funcs will list and demangle C++ functions
but the other probe actions can't work with them. When asking probe to not
demangle it will not list any of the application symbols creating the
impression that there are no symbols at all.

Make --funcs --no-demangle list all C++ functions and modify the handling
for listing code, variables and adding the uprobe work with the demangled
C++ function name.

I tried to keep this as minimal as possible but having to keep the dso in
the debuginfo and passing it everywhere to be able to demangle the linkage
name isn't pretty (and for C++ demangling the struct dso is not of much
use. Maybe having a static "empty" dso could avoid a lot of the changes).

Maybe the easiest first patch is to default to --no-demangle and change
the DEFAULT_FUNC_FILTER to not include mangled C++ symbols. The remaining
tooling would work then.

This has seen very little testing outside the following commands.

My test set includes:

 ./perf probe -x . -L "std::vector<int, std::allocator<int> >::at"
 ./perf probe -x . -L "std::vector<int, std::allocator<int> >::at:2-3"

 ./perf probe -x . -V "std::vector<int, std::allocator<int> >::at"
 ./perf probe -x . -V "std::vector<int, std::allocator<int> >::at:2"
 ./perf probe -x . -V "std::vector<int, std::allocator<int> >::size%return"


Holger Hans Peter Freyther (6):
  perf probe: Do not exclude mangled C++ funcs
  perf probe: Parse linerange for C++ functions
  perf probe: Make listing of C++ functions work
  perf probe: Show variables for C++ functions
  perf probe: Make listing of variables work for C++ functions
  perf probe: Make it possible to add a C++ uprobe

 tools/perf/builtin-probe.c     |   2 +-
 tools/perf/util/probe-event.c  |  77 ++++++++++++++++++++-
 tools/perf/util/probe-finder.c | 152 ++++++++++++++++++++++++++++++-----------
 tools/perf/util/probe-finder.h |   3 +
 tools/perf/util/string.c       |  57 ++++++++++++++++
 tools/perf/util/string2.h      |   1 +
 6 files changed, 247 insertions(+), 45 deletions(-)

-- 
2.7.4
