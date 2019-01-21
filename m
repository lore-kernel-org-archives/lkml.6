Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80FEC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDD021721
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548095749;
	bh=+wDPidEflOfbLFSSH8eTvkY5MUUomPMUmGgm9DCGzRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o11u8c9FNT6UdNchoB7JN4MGpZN15eJiKpRUsBiCCr5ceMjO9/FHQvffWW39NZNrD
	 +1LzD29ShPurUdtoW/aUmHwSsV/Im/C/prh3A5fCi723UuRV4zQN9/lscs4PUaC2yH
	 kqvWIMWlUZcOlro7lnzzn2SKjxMh/d8CzBOhmsWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfAUSfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:35:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfAUSfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:35:46 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 954CD2089F;
        Mon, 21 Jan 2019 18:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548095746;
        bh=+wDPidEflOfbLFSSH8eTvkY5MUUomPMUmGgm9DCGzRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jo4UaIrcg0XPqkMNwxEZSDOLZmUuC4SFN5sKFtHjqSUJ8VrDQ24qXszQOxo5VWLlA
         FC07GTaqUTdZKt2QE4/4YUdHWdZPH/Py/pT7snQtsM7qbR6rxrQpxzGLm0OMLABse/
         pQ1fz7EOHQ4/pVvgqPZ4Ndfen1ZbBcvoyr3H2zjg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Thiago Macieira <thiago.macieira@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 4/7] perf python: Remove -fstack-clash-protection when building with some clang versions
Date:   Mon, 21 Jan 2019 15:35:04 -0300
Message-Id: <20190121183507.23490-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121183507.23490-1-acme@kernel.org>
References: <20190121183507.23490-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

These options are not present in some (all?) clang versions, so when we
build for a distro that has a gcc new enough to have these options and
that the distro python build config settings use them but clang doesn't
support, b00m.

This is the case with fedora rawhide (now gearing towards f30), so check
if clang has the  and remove the missing ones from CFLAGS.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thiago Macieira <thiago.macieira@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5q50q9w458yawgxf9ez54jbp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 63f758c655d5..64d1f36dee99 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -17,6 +17,8 @@ if cc == "clang":
             vars[var] = sub("-mcet", "", vars[var])
         if not clang_has_option("-fcf-protection"):
             vars[var] = sub("-fcf-protection", "", vars[var])
+        if not clang_has_option("-fstack-clash-protection"):
+            vars[var] = sub("-fstack-clash-protection", "", vars[var])
 
 from distutils.core import setup, Extension
 
-- 
2.20.1

