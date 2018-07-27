Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA80C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016F420857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016F420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389111AbeG0Tyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730636AbeG0Tyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:54:50 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1120F20673;
        Fri, 27 Jul 2018 18:31:42 +0000 (UTC)
Date:   Fri, 27 Jul 2018 14:31:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jann Horn <jannh@google.com>, Golden_Miller83@protonmail.ch,
        greg@kroah.com, Kees Cook <keescook@google.com>,
        salyzyn@android.com, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, kernel-team@android.com, stable@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] tracing: do not leak kernel addresses
Message-ID: <20180727143141.4b53d554@gandalf.local.home>
In-Reply-To: <CAKwvOdmg4DSSwy9YBccYWzc+6ZU2yKSSFmfnj72wqbYDJU0gzw@mail.gmail.com>
References: <20180725202238.165314-1-salyzyn@android.com>
        <20180725210717.3b807191@vmware.local.home>
        <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com>
        <20180726153153.GA8327@kroah.com>
        <CAKwvOdk9s+=kUwcPGQzZNxR7eOGAiiasAyWhZxgKom4_6h+oxA@mail.gmail.com>
        <20180726181558.25a5c3b8@gandalf.local.home>
        <753E9YR1QhdsPhsFoYuXCwfUzfyntDrc_A93hMUkktMi7lbh3KUZMcbfqKVWUfi15zYhuiDFant-ROa4QNV5shx74ff4hGngq2BOJDv-hq4=@protonmail.ch>
        <CAG48ez1U=5nTOrnOqwMuXhdER-7XxJUYLcyYNuczwasQLQ0gXA@mail.gmail.com>
        <20180727094730.3a448629@gandalf.local.home>
        <CAKwvOdmg4DSSwy9YBccYWzc+6ZU2yKSSFmfnj72wqbYDJU0gzw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018 11:13:51 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> I found the internal bug report (reported Jan '17, you'll have to
> forgive me if my memory of the issue is hazy, or if the fix used at
> the time wasn't perfect), which was reported against the Nexus 6.
> >From the report, it was possible to `cat  
> /sys/kernel/debug/tracing/printk_formats` without being root, which I
> can't do on my workstations much more modern kernel (Nexus 6 was
> 3.10).  So I guess the question is what governs access to files below
> /sys/kernel/debug, and why was it missing from those kernels?  I
> assume some check was added, but either not backported to 3.10 stable
> (or more likely not pulled in to Nexus 6's kernel through stable;
> Android is now in a much better place for that kind of issue).

As of commit 82aceae4f0d4 ("debugfs: more tightly restrict default
mount mode") /sys/kernel/debug has been default mounted as 0700 (root
only). But that was introduced in 3.7. Not sure why your 3.10 kernel
didn't have that. Perhaps there's another commit that fixed
permissions not being inherited?

-- Steve
