Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D65CC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485D321473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej0OBI+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485D321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeLAFhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:37:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeLAFhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:37:46 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9709B20673;
        Fri, 30 Nov 2018 18:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543602456;
        bh=II1kES6SFe+IdG3bQtA6I5KRr2FSBi2LcdwyF7KCpeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ej0OBI+trNh0dKV3+l55RyUSxKSGqJPZCxxSmRwfsEqQeXqW3ig0xCkNZYYhu44u9
         kYXRTelvxayU7+r/ZSKZ6sIcG7RDTuVN9ITJDwto0F+d5gFVZgVjBZitRNkwEmQD39
         TLSm9bzAsEoV9sF3XEj+dclX4Y6kguKpb/L814rk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/22] tools lib traceevent: Fix compile warnings in tools/lib/traceevent/event-parse.c
Date:   Fri, 30 Nov 2018 15:26:40 -0300
Message-Id: <20181130182652.23620-11-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130182652.23620-1-acme@kernel.org>
References: <20181130182652.23620-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Fix following warnings:

  event-parse.c: In function ‘tep_find_event_by_name’:
  event-parse.c:3521:21: warning: ‘event’ may be used uninitialized in this function [-Wmaybe-uninitialized]
    pevent->last_event = event;
    ~~~~~~~~~~~~~~~~~~~^~~~~~~
    CC       ui/gtk/hists.o
    LINK     plugin_mac80211.so
    CC       nlattr.o
  event-parse.c: In function ‘tep_data_lat_fmt’:
  event-parse.c:5200:4: warning: ‘migrate_disable’ may be used uninitialized in this function [-Wmaybe-uninitialized]
      trace_seq_printf(s, "%d", migrate_disable);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  event-parse.c:5207:4: warning: ‘lock_depth’ may be used uninitialized in this function [-Wmaybe-uninitialized]
      trace_seq_printf(s, "%d", lock_depth);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    LINK     plugin_sched_switch.so
    LINK     plugin_function.so
    LINK     plugin_xen.so
  event-parse.c: In function ‘tep_event_info’:
  event-parse.c:5047:7: warning: ‘len_arg’ may be used uninitialized in this function [-Wmaybe-uninitialized]
         trace_seq_printf(s, format, len_arg, (char)val);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  event-parse.c:4884:6: note: ‘len_arg’ was declared here
    int len_arg;
        ^~~~~~~
  event-parse.c:4338:11: warning: ‘vsize’ may be used uninitialized in this function [-Wmaybe-uninitialized]
       val = tep_read_number(pevent, bptr, vsize);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  event-parse.c:4224:6: note: ‘vsize’ was declared here
    int vsize;
        ^~~~~

$ gcc --version
  gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Link: http://lkml.kernel.org/r/20181122112937.10582-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 3692f29fee46..fbd6d6813fab 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -3498,7 +3498,7 @@ struct tep_event_format *
 tep_find_event_by_name(struct tep_handle *pevent,
 		       const char *sys, const char *name)
 {
-	struct tep_event_format *event;
+	struct tep_event_format *event = NULL;
 	int i;
 
 	if (pevent->last_event &&
@@ -4221,7 +4221,7 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
 	unsigned long long ip, val;
 	char *ptr;
 	void *bptr;
-	int vsize;
+	int vsize = 0;
 
 	field = pevent->bprint_buf_field;
 	ip_field = pevent->bprint_ip_field;
@@ -4881,7 +4881,7 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
 	char format[32];
 	int show_func;
 	int len_as_arg;
-	int len_arg;
+	int len_arg = 0;
 	int len;
 	int ls;
 
@@ -5146,8 +5146,8 @@ void tep_data_lat_fmt(struct tep_handle *pevent,
 	static int migrate_disable_exists;
 	unsigned int lat_flags;
 	unsigned int pc;
-	int lock_depth;
-	int migrate_disable;
+	int lock_depth = 0;
+	int migrate_disable = 0;
 	int hardirq;
 	int softirq;
 	void *data = record->data;
-- 
2.19.1

