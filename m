Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE06C2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB47A20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfAURFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:05:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfAURFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:05:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DE603D962;
        Mon, 21 Jan 2019 17:05:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3CE4360A9F;
        Mon, 21 Jan 2019 17:05:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 21 Jan 2019 18:05:14 +0100 (CET)
Date:   Mon, 21 Jan 2019 18:05:12 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        keescook@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 1/5] sched: convert sighand_struct.count to refcount_t
Message-ID: <20190121170511.GA8088@redhat.com>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
 <1547814450-18902-2-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547814450-18902-2-git-send-email-elena.reshetova@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 21 Jan 2019 17:05:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/18, Elena Reshetova wrote:
>
> --- a/fs/proc/task_nommu.c
> +++ b/fs/proc/task_nommu.c
> @@ -64,7 +64,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>  	else
>  		bytes += kobjsize(current->files);
>  
> -	if (current->sighand && atomic_read(&current->sighand->count) > 1)
> +	if (current->sighand && refcount_read(&current->sighand->count) > 1)
>  		sbytes += kobjsize(current->sighand);
>  	else
>  		bytes += kobjsize(current->sighand);

I fail to understand this code with or without the patch... I do not see
how is it possible to hit ->sighand == NULL or sighand->count == 0 in
proc_pid_status() paths.

Nevermind, this is off-topic.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

