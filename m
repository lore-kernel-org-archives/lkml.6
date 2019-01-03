Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E63DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E852A217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546532049;
	bh=2pQgefaRJBMVNefE426Tc3ekD1lfmw52GNUItpEqNas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b9+3m4SDqijZBdJzQBQ6sbvrXx6X7ZnzSRACAn1FSMN/35ShZc+3v0dxe296Q9GRB
	 HrWxr/4toxuVuvVil9DqKeGZxeUTZaxuErjYjjQ+sF/ImE63nUa+bsorfzkSJGBXbV
	 EgBitrCt5PgleZxIwmQbmyRzQBzETIUw0JLquwyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbfACQOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:14:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731332AbfACQN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:13:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62AA088E76;
        Thu,  3 Jan 2019 16:13:57 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BDC35D9D1;
        Thu,  3 Jan 2019 16:13:55 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 1/2] tools thermal tmon: Use -O3 instead of -O1 if available
Date:   Thu,  3 Jan 2019 17:13:49 +0100
Message-Id: <20190103161350.11446-2-jolsa@kernel.org>
In-Reply-To: <20190103161350.11446-1-jolsa@kernel.org>
References: <20190103161350.11446-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 03 Jan 2019 16:13:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using -O3 instead of -O1 if it's supported by compiler.

Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Markus Mayer <mmayer@broadcom.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/thermal/tmon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 89a2444c1df2..59e417ec3e13 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -6,7 +6,7 @@ VERSION = 1.0
 
 BINDIR=usr/bin
 WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
-override CFLAGS+= -O1 ${WARNFLAGS}
+override CFLAGS+= $(call cc-option,-O3,-O1) ${WARNFLAGS}
 # Add "-fstack-protector" only if toolchain supports it.
 override CFLAGS+= $(call cc-option,-fstack-protector-strong)
 CC?= $(CROSS_COMPILE)gcc
-- 
2.17.2

