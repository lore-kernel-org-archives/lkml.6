Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1325AC7113C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC03A2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="v/l9nPGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfATP6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:58:42 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43225 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfATP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 10:58:41 -0500
Received: by mail-qt1-f194.google.com with SMTP id i7so20518793qtj.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 07:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jTmIghGjwE8iHAb3Dh6gyTw5bykolHFzGqZYxXOr2j4=;
        b=v/l9nPGTlkHu6FuY5yAwwmDsblcdJb5KPsIbmx7UFTrLehP1ann8DWpXqMPg0hj1QM
         8IyvYAh22vUnNQkdlhuR7ZqPufE4+31/zcOC528V1UG0DLtZ/J00sW5fBgy+eQwfl0Nw
         JlowaEMaZyxnRBY2jZBpfGaxzLB9mbe3F3UDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jTmIghGjwE8iHAb3Dh6gyTw5bykolHFzGqZYxXOr2j4=;
        b=VgtQvSdLHSmeH2b654KKPzmzzxVB+hhu0BrgIYPbGHlQJgemKzLJls1/6Gp9Gz6dx+
         xC0J8koZKKixqfG8nXWi+IQBbTXfizQHk7mwqWBZr6YNquuyIL/O+EyYG3VwsgLFZa3g
         hnX0+NdqjUgmRv+9yrVr+36ewidz0Bm6f7lWv3Ug31l26oSMJN16ziBrmcz8x82ZFhUg
         b1vga2hcCwAlkqL+mqY7DBjfsWu/V7kxLGzYF48UidQo69EEfotDZPCJKuH5bp283hp4
         tU68piLtcqC40+HVZPFMZphIzw6GUBZJDaW8raseCSXNaFUM2Sm+nhlrnwpXHQrQYoYJ
         O6OQ==
X-Gm-Message-State: AJcUukfzPrHpqegz5SwMl4kg5Z2fy2BODhaHTM9kZ+Y803WCtrCYc5/5
        ecGvyca3IPGazSwPRrF0lTpkiA==
X-Google-Smtp-Source: ALg8bN4lsruMAyRqU0ZYWrFBs3u2WffgphkfI6XIyyyI1N2qY+H1zEGQ4PgNNRC40HeCXR+sb83g9w==
X-Received: by 2002:ac8:1712:: with SMTP id w18mr23293243qtj.76.1547999920270;
        Sun, 20 Jan 2019 07:58:40 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id a17sm55244827qth.93.2019.01.20.07.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 07:58:39 -0800 (PST)
Date:   Sun, 20 Jan 2019 10:58:38 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     hpa@zytor.com
Cc:     Daniel Colascione <dancol@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
Message-ID: <20190120155838.GA23827@google.com>
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com>
 <20190119162754.GC231277@google.com>
 <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
 <20190119232503.GA149403@google.com>
 <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 03:44:48PM -0800, hpa@zytor.com wrote:
> On January 19, 2019 3:25:03 PM PST, Joel Fernandes <joel@joelfernandes.org> wrote:
> >On Sat, Jan 19, 2019 at 12:43:35PM -0500, Daniel Colascione wrote:
> >> On Sat, Jan 19, 2019 at 11:27 AM Joel Fernandes
> ><joel@joelfernandes.org> wrote:
> >> >
> >> > On Sat, Jan 19, 2019 at 09:25:32AM +0100, Greg KH wrote:
> >> > > On Fri, Jan 18, 2019 at 05:55:43PM -0500, Joel Fernandes wrote:
> >> > > > --- /dev/null
> >> > > > +++ b/kernel/kheaders.c
> >> 
> >> Thanks a ton for this work. It'll make it much easier to do cool
> >> things with BPF.
> >
> >You're welcome, thanks.
> >
> >> One question: I can imagine wanting to probe
> >> structures that are defined, not in headers, but in random
> >> implementation files. Would it be possible to optionally include
> >*all*
> >> kernel source files?
> >
> >That would be prohibitively too large to justify keeping it in memory,
> >even
> >compressed. Arguably, such structures should be moved into include/ if
> >modules or whatever is extending the kernel like eBPF needs them.
> >
> >> If not, what about a hash, so we could at least
> >> do precise correlation between a candidate local tree and what's
> >> actually on device?
> >
> >That would make a tool too difficult to write wouldn't it, since they
> >you have to
> >correlate every possible hash and keep updating eBPF tools with new
> >hashes -
> >probably not scalable. I think what you want is to use the kernel
> >version to
> >assume what such internal structures look like although that's still
> >not
> >robust.
> >
> >> BTW, I'm not sure that the magic constants you've defined are long
> >> enough.  I'd feel more comfortable with two UUIDs (16 bytes each).
> >
> >Ok, I'll expand it.
> >
> >> I'd also strongly consider LZMA compression: xz -9 on the kernel
> >> headers (with comments) brings the size down to 5MB, compared to the
> >> 7MB I get for gzip -9. Considering that this feature is optional, I
> >> think it's okay to introduce a dependency on widespread modern
> >> compression tools. (For comparison, bzip2 -9 gets us 6MB.)
> >
> >Ok, I'll look into LZMA. Thanks for checking the compression sizes.
> >
> >- Joel
> 
> Don't use lzma, use xz if you are going to do something.

Ok, sounds good.

> However, it seems unlikely to me that someone not willing to spend the space in the filesystem will spend unswappable kernel memory.
> 
> It would seem that a far saner way to do this is to use inittmpfs or perhaps an auxiliary "ktmpfs" so it can at least be swapped out if you have swap.

But this is already possible with the proposed solution, you would load the
module, extract it into a tmpfs, and unload the module. TMPFS pages can
already be swapped.

thanks,

 - Joel

