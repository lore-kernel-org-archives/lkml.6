Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA7AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1AF20675
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545165247;
	bh=mIjDOT5VHWi0rziTf3IcrsxCHBTjYTQtYKUL3LJEddk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=AcLHuTVoy19JqSC1TUtMQ+d/Qa0iNWB2v3V4pS26f/PNHExh/rrY3KvYvCMaCiBmP
	 1vdXepkUOZnJx1gPxxtPkq1ycB2V9ifCbBlnlK6xPH+UziqDgz+bp/6ce9PkHu1OgL
	 0KAecn7cPACpSBN6v6sOEDyoNULRsrxKN1LanaeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeLRUeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:34:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727476AbeLRUeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:34:02 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7A9721871;
        Tue, 18 Dec 2018 20:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545165241;
        bh=mIjDOT5VHWi0rziTf3IcrsxCHBTjYTQtYKUL3LJEddk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=E6AaQdgLc1TaoR0W3o7UgZ5n4YcFS+HRE2dgGxJDw7V7FbrjWzxjwngPt34TwQ8tX
         6hNiG9+anm2Zv3ck1gmnnz5yAU7Ff/8EZDVoPkw7lMb7WFjobJULB//RF7Cm0xoKXv
         A7M7z9Zanb9F7YoSSgjS8kM8t95KYRM0q/rSADrQ=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 6/7] tracing: Remove hist trigger synth_var_refs
Date:   Tue, 18 Dec 2018 14:33:25 -0600
Message-Id: <b4d3470526b8f0426dcec125399dad9ad9b8589d.1545161087.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

All var_refs are now handled uniformly and there's no reason to treat
the synth_refs in a special way now, so remove them and associated
functions.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 725d22f5372f..e66dd764e057 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -279,8 +279,6 @@ struct hist_trigger_data {
 	struct action_data		*actions[HIST_ACTIONS_MAX];
 	unsigned int			n_actions;
 
-	struct hist_field               *synth_var_refs[SYNTH_FIELDS_MAX];
-	unsigned int                    n_synth_var_refs;
 	struct field_var		*field_vars[SYNTH_FIELDS_MAX];
 	unsigned int			n_field_vars;
 	unsigned int			n_field_var_str;
@@ -3602,20 +3600,6 @@ static void save_field_var(struct hist_trigger_data *hist_data,
 }
 
 
-static void destroy_synth_var_refs(struct hist_trigger_data *hist_data)
-{
-	unsigned int i;
-
-	for (i = 0; i < hist_data->n_synth_var_refs; i++)
-		destroy_hist_field(hist_data->synth_var_refs[i], 0);
-}
-
-static void save_synth_var_ref(struct hist_trigger_data *hist_data,
-			 struct hist_field *var_ref)
-{
-	hist_data->synth_var_refs[hist_data->n_synth_var_refs++] = var_ref;
-}
-
 static int check_synth_field(struct synth_event *event,
 			     struct hist_field *hist_field,
 			     unsigned int field_pos)
@@ -3775,7 +3759,6 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 				goto err;
 			}
 
-			save_synth_var_ref(hist_data, var_ref);
 			field_pos++;
 			kfree(p);
 			continue;
@@ -4519,7 +4502,6 @@ static void destroy_hist_data(struct hist_trigger_data *hist_data)
 	destroy_actions(hist_data);
 	destroy_field_vars(hist_data);
 	destroy_field_var_hists(hist_data);
-	destroy_synth_var_refs(hist_data);
 
 	kfree(hist_data);
 }
-- 
2.14.1

