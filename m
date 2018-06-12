Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B5FC2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751562089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751562089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754289AbeFLS2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752696AbeFLS2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:28:36 -0400
Received: from vmware.local.home (unknown [107.19.188.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF8120660;
        Tue, 12 Jun 2018 18:28:34 +0000 (UTC)
Date:   Tue, 12 Jun 2018 14:28:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Tobin C. Harding" <me@tobin.cc>, "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] random: Return nbytes filled from hw RNG
Message-ID: <20180612142832.6fe9b9a2@vmware.local.home>
In-Reply-To: <CAHp75Vcqni6MtnLcoMG+2Tt_YeGq2QeQy4myEJp+dmjPXdj3XQ@mail.gmail.com>
References: <1528763954-27731-1-git-send-email-me@tobin.cc>
        <1528763954-27731-3-git-send-email-me@tobin.cc>
        <CAHp75Vcqni6MtnLcoMG+2Tt_YeGq2QeQy4myEJp+dmjPXdj3XQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 11:39:56 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jun 12, 2018 at 3:39 AM, Tobin C. Harding <me@tobin.cc> wrote:
> > Currently the function get_random_bytes_arch() has return value 'void'.
> > If the hw RNG fails we currently fall back to using get_random_bytes().
> > This defeats the purpose of requesting random material from the hw RNG
> > in the first place.  
> 
> > -               int chunk = min(nbytes, (int)sizeof(unsigned long));
> > +               int chunk = min_t(int, left, (int)sizeof(unsigned long));  
> 
> Isn't this (int) implied when you use min_t(int, ...) ?
> 

I would say so...

 #define min_t(type, x, y)	__careful_cmp((type)(x), (type)(y), <)

-- Steve
