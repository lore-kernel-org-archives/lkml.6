Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F953C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5908126591
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5908126591
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeFZGy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:54:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeFZGyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:54:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6sHTw1591411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:54:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6sH8R1591408;
        Mon, 25 Jun 2018 23:54:17 -0700
Date:   Mon, 25 Jun 2018 23:54:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-621a5a327c1e36ffd7bb567f44a559f64f76358f@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, adrian.hunter@intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        hpa@zytor.com
Reply-To: tglx@linutronix.de, acme@redhat.com, adrian.hunter@intel.com,
          hpa@zytor.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <1528371002-8862-1-git-send-email-adrian.hunter@intel.com>
References: <1528371002-8862-1-git-send-email-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf intel-pt: Fix packet decoding of CYC packets
Git-Commit-ID: 621a5a327c1e36ffd7bb567f44a559f64f76358f
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

Commit-ID:  621a5a327c1e36ffd7bb567f44a559f64f76358f
Gitweb:     https://git.kernel.org/tip/621a5a327c1e36ffd7bb567f44a559f64f76358f
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 7 Jun 2018 14:30:02 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:36 -0300

perf intel-pt: Fix packet decoding of CYC packets

Use a 64-bit type so that the cycle count is not limited to 32-bits.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1528371002-8862-1-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index ba4c9dd18643..d426761a549d 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -366,7 +366,7 @@ static int intel_pt_get_cyc(unsigned int byte, const unsigned char *buf,
 		if (len < offs)
 			return INTEL_PT_NEED_MORE_BYTES;
 		byte = buf[offs++];
-		payload |= (byte >> 1) << shift;
+		payload |= ((uint64_t)byte >> 1) << shift;
 	}
 
 	packet->type = INTEL_PT_CYC;
