Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B13C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159FA20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IVp9ac+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159FA20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeINNRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:17:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37986 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeINNRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7zw0GoZ4/k4I3lHAsMigctwq6xopiSxGxw3nfwml9iQ=; b=IVp9ac+hy27wuOJxprm1eVlzM
        fPQo2MZp+N1KHNVDuagPUXh4h0DI0YoVlw44UvDWspmtg1VY5UAVgiyhfUurTqACV1wjcIVJBUjOI
        2PARAo35jwF2Br1tntmxwGr5gjLupuJNK7x7B2fyBR1M6DoNxcw3bccmxBJVoPvFPXDvx2mndskJc
        HC7FGHwq/WvefVGzJMrCYvJHYQ+HWUry/vEy3C0hTqzImEX4PoWiK13NAgUvkYJf5PTA+jyL3d5cZ
        9AaTwPj8pvVeIcIjubaUBaLdlyDOXUwhFmFuarrz4mG7aHejfxESHBZgFkXFIFwgJidoBkb+5AWJQ
        8I7APrWPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0j5T-0000EK-Jg; Fri, 14 Sep 2018 08:04:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FFDC202B2E3B; Fri, 14 Sep 2018 10:04:22 +0200 (CEST)
Date:   Fri, 14 Sep 2018 10:04:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] PM / suspend: Count suspend-to-idle loop as sleep time
Message-ID: <20180914080422.GG24124@hirez.programming.kicks-ass.net>
References: <9611469.2z7W9akjOQ@aspire.rjw.lan>
 <20180914074052.GF24124@hirez.programming.kicks-ass.net>
 <CAJZ5v0hnchptNz8sHxtuTDbE-f3axgfMgKMgRiasoUv2G7Z0+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hnchptNz8sHxtuTDbE-f3axgfMgKMgRiasoUv2G7Z0+Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 09:47:28AM +0200, Rafael J. Wysocki wrote:
> On Fri, Sep 14, 2018 at 9:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > Do we want a 'warning' of sorts when the delta becomes significant (for
> > whatever that is) ? That might be an indication that there are frequent
> > wakeups which we might not be expecting. Of keep the number of spurious
> > wakeups in a stat counter somewhere -- something to look at if the
> > battery drains faster than expected.
> 
> If you echo 1 to /sys/power/pm_debug_messages, dmesg will tell you
> that (with gory details). :-)

Shiny, didn't know that ;-)
