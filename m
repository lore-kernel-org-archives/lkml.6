Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD60ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51972084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51972084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeGRE7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:59:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeGRE7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:59:01 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 260D9891;
        Wed, 18 Jul 2018 04:23:08 +0000 (UTC)
Date:   Tue, 17 Jul 2018 21:23:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bruce Merry <bmerry@ska.ac.za>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some
 machines
Message-Id: <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
In-Reply-To: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc linux-mm)

On Tue, 3 Jul 2018 08:43:23 +0200 Bruce Merry <bmerry@ska.ac.za> wrote:

> Hi
> 
> I've run into an odd performance issue in the kernel, and not being a
> kernel dev or knowing terribly much about cgroups, am looking for
> advice on diagnosing the problem further (I discovered this while
> trying to pin down high CPU load in cadvisor).
> 
> On some machines in our production system, cat
> /sys/fs/cgroup/memory/memory.stat is extremely slow (500ms on one
> machine), while on other nominally identical machines it is fast
> (2ms).
> 
> One other thing I've noticed is that the affected machines generally
> have much larger values for SUnreclaim in /proc/memstat (up to several
> GB), and slabtop reports >1GB of dentry.
> 
> Before I tracked the original problem (high CPU usage in cadvisor)
> down to this, I rebooted one of the machines and the original problem
> went away, so it seems to be cleared by a reboot; I'm reluctant to
> reboot more machines to confirm since I don't have a sure-fire way to
> reproduce the problem again to debug it.
> 
> The machines are running Ubuntu 16.04 with kernel 4.13.0-41-generic.
> They're running Docker, which creates a bunch of cgroups, but not an
> excessive number: there are 106 memory.stat files in
> /sys/fs/cgroup/memory.
> 
> Digging a bit further, cat
> /sys/fs/cgroup/memory/system.slice/memory.stat also takes ~500ms, but
> "find /sys/fs/cgroup/memory/system.slice -mindepth 2 -name memory.stat
> | xargs cat" takes only 8ms.
> 
> Any thoughts, particularly on what I should compare between the good
> and bad machines to narrow down the cause, or even better, how to
> prevent it happening?
> 
> Thanks
> Bruce
> -- 
> Bruce Merry
> Senior Science Processing Developer
> SKA South Africa
