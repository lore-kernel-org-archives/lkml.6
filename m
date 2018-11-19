Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F2BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8406D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8406D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406953AbeKTDe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:34:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405697AbeKTDez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:34:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 945F23F72E;
        Mon, 19 Nov 2018 17:10:35 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-30.brq.redhat.com [10.40.200.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EACB5D783;
        Mon, 19 Nov 2018 17:10:31 +0000 (UTC)
Date:   Mon, 19 Nov 2018 18:10:53 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119171053.GA28067@asgard.redhat.com>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119103241.5229-3-christian@brauner.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 19 Nov 2018 17:10:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 11:32:39AM +0100, Christian Brauner wrote:
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 3cf7b533b3d1..e637eab883e9 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -398,3 +398,4 @@
>  384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
>  385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
>  386	i386	rseq			sys_rseq			__ia32_sys_rseq
> +387	i386	procfd_signal		sys_procfd_signal		__ia32_sys_procfd_signal
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index f0b1709a5ffb..e95f6741ab42 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -343,6 +343,7 @@
>  332	common	statx			__x64_sys_statx
>  333	common	io_pgetevents		__x64_sys_io_pgetevents
>  334	common	rseq			__x64_sys_rseq
> +335	common	procfd_signal		__x64_sys_procfd_signal

You have wired up the syscall on x86 but have not added the syscall number
to the generic syscall header (include/uapi/asm-generic/unistd.h), why?
