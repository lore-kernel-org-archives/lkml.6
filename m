Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91663C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB2321907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DcrbpoxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBHALm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:11:42 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42045 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfBHALm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:11:42 -0500
Received: by mail-qk1-f195.google.com with SMTP id y140so1118208qkb.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2jvMzZml8G1fBRXACrLnRWMkKrhzgtpwyBjFhfxntJU=;
        b=DcrbpoxUmYXvksaE6PpHmTeR9ReoaHaRVZuN6U2gq3JgO8YnWQ1R5k6z/8sUjTjq++
         1iO9LRkj+vDobeMt6zIo0Ba00oJTLfBcloI0p+PgDeMv15KySEAUXxSo7uhasG4xaxIn
         0hOYiIv8QygM2GrjCdIBBVHGjZzXDVVXVThas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2jvMzZml8G1fBRXACrLnRWMkKrhzgtpwyBjFhfxntJU=;
        b=Bt/X80vQk8mY9dNytYiMLG8NWVqfg3Oja2v0jooxpb8tU/6WcAgrYt8+jISiLp50nI
         U5sC4/6du/zPMfLYy5rVPtcCBdZk48y2U05gHa/4Zkbb1eGfnev/nd2lloatii/TEoqd
         fPhXwWQhTqbjed6IDc99H9IIhrdEB8Y2J+pQK2RfyXKACRVPasu04cKb07ROKX9EMIwH
         1BetrEcxOlx34zYvh+WQ5DdRSUKe7nNqZ8joWXFaZhNHmnkQWqQ3M2oagqT/EmFtrvwg
         mki/QbIbe4/Mi788/hkiKSqGfAcvRi9ELI7H9JbPlfz2JoAG2qx5MeIEmYkgA+NHQSg7
         70bQ==
X-Gm-Message-State: AHQUAuYp8h+qE9mgwfXuaxc5ZQIqUwU5YRSlDMjsHM8/UY7RTHzqBlHe
        CefgNj3rRqNvxN0Qa+lXJLx/Sg==
X-Google-Smtp-Source: AHgI3IYLbR8/lq5nz5ehxKfAm/ssVexEm9+/zT9zfG28C3dRLjUJnqtnhbZrO22bKtn61bsY5noBPA==
X-Received: by 2002:a37:8784:: with SMTP id j126mr5455923qkd.228.1549584700638;
        Thu, 07 Feb 2019 16:11:40 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id w34sm842757qtj.27.2019.02.07.16.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 16:11:39 -0800 (PST)
Date:   Thu, 7 Feb 2019 19:11:39 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, dancol@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        gregkh@linuxfoundation.org, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Subject: Re: [PATCH 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
Message-ID: <20190208001139.GB193818@google.com>
References: <20190207211102.154634-1-joel@joelfernandes.org>
 <20190207175239.0607f5eb@gandalf.local.home>
 <20190207233902.GA193818@google.com>
 <20190207185042.76c7d68f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207185042.76c7d68f@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 06:50:42PM -0500, Steven Rostedt wrote:
> On Thu, 7 Feb 2019 18:39:02 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > +
> > > > +spath="$(dirname "$(readlink -f "$0")")"
> > > > +
> > > > +rm -rf $1.tmp
> > > > +mkdir $1.tmp
> > > > +
> > > > +for f in "${@:2}";
> > > > +	do find "$f" ! -name "*.c" ! -name "*.o" ! -name "*.cmd" ! -name ".*";  
> > > 
> > > I wonder if it is a good idea to pick all files in the directories
> > > defined in ikh_file_list, and not just explicitly list what we want,
> > > with a '*.h' and such?  
> > 
> > I also need few files in the archive that are not .h, these don't take up
> > much space but are needed to make an out-of-tree kernel module build succeed.
> > 
> > One of my goals with this was to make a self-contained module that could be
> > loaded to build other modules. Majority of the files are kernel headers, but
> > some are not, such as Module.symvers and other scripts. Then one can run
> > systemtap on Android which can be made to build modules using the embedded
> > headers.
> 
> Have you audited what it picks up? My main concern is that we start
> adding files that are not necessary or just simply added in the
> directory that are not needed for this.

Yes, I audited what is needed to be picked up. It turned out that I ended up
nitpicking files for not much space-saving advantage while causing the list
of files that need to be picked to be long, because most of the space is
taken by the headers.

> > > > +done | cpio -pd $1.tmp
> > > > +
> > > > +for f in $(find $1.tmp); do
> > > > +	$spath/strip-comments.pl $f
> > > > +done
> > > > +
> > > > +tar -Jcf $1 -C $1.tmp/ . > /dev/null
> > > > +
> > > > +rm -rf $1.tmp
> > > > diff --git a/scripts/strip-comments.pl b/scripts/strip-comments.pl
> > > > new file mode 100755
> > > > index 000000000000..f8ada87c5802
> > > > --- /dev/null
> > > > +++ b/scripts/strip-comments.pl
> > > > @@ -0,0 +1,8 @@
> > > > +#!/usr/bin/perl -pi
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +# This script removes /**/ comments from a file, unless such comments
> > > > +# contain "SPDX". It is used when building compressed in-kernel headers.
> > > > +
> > > > +BEGIN {undef $/;}
> > > > +s/\/\*((?!SPDX).)*?\*\///smg;  
> > > 
> > > Hmm, I'm also wondering if we could us the C pre-processor for the
> > > stripping of everything from the header file. We would then even get
> > > the header files only having what is necessary for the running kernel.  
> > 
> > I thought about this too. An issue with that is it is going to be really slow
> > due to the large number of headers. The other is, I think it will actually
> > make the headers bigger and take up more space - because all the include
> > directives will also be expanded and have more duplication. Let me know if I
> > missed something though.
> > 
> 
> Good point about the duplication. I was mostly thinking of getting rid
> of "#ifdef" blocks.
> BTW, these comments are more of a "have you thought about this" and not
> really action comments.

Ok, thanks for the comments :)

 - Joel

