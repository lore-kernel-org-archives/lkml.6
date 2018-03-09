Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeCIIs3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:48:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59905 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeCIIs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:48:26 -0500
Date: Fri, 9 Mar 2018 00:48:19 -0800
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-1c196a6c771c47a2faa63d38d913e03284f73a16@git.kernel.org>
Cc: tglx@linutronix.de, jolsa@redhat.com, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com
Reply-To: tglx@linutronix.de, jolsa@redhat.com, mingo@kernel.org,
        acme@redhat.com, linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com
In-Reply-To: <1520431349-30689-4-git-send-email-adrian.hunter@intel.com>
References: <1520431349-30689-4-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Fix error recovery from missing TIP
 packet
Git-Commit-ID: 1c196a6c771c47a2faa63d38d913e03284f73a16
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

Commit-ID:  1c196a6c771c47a2faa63d38d913e03284f73a16
Gitweb:     https://git.kernel.org/tip/1c196a6c771c47a2faa63d38d913e03284f73a16
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 7 Mar 2018 16:02:23 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:55 -0300

perf intel-pt: Fix error recovery from missing TIP packet

When a TIP packet is expected but there is a different packet, it is an
error. However the unexpected packet might be something important like a
TSC packet, so after the error, it is necessary to continue from there,
rather than the next packet. That is achieved by setting pkt_step to
zero.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1520431349-30689-4-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 00f25f4b5f48..5e4d0bbafc8b 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1616,6 +1616,7 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PWRX:
 			intel_pt_log("ERROR: Missing TIP after FUP\n");
 			decoder->pkt_state = INTEL_PT_STATE_ERR3;
+			decoder->pkt_step = 0;
 			return -ENOENT;
 
 		case INTEL_PT_OVF:
