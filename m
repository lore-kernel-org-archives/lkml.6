Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wpovIhjrGFuwZwAAmS7hNA
	; Thu, 07 Jun 2018 08:23:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 81D686089E; Thu,  7 Jun 2018 08:23:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 03DFD60115;
	Thu,  7 Jun 2018 08:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03DFD60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932616AbeFGIXR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:23:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932530AbeFGIXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:23:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578N8Y32126364
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:23:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578N8Ls2126361;
        Thu, 7 Jun 2018 01:23:08 -0700
Date: Thu, 7 Jun 2018 01:23:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-dd27b87ab5fcf3ea1c060b5e3ab5d31cc78e9f4c@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, acme@redhat.com,
        mingo@kernel.org
Reply-To: hpa@zytor.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, acme@redhat.com
In-Reply-To: <1527762225-26024-4-git-send-email-adrian.hunter@intel.com>
References: <1527762225-26024-4-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf intel-pt: Fix MTC timing after overflow
Git-Commit-ID: dd27b87ab5fcf3ea1c060b5e3ab5d31cc78e9f4c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  dd27b87ab5fcf3ea1c060b5e3ab5d31cc78e9f4c
Gitweb:     https://git.kernel.org/tip/dd27b87ab5fcf3ea1c060b5e3ab5d31cc78e9f4c
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 31 May 2018 13:23:44 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:52:08 -0300

perf intel-pt: Fix MTC timing after overflow

On some platforms, overflows will clear before MTC wraparound, and there
is no following TSC/TMA packet. In that case the previous TMA is valid.
Since there will be a valid TMA either way, stop setting 'have_tma' to
false upon overflow.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1527762225-26024-4-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index e5eb91777383..881d7c5e5e2a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1376,7 +1376,6 @@ static int intel_pt_overflow(struct intel_pt_decoder *decoder)
 {
 	intel_pt_log("ERROR: Buffer overflow\n");
 	intel_pt_clear_tx_flags(decoder);
-	decoder->have_tma = false;
 	decoder->cbr = 0;
 	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
