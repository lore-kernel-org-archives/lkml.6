Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3217BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF55C20824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF55C20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438141AbeKWDHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:07:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733000AbeKWDHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:07:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F2CD3078A33;
        Thu, 22 Nov 2018 16:27:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.142])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2EF6C60610;
        Thu, 22 Nov 2018 16:27:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 22 Nov 2018 17:27:11 +0100 (CET)
Date:   Thu, 22 Nov 2018 17:27:09 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, stable@kernel.org
Subject: Re: [PATCH] uprobes: Fix handle_swbp() vs. unregister() + register()
 race once more
Message-ID: <20181122162708.GH28270@redhat.com>
References: <20181122161031.15179-1-andrea.parri@amarulasolutions.com>
 <20181122161942.GG28270@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122161942.GG28270@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 22 Nov 2018 16:27:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22, Oleg Nesterov wrote:
> On 11/22, Andrea Parri wrote:
> >
> > Commit 142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() +
> > register() race") added the UPROBE_COPY_INSN flag, and corresponding
> > smp_wmb() and smp_rmb() memory barriers, to ensure that handle_swbp()
> > uses fully-initialized uprobes only.
> > 
> > However, the smp_rmb() is mis-placed: this barrier should be placed
> > after handle_swbp() has tested for the flag, thus guaranteeing that
> > (program-order) subsequent loads from the uprobe can see the initial
> > stores performed by prepare_uprobe().
> > 
> > Move the smp_rmb() accordingly.  Also amend the comments associated
> > to the two memory barriers to indicate their actual locations.
> > 
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: stable@kernel.org
> > Fixes: 142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() + register() race")
> 
> Thanks,
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>

Yes, but I am not sure this is the -stable material...

Oleg.

