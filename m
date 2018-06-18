Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA09CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B5E20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B5E20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754756AbeFRE6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:58:16 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:54748 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754283AbeFRE6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:58:14 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 18 Jun 2018 13:58:12 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 18 Jun 2018 13:58:12 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org
Cc:     tglx@linutronix.de, raistlin@linux.it,
        linux-kernel@vger.kernel.org, juri.lelli@gmail.com,
        bristot@redhat.com, kernel-team@lge.com, joel@joelfernandes.org
Subject: [RESEND PATCH v12 0/2] Make find_later_rq() choose a closer cpu in topology
Date:   Mon, 18 Jun 2018 13:58:07 +0900
Message-Id: <1529297889-24551-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change from v11
   -. Rebase onto the latest tip/sched/core
   -. make the word 'cpu' in comments be upper case as Ingo did
      in the commit 97fb7a0a89
   -. Avoid a compile warning caused by mismatching bwt const and
      non-const 'struct sched_domain' in find_cpu()

Change from v10
   -. modify a comment a bit as Steven suggested

Change from v9
   -. modify a comment a bit so to be more clear as Juri suggested

Change from v8
   -. add suggested-by Peterz
   -. add several comments

Change from v7
   -. fix a trivial typo
   -. modify commit messages to explain what it does more clearly
   -. simplify code with an existing macro

Change from v6
   -. add a comment about selection of fallback_cpu incase more than one exist
   -. modify a comment explaining what we do wrt PREFER_SIBLING

Change from v5
   -. exclude two patches already picked up by peterz
      (sched/deadline: Make find_later_rq() choose a closer cpu in topology)
      (sched/deadline: Change return value of cpudl_find())
   -. apply what peterz fixed for 'prefer sibling', into deadline and rt

Change from v4
   -. remove a patch that might cause huge lock contention
      (by spin lock(&cpudl.lock) in a hot path of scheduler)

Change from v3
   -. rename closest_cpu to best_cpu so that it align with rt
   -. protect referring cpudl.elements with cpudl.lock
   -. change return value of cpudl_find() to bool

Change from v2
   -. add support for SD_PREFER_SIBLING

Change from v1
   -. clean up the patch

Byungchul Park (2):
  sched/deadline: Add support for SD_PREFER_SIBLING on find_later_rq()
  sched/rt: Add support for SD_PREFER_SIBLING on find_lowest_rq()

 kernel/sched/deadline.c | 80 ++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/rt.c       | 78 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 148 insertions(+), 10 deletions(-)

-- 
1.9.1

