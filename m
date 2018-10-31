Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F96C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979D62081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UX9JeRNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979D62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeKAEOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:14:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42840 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKAEOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sLfGGg3UKKR5IgLZJ/dtj6dlYAs1m3mJoJC3Asu1I7c=; b=UX9JeRNqibDQwiMknisbzzY35
        vY4oML+3UbkHZfyuAonQS82JPIBQp5UOVwG9cuZsGrf6q/K+/G3uIbHgKxRV3DF7udmsgJ0NNBtX4
        ae9Ld2nZfWXjbFHxB1hq3l0xfr+0+UzhMcO/aaKiHtgwV5QTTgmoiZV10RwLrVS18h7WbicC4fgAO
        Y6N2QZKJQ85hkb80aaZd+9FBFBrFuz1a5QT5jUtM5RB3PZxZWyPC4kiHMf/ih8hNmLEixa6f466gp
        99x4yLDkz+EfHAfs/dELwF7Eg6u5plazLof0wc9Y+Ho7HTtRbdwanlwS00UTq0KuW3Yq/5XTgS+n9
        ZJDaQaW7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHvxF-0006PI-UI; Wed, 31 Oct 2018 19:15:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9E5D20296F15; Wed, 31 Oct 2018 20:14:59 +0100 (CET)
Date:   Wed, 31 Oct 2018 20:14:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] sched/fair: Provide can_migrate_task_llc
Message-ID: <20181031191459.GA3141@hirez.programming.kicks-ass.net>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-8-git-send-email-steven.sistare@oracle.com>
 <f75ddcd5-f9a0-30c5-94e4-c4077e17ffb0@arm.com>
 <b9915490-661b-0d0e-ae60-d5803357e1ec@oracle.com>
 <b7d91b1d-5da1-5d70-f266-93b108379b64@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7d91b1d-5da1-5d70-f266-93b108379b64@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 07:34:50PM +0000, Valentin Schneider wrote:
> On a sidenote, I find it a bit odd that the exec_start threshold depends on
> sysctl_sched_migration_cost, which to me is more about idle_balance() cost
> than "how long does it take for a previously run task to go cache cold".

A long long (think 2.6.20 long ago) there was code that did boot-time
measurement of the various cache topology costs and that threshold was
related to that.

That code got killed because of boot to boot variance and dubious
benefits.

The migration cost is what it was replaced with as a single measure.

migration cost was then later abused in the newidle balance because it
was over eager. Ideally we'd get rid of it there, because we've now got
that much more elaborate accounting, but Rohit tried and found some
regression because of that.

Maybe we should remove it from newidle anyway.
