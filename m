Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9A2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C98320844
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PdjFS/qI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C98320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbeGITE6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:04:58 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:32823 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932937AbeGITEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:04:55 -0400
Received: by mail-io0-f194.google.com with SMTP id z20-v6so18040460iol.0;
        Mon, 09 Jul 2018 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b43ZRrcQjwJ7nPu+hPQ1uLkF3309Cna5z5YL+VfiKEU=;
        b=PdjFS/qI1Yn3MV1gW+Mem2qK0bWZua6WBX5a6zyJWKifHuothFhqkNi+yeyXxlnXZh
         oQxTRWiiAJr8rwFuzL0YcgqQlUPfgjIaw6ETrOTIhoxl5xWjCS5NLjf/63+tqFKyObP2
         PcuR4iDA7/wzB6B+vnJmezFo0+1nB8y0/Jwts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b43ZRrcQjwJ7nPu+hPQ1uLkF3309Cna5z5YL+VfiKEU=;
        b=I2dzZXY6NaUV1bADhP8POPY0a1OnDbEiTUuLutQAqqgcFy8hU+mNaDCXJmFVYW6qCb
         fb73C3owTtC1XGjJNZsCxwZbyds1gVIV2ihxZaQEJw6KOtF6veXQAVGmdomaKAa7qBvA
         zdgEt3A/fdY1oU1E0glWLo5da6G96YLsxBklLxK9NYJY/1ygIhk66rqTRUguvdVM9oW7
         C3IJQ8zhaCnnPsFfv3mFkIQxfNyve9WmRhrrZNJ6F4Rito4xWapyvP6ujRa2u6r35/7P
         krzHeXD8LvrufcWdmoJAAw+S4yXfKWCJOJp93WYgQjey37iv4rv/o1B4FXh09+WkSPaP
         xvRA==
X-Gm-Message-State: APt69E1tVhPjDaqUqG7R47d3VNUkS2L8owOVePqY0T67zlvp++rWj3ko
        Y0lzNSu4ZYRiLaisjSPIN9I5A+nxsEyx3xeiD7k=
X-Google-Smtp-Source: AAOMgpelpxnlpP+I7/L/kNijInxpOV1gqTe7x3yY5r8n/JSLxjZC/b89q19IF+13whpygOJlDKe4G7gOGvzTAK8vW5Q=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr2903941iom.238.1531163095147;
 Mon, 09 Jul 2018 12:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180708210330.27324-1-mathieu.desnoyers@efficios.com>
 <20180708210330.27324-3-mathieu.desnoyers@efficios.com> <854203778.2272.1531157327328.JavaMail.zimbra@efficios.com>
 <CA+55aFzpjA3r9HdfCU5LrEhSt6S=+RfKuJ2GVc8Wv5Hz-_Me8Q@mail.gmail.com> <1519037424.2393.1531160359475.JavaMail.zimbra@efficios.com>
In-Reply-To: <1519037424.2393.1531160359475.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Jul 2018 12:04:44 -0700
Message-ID: <CA+55aFzC8P=yNc9eNkU+09dUvXJ+MMUXMCCe9kNx6R9MEJ3rjg@mail.gmail.com>
Subject: Re: [PATCH for 4.18 2/6] rseq: use get_user/put_user rather than __get_user/__put_user
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
        Joel Fernandes <joelaf@google.com>,
        Andrew Hunter <ahh@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 11:19 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Given that this memory area has already been checked with access_ok()
> on rseq registration, are you fine with leaving
> __get_user/__put_user/__copy_{from,to}_user in place so we do the
> minimal change at this stage of rc, or should I go ahead and replace
> the lot with get_user/put_user/copy_{from,to}_user ?

Do the full replacement, and let's get this over and done with.

              Linus
