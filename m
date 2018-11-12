Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1744C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6E3223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6E3223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeKLSH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:07:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbeKLSH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:07:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AA0030832EE;
        Mon, 12 Nov 2018 08:15:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2EDED5C1B4;
        Mon, 12 Nov 2018 08:15:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 12 Nov 2018 09:15:22 +0100 (CET)
Date:   Mon, 12 Nov 2018 09:15:18 +0100
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
Subject: Re: [PATCH v2] exec: make de_thread() freezable
Message-ID: <20181112081517.GA23178@redhat.com>
References: <1541994885-20059-1-git-send-email-chanho.min@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541994885-20059-1-git-send-email-chanho.min@lge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 12 Nov 2018 08:15:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12, Chanho Min wrote:
>
> @@ -1083,7 +1084,7 @@ static int de_thread(struct task_struct *tsk)
>  	while (sig->notify_count) {
>  		__set_current_state(TASK_KILLABLE);
>  		spin_unlock_irq(lock);
> -		schedule();
> +		freezable_schedule();
>  		if (unlikely(__fatal_signal_pending(tsk)))
>  			goto killed;
>  		spin_lock_irq(lock);
> @@ -1111,7 +1112,7 @@ static int de_thread(struct task_struct *tsk)
>  			__set_current_state(TASK_KILLABLE);
>  			write_unlock_irq(&tasklist_lock);
>  			cgroup_threadgroup_change_end(tsk);
> -			schedule();
> +			freezable_schedule();
>  			if (unlikely(__fatal_signal_pending(tsk)))
>  				goto killed;
>  		}

Thanks, looks good to me.

Acked-by: Oleg Nesterov <oleg@redhat.com>

