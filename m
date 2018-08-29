Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197FDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D6E205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D6E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeH2VQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:16:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:7005 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbeH2VQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:16:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 10:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="68826410"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2018 10:18:36 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 96817301BA0; Wed, 29 Aug 2018 10:18:36 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 06/10] tools, perf, script: Set user_set/wildcard_set for +- fields in -F
Date:   Wed, 29 Aug 2018 10:18:30 -0700
Message-Id: <20180829171834.6590-7-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829171834.6590-1-andi@firstfloor.org>
References: <20180829171834.6590-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The branch target output relies on the user_set flag to determine
if the branch target should be implicitely printed. When
modifying the fields with + or - also set user_set,
so that ADDR can be removed. We also need to set wildcard_set
to make the initial sanity check pass.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6a470dd8f2d0..14b19ff43cbd 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2497,6 +2497,8 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 						output[j].fields &= ~all_output_options[i].field;
 					else
 						output[j].fields |= all_output_options[i].field;
+					output[j].user_set = true;
+					output[j].wildcard_set = true;
 				}
 			}
 		} else {
@@ -2507,7 +2509,8 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 				rc = -EINVAL;
 				goto out;
 			}
-			output[type].fields |= all_output_options[i].field;
+			output[j].user_set = true;
+			output[j].wildcard_set = true;
 		}
 	}
 
-- 
2.17.1

