Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93260C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5453C20C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5453C20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeHTKvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:51:11 -0400
Received: from trent.utfs.org ([94.185.90.103]:41598 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbeHTKvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:51:11 -0400
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id F13495FB7C;
        Mon, 20 Aug 2018 09:36:37 +0200 (CEST)
Date:   Mon, 20 Aug 2018 00:36:37 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Kees Cook <keescook@chromium.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Bart Massey <bart.massey@gmail.com>,
        jfs-discussion@lists.sourceforge.net,
        David Windsor <dave@nullcore.net>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [Jfs-discussion] [PATCH] jfs: Expand usercopy whitelist for
 inline inode data
In-Reply-To: <CAGXu5j+_qOcnJjwXX9mop++Bs7HCA7QMXCs5VXofewZ7XOwddw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.999.1808200032460.791@trent.utfs.org>
References: <20180803200551.GA47157@beast> <alpine.DEB.2.21.999.1808162319420.3196@trent.utfs.org> <CAGXu5j+_qOcnJjwXX9mop++Bs7HCA7QMXCs5VXofewZ7XOwddw@mail.gmail.com>
User-Agent: Alpine 2.21.999 (DEB 277 2018-05-20)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018, Kees Cook wrote:
> On Thu, Aug 16, 2018 at 11:56 PM, Christian Kujau <lists@nerdbynature.de> wrote:
> > On Fri, 3 Aug 2018, Kees Cook via Jfs-discussion wrote:
> >> Bart Massey reported what turned out to be a usercopy whitelist false
> >> positive in JFS when symlink contents exceeded 128 bytes. The inline
> >> inode data (i_inline) is actually designed to overflow into the "extended
> >
> > So, this may be a stupid question, but: is there a way to disable this
> > hardened usercopy thing with a boot option maybe?
> >
> > Apparently, CONFIG_HARDENED_USERCOPY_FALLBACK was disabled in Debian's
> > 4.16.0-0.bpo.2-amd64 (4.16.16) kernels[0] and I have a VMware guest here
> > that prints a BUG message (below) whenever a certain directory is being
> > accesses. ls(1) is fine, but "ls -l" (i.e. with stat()) produces the splat
> > below. And indeed, the target of one of the symlinks inside is 129
> > characters long, and every attempt to stat it prints the splat below.
> >
> > Going back to 4.16.0-0.bpo.1-amd64 (4.16.5) helps, but I was wondering if
> > there was a magic boot option to disable it while I wait for 4.18 to land
> > in Debian? I booted with hardened_usercopy=off, but it doesn't seem to
> > have an effect and the directory is still inaccessible.
> 
> Precisely this was just added upstream[1] for 4.19 but isn't available
> in 4.16. It should be trivial to backport it, though, if Ben wants to
> do that? (The JFS fix is in the 4.17 and 4.18 -stable trees now, too,
> BTW.)

Ah, OK. While the patch does apply (almost) cleanly to 4.16, I think I'll 
just wait until it makes its way into the Debian (backports) kernel, as 
nobody else seems to be annoyed by this :-)

Thanks!
Christian.
-- 
BOFH excuse #53:

Little hamster in running wheel had coronary; waiting for replacement to be Fedexed from Wyoming
