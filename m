Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xUOFMNLqGFuyZgAAmS7hNA
	; Thu, 07 Jun 2018 08:22:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4BA63607F7; Thu,  7 Jun 2018 08:22:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7D563601B4;
	Thu,  7 Jun 2018 08:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D563601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932589AbeFGIWQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:22:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42381 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932198AbeFGIWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:22:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578M96t2126295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:22:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578M8a42126290;
        Thu, 7 Jun 2018 01:22:08 -0700
Date: Thu, 7 Jun 2018 01:22:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-dbcb82b93f3e8322891e47472c89e63058b81e99@git.kernel.org>
Cc: mingo@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <1527762225-26024-2-git-send-email-adrian.hunter@intel.com>
References: <1527762225-26024-2-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf intel-pt: Fix sync_switch
 INTEL_PT_SS_NOT_TRACING
Git-Commit-ID: dbcb82b93f3e8322891e47472c89e63058b81e99
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

Commit-ID:  dbcb82b93f3e8322891e47472c89e63058b81e99
Gitweb:     https://git.kernel.org/tip/dbcb82b93f3e8322891e47472c89e63058b81e99
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 31 May 2018 13:23:42 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:52:07 -0300

perf intel-pt: Fix sync_switch INTEL_PT_SS_NOT_TRACING

sync_switch is a facility to synchronize decoding more closely with the
point in the kernel when the context actually switched.

In one case, INTEL_PT_SS_NOT_TRACING state was not correctly
transitioning to INTEL_PT_SS_TRACING state due to a missing case clause.
Add it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1527762225-26024-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 492986a25ef6..3db7f0ee52a8 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1521,6 +1521,7 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 
 	if (intel_pt_is_switch_ip(ptq, state->to_ip)) {
 		switch (ptq->switch_state) {
+		case INTEL_PT_SS_NOT_TRACING:
 		case INTEL_PT_SS_UNKNOWN:
 		case INTEL_PT_SS_EXPECTING_SWITCH_IP:
 			err = intel_pt_next_tid(pt, ptq);
