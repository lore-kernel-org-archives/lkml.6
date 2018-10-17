Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1BCECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5B221476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5B221476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeJRDGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:06:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46924 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbeJRDGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:06:05 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 680AF133E9F86;
        Wed, 17 Oct 2018 12:09:00 -0700 (PDT)
Date:   Wed, 17 Oct 2018 12:08:59 -0700 (PDT)
Message-Id: <20181017.120859.2268840244308635255.davem@davemloft.net>
To:     acme@redhat.com
CC:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf: Set PLT entry/header sizes properly on Sparc.
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 17 Oct 2018 12:09:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Using the sh_entsize for both values isn't correct.  It happens
to be correct on x86...

For both 32-bit and 64-bit sparc, there are four PLT entries in the
PLT section.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 tools/perf/util/symbol-elf.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 29770ea61768..6e70cc00c161 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -324,7 +324,17 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 			plt_entry_size = 16;
 			break;
 
-		default: /* FIXME: s390/alpha/mips/parisc/poperpc/sh/sparc/xtensa need to be checked */
+		case EM_SPARC:
+			plt_header_size = 48;
+			plt_entry_size = 12;
+			break;
+
+		case EM_SPARCV9:
+			plt_header_size = 128;
+			plt_entry_size = 32;
+			break;
+
+		default: /* FIXME: s390/alpha/mips/parisc/poperpc/sh/xtensa need to be checked */
 			plt_header_size = shdr_plt.sh_entsize;
 			plt_entry_size = shdr_plt.sh_entsize;
 			break;
-- 
2.19.1.328.g5a0cc8aca

