Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9D2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D095422CA0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Awusc8NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D095422CA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934710AbeGFTb4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:31:56 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53083 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934493AbeGFTby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:31:54 -0400
Received: by mail-it0-f67.google.com with SMTP id p4-v6so17893138itf.2;
        Fri, 06 Jul 2018 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWTzVI7PHGJeOddwFuS8XZIS1wkI0ra1pYlAy5iZCeY=;
        b=Awusc8NQv7hmiiw9hI7G2wOuoXiHT+5m5H38yh/guO5U1r4Q3I0EGOy0tGd+IEocsH
         SlWbQfepiE1zExdBt5V6Szuix/4KjzXPYwBPsMvwryVbOjDhJvOiqg5m/s3lbqcFx7ws
         f3SydcsfQqioAFw/QP+sntIjvuAy4+Nea6ifM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWTzVI7PHGJeOddwFuS8XZIS1wkI0ra1pYlAy5iZCeY=;
        b=Nzha+xkIOSn1xgquwTrIsYCc12jalyYccgscrF7z4rRkzTjCVI1tYF6N9cT03sptUY
         PzKEe/iSxy/UhPz1RG0IeIy/xf3McT8uoC53dGVYcr5v4gAjRlYwpZgEtQzOgp7WGOR1
         PSjMYHqx+R3h28Q8aCjrn3mal5HuW63vz+AKi0Wbgi2Ty1fj9Wbfizx8yd2/o35mmH14
         6gD8wY8M1lxT7e9uQh6N9KNjdCoiNQu7CcOZLPKcEeaIDZCWebSmreStH925eM1sgkV6
         09CZLLq0XD+1ohx1gfNv2S3HkPLvN1H7dSsWZwmRcbqcSGfKzJIbQ2zxBJv2MdsmcSWd
         FnIA==
X-Gm-Message-State: APt69E29wKkAvET2mGVVK0+ozfS+nahWswBb5+2FoOx3Oyfp0WuazwF9
        7O0tVZlDT7uX3ypCWF2yiSEh48Q5/x7G3BYQWyQ=
X-Google-Smtp-Source: AAOMgpdoobpU568vggKCfLoeY30l+6L/fmJPMazqsjhe6XIq1GA/sYeYddRxDYONIAfppLl9OG0BDSkvFb0F4UL9y8I=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr8862485itg.1.1530905513786;
 Fri, 06 Jul 2018 12:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180705180601.18423-1-mathieu.desnoyers@efficios.com>
 <20180705180601.18423-4-mathieu.desnoyers@efficios.com> <1846432971.1245.1530892973439.JavaMail.zimbra@efficios.com>
 <436937568.1359.1530905019620.JavaMail.zimbra@efficios.com>
In-Reply-To: <436937568.1359.1530905019620.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jul 2018 12:31:42 -0700
Message-ID: <CA+55aFzz1CC6son0T2nD-Yqhy0_yC5nBer2XSH9kqe5x3N26Ug@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 3/5] rseq: uapi: declare rseq_cs field as
 union, update includes
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 12:23 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> For -rc, I would favor the following simpler approach. Or I could even
> just use get_user() instead. Thoughts ?

Please just use "get_user()".

In fact, we should be thinking seriosly about just removing
__get_user() entirely. It's wrong. It optimizes the wrong thing
entirely. It _used_ to be that the range check was noticeable, and it
really isn't any more. These days the expensive parts are the SMAP
costs, and both get_user() and __get_user() have those, except
get_user() is safer and doesn't waste I$ on inlining the code to
disable and re-enable SMAP.

                Linus
