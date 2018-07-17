Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD3ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E14C20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E14C20C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbeGQK2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:28:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729701AbeGQK2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:28:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6204A40122A2;
        Tue, 17 Jul 2018 09:56:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 71A28111DD0A;
        Tue, 17 Jul 2018 09:56:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 17 Jul 2018 11:56:31 +0200 (CEST)
Date:   Tue, 17 Jul 2018 11:56:28 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Subject: Re: [RFC][PATCH 07/11] signal: Deliver group signals via
 PIDTYPE_TGID not PIDTYPE_PID
Message-ID: <20180717095628.GA27482@redhat.com>
References: <877em2jxyr.fsf_-_@xmission.com>
 <20180711024459.10654-7-ebiederm@xmission.com>
 <20180716125144.GA18262@redhat.com>
 <8736wjtetv.fsf@xmission.com>
 <CA+55aFxDsE8sb5wQQNJdxvt8m6n6aVpOo1yVpk1BEzXDv8XzaQ@mail.gmail.com>
 <87bmb7oy94.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmb7oy94.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 17 Jul 2018 09:56:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 17 Jul 2018 09:56:31 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16, Eric W. Biederman wrote:
>
> There are two questions.
> a) Can we use the pid of a thread to find the thread group?
> b) Will the signal be queued in the thread group?

IMO "yes" to both questions, I simply see no reason to change the current
semantics. Even if glibc doesn't show the tread id's a user can see them
in /proc/$tgid/task/. So I think kill_pid_info() should just do

	p = pid_task(pid, PIDTYPE_PID);
	group_send_sig_info(p, PIDTYPE_TGID);

again, posix_timer_event() looks fine, but to me

	pid_task(timr->it_pid, shared ? PIDTYPE_TGID : PIDTYPE_PID)

looks like unnecessary complication,

	pid_task(timr->it_pid, PIDTYPE_PID);

should do the same thing.

And, I didn't mention this yesterday, but probably the next 08/11 patch can
have the same problem. But this is a bit more complicated because send_sigio()
uses the same "type" both for do_each_pid_task() and as an argument passed to
do_send_sig_info().

Oleg.

