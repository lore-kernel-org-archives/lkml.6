Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E5CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4579F20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4579F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391253AbeKVW04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:26:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11949 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbeKVW04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:26:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5301C394D30;
        Thu, 22 Nov 2018 11:47:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.142])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3CB34103BAB7;
        Thu, 22 Nov 2018 11:47:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 22 Nov 2018 12:47:54 +0100 (CET)
Date:   Thu, 22 Nov 2018 12:47:52 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ptrace: take into account saved_sigmask in
 PTRACE_{GET,SET}SIGMASK
Message-ID: <20181122114751.GA28270@redhat.com>
References: <20181120060616.6043-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120060616.6043-1-avagin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 22 Nov 2018 11:47:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19, Andrei Vagin wrote:
>
>  	case PTRACE_SETSIGMASK: {
>  		sigset_t new_set;
> @@ -962,6 +971,8 @@ int ptrace_request(struct task_struct *child, long request,
>  		child->blocked = new_set;
>  		spin_unlock_irq(&child->sighand->siglock);
>
> +		clear_tsk_restore_sigmask(child);
> +

I am not sure I understand this change...

I forgot everything I knew about criu, but iiuc PTRACE_SETSIGMASK is used
at "restore" time, doesn't this mean that TIF_RESTORE_SIGMASK/restore_sigmask
can not be set?

IOW, could you please explain how PTRACE_SETSIGMASK should be used, and why
it doesn't do something like

	if (test_tsk_restore_sigmask(child))
		child->saved_sigmask = new_set;
	else
		child->blocked = new_set;

which looks symmetrical to PTRACE_GETSIGMASK?

Oleg.

