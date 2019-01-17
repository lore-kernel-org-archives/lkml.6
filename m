Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F3EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AFA20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfAQK7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:59:08 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:44592 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbfAQK7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:59:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 0847B1858B;
        Thu, 17 Jan 2019 11:59:06 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dl9O8wN-YWCV; Thu, 17 Jan 2019 11:59:04 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 9A4CB180EA;
        Thu, 17 Jan 2019 11:59:04 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 890151A06B;
        Thu, 17 Jan 2019 11:59:04 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D5B31A067;
        Thu, 17 Jan 2019 11:59:04 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Thu, 17 Jan 2019 11:59:04 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 7155B1A05;
        Thu, 17 Jan 2019 11:59:04 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 6845180B46; Thu, 17 Jan 2019 11:59:04 +0100 (CET)
Date:   Thu, 17 Jan 2019 11:59:04 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sysctl: Add panic-fatal-signals
Message-ID: <20190117105903.dilzmdlqtyiogpo3@axis.com>
References: <20190116125422.19643-1-vincent.whitchurch@axis.com>
 <CAGXu5j+dM867PJKR+eHjhUjZvsih5ndHmGJY3y+yWGMf2-gg4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+dM867PJKR+eHjhUjZvsih5ndHmGJY3y+yWGMf2-gg4w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 09:06:18AM -0800, Kees Cook wrote:
> On Wed, Jan 16, 2019 at 4:54 AM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> > Add a sysctl which asks the kernel to panic when any userspace process
> > receives a fatal signal which would trigger a core dump.  This has
> > proven to be quite useful when debugging problems seen during testing of
> > embedded systems:  When combined with kernel core dumps (saved due to
> > the panic), it allows easier debugging of crashes which have their
> > origin in system-wide problems such as buggy drivers or other kernel or
> > hardware-related issues.
> >
> > The crashing process's core dump can be extracted from the kernel core
> > dump using tools such as the crash utility's gcore extension.
> 
> Whoa. That's intense. :)

"Insane" is the word I used myself in an earlier draft of the commit
message. :)

> If you have a use-case for it, then I guess I
> can't complain. Given that this is an instant DoS for a system that
> isn't expecting it, I do wonder if it should live behind a CONFIG or
> something to make it available only when really wanted?

Sure, I can put it behind a "depends on EXPERT" config option.  Distros
and the like should have no reason to provide access to such a sysctl.
