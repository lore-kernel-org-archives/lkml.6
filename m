Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821ADC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5A22084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544610358;
	bh=Cx7zNT/hAF7D8y7XqDvouKYC5r9IbvwZTVlt+E+u+lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ee3GepTCl97PWrZLF9nBnrnGe5zegD7PRQ2OZKEDHHapQ8YCVaLh/I0HNwMQ+c8Hv
	 CoH56EpvtX+wBBmiV3qg8yOdp9EQZcMGsSqNRt9RF6v8E4j5n5a9MTqZzkUGS58YiU
	 SloaPeHVy9cTqa0oiHloDUwwF9sBg5Sr7JJGBI8Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5A22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeLLKZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:25:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbeLLKZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:25:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A4CD118EA4;
        Wed, 12 Dec 2018 10:25:56 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B4A15D9C8;
        Wed, 12 Dec 2018 10:25:49 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Andy@vger.kernel.org, Len Brown <len.brown@intel.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: [PATCH 4/6] tools power turbostat: Override CFLAGS assignments and add LDFLAGS to build command
Date:   Wed, 12 Dec 2018 11:25:35 +0100
Message-Id: <20181212102537.25902-5-jolsa@kernel.org>
In-Reply-To: <20181212102537.25902-1-jolsa@kernel.org>
References: <20181212102537.25902-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 12 Dec 2018 10:25:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So user could specify outside CFLAGS/LDFLAGS values.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/power/x86/turbostat/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index 2ab25aa38263..1598b4fa0b11 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -9,13 +9,13 @@ ifeq ("$(origin O)", "command line")
 endif
 
 turbostat : turbostat.c
-CFLAGS +=	-Wall
-CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
-CFLAGS +=	-DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"'
+override CFLAGS +=	-Wall
+override CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
+override CFLAGS +=	-DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"'
 
 %: %.c
 	@mkdir -p $(BUILD_OUTPUT)
-	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@
+	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS)
 
 .PHONY : clean
 clean :
-- 
2.17.2

