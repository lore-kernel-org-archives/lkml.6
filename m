Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA14FC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E422080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nbeitbzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E422080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeK3Lsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:48:35 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35518 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3Lsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:48:35 -0500
Received: by mail-yw1-f66.google.com with SMTP id h32so1591482ywk.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 16:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5rIEwW9EjTfjTCfJxWzE0pXhFFZR/7GOiBBNHjWMtQ=;
        b=nbeitbzLLkUdVVpiO/8CtMUdHtOuBKeCgZN0W8PlIvw78a08YqSZMC50WwBvB1NXlX
         rJeAWW8yFQYkD0pzWzwKqo9VIU7SriqTrZuZv6S0qpbrrCD5FevKJA/oe9ZwhdDmsH1j
         5QsIZU8g6qNog1DdHRD+ctZpAQ0ijB/GS8+6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5rIEwW9EjTfjTCfJxWzE0pXhFFZR/7GOiBBNHjWMtQ=;
        b=AjnuncYg64BDfZer1VmzHebQ469d2r5qWjWif7CAG3D4ogBDFYfNNCTiZiCu4Y8c0/
         Q0XugMYv6sS29+H4xvrqt7COCeDp6MsTRMPsXF7lo0MShbSluIhvbLTY0ImIcVKDW7do
         QRbeoDnhhOp+XaXc9uNCa+l/BhzlIOH7OJwLI+NQV09O8yiZ43m3A1QXJm/88xF7prQ6
         pO9sFih0npo38FlgPFAGCs49N9UsQLtr8/uutEKjFUUyT+kVlQskSehs1m6UgwkqLh4h
         iUQeTW5/w9VGxiWpALQKGG7Z4aAmPSB9p5WZttWszysD07JrmDgIycAvE2LMSYhmvN02
         kjhg==
X-Gm-Message-State: AA+aEWbuNyjmUushpNh/SDYSeVcvofMFQM+TvdbrJ3qcydpvnMbF/PGC
        aYzW+GGvZznLbPmk+ebG/XlqF2DhEhM=
X-Google-Smtp-Source: AFSGD/Wu7raEpTqhkCqNPSbc6PMGW+1+pX+pQk3OzVql4ug9gzD6rKq09j9pfK1ScPjf0VV8rLVJmw==
X-Received: by 2002:a81:4757:: with SMTP id u84-v6mr3871053ywa.343.1543538469320;
        Thu, 29 Nov 2018 16:41:09 -0800 (PST)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id j6sm1019358ywi.110.2018.11.29.16.41.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 16:41:08 -0800 (PST)
Received: by mail-yw1-f53.google.com with SMTP id x2so1577308ywc.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 16:41:08 -0800 (PST)
X-Received: by 2002:a81:2f0f:: with SMTP id v15mr3909249ywv.124.1543538467761;
 Thu, 29 Nov 2018 16:41:07 -0800 (PST)
MIME-Version: 1.0
References: <1504729681-3504-1-git-send-email-deller@gmx.de>
 <1504729681-3504-10-git-send-email-deller@gmx.de> <CAGXu5jL3qs=YrXWesOueaZYZ8k1qjJ=1HYb9Rmfry8tzvaGY8w@mail.gmail.com>
 <20181129234912.GA7787@agluck-desk>
In-Reply-To: <20181129234912.GA7787@agluck-desk>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 29 Nov 2018 16:40:56 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJEwekbm0rad3=nq785T6yPhDfjF8neq1+WzBBver6mKw@mail.gmail.com>
Message-ID: <CAGXu5jJEwekbm0rad3=nq785T6yPhDfjF8neq1+WzBBver6mKw@mail.gmail.com>
Subject: Re: [PATCH 09/14] fs/pstore: Use %pS printk format for direct addresses
To:     Tony Luck <tony.luck@intel.com>
Cc:     Helge Deller <deller@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 3:49 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Thu, Nov 29, 2018 at 03:26:51PM -0800, Kees Cook wrote:
> > On Wed, Sep 6, 2017 at 1:28 PM Helge Deller <deller@gmx.de> wrote:
> > >
> > > Use the %pS instead of the %pF printk format specifier for printing symbols
> > > from direct addresses. This is needed for the ia64, ppc64 and parisc64
> > > architectures.
> > >
> > > Signed-off-by: Helge Deller <deller@gmx.de>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Tony Luck <tony.luck@intel.com>
> >
> > I missed this email from some time ago. I've now applied it, thanks!
>
> Though it isn't really needed any more. See
>
> 04b8eb7a4ccd ("symbol lookup: introduce dereference_symbol_descriptor()")
>
> which is part of the plan to deprecate %pF

Ah-ha! Okay then, nevermind. :) Thanks!

-- 
Kees Cook
