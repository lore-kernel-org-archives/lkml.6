Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E6AC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E161A2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547886339;
	bh=OTV8e2qblugZJ1+5CKFlI5wUbgHTSewqpkn5c17dygg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t7FFNqjh9vFZ4+5ouTgWp/9DYFa6295LTE9knH2o8uLvxvu+FgMiARiC1IrzSi+OQ
	 OPoKaYpG7GM22fC0/4lxYttcqdiZOGyyW6r8mu+3ZR7Dy4guFEEQMIiBy1jNaA+4g6
	 ugH86cZsesbPSTBC4zRUOE0q/kygCFECXtmU0Nes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfASIZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:25:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfASIZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:25:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55D8F20823;
        Sat, 19 Jan 2019 08:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547886335;
        bh=OTV8e2qblugZJ1+5CKFlI5wUbgHTSewqpkn5c17dygg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EF8Uwj+zXRZ0tss2GmaJYpu8e9JxYQK2GH7Y+BHKVgD7oB0BfcANK8Dxkace6FYwM
         o7Tmb3jSycEmBkKsrmoKM6RMPOZWDJgFBimXV3o/MkVUkSHpCppm0FVou0KZyIZ6I5
         O8btpuzWwfkx0wKTP3YJCeDcvujmPSxHlQzKtllM=
Date:   Sat, 19 Jan 2019 09:25:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20190119082532.GA9004@kroah.com>
References: <20190118225543.86996-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118225543.86996-1-joel@joelfernandes.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 05:55:43PM -0500, Joel Fernandes wrote:
> --- /dev/null
> +++ b/kernel/kheaders.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0

Nice, but:

<snip>

> +MODULE_LICENSE("GPL");

That means "GPL2+" (yeah, horrible, I know, we all get it wrong, look at
include/linux/module.h for details)

So you should change that line to:
	MODULE_LICENSE("GPLv2");

Other than that, nice work.

greg k-h
