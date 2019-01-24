Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91724C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55040218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MTUFYL4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAXCcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:32:20 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37551 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfAXCcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 21:32:19 -0500
Received: by mail-qt1-f194.google.com with SMTP id t33so4901906qtt.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 18:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CGuClkjsH6Nm5oWhdq5m1OKE4/YFrdge0arIdi6haBM=;
        b=MTUFYL4uz20ZkJdQhBGq81oRQWYM/a5LaWZ3I2DMb0GPKDgW3mOaYzvDCEXEC6ECvI
         RQEiAEm/QayLuH9k2zjTSD2J4QfCvJ4VmXSfnISUcdMH0bpVanUC1/u7ofTELrIdCUtx
         7yUACNXLezQ7OAFylAuhiAP2YzBLqdjQX5fY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CGuClkjsH6Nm5oWhdq5m1OKE4/YFrdge0arIdi6haBM=;
        b=q94KLGOK1Df+B8Gw/XCoADSQud7tU1OXJ+FmVHXRT4dlDgvnHK+kFH481C+YRKUin8
         MwbUbF77xmlDe4qdQ3JfYza5ebmwCnRqAlmtFRbnSqSzgSep1IHc6b/bptQ2ZwX4x/la
         78/aPIi+QcRJB/vl/WK+MSLhvAu/GmmyvvxxWYt5XCkMYT347WqWAeIbIYABFLoR/8BH
         4KJZmKfyeDEpdIhH6vgw1l4iP7MkXRbYsjAozM8QitTYMPGS2DnnAtrT1gUdflBfGn9F
         7vHFA4GuQPfTNMcfal9fXLmGFDeYQAlPgvI1mi/1/QjH1FmT/Evc/i3OHxRL4x0z5HT7
         Fiaw==
X-Gm-Message-State: AJcUuke0+xY7unAXeWKG2kNVz0fS2r3tF+u5cluWzZ//Tl8pRLN/w6kz
        bmBP56INoXlMeiI3Gn/iDfwnPw==
X-Google-Smtp-Source: ALg8bN7aN7ApDa5XT1RO4Ay8vsWyXjf1hbfxsBVmO4Oq+Zselgl4KwUOIWbugtyUXahcn4bIJ9l0JQ==
X-Received: by 2002:a0c:a144:: with SMTP id d62mr4370503qva.50.1548297138371;
        Wed, 23 Jan 2019 18:32:18 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id a17sm73484791qtk.82.2019.01.23.18.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 18:32:17 -0800 (PST)
Date:   Wed, 23 Jan 2019 21:32:16 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Karim Yaghmour <karim.yaghmour@opersys.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atish patra <atishp04@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20190124023216.GA75730@google.com>
References: <20190119102800.GB17723@infradead.org>
 <20190119103606.GA17400@kroah.com>
 <8BD4CB7A-944C-4EC5-A198-1D85C9EE28D6@zytor.com>
 <20190120161003.GB23827@google.com>
 <A40C22DF-B43F-44BA-8148-FC0881087315@zytor.com>
 <20190121014553.GD23827@google.com>
 <BC774ED4-C0FC-4AA6-9BAF-36930A661D9B@zytor.com>
 <20190122133901.GA189736@google.com>
 <117d2f96-b0e9-2376-69b7-836fa0c52539@opersys.com>
 <CAKOZuesWgo3CZj49aUChX_-dpijCrVLxgVZChyLLmOWXCLQf-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuesWgo3CZj49aUChX_-dpijCrVLxgVZChyLLmOWXCLQf-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:37:47PM -0800, Daniel Colascione wrote:
> On Wed, Jan 23, 2019 at 1:29 PM Karim Yaghmour
> <karim.yaghmour@opersys.com> wrote:
[...]
> > Personally I advocated a more aggressive approach with Joel in private:
> > just put the darn headers straight into the kernel image, it's the
> > *only* artifact we're sure will follow the Android device whatever
> > happens to it (like built-in ftrace).
> 
> I was thinking along similar lines. Ordinarily, we make loadable
> kernel modules. What we kind of want here is a non-loadable kernel
> module --- or a non-loadable section in the kernel image proper. I'm
> not familiar with early-stage kernel loader operation: I know it's
> possible to crease discardable sections in the kernel image, but can
> we create sections that are never slurped into memory in the first
> place? If not, maybe loading and immediately discarding the header
> section is good enough.

I am happy to see if I can shrink it down further. Especially using xz and
stripping all comments period. I am optimistic this can be brought down
further to a point where it would make sense to everyone to build it into the
kernel. Lets see.

Last time I stripped comments, it went down by ~40%. What I haven't tried is
doing this *with* xz compression. I am also open to brainstorming what else
can be stripped.

OTOH the reason I didn't focus much on size is: modules are pretty much
universal and I'm confident of wide spread use of this feature for Android-based
products and not needing of "chasing headers" if we modularize it, since
Android's project treble has modularized things and modules are now default
enabled. Putting headers into a module lets us enjoy the ride there.

I am quite hosed for the next week or so to work on this, but I should be
able to get back to it after.

cheers,

 - Joel


> 
> > To that end, I even had some crazy
> > ideas on how to compress the headers even further than with std
> > compression algorithms -- here's a snippet from an email I sent Joel
> > some time back detailing such a hack:
> > > Since C headers have fairly constrained semantics and since the types of semantics generally used to name structs, etc. in the Linux kernel are well established, we can likely devise a very customized compression algorithm for the purpose.
> 
> Would such a thing really do better than LZMA? LZMA already has very
> clever techniques for eliminating long-range redundancies in
> compressible text, including redundancies at the sub-byte level. I can
> certainly understand the benefit of stripping comments, since removing
> comments really does decrease the total amount of information the
> compressor has to preserve, but I'm not sure how much the encoding
> scheme you propose below would help, since it reminds me of the
> encoding scheme that LZMA would discover automatically.
> 
> > Whether such craziness makes sense or is adopted or not isn't mine to
> > chart, but I certainly can't see eBPF reaching the same mass deployment
> > ftrace has within the Android ecosystem until there's a way to use it
> > without having to chase kernel headers independently of kernel images.
> > There are "too many clicks" involved and someone somewhere will drop the
> > ball if it's not glued to the kernel in some way shape or form. Any
> > solution that solves this is one I'd love to hear about.
> 
> I agree. There definitely needs to be a "just collect a damn trace"
> button that works on any device, and for this button to work and
> incorporate eBPF, the system needs to be able to describe itself.
