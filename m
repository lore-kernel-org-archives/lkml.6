Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C2EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D855214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsCF5Bxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfBAWb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:31:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39163 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfBAWb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:31:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so7687901wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 14:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=smXPr7YyN9j+5o0duj+MSQFg2t+PKQaX/rq1b/eiWjo=;
        b=jsCF5BxyJ6sYySiyBU+MICQstL4UBvQYWQUt4XvqWxESUCPkRopUz9F1NT7Pq0EuW+
         mOBDgmMOyWqQ5wDpoCR6i1DoWWAo4GADIw+5MC59C+AIjzz+uNo2eAzZn0k7msYH46rR
         PlN1HS88UgazpnqOtvwC3OwAFsYwR3FnPdnf1txiWZEfMJh6BPH5+LK1dG0CXxITqcFk
         VQ6Xy2Rg8XCIx49gKTNaOKpx8n8C2KxCm0IRrUhUlJw+edIDPr9SIcCBcmt++fDBhYtC
         MNmthrk4td6JYGT89WBUl24WQPRQ98DXaGfBg8WRJStLbflaZ6qd8zjH7F1DocFLDXLD
         OFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=smXPr7YyN9j+5o0duj+MSQFg2t+PKQaX/rq1b/eiWjo=;
        b=Zp09Rez8CGcwuKCIb5ZIKneq1ucafx3SafNGj9j+x/SiIvHe00L0/c96WrJ8FQlNhg
         z/gJ1KRnxJ/UuMw6uYiqVT4PysLWMk9RApW7Uh/fgbOXwlLYGm2ZRo1i0fQgZVob12mV
         iavgFXiNumHPwZHtmjvM2WfqqJaXbn9YIiS6aqkpKV/YKtyB242kuXMUFlmGuEXiVJ/c
         ebQBwDl62+pmKvDI4uJy+wctgEaWdm0UHIWVqXkn/tKEEs0TCcACsfnqGYpVbqXmiPm7
         qNKpmPhSdj6hjZfq7QUwED6NHcQzXDhcp9/Ppl7FZno2ONzHOuzSxdUOtD2H4L0TZd6D
         w4LQ==
X-Gm-Message-State: AHQUAuad7MCwjYA/X8B/9mHnBd+3cBsMEUNZe7+CeDhurnLGdzq8ZbrA
        guxY3hvps0IVCIdcKatA869J+30=
X-Google-Smtp-Source: AHgI3IbXjbg24x03xHhiG/DK8jZrx2DAGbIg4FCALGFVLE94B5sTMsKAmjN+uKPHvgJiJVBoGVquPg==
X-Received: by 2002:a1c:7c07:: with SMTP id x7mr2442217wmc.82.1549060313451;
        Fri, 01 Feb 2019 14:31:53 -0800 (PST)
Received: from avx2 ([46.53.241.160])
        by smtp.gmail.com with ESMTPSA id l20sm16551723wrb.93.2019.02.01.14.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:31:52 -0800 (PST)
Date:   Sat, 2 Feb 2019 01:31:51 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] numa: make "nr_online_nodes" unsigned int
Message-ID: <20190201223151.GB15820@avx2>
References: <20190201223029.GA15820@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190201223029.GA15820@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Number of online NUMA nodes can't be negative as well.
This doesn't save space as the variable is used only in 32-bit context,
but do it anyway for consistency.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/nodemask.h |    4 ++--
 mm/page_alloc.c          |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -445,7 +445,7 @@ static inline int next_memory_node(int nid)
 }
 
 extern unsigned int nr_node_ids;
-extern int nr_online_nodes;
+extern unsigned int nr_online_nodes;
 
 static inline void node_set_online(int nid)
 {
@@ -486,7 +486,7 @@ static inline int num_node_state(enum node_states state)
 #define first_memory_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
 #define nr_node_ids		1U
-#define nr_online_nodes		1
+#define nr_online_nodes		1U
 
 #define node_set_online(node)	   node_set_state((node), N_ONLINE)
 #define node_set_offline(node)	   node_clear_state((node), N_ONLINE)
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -290,7 +290,7 @@ EXPORT_SYMBOL(movable_zone);
 
 #if MAX_NUMNODES > 1
 unsigned int nr_node_ids __read_mostly = MAX_NUMNODES;
-int nr_online_nodes __read_mostly = 1;
+unsigned int nr_online_nodes __read_mostly = 1;
 EXPORT_SYMBOL(nr_node_ids);
 EXPORT_SYMBOL(nr_online_nodes);
 #endif
@@ -5597,7 +5597,7 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
 	else
 		page_group_by_mobility_disabled = 0;
 
-	pr_info("Built %i zonelists, mobility grouping %s.  Total pages: %ld\n",
+	pr_info("Built %u zonelists, mobility grouping %s.  Total pages: %ld\n",
 		nr_online_nodes,
 		page_group_by_mobility_disabled ? "off" : "on",
 		vm_total_pages);
