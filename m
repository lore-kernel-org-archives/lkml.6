Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBD4C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED816218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfA3XNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:13:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbfA3XNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:13:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D2767AE93;
        Wed, 30 Jan 2019 22:33:12 +0000 (UTC)
Received: from krava (ovpn-204-189.brq.redhat.com [10.40.204.189])
        by smtp.corp.redhat.com (Postfix) with SMTP id EDC685D787;
        Wed, 30 Jan 2019 22:33:09 +0000 (UTC)
Date:   Wed, 30 Jan 2019 23:33:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        eranian@google.com, vincent.weaver@maine.edu,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Message-ID: <20190130223308.GA8145@krava>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190130183648.GA24233@krava>
 <87zhrhzxpo.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhrhzxpo.fsf@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 30 Jan 2019 22:33:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 12:39:47PM -0800, Andi Kleen wrote:
> Jiri Olsa <jolsa@redhat.com> writes:
> >
> > the patch adds check_eriod pmu callback.. I need to check if there's
> > better way to do this, but so far it fixes the crash for me
> >
> > if you guys could check this patch, that'd be great
> 
> There's already a limit_period callback, perhaps that could
> be extended. But ok, can do it this way too.

right, we call it within x86_perf_event_set_period to limit
the period, but I guess we should include this check after
changing the period:

        if (event->attr.sample_period && x86_pmu.limit_period) {
                if (x86_pmu.limit_period(event, event->attr.sample_period) >
                                event->attr.sample_period)
                        return -EINVAL;
        }

> 
> I suspect there are some other cases that need this callback, not
> just BTS, e.g. the checks in hsw_hw_config

ok, the sample_period values for checkpointed events,
we should check for this as well.. I'll add that

jirka
