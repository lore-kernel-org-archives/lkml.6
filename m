Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB23C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD7F21477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag7R6ubf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD7F21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeJEXJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEXJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:09:58 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47001208E7;
        Fri,  5 Oct 2018 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538755837;
        bh=ISJhP+8fLpA30HRsmsEDKO0AbOV8UxkW9KDWipFinAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ag7R6ubf0wDUhchWUlq/tQO8O0z5rAtnLCVkizOkfUhtUsZCK0ChJOXCqHU1zsz9P
         qel6EikXEC12bKdFIJasoudepW0/gshZz8H/oUWvX1fdB1E3gs6TvFjr9e7/4hEGZI
         6ecgNapA4rpF7FeWSao/kp85flJ1+Mu/3MbsOuZk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thiago Macieira <thiago.macieira@intel.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 4/5] perf python: Use -Wno-redundant-decls to build with PYTHON=python3
Date:   Fri,  5 Oct 2018 13:10:11 -0300
Message-Id: <20181005161012.18475-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181005161012.18475-1-acme@kernel.org>
References: <20181005161012.18475-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 
-- 
2.14.4

