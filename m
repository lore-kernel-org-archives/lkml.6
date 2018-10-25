Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF4ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3823E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3BwbED9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3823E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeJYTnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeJYTnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:43:09 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4D2020847;
        Thu, 25 Oct 2018 11:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465851;
        bh=wUMRfJpG5kvC+FATqjXQEDnUtQLVHY6tgqfjD8lYSm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3BwbED9q0VAk9ZrkL0gH4mkHGThO0+txEyXY2SGwCsjWBhHPKuBNUKDFKN5pwafn
         DP2vH5Poc6X8VHHYwOOeJXHPDhjtAjt2aZ+e5u7Q3lqfTmI2jJYRfgxyrb18vvseBy
         zjzxMqfJJRL1sj7IkTMMuGokj1l+tYbIiDb9PUjQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/37] perf jitdump: Add Sparc support.
Date:   Thu, 25 Oct 2018 08:09:57 -0300
Message-Id: <20181025111031.3440-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>

Signed-off-by: David S. Miller <davem@davemloft.net>
Link: http://lkml.kernel.org/r/20181016.211545.1487970139012324624.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/sparc/Makefile | 2 ++
 tools/perf/util/genelf.h       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/arch/sparc/Makefile b/tools/perf/arch/sparc/Makefile
index 7fbca175099e..275dea7ff59a 100644
--- a/tools/perf/arch/sparc/Makefile
+++ b/tools/perf/arch/sparc/Makefile
@@ -1,3 +1,5 @@
 ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 endif
+
+PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index de322d51c7fe..b72440bf9a79 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -29,6 +29,12 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 #elif defined(__powerpc__)
 #define GEN_ELF_ARCH	EM_PPC
 #define GEN_ELF_CLASS	ELFCLASS32
+#elif defined(__sparc__) && defined(__arch64__)
+#define GEN_ELF_ARCH	EM_SPARCV9
+#define GEN_ELF_CLASS	ELFCLASS64
+#elif defined(__sparc__)
+#define GEN_ELF_ARCH	EM_SPARC
+#define GEN_ELF_CLASS	ELFCLASS32
 #else
 #error "unsupported architecture"
 #endif
-- 
2.14.4

