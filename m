Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A77C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 15:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D94218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 15:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbeLYPje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 10:39:34 -0500
Received: from relay.sw.ru ([185.231.240.75]:52714 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbeLYPje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 10:39:34 -0500
Received: from [10.94.4.83] (helo=finist-ce7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <khorenko@virtuozzo.com>)
        id 1gbono-0006n5-5W; Tue, 25 Dec 2018 18:39:28 +0300
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 0/1] mm: add a warning about high order allocations
Date:   Tue, 25 Dec 2018 18:39:26 +0300
Message-Id: <20181225153927.2873-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q: Why do we need to bother at all?
A: If a node is highly loaded and its memory is significantly fragmented
(unfortunately almost any node with serious load has highly fragmented memory)
then any high order memory allocation can trigger massive memory shrink and
result in quite a big allocation latency. And the node becomes less responsive
and users don't like it.
The ultimate solution here is to get rid of large allocations, but we need an
instrument to detect them.

Q: Why warning? Use tracepoints!
A: Well, this is a matter of magic defaults.
Yes, you can use tracepoints to catch large allocations, but you need to do this
on purpose and regularly and this is to be done by every developer which is
quite unreal.
On the other hand if you develop something and get a warning, you'll have to
think about the reason and either succeed with reworking the code to use
smaller allocation sizes (and thus decrease allocation latency!) or just use
kvmalloc() if you don't really need physically continuos chunk or come to the
conclusion you definitely need physically continuos memory and shut up the
warning.

Q: Why compile time config option?
A: In order not to decrease the performance even a bit in case someone does not
want to hunt for large allocations.
In an ideal life i'd prefer this check/warning is enabled by default and may be
even without a config option so it works on every node. Once we find and rework
or mark all large allocations that would be good by default. Until that though
it will be noisy.

Another option is to rework the patch via static keys (having the warning
disabled by default surely). That makes it possible to turn on the feature
without recompiling the kernel - during testing period for example.

If you prefer this way, i would be happy to rework the patch via static keys.

Konstantin Khorenko (1):
  mm/page_alloc: add warning about high order allocations

 kernel/sysctl.c | 15 +++++++++++++++
 mm/Kconfig      | 18 ++++++++++++++++++
 mm/page_alloc.c | 25 +++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

-- 
2.15.1

