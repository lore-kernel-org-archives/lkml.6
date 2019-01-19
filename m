Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63342C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C2C2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fxAO2ZW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfASQ15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:27:57 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42856 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbfASQ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:27:57 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so18610591qtq.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a88CGqOfDzD9ShGO5Yin74afZHL8p3Gen/fNZt07QA8=;
        b=fxAO2ZW0DAxdMnxXaYpzk0M2iCLqNnKbNJ1EDgkSwCuNOEYTE0NxSF0G45MuSS2+JO
         E4Q1vh0SMESt8izy8OxFoWXxj292Smf0bj3PvZOkZs/oszKtjsIkpRgJ5dOErhfqnUq+
         b2Uq7mNxXlqFfUgNGCjvfgF4Zg1JnmxAdIEUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a88CGqOfDzD9ShGO5Yin74afZHL8p3Gen/fNZt07QA8=;
        b=HffVi2HdiK2LBrvOtrfRvkHXQklzNWzKr2ov6+mYJxXIJFI0zE15LPtfkSgMI7dcvv
         EcoS3Zvm1qalRZagpT1s9dOaiMVxNVQOBVqD7x8wD4sGdhl1sgjIlqSD8XD/k79VJaol
         ajeGw99WpWpQQON/NfrQ40WUhoJM3dZblrfYWOuArHd2nHKX11dOJrSNK/khVvw8pVvd
         qKeQhD/UbFPut2li+TCX4nCfkDr0Tlk8i48GWgAvbJNjRXwz+SBs2qCq9JkqhxIA66eF
         ccZR6zyTcZOuFZQSd5QRRe1ihedIlOWcsOYXFWJTtv7aTco/P1gXZQRAiJO/AEmanVib
         FflQ==
X-Gm-Message-State: AJcUukc8Y8yocHYtdx7eXrAlT0TiytkyaGZEqLND6raQWggTdGmY+sMZ
        kmzHZwc4RKCd4xDchDSU1u8fgw==
X-Google-Smtp-Source: ALg8bN6MBtBdiiU5f1UPPB8SuGb6l2Wiue2QOSxYGe32GJZlxxaZueAT7iCSuiJ+qor+Opsm4ueAFw==
X-Received: by 2002:ac8:4284:: with SMTP id o4mr4246446qtl.389.1547915276351;
        Sat, 19 Jan 2019 08:27:56 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id c48sm62532146qtd.9.2019.01.19.08.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 08:27:55 -0800 (PST)
Date:   Sat, 19 Jan 2019 11:27:54 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        dancol@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
Message-ID: <20190119162754.GC231277@google.com>
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119082532.GA9004@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 09:25:32AM +0100, Greg KH wrote:
> On Fri, Jan 18, 2019 at 05:55:43PM -0500, Joel Fernandes wrote:
> > --- /dev/null
> > +++ b/kernel/kheaders.c
> > @@ -0,0 +1,74 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> Nice, but:
> 
> <snip>
> 
> > +MODULE_LICENSE("GPL");
> 
> That means "GPL2+" (yeah, horrible, I know, we all get it wrong, look at
> include/linux/module.h for details)
> 
> So you should change that line to:
> 	MODULE_LICENSE("GPLv2");

Ok, will fix.

> Other than that, nice work.

thanks!

 - Joel

