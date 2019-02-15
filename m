Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14089C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A40222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="a1C9++zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbfBOSOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:14:32 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45311 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731763AbfBOSOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:14:30 -0500
Received: by mail-yw1-f67.google.com with SMTP id d190so4025712ywd.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 10:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+WUd014/LJCShtLmJFavi/k6g9qeRBc8qLTGaKJAsU=;
        b=a1C9++zg/8Xow9jJtcRPER7lqOqA1xZ/VEeGI/x4i7V07mc76UEu2txWrBTwYlTQMy
         MA4EPF8kN5QqA4OQPMrTu66ZhOhde/Am0GRS65q3N7EfRFRR3z9diBn5LH9IyH5nhRs7
         NhxjLvYwGbKfpiWvzrCAHAm+m0Y5MWauAir24VuIFJ9x5/8tvpt0MVvrfGhbcXgv8oCM
         DZEQPzM3qwpCm9lAClj4TwtskFXajON48W/UdXwVEwvxP1/EBdu6+w5goqmM/Tot222V
         oX9iJIgWFQqsbayx0Buib7Jj52TL/tiGTi+NI78UPh4sqvBBXCfgSQ1KDVj/Z0Ok3WP7
         6gmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+WUd014/LJCShtLmJFavi/k6g9qeRBc8qLTGaKJAsU=;
        b=B2MKarOe59W5ubHADeBlhH6BvxeMujpxvN8lknOL6HALes8u/PbANLuh0nwojjGftJ
         R7HjEQlKyOTeNqiLRs4lPz3MOd4EeuzT5zCPpq7BqPODIVKm0Cu5as184Qoyackpd5R3
         OsemWEOpGNlDKTzYdhECExYdsWpXfwWh1XBTVx5nYqfPxFklCrklGftcS2NbonkaI8ra
         FQmmkcWiFF8xuEf3VbIa1dlSQNJpmHjM3H6vKFKZbiOF6qKYUuh5m+WgYC2//hGS07Yb
         xlGW1DKAQPiDueFypjY/tgPudjgMkPqYpfgcbBYc/0nXORKxBPPDI7fCMg/Y5bWlEC1t
         4LSQ==
X-Gm-Message-State: AHQUAuZWTHKJ2vVRiu5Y3sM3eWy23T4yfwMbWc0xZGnjLrgMU3J2hMh2
        M2i+UfxFdd4sDxLCiABI51uAOg==
X-Google-Smtp-Source: AHgI3IYTX5lnhvZHQEN+YihHwwia31uJ3zDJzj3kiVMLj9iTKxSvAREKWHdagDlzSpi65TjvKxg+gw==
X-Received: by 2002:a81:5a86:: with SMTP id o128mr8612249ywb.205.1550254469589;
        Fri, 15 Feb 2019 10:14:29 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:33c1])
        by smtp.gmail.com with ESMTPSA id 82sm2214565ywq.97.2019.02.15.10.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 10:14:28 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/6] mm: memcontrol: clean up the LRU counts tracking
Date:   Fri, 15 Feb 2019 13:14:19 -0500
Message-Id: <20190215181425.32624-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg LRU stats usage is currently a bit messy. Memcg has private
per-zone counters because reclaim needs zone granularity sometimes,
but we also have plenty of users that need to awkwardly sum them up to
node or memcg granularity. Meanwhile the canonical per-memcg vmstats
do not track the LRU counts (NR_INACTIVE_ANON etc.) as you'd expect.

This series enables LRU count tracking in the per-memcg vmstats array
such that lruvec_page_state() and memcg_page_state() work on the enum
node_stat_item items for the LRU counters. Then it converts all the
callers that don't specifically need per-zone numbers over to that.

 include/linux/memcontrol.h | 28 ---------------
 include/linux/mm_inline.h  |  2 +-
 include/linux/mmzone.h     |  5 ---
 mm/memcontrol.c            | 85 +++++++++++++++++++++++++-------------------
 mm/vmscan.c                |  2 +-
 mm/workingset.c            |  5 +--
 6 files changed, 54 insertions(+), 73 deletions(-)


