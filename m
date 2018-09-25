Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D309C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA97D20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA97D20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbeIYPlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:41:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44849 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeIYPlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:41:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8P9YPMl3386486
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Sep 2018 02:34:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8P9YOWc3386483;
        Tue, 25 Sep 2018 02:34:24 -0700
Date:   Tue, 25 Sep 2018 02:34:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-c3khb9ac86s00qxzjrueomme@git.kernel.org>
Cc:     mingo@kernel.org, namhyung@kernel.org, dsahern@gmail.com,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, thiago.macieira@intel.com,
        jolsa@kernel.org, wangnan0@huawei.com, acme@redhat.com
Reply-To: adrian.hunter@intel.com, thiago.macieira@intel.com,
          jolsa@kernel.org, wangnan0@huawei.com, acme@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, namhyung@kernel.org, dsahern@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf python: Use -Wno-redundant-decls to build with
 PYTHON=python3
Git-Commit-ID: 24ef0fd0a1f389b156e6ef0edd71072728831bd9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  24ef0fd0a1f389b156e6ef0edd71072728831bd9
Gitweb:     https://git.kernel.org/tip/24ef0fd0a1f389b156e6ef0edd71072728831bd9
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 18 Sep 2018 16:08:02 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 10:25:13 -0300

perf python: Use -Wno-redundant-decls to build with PYTHON=python3

When building in ClearLinux using 'make PYTHON=python3' with gcc 8.2.1
it fails with:

    GEN      /tmp/build/perf/python/perf.so
  In file included from /usr/include/python3.7m/Python.h:126,
                   from /git/linux/tools/perf/util/python.c:2:
  /usr/include/python3.7m/import.h:58:24: error: redundant redeclaration of ‘_PyImport_AddModuleObject’ [-Werror=redundant-decls]
   PyAPI_FUNC(PyObject *) _PyImport_AddModuleObject(PyObject *, PyObject *);
                          ^~~~~~~~~~~~~~~~~~~~~~~~~
  /usr/include/python3.7m/import.h:47:24: note: previous declaration of ‘_PyImport_AddModuleObject’ was here
   PyAPI_FUNC(PyObject *) _PyImport_AddModuleObject(PyObject *name,
                          ^~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  error: command 'gcc' failed with exit status 1

And indeed there is a redundant declaration in that Python.h file, one
with parameter names and the other without, so just add
-Wno-error=redundant-decls to the python setup instructions.

Now perf builds with gcc in ClearLinux with the following Dockerfile:

  # docker.io/acmel/linux-perf-tools-build-clearlinux:latest
  FROM docker.io/clearlinux:latest
  MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
  RUN swupd update && \
      swupd bundle-add sysadmin-basic-dev
  RUN mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
      groupadd -r perfbuilder && \
      useradd -m -r -g perfbuilder perfbuilder && \
      chown -R perfbuilder.perfbuilder /tmp/build/ /git/
  USER perfbuilder
  COPY rx_and_build.sh /
  ENV EXTRA_MAKE_ARGS=PYTHON=python3
  ENTRYPOINT ["/rx_and_build.sh"]

Now to figure out why the build fails with clang, that is present in the
above container as detected by the rx_and_build.sh script:

  clang version 6.0.1 (tags/RELEASE_601/final)
  Target: x86_64-unknown-linux-gnu
  Thread model: posix
  InstalledDir: /usr/sbin
  make: Entering directory '/git/linux/tools/perf'
    BUILD:   Doing 'make -j4' parallel build
    HOSTCC   /tmp/build/perf/fixdep.o
    HOSTLD   /tmp/build/perf/fixdep-in.o
    LINK     /tmp/build/perf/fixdep

  Auto-detecting system features:
  ...                         dwarf: [ OFF ]
  ...            dwarf_getlocations: [ OFF ]
  ...                         glibc: [ OFF ]
  ...                          gtk2: [ OFF ]
  ...                      libaudit: [ OFF ]
  ...                        libbfd: [ OFF ]
  ...                        libelf: [ OFF ]
  ...                       libnuma: [ OFF ]
  ...        numa_num_possible_cpus: [ OFF ]
  ...                       libperl: [ OFF ]
  ...                     libpython: [ OFF ]
  ...                      libslang: [ OFF ]
  ...                     libcrypto: [ OFF ]
  ...                     libunwind: [ OFF ]
  ...            libdw-dwarf-unwind: [ OFF ]
  ...                          zlib: [ OFF ]
  ...                          lzma: [ OFF ]
  ...                     get_cpuid: [ OFF ]
  ...                           bpf: [ OFF ]

  Makefile.config:331: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
  make[1]: *** [Makefile.perf:206: sub-make] Error 2
  make: *** [Makefile:70: all] Error 2
  make: Leaving directory '/git/linux/tools/perf'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thiago Macieira <thiago.macieira@intel.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-c3khb9ac86s00qxzjrueomme@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 97efbcad076e..1942f6dd24f6 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -35,7 +35,7 @@ class install_lib(_install_lib):
 
 cflags = getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
-cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter' ]
+cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
 if cc != "clang":
     cflags += ['-Wno-cast-function-type' ]
 
