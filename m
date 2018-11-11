Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC89C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2611A20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2611A20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeKLGWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:22:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50198 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730292AbeKLFsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:17 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsd-0000oG-Td; Sun, 11 Nov 2018 19:58:47 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsb-0001ty-1X; Sun, 11 Nov 2018 19:58:45 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Namhyung Kim" <namhyung@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Jiri Olsa" <jolsa@kernel.org>, "David Ahern" <dsahern@gmail.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.999645478@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 366/366] perf tools: Fix python extension build for gcc 8
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit b7a313d84e853049062011d78cb04b6decd12f5c upstream.

The gcc 8 compiler won't compile the python extension code with the
following errors (one example):

  python.c:830:15: error: cast between incompatible  function types from              \
  ‘PyObject * (*)(struct pyrf_evsel *, PyObject *, PyObject *)’                       \
  uct _object * (*)(struct pyrf_evsel *, struct _object *, struct _object *)’} to     \
  ‘PyObject * (*)(PyObject *, PyObject *)’ {aka ‘struct _object * (*)(struct _objeuct \
  _object *)’} [-Werror=cast-function-type]
     .ml_meth  = (PyCFunction)pyrf_evsel__open,

The problem with the PyMethodDef::ml_meth callback is that its type is
determined based on the PyMethodDef::ml_flags value, which we set as
METH_VARARGS | METH_KEYWORDS.

That indicates that the callback is expecting an extra PyObject* arg, and is
actually PyCFunctionWithKeywords type, but the base PyMethodDef::ml_meth type
stays PyCFunction.

Previous gccs did not find this, gcc8 now does. Fixing this by silencing this
warning for python.c build.

Commiter notes:

Do not do that for CC=clang, as it breaks the build in some clang
versions, like the ones in fedora up to fedora27:

  fedora:25:error: unknown warning option '-Wno-cast-function-type'; did you mean '-Wno-bad-function-cast'? [-Werror,-Wunknown-warning-option]
  fedora:26:error: unknown warning option '-Wno-cast-function-type'; did you mean '-Wno-bad-function-cast'? [-Werror,-Wunknown-warning-option]
  fedora:27:error: unknown warning option '-Wno-cast-function-type'; did you mean '-Wno-bad-function-cast'? [-Werror,-Wunknown-warning-option]
  #

those have:

  clang version 3.9.1 (tags/RELEASE_391/final)

The one in rawhide accepts that:

  clang version 6.0.0 (tags/RELEASE_600/final)

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Link: http://lkml.kernel.org/r/20180319082902.4518-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/perf/util/setup.py | 2 ++
 1 file changed, 2 insertions(+)

--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -21,6 +21,7 @@ class install_lib(_install_lib):
 cflags = getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
 cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter' ]
+cflags += ['-Wno-cast-function-type' ]
 
 build_lib = getenv('PYTHON_EXTBUILD_LIB')
 build_tmp = getenv('PYTHON_EXTBUILD_TMP')

