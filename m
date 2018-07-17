Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A09ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA547208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA547208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbeGQMcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:32:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731154AbeGQMcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:32:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5D1E402332F;
        Tue, 17 Jul 2018 11:59:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5D8252026D68;
        Tue, 17 Jul 2018 11:59:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 17 Jul 2018 13:59:54 +0200 (CEST)
Date:   Tue, 17 Jul 2018 13:59:52 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
Subject: Re: [RFC][PATCH 05/11] pids: Move the pgrp and session pid pointers
 from task_struct to signal_struct
Message-ID: <20180717115952.GA29647@redhat.com>
References: <877em2jxyr.fsf_-_@xmission.com>
 <20180711024459.10654-5-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711024459.10654-5-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 17 Jul 2018 11:59:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 17 Jul 2018 11:59:54 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bit offtopic/cosmetic and we can do this later, just for record
before I forget this...

On 07/10, Eric W. Biederman wrote:
>
> +static struct pid **task_pid_ptr(struct task_struct *task, enum pid_type type)
> +{
> +	return (type == PIDTYPE_PID) ?
> +		&task->thread_pid :
> +		(type == __PIDTYPE_TGID) ?
> +		&task->signal->leader_pid :
> +		&task->signal->pids[type];
> +}

This new helper is (simplified after you removed __PIDTYPE_TGID/leader_pid) can
have more users: task_pid_type(), init_task_pid(). In fact even (say) task_tgid()
can use it if we export it inline.

And if we make task_pid_ptr() the only user of signal->pids[] array we can shrink
it, signal->pids[0] is not used. Or may be we can simply redefine enum pid_type,
we can define PIDTYPE_PID == -1 or move it at the end, or do something else.

Once again, this is just random/minor thoughts, feel free to ignore.

Oleg.

