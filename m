Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GL0WOhd4GVu8LgAAmS7hNA
	; Thu, 07 Jun 2018 18:23:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0050F6074D; Thu,  7 Jun 2018 18:23:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXvoUXqc"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7367D606DD;
	Thu,  7 Jun 2018 18:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7367D606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936251AbeFGSXf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932775AbeFGSXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:23:31 -0400
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0BE208A6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 18:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528395811;
        bh=DGas0yYUuBo/5SrdIsEdP/gAywZcnq69Xrqlg0GVx6w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LXvoUXqcKFc4wkPjVuPKCOr/TI4C4scO5Im/yFQh5NAueRmiV1wM6tNyz1N7qo/zo
         vANLnZcaxJuDwdnu6H6zZex+8iCgSJrwDqdX3ZF2NtNwvqLh4JbtFRuTrNBfeUyWJN
         +/1WJ6scCD8fqKPoUMnyWrWKJHuisAyCiHfmQajo=
Received: by mail-wm0-f42.google.com with SMTP id p11-v6so21003929wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:23:31 -0700 (PDT)
X-Gm-Message-State: APt69E0iWPopkg6gp/yj0FqoOOfh2UQUY1mdNAFR2YtBi3huUrxTeXqN
        Oxz5wGqEY9Na8Ee7fZGVpI1qepiao+cgjRIottYXUw==
X-Google-Smtp-Source: ADUXVKJHpM882L3Q+Vlp7ccJIZHQl5pyTEVjKKBZThX7P6LpV6vD6pAXi9Ss8Cg+Obr4PB58vabINokxGjwRh5gtzrM=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr2481696wma.21.1528395809621;
 Thu, 07 Jun 2018 11:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-2-yu-cheng.yu@intel.com>
 <CALCETrX4ALKbphJiZs4MXWtRFvQYD905bNAMTogbOeLh0Pp6xw@mail.gmail.com> <1528393611.4636.70.camel@2b52.sc.intel.com>
In-Reply-To: <1528393611.4636.70.camel@2b52.sc.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 11:23:18 -0700
X-Gmail-Original-Message-ID: <CALCETrU0gXZOZ90vUSMV_csop2O4TpKW_8D17no-wp-X3nutxA@mail.gmail.com>
Message-ID: <CALCETrU0gXZOZ90vUSMV_csop2O4TpKW_8D17no-wp-X3nutxA@mail.gmail.com>
Subject: Re: [PATCH 01/10] x86/cet: User-mode shadow stack support
To: Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Florian Weimer <fweimer@redhat.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 10:50 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Thu, 2018-06-07 at 09:37 -0700, Andy Lutomirski wrote:
> > On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > >
> > > This patch adds basic shadow stack enabling/disabling routines.
> > > A task's shadow stack is allocated from memory with VM_SHSTK
> > > flag set and read-only protection.  The shadow stack is
> > > allocated to a fixed size and that can be changed by the system
> > > admin.
> >
> > How do threads work?  Can a user program mremap() its shadow stack to
> > make it bigger?
>
> A pthread's shadow stack is allocated/freed by the kernel.  This patch
> has the supporting routines that handle both non-pthread and pthread.
>
> In [PATCH 04/10] "Handle thread shadow stack", we allocate pthread
> shadow stack in copy_thread_tls(), and free it in deactivate_mm().
>
> If clone of a pthread fails, shadow stack is freed in
> cet_disable_free_shstk() below (I will add more comments):
>
> If (Current thread existing)
>         Disable and free shadow stack
>
> If (Clone of a pthread fails)
>         Free the pthread shadow stack
>
> We block mremap, mprotect, madvise, and munmap on a vma that has
> VM_SHSTK (in separate patches).

Why?  mremap() seems like a sensible way to enlarge a shadow stack.
munmap() seems like a good way to get rid of one, and mmap() seems
like a nice way to create a new shadow stack if one were needed (for
green threads or similar).
