Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0201FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBCA216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBCA216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbeKNB6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:58:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbeKNB6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:58:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE39F312E9F6;
        Tue, 13 Nov 2018 16:00:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 45F08600D7;
        Tue, 13 Nov 2018 16:00:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 13 Nov 2018 17:00:06 +0100 (CET)
Date:   Tue, 13 Nov 2018 17:00:04 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Roman Gushchin <guroan@gmail.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Message-ID: <20181113160003.GD30990@redhat.com>
References: <20181112230422.5911-1-guro@fb.com>
 <20181112230422.5911-5-guro@fb.com>
 <20181113153700.GB30990@redhat.com>
 <20181113154349.GF2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113154349.GF2509588@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 13 Nov 2018 16:00:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On 11/13, Tejun Heo wrote:
>
> > OK, please forget for now, but perhaps it would be more clean to add
> > JOBCTL_TRAP_FREEZE to the JOBCTL_PENDING_MASK check in recalc_sigpending()
> > and change get_signal to check JOBCTL_TRAP_MASK | JOBCTL_TRAP_FREEZE; and
> > I am not even sure cgroup_freezer_enter() should live in do_jobctl_trap().
>
> I'm sure you're aware of the context but just to refresh - one thing
> which was really broken about cgroup1 freezer was that it piggybacked
> on hibernation freezer and put frozen tasks in a state which is
> undefined when seen from userspace - they're just stuck in D sleep
> somewhere in the kernel.  That's fine when the whole system is not
> gonna be running, but not when only a subportion is being frozen.

Thanks, I see.

> So, the primary goal of cgroup2 freezer is putting the tasks in an
> equivalent state as jobctl stop.  It's a jobctl stop but controlled by
> cgroup frozen state, meaning that they can be killed, PTRACE_SEIZE'd
> and INTERRUPT'ed (PTRACE_ATTACH doesn't work as signal delivery should
> be blocked but that's fine) and so on.

And I agree, JOBCTL_TRAP_FREEZE looks fine.

Just somehow I _feel_ that we can improve this logic a bit, but let me
repeat that of course I can be easily wrong and I didn't even read the
patch yet.

Oleg.

