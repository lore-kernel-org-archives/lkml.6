Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D116FC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9825621476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ges/xvJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9825621476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbeJKXNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:13:43 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E37421470;
        Thu, 11 Oct 2018 15:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272757;
        bh=0xQ9OxmmXZ3G8YzudKU+xOX8QCHs/qwI2oe9k8kx180=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ges/xvJbdy1ZvtHoSgzwN+ZfKnM74jHg8w0q95cxnFeTXUm0r+j8vczS/Az60y3ab
         cXviu4jkdpG+gG1QOa4L4Lyw85+v9v7g2v+fFQHeP4KSQ/DCSHMXqOq+dKLHGVRBJx
         YeA8n8cIWV1GQIEzctzqm2vO8E4WXhnAWdcLD59o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH 4.14 28/45] perf tools: Fix python extension build for gcc 8
Date:   Thu, 11 Oct 2018 17:39:55 +0200
Message-Id: <20181011152510.105212304@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: Ignat Korchagin <ignat@cloudflare.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/setup.py |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -28,6 +28,8 @@ class install_lib(_install_lib):
 cflags = getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
 cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter' ]
+if cc != "clang":
+    cflags += ['-Wno-cast-function-type' ]
 
 src_perf  = getenv('srctree') + '/tools/perf'
 build_lib = getenv('PYTHON_EXTBUILD_LIB')


