Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeCIIsy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:48:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49531 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbeCIIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:48:53 -0500
Date: Fri, 9 Mar 2018 00:48:47 -0800
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-91d29b288aed3406caf7c454bf2b898c96cfd177@git.kernel.org>
Cc: jolsa@redhat.com, adrian.hunter@intel.com, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, acme@redhat.com,
        mingo@kernel.org
Reply-To: mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, adrian.hunter@intel.com,
        jolsa@redhat.com
In-Reply-To: <1520431349-30689-5-git-send-email-adrian.hunter@intel.com>
References: <1520431349-30689-5-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Fix timestamp following overflow
Git-Commit-ID: 91d29b288aed3406caf7c454bf2b898c96cfd177
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  91d29b288aed3406caf7c454bf2b898c96cfd177
Gitweb:     https://git.kernel.org/tip/91d29b288aed3406caf7c454bf2b898c96cfd177
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 7 Mar 2018 16:02:24 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:56 -0300

perf intel-pt: Fix timestamp following overflow

timestamp_insn_cnt is used to estimate the timestamp based on the number of
instructions since the last known timestamp.

If the estimate is not accurate enough decoding might not be correctly
synchronized with side-band events causing more trace errors.

However there are always timestamps following an overflow, so the
estimate is not needed and can indeed result in more errors.

Suppress the estimate by setting timestamp_insn_cnt to zero.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1520431349-30689-5-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 5e4d0bbafc8b..f9157aed1289 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1378,6 +1378,7 @@ static int intel_pt_overflow(struct intel_pt_decoder *decoder)
 	intel_pt_clear_tx_flags(decoder);
 	decoder->have_tma = false;
 	decoder->cbr = 0;
+	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
 	decoder->overflow = true;
 	return -EOVERFLOW;
