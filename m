Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A043C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E972063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976458;
	bh=GQZhYTfQbiLgV0u9OMuxy2R+Eqswi4te3uB6ECv1fEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DVxTcPgl58oSYh3x/QwOrt0M90y6kNjzZFNlVncrKplXWyraamBalgLADUJdFcmTi
	 aYboQQNLrZoHukVvDStirsZOofI6xqFo9Qv1R8oRk7y3dUkR5UfScxankf6kT/DImZ
	 XgArS1qsycseaZFsZT2O5DApsVkOHg9e6jr2QSbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbfAHTk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731998AbfAHTec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:34:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4FE205C9;
        Tue,  8 Jan 2019 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976071;
        bh=GQZhYTfQbiLgV0u9OMuxy2R+Eqswi4te3uB6ECv1fEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRuGDMUe3QIqew0+3sOfHyxlEvR2ivqkrDiXKI1XsdSjHiQNw+JNnolbtrnZh8ZNm
         ccKT6QlhPAE2wfN39leYhIoWkQKo+R9i87crYcNDj6g4xlr72Yr+AIA87zkYqJ5PTu
         xAuBG/a4qyt8FtdPTTle+Vl1KWq4HyI/EFBprUPo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 28/36] tools lib subcmd: Don't add the kernel sources to the include path
Date:   Tue,  8 Jan 2019 14:33:40 -0500
Message-Id: <20190108193348.123880-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193348.123880-1-sashal@kernel.org>
References: <20190108193348.123880-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit ece9804985b57e1ccd83b1fb6288520955a29d51 ]

At some point we decided not to directly include kernel sources files
when building tools/perf/, but when tools/lib/subcmd/ was forked from
tools/perf it somehow ended up adding it via these two lines in its
Makefile:

  CFLAGS += -I$(srctree)/include/uapi
  CFLAGS += -I$(srctree)/include

As $(srctree) points to the kernel sources.

Removing those lines and keeping just:

  CFLAGS += -I$(srctree)/tools/include/

Is enough to build tools/perf and tools/objtool.

This fixes the build when building from the sources in environments such
as the Android NDK crossbuilding from a fedora:26 system:

  subcmd-util.h:11:15: error: expected ',' or ';' before 'void'
   static inline void report(const char *prefix, const char *err, va_list params)
                 ^
  In file included from /git/perf/include/uapi/linux/stddef.h:2:0,
                   from /git/perf/include/uapi/linux/posix_types.h:5,
                   from /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/sys/types.h:36,
                   from /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/unistd.h:33,
                   from run-command.c:2:
  subcmd-util.h:18:17: error: '__no_instrument_function__' attribute applies only to functions

The /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/sys/types.h
file that includes linux/posix_types.h ends up getting the one in the kernel
sources causing the breakage. Fix it.

Test built tools/objtool/ too.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 4b6ab94eabe4 ("perf subcmd: Create subcmd library")
Link: https://lkml.kernel.org/n/tip-5lhaoecrj12t0bqwvpiu14sm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/subcmd/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index ce4b7e527566..a690d230c311 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -29,8 +29,6 @@ endif
 CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
 
 CFLAGS += -I$(srctree)/tools/include/
-CFLAGS += -I$(srctree)/include/uapi
-CFLAGS += -I$(srctree)/include
 
 SUBCMD_IN := $(OUTPUT)libsubcmd-in.o
 
-- 
2.19.1

