Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29421C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE6720857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE6720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeKHOoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 09:44:05 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:57936 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHOoF (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 8 Nov 2018 09:44:05 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 07 Nov 2018 22:10:17 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk, dave@stgolabs.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 0/6] epoll: some miscellaneous optimizations
Date:   Wed,  7 Nov 2018 21:10:00 -0800
Message-Id: <20181108051006.18751-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following are some incremental optimizations on some of the epoll
core. Each patch has the details, but together, the series is seen
to shave off measurable cycles on a number of systems and workloads.

For example, on a 40-core IB, a pipetest as well as parallel epoll_wait()
benchmark show around a 20-30% increase in raw operations per second when
the box is fully occupied (incremental thread counts), and up to 15%
performance improvement with lower counts.

Passes ltp epoll related testcases. Please consider for v4.21/5.0.

Thanks!

Davidlohr Bueso (6):
  fs/epoll: remove max_nests argument from ep_call_nested()
  fs/epoll: simplify ep_send_events_proc() ready-list loop
  fs/epoll: drop ovflist branch prediction
  fs/epoll: robustify ep->mtx held checks
  fs/epoll: reduce the scope of wq lock in epoll_wait()
  fs/epoll: avoid barrier after an epoll_wait(2) timeout

 fs/eventpoll.c | 206 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 108 insertions(+), 98 deletions(-)

-- 
2.16.4

