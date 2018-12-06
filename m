Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6AC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F2F20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131689;
	bh=wzpZPqJ6xpSRq5a3sBjuno+7x6HkcwxKFUNvDjhsTBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IFkrPhJPBGNOyNTmF6ZJTA067XZO3Ce1fMBZWZ8MP180npThMM3wgywyH9lFmuMne
	 DpQMqpl18pUdxurlceX4jX/JZo38b2SFEmk0T39CSDvT+Pctp1pbpjglRW9jvd47Q7
	 uBzVg2kUU2WXC9acqvNIwrjXnj44Q2Ayq5lny3f0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F2F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeLFV2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:28:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbeLFV2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:28:02 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323512082B;
        Thu,  6 Dec 2018 21:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131681;
        bh=wzpZPqJ6xpSRq5a3sBjuno+7x6HkcwxKFUNvDjhsTBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nT9SVqe7Id/HVdw06/hrLsMhGrKoVSScCoYQBfNNUH+dl+KNteUeaWux8pK9ROI0M
         b6oUMUjkDAcDH1Ztif74X29NXsPFVWba12BHbs6rldGVOrnR5zvFG4fvFOr80xLvMA
         HYkbzT5Qdm/6/OmSGGIjQeuXauGNbOC2VdPTKPdc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/75] tools lib traceevent: Add sanity check to is_timestamp_in_us()
Date:   Thu,  6 Dec 2018 18:25:09 -0300
Message-Id: <20181206212602.20474-23-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch adds a sanity check to is_timestamp_in_us() input parameter
trace_clock. It avoids a potential segfault in this function for the
case trace_clock is NULL.

Reported-by: Slavomir Kaslev <kaslevs@vmware.com>
Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181128145552.68c4f87b@gandalf.local.home
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index fbd6d6813fab..2b5cb33046ce 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5409,7 +5409,7 @@ void tep_event_info(struct trace_seq *s, struct tep_event_format *event,
 
 static bool is_timestamp_in_us(char *trace_clock, bool use_trace_clock)
 {
-	if (!use_trace_clock)
+	if (!trace_clock || !use_trace_clock)
 		return true;
 
 	if (!strcmp(trace_clock, "local") || !strcmp(trace_clock, "global")
-- 
2.19.2

