Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E663C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1599B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lay2ZKDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1599B20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbeGYTN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbeGYTN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:13:56 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE6BA20891;
        Wed, 25 Jul 2018 18:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541671;
        bh=jpL56V2Dg1dcc6+x2VJdOtrf3KK2R9nSNkSHWKDtWcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lay2ZKDAhJlAF/6uSkbiWjAnsvYDcCSkC+l9pZDHL06+0s5aoT3gysTfTJt+9Ngcq
         4LLVFaHALfWJaF6l1A03aO8quwS/kxeMPEzLVjx4YsR1RhvsSn/i8ZFep6UCl0Vo7K
         kYWCA+EIIzjyAExa+u5Ge/Ink7dO8iaFKixQzDcA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/27] perf kvm: Fix subcommands on s390
Date:   Wed, 25 Jul 2018 14:59:43 -0300
Message-Id: <20180725180001.15108-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

With commit eca0fa28cd0d ("perf record: Provide detailed information on
s390 CPU") s390 platform provides detailed type/model/capacity
information in the CPU identifier string instead of just "IBM/S390".

This breaks 'perf kvm' support which uses hard coded string IBM/S390 to
compare with the CPU identifier string. Fix this by changing the
comparison.

Reported-by: Stefan Raspl <raspl@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Tested-by: Stefan Raspl <raspl@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: stable@vger.kernel.org
Fixes: eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
Link: http://lkml.kernel.org/r/20180712070936.67547-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/kvm-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index d233e2eb9592..aaabab5e2830 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -102,7 +102,7 @@ const char * const kvm_skip_events[] = {
 
 int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
 {
-	if (strstr(cpuid, "IBM/S390")) {
+	if (strstr(cpuid, "IBM")) {
 		kvm->exit_reasons = sie_exit_reasons;
 		kvm->exit_reasons_isa = "SIE";
 	} else
-- 
2.14.4

