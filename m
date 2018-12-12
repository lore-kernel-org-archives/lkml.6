Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398DCC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F305E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544610349;
	bh=bZ28eKO/N6RXwKRtfBART9plCqgu9HSmTGM46qOPjL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ej7ub0ru7Xf/1Tym/CapOoG5v71EpgEiDylVGkOvdq3uBHG/4G67hUW31VLYJVRAi
	 BsW+iuTE2/pnYUSJcEwyjGUB1IM18/4jeAegXIFPRIM3zP1WnptLsc3Ar21EL56W1a
	 yc5ZKk2WBfIMcFQVeu9sZqNDbTXzNgTXNG9eb4OY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F305E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeLLKZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:25:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbeLLKZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:25:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 031D4308428D;
        Wed, 12 Dec 2018 10:25:46 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F22D55E7D9;
        Wed, 12 Dec 2018 10:25:44 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: [PATCH 1/6] tools power x86_energy_perf_policy: Override CFLAGS assignments and add LDFLAGS to build command
Date:   Wed, 12 Dec 2018 11:25:32 +0100
Message-Id: <20181212102537.25902-2-jolsa@kernel.org>
In-Reply-To: <20181212102537.25902-1-jolsa@kernel.org>
References: <20181212102537.25902-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 12 Dec 2018 10:25:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So user could specify outside CFLAGS/LDFLAGS values.

Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/power/x86/x86_energy_perf_policy/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/Makefile b/tools/power/x86/x86_energy_perf_policy/Makefile
index f4534fb8b951..ae7a0e09b722 100644
--- a/tools/power/x86/x86_energy_perf_policy/Makefile
+++ b/tools/power/x86/x86_energy_perf_policy/Makefile
@@ -9,12 +9,12 @@ ifeq ("$(origin O)", "command line")
 endif
 
 x86_energy_perf_policy : x86_energy_perf_policy.c
-CFLAGS +=	-Wall
-CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
+override CFLAGS +=	-Wall
+override CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
 
 %: %.c
 	@mkdir -p $(BUILD_OUTPUT)
-	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@
+	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS)
 
 .PHONY : clean
 clean :
-- 
2.17.2

