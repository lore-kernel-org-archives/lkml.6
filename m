Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC18BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E74217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbfAGPNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:13:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfAGPNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:13:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A324C065F79;
        Mon,  7 Jan 2019 15:13:11 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E59F60CD9;
        Mon,  7 Jan 2019 15:13:04 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] /proc/stat: Reduce irqs counting performance overhead
Date:   Mon,  7 Jan 2019 10:12:56 -0500
Message-Id: <1546873978-27797-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 07 Jan 2019 15:13:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As newer systems have more and more IRQs and CPUs available in their
system, the performance of reading /proc/stat frequently is getting
worse and worse.

Last year, I had proposed patch to extract out the IRQ line of /proc/stat
into a new procfs file. However, this may break existing applications
that depend on the presence of the IRQ line in /proc/stat.

Davidlohr had proposed a new /proc/stat2 file which is almost the same
as /proc/stat except that it has no IRQ line. This will require change
in applications to use the new procfs file.

This patchset uses a different approach to reduce the performance impact
by using a sysctl parameter to control the maximum frequency at which the
IRQ count computation can be done. The result is that the IRQ counts from
/proc/stat may be a bit stale, but still provide the needed information.

Waiman Long (2):
  /proc/stat: Extract irqs counting code into show_stat_irqs()
  /proc/stat: Add sysctl parameter to control irq counts latency

 Documentation/sysctl/fs.txt | 16 +++++++++
 fs/proc/stat.c              | 87 +++++++++++++++++++++++++++++++++++++++------
 kernel/sysctl.c             | 12 +++++++
 3 files changed, 105 insertions(+), 10 deletions(-)

-- 
1.8.3.1

