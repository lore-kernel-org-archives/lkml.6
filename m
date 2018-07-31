Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F70CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F68320894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F68320894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbeHABVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 21:21:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53146 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732813AbeHABVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 21:21:52 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 79D9829;
        Tue, 31 Jul 2018 23:39:10 +0000 (UTC)
Date:   Tue, 31 Jul 2018 16:39:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: Remove memcg_cgroup::id from IDR on
 mem_cgroup_css_alloc() failure
Message-Id: <20180731163908.603d7a27c6534341e1afa724@linux-foundation.org>
In-Reply-To: <20180730153113.GB4567@cmpxchg.org>
References: <6dbc33bb-f3d5-1a46-b454-13c6f5865fcd@virtuozzo.com>
        <20180413113855.GI17484@dhcp22.suse.cz>
        <8a81c801-35c8-767d-54b0-df9f1ca0abc0@virtuozzo.com>
        <20180413115454.GL17484@dhcp22.suse.cz>
        <abfd4903-c455-fac2-7ed6-73707cda64d1@virtuozzo.com>
        <20180413121433.GM17484@dhcp22.suse.cz>
        <20180413125101.GO17484@dhcp22.suse.cz>
        <20180726162512.6056b5d7c1d2a5fbff6ce214@linux-foundation.org>
        <20180727193134.GA10996@cmpxchg.org>
        <20180729192621.py4znecoinw5mqcp@esperanza>
        <20180730153113.GB4567@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 11:31:13 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Subject: [PATCH] mm: memcontrol: simplify memcg idr allocation and error
>  unwinding
> 
> The memcg ID is allocated early in the multi-step memcg creation
> process, which needs 2-step ID allocation and IDR publishing, as well
> as two separate IDR cleanup/unwind sites on error.
> 
> Defer the IDR allocation until the last second during onlining to
> eliminate all this complexity. There is no requirement to have the ID
> and IDR entry earlier than that. And the root reference to the ID is
> put in the offline path, so this matches nicely.

This patch isn't aware of Kirill's later "mm, memcg: assign memcg-aware
shrinkers bitmap to memcg", which altered mem_cgroup_css_online():

@@ -4356,6 +4470,11 @@ static int mem_cgroup_css_online(struct
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	if (memcg_alloc_shrinker_maps(memcg)) {
+		mem_cgroup_id_remove(memcg);
+		return -ENOMEM;
+	}
+
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	atomic_set(&memcg->id.ref, 1);
 	css_get(css);

