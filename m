Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B296C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684362082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684362082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeLKKkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:40:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKKkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:40:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FC2D3082E52;
        Tue, 11 Dec 2018 10:40:31 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-82.ams2.redhat.com [10.36.116.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF0005D964;
        Tue, 11 Dec 2018 10:40:24 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at nptl init and thread creation (v4)
References: <20181204192141.4684-1-mathieu.desnoyers@efficios.com>
Date:   Tue, 11 Dec 2018 11:40:22 +0100
Message-ID: <87h8fkz6qx.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 11 Dec 2018 10:40:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> I want to keep the __rseq_refcount symbol so out-of-libc users can
> register rseq if they are linked against a pre-2.29 libc.

Sorry, I was confused.

> diff --git a/csu/Makefile b/csu/Makefile
> index 88fc77662e..81d471587f 100644
> --- a/csu/Makefile
> +++ b/csu/Makefile
> @@ -28,7 +28,7 @@ include ../Makeconfig
>  
>  routines = init-first libc-start $(libc-init) sysdep version check_fds \
>  	   libc-tls elf-init dso_handle
> -aux	 = errno
> +aux	 = errno rseq
>  elide-routines.os = libc-tls
>  static-only-routines = elf-init
>  csu-dummies = $(filter-out $(start-installed-name),crt1.o Mcrt1.o)

Do we plan to add Hurd support for this?

> diff --git a/sysdeps/unix/sysv/linux/rseq-internal.h b/sysdeps/unix/sysv/linux/rseq-internal.h
> new file mode 100644
> index 0000000000..2367926def
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/rseq-internal.h

> +#define RSEQ_SIG 0x53053053

What's this?  This needs a comment.

> +extern __thread volatile struct rseq __rseq_abi
> +__attribute__ ((tls_model ("initial-exec")));
> +
> +extern __thread volatile uint32_t __rseq_refcount
> +__attribute__ ((tls_model ("initial-exec")));

The volatile qualifier needs justification in a comment.  (Usually,
volatile is wrong. and it is difficult to get rid of it.)

We need to document these public symbols somewhere.  There should be an
installed header file.

> diff --git a/nptl/Versions b/nptl/Versions
> index e7f691da7a..f7890f73fc 100644
> --- a/nptl/Versions
> +++ b/nptl/Versions
> @@ -277,6 +277,10 @@ libpthread {
>      cnd_timedwait; cnd_wait; tss_create; tss_delete; tss_get; tss_set;
>    }
>  
> +  GLIBC_2.29 {
> +    __rseq_refcount;
> +  }

Why put this into libpthread, and __rseq_abi into libc?

What, exactly, is the benefit of having __rseq_refcount defined by
glibc?  Have you actually got this working?  If an rseq library is
linked against glibc 2.29, it will reference the GLIBC_2.29 symbol
version, so it cannot be loaded by older glibcs.  In this case,
__rseq_refcount is not needed.

If you build against pre-2.29, then the __rseq_refcount symbol will be
unversioned.  But then you don't need it glibc, either.

So it seems to me that the addition to glibc is useless in both
scenarios.  Am I missing something?

By the way, you could avoid the need for unregistration if you allocated
the rseq areas persistently, index by TID.  They are quite small, so
with the typical PID range, maybe the wasted memory due to changing TIDs
would be acceptable?

I guess things would be so much easier if the kernel simply provided a
means to obtain the address of a previously registered rseq area.

Thanks,
Florian
