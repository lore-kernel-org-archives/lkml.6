Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D14C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AEC2146F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131707;
	bh=5Zz9FQbKUYqA2xjdHllEs3ZqhmJzpAKonquVL14SvpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yurn+FltJOnVzlcocfgSvrzngZI+vjLTrC4ngfWtWZ2cAnIX+V0/YlpU2cMm+w3y2
	 NM4+hHOrVXmyy/j7MlcpUhzr3BT0ymbOQ6REF0Mo/qKhcYxsmFwEGPJgL4uiIkqBM4
	 GIO+fcXvYUpYmBMJxyhS0YrNskHwOjeDfHM1QTvw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AEC2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeLFV2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbeLFV2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:28:23 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 276A52082B;
        Thu,  6 Dec 2018 21:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131702;
        bh=5Zz9FQbKUYqA2xjdHllEs3ZqhmJzpAKonquVL14SvpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Brq/3PpJnZd9BRSI8oVQtlDfzx0q+Ck6zLP4RY8Y7/D5nFIF2noJm2UjNro5Jh7/G
         uH58PMYhn5TzR4jMxEPg/X8uJlNCIrVEAWXb96qftARgFlNVHTjYa6MGEuyYxHOvoR
         IkTTiSFj1XA0BQr0KXrMOZnz+uPWJSAnOZF6+bko=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/75] tools lib traceevent: Implement new API tep_get_ref()
Date:   Thu,  6 Dec 2018 18:25:14 -0300
Message-Id: <20181206212602.20474-28-acme@kernel.org>
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

This patch implements a new API of the tracevent library:

  int tep_get_ref(struct tep_handle *tep);

The API returns the reference counter "ref_count" of the tep handler.
As "struct tep_handle" is internal only, its members cannot be accessed
by the library users, the API is used to get the reference counter.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154646.890615385@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 7 +++++++
 tools/lib/traceevent/event-parse.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 2b5cb33046ce..d1e6ee3d43cf 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -6730,6 +6730,13 @@ void tep_ref(struct tep_handle *pevent)
 	pevent->ref_count++;
 }
 
+int tep_get_ref(struct tep_handle *tep)
+{
+	if (tep)
+		return tep->ref_count;
+	return 0;
+}
+
 void tep_free_format_field(struct tep_format_field *field)
 {
 	free(field->type);
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 16bf4c890b6f..44ec26c72c2e 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -581,6 +581,7 @@ struct tep_handle *tep_alloc(void);
 void tep_free(struct tep_handle *pevent);
 void tep_ref(struct tep_handle *pevent);
 void tep_unref(struct tep_handle *pevent);
+int tep_get_ref(struct tep_handle *tep);
 
 /* access to the internal parser */
 void tep_buffer_init(const char *buf, unsigned long long size);
-- 
2.19.2

