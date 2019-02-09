Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0095C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 13:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EE621919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 13:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfBINCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 08:02:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52847 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfBINCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 08:02:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19D2B5i2634513
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 05:02:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19D2AXI2634509;
        Sat, 9 Feb 2019 05:02:10 -0800
Date:   Sat, 9 Feb 2019 05:02:10 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-26ee2bcdea33c60aa833cc32a1624ef5d49c9c6f@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        mingo@kernel.org, jolsa@redhat.com
Reply-To: jolsa@redhat.com, mingo@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          acme@redhat.com
In-Reply-To: <20190206103947.15750-5-adrian.hunter@intel.com>
References: <20190206103947.15750-5-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Packet splitting can happen only on
 32-bit
Git-Commit-ID: 26ee2bcdea33c60aa833cc32a1624ef5d49c9c6f
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

Commit-ID:  26ee2bcdea33c60aa833cc32a1624ef5d49c9c6f
Gitweb:     https://git.kernel.org/tip/26ee2bcdea33c60aa833cc32a1624ef5d49c9c6f
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 6 Feb 2019 12:39:46 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:27:54 -0300

perf intel-pt: Packet splitting can happen only on 32-bit

Data is copied when the trace is stopped, so packets are never split
between buffers except when processing if the buffer cannot fit in the
address space which can only happen on 32-bit systems. Change the logic
to reflect that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190206103947.15750-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index a54d6c9a4601..6e03db142091 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -868,7 +868,7 @@ static int intel_pt_get_next_packet(struct intel_pt_decoder *decoder)
 
 		ret = intel_pt_get_packet(decoder->buf, decoder->len,
 					  &decoder->packet);
-		if (ret == INTEL_PT_NEED_MORE_BYTES &&
+		if (ret == INTEL_PT_NEED_MORE_BYTES && BITS_PER_LONG == 32 &&
 		    decoder->len < INTEL_PT_PKT_MAX_SZ && !decoder->next_buf) {
 			ret = intel_pt_get_split_packet(decoder);
 			if (ret < 0)
