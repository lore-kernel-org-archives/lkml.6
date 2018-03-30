Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeC3BdF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 21:33:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:18372 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbeC3BdE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 21:33:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="212506258"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 0/6] Support perf -vv
Date: Fri, 30 Mar 2018 17:27:10 +0800
Message-Id: <1522402036-22915-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We keep having bug reports that when users build perf on their own,
but they don't install some needed libraries such as libelf,
libbfd/libibery.

The perf can build, but it is missing important functionality. And
users may complain that perf has issue or bug.

This patch-set support to print the status of compiled-in libraries.

Once users think perf missing some functionality, it should be very
easy for them to check the libraries status.

For example:

$ ./perf version --build-options
    or
  ./perf --version --build-options
    or
  ./perf -v --build-options
    or
  ./perf -vv

perf version 4.13.rc5.g6727c5
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                  gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
              libaudit: [ OFF ]  # HAVE_LIBAUDIT_SUPPORT
                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT

v4:
---
1. Also print the macro name. That would make it easier
   to grep around in the source looking for where code
   related a particular features is located.

2. Update since HAVE_DWARF_GETLOCATIONS is renamed to
   HAVE_DWARF_GETLOCATIONS_SUPPORT

Patch impacted:
---------------
  perf config: Rename to HAVE_DWARF_GETLOCATIONS_SUPPORT
  perf version: Print the compiled-in status of libraries
  others not changed

Jin Yao (5):
  perf config: Add some new -DHAVE_XXX to CFLAGS
  perf config: Rename to HAVE_DWARF_GETLOCATIONS_SUPPORT
  perf version: Print the compiled-in status of libraries
  perf: Support perf -vv
  perf Documentation: Create perf-version.txt

Jiri Olsa (1):
  tools include: Add config.h header file

 tools/include/tools/config.h              | 34 +++++++++++++
 tools/perf/Documentation/perf-version.txt | 24 +++++++++
 tools/perf/Makefile.config                |  8 ++-
 tools/perf/builtin-version.c              | 82 ++++++++++++++++++++++++++++++-
 tools/perf/perf.c                         |  6 +++
 tools/perf/perf.h                         |  1 +
 tools/perf/util/dwarf-aux.c               |  2 +-
 7 files changed, 154 insertions(+), 3 deletions(-)
 create mode 100644 tools/include/tools/config.h
 create mode 100644 tools/perf/Documentation/perf-version.txt

-- 
2.7.4
