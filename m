Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FB7C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7F62241B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw8hEBt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7F62241B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390957AbeKLIX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390901AbeKLIX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:27 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 582552154B;
        Sun, 11 Nov 2018 22:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975609;
        bh=BUzHnzJnTqHcnTVxmHM/Z1xLyC46Ol1iXFXBYn7yjas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dw8hEBt/BdFdGBK4cb5W2DTLCovbxWUFWNddSpoMhVbDyCQ2vmdz9u98G0jzbDn/u
         svOZQdmt+gS+zo4JEAITSp/rujjuKXXzibo+zr+yZTU0dnFTTi3Qj/hvAtBvBeNxKv
         vcf0M5QDkkB0IifnVVqpxbw0LZO6WscKqENxAP/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 017/141] Revert "perf tools: Fix PMU term format max value calculation"
Date:   Sun, 11 Nov 2018 14:24:36 -0800
Message-Id: <20181111221630.126405657@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 1b9caa10b31dda0866f4028e4bfb923fb6e4072f ]

This reverts commit ac0e2cd555373ae6f8f3a3ad3fbbf5b6d1e7aaaa.

Michael reported an issue with oversized terms values assignment
and I noticed there was actually a misunderstanding of the max
value check in the past.

The above commit's changelog says:

  If bit 21 is set, there is parsing issues as below.

    $ perf stat -a -e uncore_qpi_0/event=0x200002,umask=0x8/
    event syntax error: '..pi_0/event=0x200002,umask=0x8/'
                                      \___ value too big for format, maximum is 511

But there's no issue there, because the event value is distributed
along the value defined by the format. Even if the format defines
separated bit, the value is treated as a continual number, which
should follow the format definition.

In above case it's 9-bit value with last bit separated:
  $ cat uncore_qpi_0/format/event
  config:0-7,21

Hence the value 0x200002 is correctly reported as format violation,
because it exceeds 9 bits. It should have been 0x102 instead, which
sets the 9th bit - the bit 21 of the format.

  $ perf stat -vv -a -e uncore_qpi_0/event=0x102,umask=0x8/
  Using CPUID GenuineIntel-6-2D
  ...
  ------------------------------------------------------------
  perf_event_attr:
    type                             10
    size                             112
    config                           0x200802
    sample_type                      IDENTIFIER
  ...

Reported-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: ac0e2cd55537 ("perf tools: Fix PMU term format max value calculation")
Link: http://lkml.kernel.org/r/20181003072046.29276-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/pmu.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -685,13 +685,14 @@ static void pmu_format_value(unsigned lo
 
 static __u64 pmu_format_max_value(const unsigned long *format)
 {
-	__u64 w = 0;
-	int fbit;
+	int w;
 
-	for_each_set_bit(fbit, format, PERF_PMU_FORMAT_BITS)
-		w |= (1ULL << fbit);
-
-	return w;
+	w = bitmap_weight(format, PERF_PMU_FORMAT_BITS);
+	if (!w)
+		return 0;
+	if (w < 64)
+		return (1ULL << w) - 1;
+	return -1;
 }
 
 /*


