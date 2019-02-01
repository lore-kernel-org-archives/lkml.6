Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3CFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB20E20B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfBAFhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:37:16 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39143 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfBAFhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:37:15 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5E3E8C0002;
        Fri,  1 Feb 2019 05:37:11 +0000 (UTC)
Date:   Fri, 1 Feb 2019 06:37:10 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 0/3] sched/wait, staging/android: simplification and
 optimization of freeze related code
Message-ID: <cover.1548998323.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset changes the wait api to use freezable_schedule when
possible and adds a new wait_event_freezable_hrtimeout method.

wait_event_freezable_hrtimeout is then used to greatly simplify
handle_vsoc_cond_wait in the android vsoc driver.

This reduces the size of the vsoc driver and allows for potential
performance gain during freeze in the wait api.

This is a follow up of my previous patch "sched/wait: introduce
wait_event_freezable_hrtimeout"[0]. More information related to the
performance gain by using freezable_schedule can be found in the
previous discussion[1].

[0] https://lkml.org/lkml/2019/1/17/877
[1] https://lkml.org/lkml/2019/1/19/58

Hugo Lefeuvre (3):
  sched/wait: use freezable_schedule when possible
  sched/wait: introduce wait_event_freezable_hrtimeout
  staging/android: simplify handle_vsoc_cond_wait

 drivers/staging/android/vsoc.c | 69 +++++-----------------------------
 include/linux/wait.h           | 31 +++++++++++----
 2 files changed, 34 insertions(+), 66 deletions(-)

-- 
2.20.1
