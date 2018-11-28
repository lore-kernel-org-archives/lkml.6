Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9502EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4292086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4292086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeK2B0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:26:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:59854 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2B03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:26:29 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gS0lU-0007Eh-BY; Wed, 28 Nov 2018 15:24:32 +0100
Date:   Wed, 28 Nov 2018 15:24:31 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 00/28] x86/speculation: Remedy the STIBP/IBPB
 overhead
In-Reply-To: <20181125183328.318175777@linutronix.de>
Message-ID: <alpine.DEB.2.21.1811281516280.1532@nanos.tec.linutronix.de>
References: <20181125183328.318175777@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2018, Thomas Gleixner wrote:

> Thats hopefully the final version of this. Changes since V1:
> 
>   - Renamed the command line option and related code to spectre_v2_user= as
>     suggested by Josh.
> 
>   - Thought more about the back to back optimization and finally left the
>     IBPB code in switch_mm().
> 
>     It still removes the ptrace check for the always IBPB case. That's
>     substantial overhead for dubious value now that the default is
>     conditional (prctl/seccomp) IBPB.
> 
>   - Added two options which allow conditional STIBP and IBPB always mode.
> 
>   - Addressed the review comments
> 
> Documentation is still work in progress. Thanks Andi for providing the
> first draft for it.
> 
> Still based on tip.git x86/pti as it has been discussed to remove the
> minimal RETPOLINE bandaid from stable kernels as well.

I've integrated the latest review feedback and the change which plugs the
TIF async update issue and pushed all of it out to:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/pti

For the stable 4.14.y and 4.19.y trees, I've collected the missing bits and
pieces and uploaded tarballs which contain everything ready for consumption:

   https://tglx.de/~tglx/patches-spec-4.14.y.tar.xz

      sha256 of patches-spec-4.14.y.tar:
      3d2976ef06ab5556c1c6cba975b0c9390eb57f43c506fb7f8834bb484feb9b17

   https://tglx.de/~tglx/patches-spec-4.19.y.tar.xz

      sha256 of patches-spec-4.19.y.tar:
      b7666cf378ad63810a17e98a471aae81a49738c552dbe912aea49de83f8145cc

Thanks everyone for review, discussion, testing ... !

Thanks,

	tglx
