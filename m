Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF99C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C99520839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C99520839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeLLSAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:00:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbeLLSAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:00:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCA78C058CB3;
        Wed, 12 Dec 2018 18:00:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.131])
        by smtp.corp.redhat.com (Postfix) with SMTP id 626CF61478;
        Wed, 12 Dec 2018 18:00:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 12 Dec 2018 19:00:24 +0100 (CET)
Date:   Wed, 12 Dec 2018 19:00:17 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        strace-devel@lists.strace.io, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 24/25] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181212180017.GB30309@redhat.com>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043126.GX6131@altlinux.org>
 <20181210141107.GB4177@redhat.com>
 <20181210162131.GG14149@altlinux.org>
 <20181211152953.GA8504@redhat.com>
 <20181211162305.GA480@altlinux.org>
 <20181211202709.GA3839@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211202709.GA3839@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 12 Dec 2018 18:00:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11, Dmitry V. Levin wrote:
>
> > > Still can't understand... are you saying that without (say) __pad2[4]
> > > sizeof(ptrace_syscall_info) or offsetofend(ptrace_syscall_info, seccomp)
> > > will depend on arch? Or what? I am just curious.
> >
> > Yes, without padding these sizes will depend on architecture:
>
> > $ cat t.c
> > #include <linux/types.h>
> > int main() {
> > 	struct s {
> > 		__u64 nr;
> > 		__u64 args[6];
> > 		__u32 ret_data;
> > 	};
> > 	return sizeof(struct s);
> > }
> >
> > $ gcc -m64 -Wall -O2 t.c && ./a.out; echo $?
> > 64
> > $ gcc -m32 -Wall -O2 t.c && ./a.out; echo $?
> > 60
> >
> > This happens because __u64 has 32-bit alignment on some 32-bit
> > architectures like x86.
> >
> > There is also m68k where __u32 has 16-bit alignment.

OK, thanks,

> Said that, I think it would be better if PTRACE_GET_SYSCALL_INFO
> did not take these trailing pads into account, e.g.
>
> -       return offsetofend(struct ptrace_syscall_info, seccomp);
> +       return offsetofend(struct ptrace_syscall_info, seccomp.ret_data);
> ...
> -       return offsetofend(struct ptrace_syscall_info, exit);
> +       return offsetofend(struct ptrace_syscall_info, exit.is_error);
>
> The reason is that it would allow to fill these trailing pads with
> something useful in the future.

Agreed.

But this way everything looks even more confusing. To me it would be
better to simply remove these pads, but I won't insist.

Oleg.

