Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC858C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC762080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD33Bqso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC762080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404381AbeKVOOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404284AbeKVOOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:30 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAF2420684;
        Thu, 22 Nov 2018 03:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857824;
        bh=dXG57RcrwgAEisLlVUCXWsvq2v9mr2DDu1Ha3ISfLI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GD33Bqsop3SDAZmU1eX6skbZV9nRk/5TU//S29WkyW4RmOH7VGu0EaHbx61uDo5Ch
         Uw6Ds58C9XTwZCbvm73L53ZxLefGrDGcG9Ll0g8eNMKBzXh5Bfcd02lwXPplRe7XLr
         2wqhvbqx/56wI2Nxa0J7spp1bDH0oQXbgc/dwssU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/28] perf script: Add newline after uregs output
Date:   Thu, 22 Nov 2018 00:35:57 -0300
Message-Id: <20181122033611.15890-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

This change makes it much easier to easily distinguish between
consecutive samples by keeping the empty line between them, like we see
when we do not enable uregs output.

Before:

  cpp-inlining 28298 [-01] 54837.342780:    3068085 cycles:pp:
              7ffff7c96709 __hypot_finite+0xa9 (/usr/lib/libm-2.28.so)
              ...
   ABI:2    AX:0x0    BX:0x40f56cf6    CX:0x294a3ae7    ...
  cpp-inlining 28298 [-01] 54837.344493:    2881929 cycles:pp:
              7ffff7c96696 __hypot_finite+0x36 (/usr/lib/libm-2.28.so)
              ...
   ABI:2    AX:0x40d440c7    BX:0x40d440c7    CX:0x4d45e5da    ...

After:

  cpp-inlining 28298 [-01] 54837.342780:    3068085 cycles:pp:
              7ffff7c96709 __hypot_finite+0xa9 (/usr/lib/libm-2.28.so)
              ...
   ABI:2    AX:0x0    BX:0x40f56cf6    CX:0x294a3ae7    ...

  cpp-inlining 28298 [-01] 54837.344493:    2881929 cycles:pp:
              7ffff7c96696 __hypot_finite+0x36 (/usr/lib/libm-2.28.so)
              ...
   ABI:2    AX:0x40d440c7    BX:0x40d440c7    CX:0x4d45e5da    ...

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181107093705.16346-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b5bc85bd0bbe..daf73832743e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -603,6 +603,8 @@ static int perf_sample__fprintf_uregs(struct perf_sample *sample,
 		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
 
+	fprintf(fp, "\n");
+
 	return printed;
 }
 
-- 
2.14.5

