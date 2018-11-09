Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D673DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909A420827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c17H/Qa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909A420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeKJEyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:54:23 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50790 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJEyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:54:23 -0500
Received: by mail-it1-f193.google.com with SMTP id k206-v6so4546089ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 11:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/RtZ3MIx7jsJHd6nyiuy5o2cZGKQ6Xp7R/TlgscXQZI=;
        b=c17H/Qa8xStIYpAdDTEbEXdpp3YxPj5e6IxZXeLNB2WRIIrqha18u5Fw9zgsWP+8ON
         wqfefFPnznPEyK6PwS+jQStOMduS17AHHWk9JpMP+/ZgrpCu3LtrUvyc6y6Tx/0hTD+L
         m6SOLlAwdRHwC26JZgrGsOLBBkDtWAPrWVEQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/RtZ3MIx7jsJHd6nyiuy5o2cZGKQ6Xp7R/TlgscXQZI=;
        b=sjHpHhmJDvNPSoIQiNZx1n/f72Ta3f6yp1bwYAQ+3U41x4D8DK3FEfZmjacWt81w1S
         3ZGQouceOlM7n8qpS6XBB1ZnAJKUx8hYtB9Ru3rdOrcMqX8okDoZGWAi1tuf8skavqqe
         bCdZE9cbJNWLAUaNfAKOSp5iueemjcL9MPeQHWsQwbj0J4vpm2kVaDazCQ9Ya5iOv5cS
         QpnJHHLG/xUP6u38RH/sffDYhMRgWBzI+A2nzeIgalPVtt1+drwEBUTLX9hGdZOdeMl2
         DgHaB+Vh5jCYmkg1YAFZdmb76TprpRfPwttURjFTzL8YIC20EZRVuvSfIIwRrmBJbhMP
         XmUg==
X-Gm-Message-State: AGRZ1gKfSBnt2AeS0st+LUnOrsJtkGQVD2ptQEyf44bi6oH+RR+iY0t+
        Nc6IDGhIH73j+DsvgQPjpP5Cxj+gcJvIrIkYzKiEaw==
X-Google-Smtp-Source: AJdET5eQ3mY85VGkFjalNGuAIqHaatMkvua6VXWIrD+dWuj+JwniDIcTxhG03TRKZ1ehvvkl1G9rKvRC4l5XjJXqkhQ=
X-Received: by 2002:a24:2190:: with SMTP id e138-v6mr3386590ita.71.1541790747413;
 Fri, 09 Nov 2018 11:12:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Fri, 9 Nov 2018 11:12:26 -0800 (PST)
In-Reply-To: <20181109190320.tn3fpaegg5dkgvdb@treble>
References: <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <CAKv+Gu9bMkFEx_GxH3uLm0gveQurp7ELDi6C5NvpugufPFMbRA@mail.gmail.com>
 <20181109151028.faifw66enzye32gg@treble> <CAKv+Gu_J1b30+pMNRF0icEpyew4TM_VP3ShG=4HkLnk=fRL9zg@mail.gmail.com>
 <CAKv+Gu-DOW2WT=h8C0x5igbCDAc2bp3mTRM6U_wTJST+RnVicg@mail.gmail.com>
 <20181109173106.kbghzsdsu7oachl6@treble> <CAKv+Gu-9XYOwAPJ5m6F4Cn9Uo6dvbtEG9p0knX+_XcjHp2QKGA@mail.gmail.com>
 <20181109174608.eahqh4fkyl3k2gvs@treble> <CAKv+Gu8b1KbRtJPrbXk3+K=1uRV6OcvB+zEMYk-UK3sFxKzsgQ@mail.gmail.com>
 <CAKv+Gu9iJAyZ1u5AjPjTyxP4QJYOjMsMBi1eoMahtUjnLwqSHQ@mail.gmail.com> <20181109190320.tn3fpaegg5dkgvdb@treble>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 9 Nov 2018 20:12:26 +0100
Message-ID: <CAKv+Gu_REsDKZ4q4xSTTO8y7ZMMYd6kormb5NE5D-eV=GnwcZg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 November 2018 at 20:03, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Fri, Nov 09, 2018 at 06:53:21PM +0100, Ard Biesheuvel wrote:
>> > It's a bit fiddly since inline and out-of-line both use
>> > arch_static_call_transform(), but what I need to do is basically:
>> >
>> > - for out-of-line, the trampoline needs to be patched into a
>> > movn/movk/movk/br sequence if the target is too far
>> > - for inline, the trampoline itself needs to be patched from
>> > adrp/ldr/br (which does a load and a indirect branch) to
>> > movn/movk/movk/br (which uses immediates), and the call sites need to
>> > be patched into calls to the veneer if the target is out of range.
>> >
>> > So arch_static_call_transform() needs to know where the trampoline is
>> > for this use case, so could we perhaps add a 'void *orig' in the key
>> > struct that keeps track of the original value of 'addr' ?
>>
>> ... and pass it to arch_static_call_transform
>
> Ok.  So in both cases, you need both the call site address and the tramp
> address, right?  We could add a 'tramp' pointer to the key struct -- I
> assume that's what you mean?
>

Yes.

> And also change
>
>   void arch_static_call_transform(unsigned long insn, void *dest)
>
> to
>
>   void arch_static_call_transform(void *call_site, void *tramp, void *dest)
>

Indeed.
