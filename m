Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18449C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE1020700
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbfAKTwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:52:38 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34581 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbfAKTwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:52:37 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gi2r2-0002u7-7G; Fri, 11 Jan 2019 20:52:32 +0100
Date:   Fri, 11 Jan 2019 20:52:31 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH] x86/speculation: Don't inherit TIF_SSBD on
 execve()
In-Reply-To: <1545246590-12704-1-git-send-email-longman@redhat.com>
Message-ID: <alpine.DEB.2.21.1901112046290.1661@nanos.tec.linutronix.de>
References: <1545246590-12704-1-git-send-email-longman@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018, Waiman Long wrote:

> With the default SPEC_STORE_BYPASS_SECCOMP/SPEC_STORE_BYPASS_PRCTL mode,
> the TIF_SSBD bit will be inherited when a new task is fork'ed or cloned.
> 
> As only certain class of applications (like Java) requires disabling
> speculative store bypass for security purpose, it may not make sense to
> allow the TIF_SSBD bit to be inherited across execve() boundary where the
> new application may not need SSBD at all and is probably not aware that
> SSBD may have been turned on. This may cause an unnecessary performance
> loss of up to 20% in some cases.

Lot's of MAY's here. Aside of that this fundamentally changes the
behaviour. I'm not really a fan of doing that.

If there are good reasons to have a non-inherited variant, then we rather
introduce that instead of changing the existing semantics without a way for
existing userspace to notice.

Thanks,

	tglx

