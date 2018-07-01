Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16994C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B962598A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B962598A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965072AbeGASYj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:24:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753375AbeGAQSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:18:45 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 10EDE49B;
        Sun,  1 Jul 2018 16:18:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.4 084/105] perf intel-pt: Fix MTC timing after overflow
Date:   Sun,  1 Jul 2018 18:02:34 +0200
Message-Id: <20180701153155.463896306@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit dd27b87ab5fcf3ea1c060b5e3ab5d31cc78e9f4c upstream.

On some platforms, overflows will clear before MTC wraparound, and there
is no following TSC/TMA packet. In that case the previous TMA is valid.
Since there will be a valid TMA either way, stop setting 'have_tma' to
false upon overflow.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1527762225-26024-4-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |    1 -
 1 file changed, 1 deletion(-)

--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1268,7 +1268,6 @@ static int intel_pt_overflow(struct inte
 {
 	intel_pt_log("ERROR: Buffer overflow\n");
 	intel_pt_clear_tx_flags(decoder);
-	decoder->have_tma = false;
 	decoder->cbr = 0;
 	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;


