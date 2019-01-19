Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEF3C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A102086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lUsbKLz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfASXZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 18:25:07 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41818 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfASXZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 18:25:07 -0500
Received: by mail-qt1-f196.google.com with SMTP id l12so19238938qtf.8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 15:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5UkPRGKfdEvlsfd9/KG3M4goE5oDuersbmF8B1UJNXc=;
        b=lUsbKLz4EzaLSR59z0DgsAcdOVzLsZO0QlWVX3TRWZ0NBqlreUnFzXtjhkThjV84uE
         GuzPJcNI4BWHh02smeWz5yEPQoaxHG7LFG2YI+zSynFZsBrdGVy2hHwm9jhblX7zQsDM
         WdoTd2bLsW6OkOc3pbAojs2iGB4v/7XzD677E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5UkPRGKfdEvlsfd9/KG3M4goE5oDuersbmF8B1UJNXc=;
        b=uJ2v9lI1J71GQPR/1EuurobuSn26SqJYRcw0m3btQUKx7Dh8fdWsSIXP5fX0Q+TaRa
         CBM9SH76hUt3eqZZxyNkbvt/gP86w55SRksTyXwsE4DHVu0nYzdo2wadubDefVRpmqxS
         ISHM/qzAx4+wVB2xPGMWqIon/91KpFdzl6LCLs5tIsQGwDkfyLtYphYIzLaiaK7Rr1cd
         aDQHKpYl6wXcORFrk0TKUCHK9LPz22eNwNwc1cMUpCfcY5jC9APcXi/9AgCVwuWjQ6nJ
         vK+PLkTubfn3vc7MhxS5iinY7UO8sUe/qBwJ8HcKWHjW8EapiYOh65GCngMhu4Qa16Ui
         UNNw==
X-Gm-Message-State: AJcUukcQvT0tOlP4fNLKMW2FYDSQTvwWO2E+rBFV3aDPWWPPbm5Jk7Qz
        A/fz7xbwepUqlvjg2pPQQ1TS0Q==
X-Google-Smtp-Source: ALg8bN5saY132+VlxETzJxTpMSASF96ZMV8ZAJZRk1NsRlgIR6HNEypknFd+MC5a/LcuMm0H2NCc7g==
X-Received: by 2002:a0c:8322:: with SMTP id j31mr20773690qva.56.1547940305781;
        Sat, 19 Jan 2019 15:25:05 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id 14sm4092733qka.37.2019.01.19.15.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 15:25:04 -0800 (PST)
Date:   Sat, 19 Jan 2019 18:25:03 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        karim.yaghmour@opersys.com, Kees Cook <keescook@chromium.org>,
        kernel-team@android.com,
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
Message-ID: <20190119232503.GA149403@google.com>
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com>
 <20190119162754.GC231277@google.com>
 <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 12:43:35PM -0500, Daniel Colascione wrote:
> On Sat, Jan 19, 2019 at 11:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Sat, Jan 19, 2019 at 09:25:32AM +0100, Greg KH wrote:
> > > On Fri, Jan 18, 2019 at 05:55:43PM -0500, Joel Fernandes wrote:
> > > > --- /dev/null
> > > > +++ b/kernel/kheaders.c
> 
> Thanks a ton for this work. It'll make it much easier to do cool
> things with BPF.

You're welcome, thanks.

> One question: I can imagine wanting to probe
> structures that are defined, not in headers, but in random
> implementation files. Would it be possible to optionally include *all*
> kernel source files?

That would be prohibitively too large to justify keeping it in memory, even
compressed. Arguably, such structures should be moved into include/ if
modules or whatever is extending the kernel like eBPF needs them.

> If not, what about a hash, so we could at least
> do precise correlation between a candidate local tree and what's
> actually on device?

That would make a tool too difficult to write wouldn't it, since they you have to
correlate every possible hash and keep updating eBPF tools with new hashes -
probably not scalable. I think what you want is to use the kernel version to
assume what such internal structures look like although that's still not
robust.

> BTW, I'm not sure that the magic constants you've defined are long
> enough.  I'd feel more comfortable with two UUIDs (16 bytes each).

Ok, I'll expand it.

> I'd also strongly consider LZMA compression: xz -9 on the kernel
> headers (with comments) brings the size down to 5MB, compared to the
> 7MB I get for gzip -9. Considering that this feature is optional, I
> think it's okay to introduce a dependency on widespread modern
> compression tools. (For comparison, bzip2 -9 gets us 6MB.)

Ok, I'll look into LZMA. Thanks for checking the compression sizes.

- Joel

