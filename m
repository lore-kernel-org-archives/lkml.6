Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18627ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FCD20847
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb4J1y8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FCD20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJYTno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:43:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbeJYTnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:43:43 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C51302075D;
        Thu, 25 Oct 2018 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465885;
        bh=HAmecvqXAbsnsKb9W0PJtIM/eOgsnxyou8VEbd9vtfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tb4J1y8V8BFsBK6s4jKDnM4W+5L+CFpItaE8HDw+RLPqaRi2yMcDUOi8SSs6ui5vO
         AeDDMLanQW6Wzld2Qf6LJ6fKpk7/D+Yrs5jIGLbuLIyof3qMZS4OAn6tDtCZ1Hlvp+
         JX9add3jOsUSkIv70YMIWKEBMkskjHxdBZpeJddk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/37] perf script: Allow extended console debug output
Date:   Thu, 25 Oct 2018 08:10:07 -0300
Message-Id: <20181025111031.3440-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

The script tool isn't using a browser, yet use_browser wasn't set
explicitly to zero. This in turn lead to confusing output such as:

  ```
  $ perf script -vvv ...
  ...
  overlapping maps in /home/milian/foobar (disable tui for more info)
  ...
  ```

Explicitly set use_browser to 0 now, which gives us the extended
debug information now in perf script as expected.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lkml.kernel.org/r/20181021191424.16183-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4da5e32b9e03..bd468b90801b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3417,8 +3417,10 @@ int cmd_script(int argc, const char **argv)
 		exit(-1);
 	}
 
-	if (!script_name)
+	if (!script_name) {
 		setup_pager();
+		use_browser = 0;
+	}
 
 	session = perf_session__new(&data, false, &script.tool);
 	if (session == NULL)
-- 
2.14.4

