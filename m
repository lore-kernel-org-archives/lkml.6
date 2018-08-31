Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752E9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B8B20843
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OguqJ3jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B8B20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeIAB3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:29:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37577 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeIAB3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:29:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id h69-v6so6061973pfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 14:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cj7JgX+iXT4uVtzoZVFieuPOGdIccPYkThtUySHDX3o=;
        b=OguqJ3jmuSSpbIQ20CGUxnTlM/NbIUSJ/4qvAX8dD8WOyfGvZNj23XRFdUZ+Rdz4Km
         E0xxTBxMC98+BIioFZjj4JkL+KPwF+RzGk6UIJX3ayzZGua0aNT4K99BlkPa6aXZPZ7+
         sRfl6B+s+OY10SK1udN+PHe0YKIbseHx57q8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cj7JgX+iXT4uVtzoZVFieuPOGdIccPYkThtUySHDX3o=;
        b=oqWUdvFAHZ1tS50+9HdNy+6nMGl3jd/8MuQiLjebTSexGPN0jnxJ1RsiVP4FIPZaUP
         95Wj3RrCKlojvnxG/D8+IzgVZ/Ms2U5UZrRZvfJK3yvd6faonzbgggMCCB52eDPxzWnK
         n4rf9IO1iGOw6RIcTUBPwykyqvWs6TBxcKMWg71hY9UQ5IDOqEa0DbtkJ3qTe1Ck4F8d
         DMcpn/1K+VOhjpCEWkLvQQeFHvL77qda22ewJd5lkZPvSbs+CFdfJGAuE44R7lJAJOFO
         aCLqkl1xcgEUhzNmugvmYb4d2CxjAW+dGMHr4FSBrW21J+RVglCXzxoRB6+sqeIlcFmw
         xfgw==
X-Gm-Message-State: APzg51A1eKT+i0WLnbVIGVcVRcY3nLrQF2GdUZKvBFiksUa/NSG0LVa0
        EejmtQU+rB3EWL4QeVuDHT5Guw==
X-Google-Smtp-Source: ANB0VdasySdItJWdWiVlXP+3rKJiuvUdpg46FbcWkl+DBNJ4lHrN9szEMRZ8sLbBh1tzhsXtcxpwZg==
X-Received: by 2002:a62:3001:: with SMTP id w1-v6mr17731669pfw.19.1535750412330;
        Fri, 31 Aug 2018 14:20:12 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5e2b:39df:72ed:4968])
        by smtp.gmail.com with ESMTPSA id d24-v6sm11838607pgv.23.2018.08.31.14.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 14:20:11 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH] clk: fix clk_calc_subtree compute duplications
Date:   Fri, 31 Aug 2018 14:20:07 -0700
Message-Id: <20180831212007.247186-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_calc_subtree was called at every step up the clk tree in
clk_calc_new_rates. Since it recursively calls itself for its
children, this means it would be called once on each clk for each
step above the top clk is.

This is fixed by adding a non-recursive function called at every
step in clk_calc_new_rates that fills in new_rate, new_parent, etc.
Since the clks not called directly for clk_calc_new_rates can only
change their rate, we only set new_rate in clk_calc_subtree.
clk_calc_subtree is also only called on the top clk after it's found
via clk_calc_new_rates to remove the duplicate recursive calls.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/clk/clk.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d31055ae6ec6..52032fb1a8a2 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1609,11 +1609,18 @@ static int __clk_speculate_rates(struct clk_core *core,
 	return ret;
 }
 
-static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
-			     struct clk_core *new_parent, u8 p_index)
+static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate)
 {
 	struct clk_core *child;
 
+	core->new_rate = new_rate;
+	hlist_for_each_entry(child, &core->children, child_node)
+		clk_calc_subtree(child, clk_recalc(child, new_rate));
+}
+
+static void clk_set_change(struct clk_core *core, unsigned long new_rate,
+			   struct clk_core *new_parent, u8 p_index)
+{
 	core->new_rate = new_rate;
 	core->new_parent = new_parent;
 	core->new_parent_index = p_index;
@@ -1621,11 +1628,6 @@ static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
 	core->new_child = NULL;
 	if (new_parent && new_parent != core->parent)
 		new_parent->new_child = core;
-
-	hlist_for_each_entry(child, &core->children, child_node) {
-		child->new_rate = clk_recalc(child, new_rate);
-		clk_calc_subtree(child, child->new_rate, NULL, 0);
-	}
 }
 
 /*
@@ -1709,7 +1711,7 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 		top = clk_calc_new_rates(parent, best_parent_rate);
 
 out:
-	clk_calc_subtree(core, new_rate, parent, p_index);
+	clk_set_change(core, new_rate, parent, p_index);
 
 	return top;
 }
@@ -1910,6 +1912,8 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	if (ret)
 		return ret;
 
+	clk_calc_subtree(top, top->new_rate);
+
 	/* notify that we are about to change rates */
 	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
 	if (fail_clk) {
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

