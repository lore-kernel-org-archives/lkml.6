Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA688ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA5420647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA5420647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbeGTSTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:19:40 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:39982 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387868AbeGTSTj (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 20 Jul 2018 14:19:39 -0400
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 20 Jul 2018 11:30:19 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH -next 0/2] fs/epoll: loosen irq safety when possible
Date:   Fri, 20 Jul 2018 10:29:54 -0700
Message-Id: <20180720172956.2883-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Both patches replace saving+restoring interrupts when taking the
ep->lock (now the waitqueue lock), with just disabling local irqs.
This shows immediate performance benefits in patch 1 for an epoll
workload running on Xen. The main concern we need to have with this
sort of changes in epoll is the ep_poll_callback() which is passed
to the wait queue wakeup and is done very often under irq context,
this patch does not touch this call.

Patches have been tested pretty heavily with the customer workload,
microbenchmarks, ltp testcases and two high level workloads that
use epoll under the hood: nginx and libevent benchmarks.

Details are in the individual patches.

Applies on top of mmotd.

Thanks!

Davidlohr Bueso (2):
  fs/epoll: loosen irq safety in ep_scan_ready_list()
  fs/epoll: loosen irq safety in epoll_insert() and epoll_remove()

 fs/eventpoll.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

-- 
2.16.4

