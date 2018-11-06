Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD390C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B618E20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B618E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbeKGDu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:50:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:60792 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387741AbeKGDu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:50:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E462AB64;
        Tue,  6 Nov 2018 18:23:56 +0000 (UTC)
Date:   Tue, 6 Nov 2018 10:23:49 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     akpm@linux-foundation.org, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] perf-bench: Add epoll parallel epoll_wait benchmark
Message-ID: <20181106182349.thdkpvshkna5vd7o@linux-r8p5>
References: <20181106152226.20883-1-dave@stgolabs.net>
 <20181106152226.20883-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181106152226.20883-2-dave@stgolabs.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mind this fixlet for using et/oneshot and the multiq option.

diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index c4c5ef60feb4..4e4efc5cfe22 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -215,13 +215,13 @@ static void *workerfn(void *arg)
 
 		if (et) {
 			ev.events = EPOLLIN | EPOLLET;
-			ret = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);
+			ret = epoll_ctl(efd, EPOLL_CTL_ADD, fd, &ev);
 		}
 
 		if (oneshot) {
 			/* rearm the file descriptor with a new event mask */
 			ev.events |= EPOLLIN | EPOLLONESHOT;
-			ret = epoll_ctl(epollfd, EPOLL_CTL_MOD, fd, &ev);
+			ret = epoll_ctl(efd, EPOLL_CTL_MOD, fd, &ev);
 		}
 
 		ops++;
@@ -249,7 +249,7 @@ static void nest_epollfd(struct worker *w)
 
 	for (i = 0; i < nested; i++) {
 		epollfdp[i] = epoll_create(1);
-		if (epollfd < 0)
+		if (epollfdp[i] < 0)
 			err(EXIT_FAILURE, "epoll_create");
 	}
 
