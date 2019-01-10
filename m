Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1B8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712CC214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfAJW3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:29:32 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:47152 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfAJW3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:29:31 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-101-80-nat.elisa-mobile.fi [85.76.101.80])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id BEE9130141;
        Fri, 11 Jan 2019 00:29:28 +0200 (EET)
Date:   Fri, 11 Jan 2019 00:29:28 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: Re: Bug report: unaligned access with ext4 encryption
Message-ID: <20190110222928.GB22416@darkstar.musicnaut.iki.fi>
References: <20190103171659.GA208343@gmail.com>
 <20181230162906.GI27785@darkstar.musicnaut.iki.fi>
 <17391.1546622882@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17391.1546622882@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 04, 2019 at 05:28:02PM +0000, David Howells wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> > Hi Aaro, thanks for the bug report!  I think you're on the right track; it makes
> > much more sense to have the keyrings subsystem store the payload with better
> > alignment, than to work around the 2-byte alignment in fscrypt.
> > 
> > But how about '__aligned(__alignof__(u64))' instead?  4 bytes may not be enough.
> > 
> > David, what do you think?
> 
> Does that even work?

That should work.

> Might be better to just insert 6 bytes of padding with a comment, but yes I
> agree that it's probably better to align it to at least machine word size.

Padding is fragile, e.g. if struct rcu_head changes. Using __aligned should
make it always right automatically.

A.
