Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A34C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D4F2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbfA3QwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:52:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42029 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732276AbfA3QwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:52:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B3D4C0DA365;
        Wed, 30 Jan 2019 16:52:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9DA49176DE;
        Wed, 30 Jan 2019 16:52:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 30 Jan 2019 17:52:03 +0100 (CET)
Date:   Wed, 30 Jan 2019 17:52:01 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v6 4/7] cgroup: cgroup v2 freezer
Message-ID: <20190130165200.GA4131@redhat.com>
References: <20181222000307.28231-1-guro@fb.com>
 <20181222000307.28231-5-guro@fb.com>
 <20190125122713.GA18218@redhat.com>
 <CALo0P13XnGiFykMXY3ZKu158ZqnBwHru0gyhQUrJSHEprnmiHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALo0P13XnGiFykMXY3ZKu158ZqnBwHru0gyhQUrJSHEprnmiHQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 30 Jan 2019 16:52:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On 01/28, Roman Gushchin wrote:
>
> Yes, I think you're right: cgroup_exit() should check CGRP_FREEZE bit,
> not CGRP_FROZEN. Like cgroup_post_fork() does (a one-liner change below).

but this won't fix all problems? it seems that you missed my other concerns.

Firstly, this doesn't look consistent. Suppose a cgroup contains a single
process sleeping in ptrace_stop(). Then it becomes CGRP_FROZEN right after
"echo 1 > cgroup.freeze".

OTOH. if this single task sleeps in do_freezer_trap() and gets PTRACE_INTERRUPT,
it will equally sleep ptrace_stop() but cgroup won't be CGRP_FROZEN. Never.

Worse, this looks just wrong. In the latter case, cgroup becomes CGRP_FROZEN
right after a 2nd task migrates to this cgroup, before this new task calls
do_freezer_trap() or cgroup_enter_stopped().



> About spurious transitions (like frozen->non frozen->frozen on a task
> being SIGKILLed):
> in early versions of the patchset I've tried to avoid them, but then
> following the Tejun's advice
> switched over to expose them to a user. The logic behind is simple: if
> the state of the cgroup has been changed (a task is gone, for
> example), let's notify a user.

OK, I won't argue...

actually I can't argue because I do not really understand why do we want
a "killable" freezer, let alone ptraceable ;)

Oleg.

