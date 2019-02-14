Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A64FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5285E222E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407889AbfBNQaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:30:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfBNQaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:30:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B71F9C049E20;
        Thu, 14 Feb 2019 16:30:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 62AE110027DA;
        Thu, 14 Feb 2019 16:30:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 14 Feb 2019 17:30:21 +0100 (CET)
Date:   Thu, 14 Feb 2019 17:30:19 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v7 0/7] freezer for cgroup v2
Message-ID: <20190214163018.GD19102@redhat.com>
References: <20190212184807.20304-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212184807.20304-1-guro@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 14 Feb 2019 16:30:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12, Roman Gushchin wrote:
>
>   - handle properly the case, when a task is both stopped and frozen

I didn't read this version yet, just looked at

	+static void cgroup_update_frozen(struct cgroup *cgrp)
	+{
	+	bool frozen;
	+
	+	lockdep_assert_held(&css_set_lock);
	+
	+	/*
	+        * If the cgroup has to be frozen (CGRP_FREEZE bit set),
	+        * and all tasks are frozen and/or stopped, let's consider
	+        * the cgroup frozen. Otherwise it's not frozen.
	+        */
	+	frozen = test_bit(CGRP_FREEZE, &cgrp->flags) &&
	+               cgrp->freezer.nr_frozen_tasks +
	+	        cgrp->freezer.nr_stopped_tasks >=
	+	        cgrp->freezer.nr_tasks_to_freeze;

if this is the only change which should handle this case correctly, I doubt it can
help. See another email I sent you a minute ago...

Oleg.

