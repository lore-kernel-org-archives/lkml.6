Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C9FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94176206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfAPDNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 22:13:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbfAPDNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 22:13:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B746536809;
        Wed, 16 Jan 2019 03:13:12 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E7836014F;
        Wed, 16 Jan 2019 03:13:06 +0000 (UTC)
Date:   Wed, 16 Jan 2019 11:13:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: linux-next: manual merge of the block tree with the fscrypt tree
Message-ID: <20190116031301.GC26146@ming.t460p>
References: <20190116132522.1b756433@canb.auug.org.au>
 <ca843f39-3fcd-1a03-34c9-7284f10fe262@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca843f39-3fcd-1a03-34c9-7284f10fe262@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 16 Jan 2019 03:13:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 07:55:39PM -0700, Jens Axboe wrote:
> On 1/15/19 7:25 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the block tree got a conflict in:
> > 
> >   fs/ext4/readpage.c
> > 
> > between commit:
> > 
> >   acc9eb0a6073 ("ext4: add fs-verity read support")
> > 
> > from the fscrypt tree and commit:
> > 
> >   eb754eb2a953 ("block: allow bio_for_each_segment_all() to iterate over multi-page bvec")
> > 
> > from the block tree.
> > 
> > I fixed it up (see below - the former moved the code modified by the
> > latter) and can carry the fix as necessary. This is now fixed as far as
> > linux-next is concerned, but any non trivial conflicts should be mentioned
> > to your upstream maintainer when your tree is submitted for merging.
> > You may also want to consider cooperating with the maintainer of the
> > conflicting tree to minimise any particularly complex conflicts.
> 
> Ming, I'm pulling this, I thought we agreed none of these bullshit
> renames? The fact that a patch looks like this:
> 
> -               for_each_bvec(bv, (it)->bvecs, __cur_iter, __cur_iter)        \
> +               for_each_segment(bv, (it)->bvecs, __cur_iter, __cur_iter)     \
> 
> is SUPER annoying and does NOTHING but to cause merge conflicts.
> 
> Resend it without that.

We need to differentiate 'segment' with 'bvec' in bvec helpers, which is
usually seldom used by drivers. For example, only two in-tree users(ceph, iov_iter).
That is why I rename it, and seems Christoph prefers to do it too.

Thanks,
Ming
