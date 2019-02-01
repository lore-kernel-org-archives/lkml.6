Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77E0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E039218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549049260;
	bh=i/42Ix6BSJ2O9QTvPZdAzHGqiD6AReRsP2p4D+VZYVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0KEdgYFynO6MkOIuf4pLbr3Q60a1iZ+5dE0K2KMiwSZ5SQPsECwIX7bYsVziltQIA
	 iHsQaMX+Bo2Sbsf/l+IZn8QtzvkW8HhDBPmjI1jFxYmrKqjGnU+UpRgRRRFVdHjZYZ
	 5XOhBTEuW99v0xmBG/maxOlfcEWoAIydHAhogmag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfBAT1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:27:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfBAT1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:27:38 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3060821908
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549049257;
        bh=i/42Ix6BSJ2O9QTvPZdAzHGqiD6AReRsP2p4D+VZYVY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rZJxaFWoGdki3rioPIMVk+6BdywslYixaEORk//wp1flvoP5JcRL3WXrmbRkXwBQT
         9ixT3/z97/pmjEqtABLl37AC+YcqCGciiUG6OiJvLhSjGg0WkQ5UhkVPmk0ppDuII+
         6T6dDTYxOMXITLWW1T0zdiEPNWLW1r6IRgTZ5/tA=
Received: by mail-wm1-f46.google.com with SMTP id f188so7314443wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 11:27:37 -0800 (PST)
X-Gm-Message-State: AHQUAuYObndxOAsVHs2oekVH/G5AyBNrAfJYNMtS0qFk0+9zY+SNVr69
        5VNJmhpbGz7+2XX6iwEGEqzQuogOi4sdpPyMbISn6g==
X-Google-Smtp-Source: AHgI3IYdJEqbUyrK6qHUKKShwEAFFGkdfWtFRxObjGwC4lG6dXuprQlDkNKd/ScHl6bfIDYpD2EeYhjPiot3HIwl/0k=
X-Received: by 2002:a1c:f909:: with SMTP id x9mr3639529wmh.108.1549049255528;
 Fri, 01 Feb 2019 11:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-21-thgarnie@chromium.org>
In-Reply-To: <20190131192533.34130-21-thgarnie@chromium.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 1 Feb 2019 11:27:22 -0800
X-Gmail-Original-Message-ID: <CALCETrVcU_9cczwbfVg6E2cey5B8O9k4j+jYgp0T-CiX9HELtA@mail.gmail.com>
Message-ID: <CALCETrVcU_9cczwbfVg6E2cey5B8O9k4j+jYgp0T-CiX9HELtA@mail.gmail.com>
Subject: Re: [PATCH v6 20/27] x86: Support global stack cookie
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <jroedel@suse.de>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:29 AM Thomas Garnier <thgarnie@chromium.org> wrote:
>
> Add an off-by-default configuration option to use a global stack cookie
> instead of the default TLS. This configuration option will only be used
> with PIE binaries.
>
> For kernel stack cookie, the compiler uses the mcmodel=kernel to switch
> between the fs segment to gs segment. A PIE binary does not use
> mcmodel=kernel because it can be relocated anywhere, therefore the
> compiler will default to the fs segment register. This is fixed on the
> latest version of gcc.

I hate all these gcc-sucks-so-we-hack-it-and-change-nasty-semantics
options.  How about just preventing use of both stack protector and
PIE unless the version of gcc in use is new enough.

Also, does -mstack-protector-guard-reg not solve this?  See
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708.  Or is there
another bug?  Or are you worried about gcc versions that don't have
that feature yet?
