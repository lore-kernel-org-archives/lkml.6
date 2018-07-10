Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869FAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4775B2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4775B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754617AbeGJC3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:29:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754463AbeGJC3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 22:29:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2CBA40122D2;
        Tue, 10 Jul 2018 02:29:06 +0000 (UTC)
Received: from treble (ovpn-120-114.rdu2.redhat.com [10.10.120.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9BED2156889;
        Tue, 10 Jul 2018 02:29:05 +0000 (UTC)
Date:   Mon, 9 Jul 2018 21:29:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH v2] objtool: move libelf detection to Kconfig from
 Makefile
Message-ID: <20180710022904.e3oql2ts4qz43bzo@treble>
References: <1531186516-15764-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531186516-15764-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 10 Jul 2018 02:29:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 10 Jul 2018 02:29:06 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:35:16AM +0900, Masahiro Yamada wrote:
> Currently, users are allowed to enable STACK_VALIDATION regardless
> of the compiler capability.  The top-level Makefile warns or breaks
> the build if it turns out that the host compiler cannot link libelf.
> 
> Move the libelf test to Kconfig so that users can enable the feature
> only when the host compiler can build the objtool.  The ugly check
> in the Makefile will go away.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Actually, looking at this again, I want to rescind my ack.

This patches changes the behavior in a subtle (but important) way.

Before, if I did "make defconfig", it would *always* choose the ORC
unwinder.  Then, if I didn't have libelf-devel, the build would fail and
it would tell me what I need to install.

But now with this patch, if I do "make defconfig", the generated config
actually changes based on what I happen to have installed on my build
system.  If I don't have libelf-devel, then it silently chooses the
non-default unwinder (frame pointer).

This is a subtle difference, but IMO it's dangerous, because it will
silently enable the frame pointer unwinder for the majority of new
systems, even though it's not the default.

I strongly prefer the original behavior, because we really want to
encourage people to use the ORC unwinder, even if that means they have
to install a package to build it.

Also -- in general -- I suspect that silently changing the defaults like
this will create a lot of bad surprises.  The output of "make defconfig"
should be predictable and not dependent on what RPMs I happen to have
installed.

-- 
Josh
