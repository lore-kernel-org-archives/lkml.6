Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C009BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A2021019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548165547;
	bh=eFCV2I0SuRanve7T87d5UFTNQZX8eA+dD9s9Tx4QdpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NEUdvs+OFGAbFIU3Pf8oNUarIHHEQOXxMZsbXXQsTmSc3T53sHxacxEYVMSFc3MIy
	 JoEvDtZPhsMsSlsJCBYJ41E+464D0/Ck3kNT3aKA4SuQcNZ7mSbVeTy9G+Q1vfo9gA
	 3f1c6nIMG9tb5U12Rv8gWgk99B63TiEHwkJYpSHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfAVN7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:59:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbfAVN7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:59:05 -0500
Received: from quaco.ghostprotocols.net (unknown [189.16.122.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0094721019;
        Tue, 22 Jan 2019 13:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548165544;
        bh=eFCV2I0SuRanve7T87d5UFTNQZX8eA+dD9s9Tx4QdpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdmvdvwNbowWClLwsVn3B9pXPeFKiDH7YIgiUD8QcPleunfnSbH7wr9eRXdgc1yrh
         W73Og8b3CT4EAtLQBnFRpewN1UeeeziWAzeEA4pCWP9FaFQitv/BYjxv25FEZfMtAh
         ppv0lHMAmqX6COgtrazhmyMnpz5KWdnHS5+cS9hE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2D60140355; Tue, 22 Jan 2019 11:59:01 -0200 (-02)
Date:   Tue, 22 Jan 2019 11:59:01 -0200
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 6/7] perf hist: Use cached rbtrees
Message-ID: <20190122135901.GE14973@kernel.org>
References: <20181206191819.30182-1-dave@stgolabs.net>
 <20181206191819.30182-7-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181206191819.30182-7-dave@stgolabs.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 06, 2018 at 11:18:18AM -0800, Davidlohr Bueso escreveu:
> At the cost of an extra pointer, we can avoid the O(logN) cost
> of finding the first element in the tree (smallest node), which
> is something heavily required for histograms. Specifically, the
> following are converted to rb_root_cached, and users accordingly:
> 
> hist::entries_in_array
> hist::entries_in
> hist::entries
> hist::entries_collapsed
> hist_entry::hroot_in
> hist_entry::hroot_out

  CC       /tmp/build/perf/util/hist.o
ui/browsers/hists.c: In function ‘hierarchy_set_folding’:
ui/browsers/hists.c:511:21: error: passing argument 1 of ‘rb_first’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  for (nd = rb_first(&he->hroot_out); nd; nd = rb_next(nd)) {
                     ^~~~~~~~~~~~~~
In file included from ui/browsers/hists.c:8:
/home/acme/git/perf/tools/include/linux/rbtree.h:83:24: note: expected ‘const struct rb_root *’ but argument is of type ‘struct rb_root_cached *’
 extern struct rb_node *rb_first(const struct rb_root *);
                        ^~~~~~~~
ui/browsers/hists.c: In function ‘__hist_browser__set_folding’:
ui/browsers/hists.c:569:16: error: passing argument 1 of ‘rb_first’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  nd = rb_first(&browser->hists->entries);
                ^~~~~~~~~~~~~~~~~~~~~~~~

So I added this on top, please check:


diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f8913723a99a..85790a4d1842 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -508,7 +508,7 @@ static int hierarchy_set_folding(struct hist_browser *hb, struct hist_entry *he,
 	struct hist_entry *child;
 	int n = 0;
 
-	for (nd = rb_first(&he->hroot_out); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&he->hroot_out); nd; nd = rb_next(nd)) {
 		child = rb_entry(nd, struct hist_entry, rb_node);
 		percent = hist_entry__get_percent_limit(child);
 		if (!child->filtered && percent >= hb->min_pcnt)
@@ -566,7 +566,7 @@ __hist_browser__set_folding(struct hist_browser *browser, bool unfold)
 	struct rb_node *nd;
 	struct hist_entry *he;
 
-	nd = rb_first(&browser->hists->entries);
+	nd = rb_first_cached(&browser->hists->entries);
 	while (nd) {
 		he = rb_entry(nd, struct hist_entry, rb_node);
 
@@ -1738,7 +1738,7 @@ static void ui_browser__hists_init_top(struct ui_browser *browser)
 		struct hist_browser *hb;
 
 		hb = container_of(browser, struct hist_browser, b);
-		browser->top = rb_first(&hb->hists->entries);
+		browser->top = rb_first_cached(&hb->hists->entries);
 	}
 }
 
@@ -2649,7 +2649,7 @@ add_socket_opt(struct hist_browser *browser, struct popup_action *act,
 static void hist_browser__update_nr_entries(struct hist_browser *hb)
 {
 	u64 nr_entries = 0;
-	struct rb_node *nd = rb_first(&hb->hists->entries);
+	struct rb_node *nd = rb_first_cached(&hb->hists->entries);
 
 	if (hb->min_pcnt == 0 && !symbol_conf.report_hierarchy) {
 		hb->nr_non_filtered_entries = hb->hists->nr_non_filtered_entries;
@@ -2669,7 +2669,7 @@ static void hist_browser__update_percent_limit(struct hist_browser *hb,
 					       double percent)
 {
 	struct hist_entry *he;
-	struct rb_node *nd = rb_first(&hb->hists->entries);
+	struct rb_node *nd = rb_first_cached(&hb->hists->entries);
 	u64 total = hists__total_period(hb->hists);
 	u64 min_callchain_hits = total * (percent / 100);
 
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index dfab3deef028..74414ccd8c84 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -401,7 +401,7 @@ static void perf_gtk__show_hists(GtkWidget *window, struct hists *hists,
 }
 
 static void perf_gtk__add_hierarchy_entries(struct hists *hists,
-					    struct rb_root *root,
+					    struct rb_root_cached *root,
 					    GtkTreeStore *store,
 					    GtkTreeIter *parent,
 					    struct perf_hpp *hpp,
@@ -415,7 +415,7 @@ static void perf_gtk__add_hierarchy_entries(struct hists *hists,
 	u64 total = hists__total_period(hists);
 	int size;
 
-	for (node = rb_first(root); node; node = rb_next(node)) {
+	for (node = rb_first_cached(root); node; node = rb_next(node)) {
 		GtkTreeIter iter;
 		float percent;
 		char *bf;
@@ -578,7 +578,7 @@ static void perf_gtk__show_hierarchy(GtkWidget *window, struct hists *hists,
 	gtk_tree_view_set_model(GTK_TREE_VIEW(view), GTK_TREE_MODEL(store));
 	g_object_unref(GTK_TREE_MODEL(store));
 
-	perf_gtk__add_hierarchy_entries(hists, &hists->entries.rb_root, store,
+	perf_gtk__add_hierarchy_entries(hists, &hists->entries, store,
 					NULL, &hpp, min_pcnt);
 
 	gtk_tree_view_set_rules_hint(GTK_TREE_VIEW(view), TRUE);
