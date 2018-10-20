Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4784C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 08:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756D521476
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 08:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756D521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJTQl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 12:41:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55596 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbeJTQl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 12:41:27 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3712812DE57FB;
        Sat, 20 Oct 2018 01:31:49 -0700 (PDT)
Date:   Sat, 20 Oct 2018 01:31:38 -0700 (PDT)
Message-Id: <20181020.013138.902940115880074117.davem@davemloft.net>
To:     acme@kernel.org
CC:     linux-kernel@vger.kernel.org
Subject: perf handling of unknown symbols...
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 20 Oct 2018 01:31:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I was able to, I think, track down why I get unknown symbols with perf
top.

It happens for processes that start up while perf is running.

It's due to races if a process changes it's address space really
quickly while perf is processing all of the events.

If we are probing procfs and/or sysfs or something like that to gather
information before a process exec'd or fork'd, but after it has done
so, the dso lookups and stuff are going to fail.

So we end up with an unresolvable dso, and an al.sym which is NULL and
then we hit this check in perf_event__process_sample() of
builtin-top.c:

	if (al.sym == NULL || !al.sym->idle) {

Before 2011 and commit:

commit ab81f3fd350c510730adb1ca40ef55c2b2952121
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Oct 5 19:16:15 2011 -0300

    perf top: Reuse the 'report' hist_entry/hists classes

the test was just:

	if (!al.sym->ignore) {

and the commit message even mentions:

    This actually fixes several problems we had in the old 'perf top':
    
    1. Unresolved symbols not show, limitation that came from the old
       "KernelTop" codebase, to solve it we would need to do changes
       that would make sym_entry have most of the hist_entry fields.
 ...

The problem with still processing samples without a resolved symbol is
that these histogram entries created will "poison" that memory area.

We end up with all of these histogram entries, one for every single PC
ever sampled in these temporarily unresolvable areas.  So all future
samples match up, and accumulate, into those unresolved entries.

They never get collapsed back into a histogram entry which covers the
eventually resolved symbol's range.

If symbol resolution is in fact racy as I describe above, then we
should handle unresolved symbols better.  Especially the case where an
initially unresolved area becomes resolved.
