Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B281C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3448B21848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfBTOhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:37:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfBTOhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:37:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6F4C1440B5;
        Wed, 20 Feb 2019 14:37:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 842C861D06;
        Wed, 20 Feb 2019 14:37:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 20 Feb 2019 15:37:50 +0100 (CET)
Date:   Wed, 20 Feb 2019 15:37:48 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v8 0/7] freezer for cgroup v2
Message-ID: <20190220143748.GA9477@redhat.com>
References: <20190219220252.4906-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219220252.4906-1-guro@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 20 Feb 2019 14:37:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19, Roman Gushchin wrote:
>
> It provides similar functionality as v1 freezer, but the interface
> conforms to the cgroup v2 interface design principles, and it
> provides a better user experience: tasks can be killed, ptrace works,

I tried to not argue with intent, but to be honest I am more and more
sceptical... Lets forget about ptrace for the moment.

Once again, why do we want a killable freezer?

If a user wants to kill a frozen task from CGRP_FROZEN cgroup he can simply

	1. send SIGKILL to that task

	2. migrate it to the root cgroup.

why this doesn't / can't work?



Why I am starting to argue... The ability to kill a frozen task complicates
the code, and since cgroup_enter_stopped() (in this version at least) doesn't
properly interacts with freezable_schedule() leads to other problems.

From 7/7:

	+  cgroup.freeze
	+	A read-write single value file which exists on non-root cgroups.
	+	Allowed values are "0" and "1". The default is "0".
	+
	+	Writing "1" to the file causes freezing of the cgroup and all
	+	descendant cgroups. This means that all belonging processes will
	+	be stopped and will not run until the cgroup will be explicitly
	+	unfrozen. Freezing of the cgroup may take some time;
                                                 ^^^^^^^^^^^^^^^^^^
it may take infinite time.

Just suppose that a task does vfork() and this races with cgroup_do_freeze(true).
If the new child notices JOBCTL_TRAP_FREEZE before exit/exec the cgroup will be
never frozen.

If I read the current kernel/cgroup/freezer.c correctly, CGROUP_FREEZING should
"always" work (unless a task hangs in D state) and to me this looks more important
than kill/ptrace support...

> there is no separate controller, which has to be enabled, etc.

agreed, this is nice.

Oleg.

