Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C42EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E4C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E4C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeK2BMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:12:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbeK2BMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:12:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0F96C051663;
        Wed, 28 Nov 2018 14:10:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id 19A346149D;
        Wed, 28 Nov 2018 14:10:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 28 Nov 2018 15:10:56 +0100 (CET)
Date:   Wed, 28 Nov 2018 15:10:50 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        strace-devel@lists.strace.io
Subject: Re: [PATCH v4 2/2] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181128141049.GD30395@redhat.com>
References: <20181128130439.GB28206@altlinux.org>
 <20181128130715.GD28206@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128130715.GD28206@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 28 Nov 2018 14:10:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28, Dmitry V. Levin wrote:
>
> +static unsigned long
> +ptrace_get_syscall_info_entry(struct task_struct *child,
> +			      struct ptrace_syscall_info *info)
> +{
> +	struct pt_regs *regs = task_pt_regs(child);
> +	unsigned long args[ARRAY_SIZE(info->entry.args)];
> +	int i;
> +
> +	info->op = PTRACE_SYSCALL_INFO_ENTRY;
> +	info->arch = syscall_get_arch(child);
> +	info->entry.nr = syscall_get_nr(child, regs);
> +	info->entry.instruction_pointer = instruction_pointer(regs);
> +	info->entry.stack_pointer = user_stack_pointer(regs);
> +	info->entry.frame_pointer = frame_pointer(regs);
> +	syscall_get_arguments(child, regs, 0, ARRAY_SIZE(args), args);
> +	for (i = 0; i < ARRAY_SIZE(args); i++)
> +		info->entry.args[i] = args[i];

I must have missed something, but why do we need the temporary args[],
syscall_get_arguments(..., info->entry.args) should equally work?

Oleg.

