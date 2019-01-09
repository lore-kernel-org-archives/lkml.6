Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6331C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60E3214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfAISYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:24:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfAISYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:24:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8010356CF;
        Wed,  9 Jan 2019 18:24:20 +0000 (UTC)
Received: from sky.random (ovpn-123-111.rdu2.redhat.com [10.10.123.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EE9710A1839;
        Wed,  9 Jan 2019 18:24:20 +0000 (UTC)
Date:   Wed, 9 Jan 2019 13:24:18 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] RFC: sched/fair: skip select_idle_sibling() in
 presence of sync wakeups
Message-ID: <20190109182418.GB28624@redhat.com>
References: <20190109034941.28759-1-aarcange@redhat.com>
 <1547007588.17100.17.camel@gmx.de>
 <20190109100751.GQ31517@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109100751.GQ31517@techsingularity.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 09 Jan 2019 18:24:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:07:51AM +0000, Mel Gorman wrote:
> I agree with Mike here. Many previous attempts to strictly obey the strict
> hint has led to regressions elsewhere -- specifically a task waking 2+
> wakees that temporarily stack on one CPU when nearby CPUs sharing LLC

sync-waking 2 wakees in a row before going to sleep should cause the
runqueue to have nr_running != 1 after the first wakee is waken up on
the local CPU. Your example explains the following nr_running == 1
check in the patch:

	    (sync && target == this_cpu && cpu_rq(this_cpu)->nr_running == 1))
					   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The implementation is just an RFC because it may have other drawbacks,
but I thought the second wakee of this specific example supposedly
should still do the idle core/ht balancing normally like before the
change.

Thanks,
Andrea
