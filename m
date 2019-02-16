Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0ECC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 23:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9FB21A49
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 23:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfBPXrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 18:47:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52422 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfBPXrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 18:47:13 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gv9fi-0001hH-3r; Sat, 16 Feb 2019 23:47:02 +0000
Date:   Sat, 16 Feb 2019 23:47:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
        baloo@gandi.net, the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Pascal Bouchareine <pascal@gandi.net>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
Message-ID: <20190216234702.GP2217@ZenIV.linux.org.uk>
References: <20190215235901.23541-1-baloo@gandi.net>
 <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com>
 <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de>
 <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 02:50:15PM -0800, Andy Lutomirski wrote:

> What is the actual problem?  We’re not actually demand-faulting this data, are we?  Are we just overrunning the buffer because the from_user helpers are too clever?  Can we fix it for real by having the fancy helpers do *aligned* loads so that they don’t overrun the buffer?  Heck, this might be faster, too.

Unaligned _stores_ are not any cheaper, and you'd get one hell of
extra arithmetics from trying to avoid both.  Check something
like e.g. memcpy() on alpha, where you really have to keep all
accesses aligned, both on load and on store side.

Can't we just pad the buffers a bit?  Making sure that name_buf
and symlink_buf are _not_ followed by unmapped pages shouldn't
be hard.  Both are allocated by kmalloc(), so...

What am I missing here?
