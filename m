Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5839CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF5520840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF5520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeKITBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:01:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeKITBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:01:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1F814DB1F;
        Fri,  9 Nov 2018 09:21:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4B1BD1062253;
        Fri,  9 Nov 2018 09:21:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  9 Nov 2018 10:21:28 +0100 (CET)
Date:   Fri, 9 Nov 2018 10:21:24 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Chanho Min <chanho.min@lge.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Seungho Park <seungho1.park@lge.com>,
        Inkyu Hwang <inkyu.hwang@lge.com>,
        Donghwan Jung <donghwan.jung@lge.com>,
        Jongsung Kim <neidhard.kim@lge.com>
Subject: Re: [PATCH] exec: make de_thread() freezable
Message-ID: <20181109092123.GA29945@redhat.com>
References: <1541752656-12857-1-git-send-email-chanho.min@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541752656-12857-1-git-send-email-chanho.min@lge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 09 Nov 2018 09:21:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09, Chanho Min wrote:
>
> @@ -1083,7 +1084,7 @@ static int de_thread(struct task_struct *tsk)
>  	while (sig->notify_count) {
>  		__set_current_state(TASK_KILLABLE);
>  		spin_unlock_irq(lock);
> -		schedule();
> +		freezable_schedule();

Thanks, but please note another schedule() in "if (!thread_group_leader(tsk))"
branch, we probably want to change it too?

Oleg.

